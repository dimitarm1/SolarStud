"""Period statistics (bar-chart reports), ported from the old Delphi
program's LoadChart() (SolarStud/main.pas). The old program kept every
sale in one PLASHTANIA ledger table; this app splits that across
`sessions` (bed/duration/revenue) and `sales_log` (cosmetics/card
events), so the SQL differs, but every report LoadChart offered is
covered here: tanning revenue/visits/hours and cosmetics/card totals,
each sliceable by bed, weekday, date, hour of day, month, product, or
recharge option.
"""

import db

# Monday-first, matching how Bulgarian weekly reports are normally read
# (the old program's own DayOfWeek-based grouping used a different raw
# index, but the display order it's ported to here is this one).
WEEKDAY_LABELS = ["Пон", "Вт", "Сря", "Чет", "Пет", "Съб", "Нед"]

METRICS = [
    {"id": "tanning_revenue", "label": "Приходи от солариум", "unit": "лв", "source": "sessions"},
    {"id": "visits", "label": "Посещения", "unit": "брой", "source": "sessions"},
    {"id": "tanning_hours", "label": "Отработени часове", "unit": "часове", "source": "sessions"},
    {"id": "cosmetics_revenue", "label": "Приходи от козметика", "unit": "лв", "source": "cosmetics"},
    {"id": "cosmetics_count", "label": "Продадена козметика", "unit": "брой", "source": "cosmetics"},
    {"id": "services_revenue", "label": "Приходи от услуги", "unit": "лв", "source": "services"},
    {"id": "services_count", "label": "Извършени услуги", "unit": "брой", "source": "services"},
    {"id": "cards_count", "label": "Продадени/презаредени карти", "unit": "брой", "source": "cards"},
    {"id": "total_revenue", "label": "Общо приходи (всичко)", "unit": "лв", "source": "total"},
]

BREAKDOWNS = [
    {"id": "none", "label": "Общо за периода"},
    {"id": "date", "label": "По ден от периода"},
    {"id": "weekday", "label": "По ден от седмицата"},
    {"id": "hour", "label": "По час от деня"},
    {"id": "month", "label": "По месец"},
    {"id": "bed", "label": "По легло"},
    {"id": "product", "label": "По продукт"},
    {"id": "service", "label": "По услуга"},
    {"id": "recharge_option", "label": "По вид презареждане"},
]

# Which breakdowns make sense for which metric's data source.
_ALLOWED_BREAKDOWNS = {
    "sessions": ["none", "date", "weekday", "hour", "month", "bed"],
    "cosmetics": ["none", "date", "weekday", "month", "product"],
    "services": ["none", "date", "weekday", "month", "service"],
    "cards": ["none", "date", "weekday", "month", "recharge_option"],
    "total": ["none", "date", "weekday", "month"],
}

# A second "split into one series per bed" axis only makes sense for
# session metrics combined with a time-based breakdown - mirrors the old
# program's paired reports ("...по ден от седмицата" vs "...по ден от
# седмицата по солариум").
_SPLIT_BY_BED_BREAKDOWNS = {"date", "weekday", "month"}

_METRIC_VALUE_EXPR = {
    "tanning_revenue": "ROUND(SUM(cash_amount + card_amount), 2)",
    "visits": "COUNT(*)",
    "tanning_hours": "ROUND(SUM(total_min) / 60.0, 2)",
    "cosmetics_revenue": "ROUND(SUM(cash_amount + card_amount), 2)",
    "cosmetics_count": "COALESCE(SUM(qty), 0)",
    "services_revenue": "ROUND(SUM(cash_amount + card_amount), 2)",
    "services_count": "COALESCE(SUM(qty), 0)",
    "cards_count": "COUNT(*)",
    "total_revenue": "ROUND(SUM(cash_amount + card_amount), 2)",
}


def metric_info(metric_id):
    return next(m for m in METRICS if m["id"] == metric_id)


def allowed_breakdowns(metric_id):
    source = metric_info(metric_id)["source"]
    return [b for b in BREAKDOWNS if b["id"] in _ALLOWED_BREAKDOWNS[source]]


def supports_split_by_bed(metric_id, breakdown_id):
    return metric_info(metric_id)["source"] == "sessions" and breakdown_id in _SPLIT_BY_BED_BREAKDOWNS


def _weekday_order(dow_expr):
    """SQL for sorting strftime('%w', ...) (0=Sunday..6=Saturday) so
    Monday comes first - matches WEEKDAY_LABELS's order."""
    return f"(({dow_expr} + 6) % 7)"


def _time_group(breakdown_id, date_col):
    """(group_expr, order_expr, label_fn) for the four breakdowns shared
    by every data source. label_fn turns one raw group value into its
    display label."""
    if breakdown_id == "date":
        expr = f"date({date_col})"
        return expr, expr, lambda raw: "{2}.{1}".format(*raw.split("-"))
    if breakdown_id == "weekday":
        expr = f"CAST(strftime('%w', {date_col}) AS INTEGER)"
        return expr, _weekday_order(expr), lambda raw: WEEKDAY_LABELS[(int(raw) + 6) % 7]
    if breakdown_id == "hour":
        expr = f"strftime('%H', {date_col})"
        return expr, expr, lambda raw: f"{raw}ч"
    if breakdown_id == "month":
        expr = f"strftime('%Y-%m', {date_col})"
        return expr, expr, lambda raw: raw
    raise ValueError(f"Unknown time breakdown {breakdown_id!r}")


def _run_sessions(conn, metric_id, breakdown_id, date_from, date_to, split_by_bed):
    value_expr = _METRIC_VALUE_EXPR[metric_id]
    where = "WHERE date(started_at) BETWEEN ? AND ?"
    params = [date_from, date_to]

    if breakdown_id == "none":
        row = conn.execute(f"SELECT {value_expr} AS v FROM sessions {where}", params).fetchone()
        return ["Общо"], [[row["v"] or 0]]

    if breakdown_id == "bed":
        rows = conn.execute(
            f"SELECT beds.number AS label, {value_expr} AS v FROM sessions "
            f"JOIN beds ON beds.id = sessions.bed_id {where} "
            "GROUP BY sessions.bed_id ORDER BY beds.sort_order",
            params,
        ).fetchall()
        return [r["label"] for r in rows], [[r["v"] or 0 for r in rows]]

    group_expr, order_expr, label_fn = _time_group(breakdown_id, "started_at")

    if not split_by_bed:
        rows = conn.execute(
            f"SELECT {group_expr} AS grp, {value_expr} AS v FROM sessions {where} "
            f"GROUP BY grp ORDER BY {order_expr}",
            params,
        ).fetchall()
        return [label_fn(str(r["grp"])) for r in rows], [[r["v"] or 0 for r in rows]]

    rows = conn.execute(
        f"SELECT {group_expr} AS grp, beds.number AS bed_label, beds.sort_order AS bed_order, "
        f"{value_expr} AS v FROM sessions JOIN beds ON beds.id = sessions.bed_id {where} "
        f"GROUP BY grp, sessions.bed_id ORDER BY {order_expr}, beds.sort_order",
        params,
    ).fetchall()
    categories = sorted({str(r["grp"]) for r in rows}, key=lambda raw: raw)
    if breakdown_id == "weekday":
        categories = sorted(categories, key=lambda raw: (int(raw) + 6) % 7)
    beds_seen = sorted({(r["bed_order"], r["bed_label"]) for r in rows})
    grid = {bed_label: {str(r["grp"]): r["v"] or 0 for r in rows if r["bed_label"] == bed_label} for _, bed_label in beds_seen}
    labels = [label_fn(raw) for raw in categories]
    series = [[grid[bed_label].get(raw, 0) for raw in categories] for _, bed_label in beds_seen]
    return labels, series, [bed_label for _, bed_label in beds_seen]


def _run_sales_log(conn, metric_id, breakdown_id, date_from, date_to):
    value_expr = _METRIC_VALUE_EXPR[metric_id]
    kind_filter = {
        "cosmetics_revenue": "product_sale",
        "cosmetics_count": "product_sale",
        "services_revenue": "service_sale",
        "services_count": "service_sale",
        "cards_count": "card_recharge",
        "total_revenue": None,
    }[metric_id]

    # Qualified with the table name throughout: the product/recharge_option
    # breakdowns below join in products/recharge_options, which each have
    # their own created_at column too, so an unqualified reference here
    # would be ambiguous once joined.
    where = "WHERE date(sales_log.created_at) BETWEEN ? AND ?"
    params = [date_from, date_to]
    if kind_filter:
        where += " AND kind = ?"
        params.append(kind_filter)

    if breakdown_id == "none":
        row = conn.execute(f"SELECT {value_expr} AS v FROM sales_log {where}", params).fetchone()
        return ["Общо"], [[row["v"] or 0]]

    if breakdown_id == "product":
        rows = conn.execute(
            f"SELECT products.name AS label, {value_expr} AS v FROM sales_log "
            f"JOIN products ON products.id = sales_log.product_id {where} "
            "AND sales_log.product_id IS NOT NULL GROUP BY sales_log.product_id ORDER BY v DESC",
            params,
        ).fetchall()
        return [r["label"] for r in rows], [[r["v"] or 0 for r in rows]]

    if breakdown_id == "service":
        rows = conn.execute(
            f"SELECT services.name AS label, {value_expr} AS v FROM sales_log "
            f"JOIN services ON services.id = sales_log.service_id {where} "
            "AND sales_log.service_id IS NOT NULL GROUP BY sales_log.service_id ORDER BY v DESC",
            params,
        ).fetchall()
        return [r["label"] for r in rows], [[r["v"] or 0 for r in rows]]

    if breakdown_id == "recharge_option":
        rows = conn.execute(
            f"SELECT recharge_options.name AS label, {value_expr} AS v FROM sales_log "
            f"JOIN recharge_options ON recharge_options.id = sales_log.recharge_option_id {where} "
            "AND sales_log.recharge_option_id IS NOT NULL GROUP BY sales_log.recharge_option_id "
            "ORDER BY v DESC",
            params,
        ).fetchall()
        return [r["label"] for r in rows], [[r["v"] or 0 for r in rows]]

    group_expr, order_expr, label_fn = _time_group(breakdown_id, "sales_log.created_at")
    rows = conn.execute(
        f"SELECT {group_expr} AS grp, {value_expr} AS v FROM sales_log {where} "
        f"GROUP BY grp ORDER BY {order_expr}",
        params,
    ).fetchall()
    return [label_fn(str(r["grp"])) for r in rows], [[r["v"] or 0 for r in rows]]


def run_report(metric_id, breakdown_id, date_from, date_to, split_by_bed=False):
    """Returns {metric, breakdown, unit, categories, series: [{label, data}]}
    ready to hand straight to a Chart.js bar chart - one series unless
    split_by_bed produced one per bed."""
    metric = metric_info(metric_id)
    if breakdown_id not in {b["id"] for b in allowed_breakdowns(metric_id)}:
        raise ValueError(f"Breakdown {breakdown_id!r} not valid for metric {metric_id!r}")
    split_by_bed = split_by_bed and supports_split_by_bed(metric_id, breakdown_id)

    conn = db.get_connection()
    try:
        if metric["source"] == "sessions":
            result = _run_sessions(conn, metric_id, breakdown_id, date_from, date_to, split_by_bed)
        else:
            result = _run_sales_log(conn, metric_id, breakdown_id, date_from, date_to)
    finally:
        conn.close()

    if len(result) == 3:
        categories, series_data, series_labels = result
    else:
        categories, series_data = result
        series_labels = [metric["label"]]

    return {
        "metric": metric_id,
        "breakdown": breakdown_id,
        "unit": metric["unit"],
        "categories": categories,
        "series": [
            {"label": label, "data": data} for label, data in zip(series_labels, series_data)
        ],
    }
