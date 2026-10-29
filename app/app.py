import os
import threading
import time
import urllib.error
import urllib.request
import webbrowser
from datetime import datetime, timedelta
from pathlib import Path

from flask import Flask, abort, jsonify, redirect, render_template, request, send_file, url_for

import chipcard
import controller_link
import db
import models
import sales
import stats

ALLOWED_IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg"}
DEBUG = True
PORT = 5000

app = Flask(__name__)
db.init_db()

VERSION = "V1.2"

NAV_ITEMS = [
    {"id": "tanning", "label": "Солариум", "icon": "sun"},
    {"id": "cosmetics", "label": "Козметика", "icon": "leaf"},
    {"id": "services", "label": "Услуги", "icon": "sparkle"},
    {"id": "cards", "label": "Карти", "icon": "card"},
    {"id": "studio", "label": "Студио", "icon": "home"},
]

BOTTOM_BUTTONS = [
    {"id": "protocol", "label": "Протокол", "icon": "protocol"},
    {"id": "stats", "label": "Статистика", "icon": "chart"},
    {"id": "cosmetics", "label": "Козметика", "icon": "leaf"},
    {"id": "services", "label": "Услуги", "icon": "sparkle"},
    {"id": "cards", "label": "Карти", "icon": "card"},
    {"id": "studio", "label": "Студио", "icon": "home"},
]


@app.route("/")
def index():
    return render_template(
        "index.html",
        version=VERSION,
        beds=models.list_beds(),
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
    )


@app.route("/bed/<int:bed_id>")
def bed_detail(bed_id):
    bed = models.get_bed(bed_id)
    if bed is None:
        abort(404)
    return render_template(
        "bed_detail.html",
        version=VERSION,
        bed=bed,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        session_min=models.MIN_SESSION_MINUTES,
        session_max=models.MAX_SESSION_MINUTES,
        session_default=models.DEFAULT_SESSION_MINUTES,
        prep_min_bound=models.MIN_PREP_MINUTES,
        prep_max_bound=models.MAX_PREP_MINUTES,
        cool_min_bound=models.MIN_COOL_MINUTES,
        cool_max_bound=models.MAX_COOL_MINUTES,
        controller_address_min=models.MIN_CONTROLLER_ADDRESS,
        controller_address_max=models.MAX_REAL_CONTROLLER_ADDRESS,
        demo_address_min=models.MIN_DEMO_CONTROLLER_ADDRESS,
        demo_address_max=models.MAX_CONTROLLER_ADDRESS,
        hw_error=request.args.get("hw_error"),
        payment_error=request.args.get("payment_error"),
    )


@app.route("/bed/<int:bed_id>/start", methods=["POST"])
def start_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    total_min = request.form.get("total_min", type=int, default=models.DEFAULT_SESSION_MINUTES)
    card_id = request.form.get("card_id", type=int, default=None)
    card_amount = request.form.get("card_amount", type=float, default=0.0)
    chip_amount = request.form.get("chip_amount", type=float, default=0.0)
    try:
        models.start_session_with_payment(
            bed_id, total_min=total_min, card_id=card_id, requested_card_amount=card_amount,
            chip_amount=chip_amount, chip_reader_name=models.get_chip_reader_name() or None,
        )
    except controller_link.ControllerLinkError as exc:
        return redirect(url_for("bed_detail", bed_id=bed_id, hw_error=str(exc)))
    except (sales.PaymentError, chipcard.ChipCardError) as exc:
        return redirect(url_for("bed_detail", bed_id=bed_id, payment_error=str(exc)))
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/bed/<int:bed_id>/stop", methods=["POST"])
def stop_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    try:
        models.stop_session(bed_id)
    except controller_link.ControllerLinkError as exc:
        return redirect(url_for("bed_detail", bed_id=bed_id, hw_error=str(exc)))
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/bed/<int:bed_id>/skip-prep", methods=["POST"])
def skip_prep_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    try:
        models.skip_prep(bed_id)
    except controller_link.ControllerLinkError as exc:
        return redirect(url_for("bed_detail", bed_id=bed_id, hw_error=str(exc)))
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/bed/<int:bed_id>/photo")
def bed_photo(bed_id):
    bed = models.get_bed(bed_id)
    if bed is None or not bed["picture_path"]:
        abort(404)
    path = Path(bed["picture_path"])
    if path.suffix.lower() not in ALLOWED_IMAGE_EXTENSIONS or not path.is_file():
        abort(404)
    return send_file(path, conditional=True)


@app.route("/bed/<int:bed_id>/settings", methods=["POST"])
def update_bed_settings(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    models.update_bed_settings(
        bed_id,
        number=request.form.get("number", ""),
        model=request.form.get("model", ""),
        prep_min=request.form.get("prep_min", type=int, default=models.MIN_PREP_MINUTES),
        cool_min=request.form.get("cool_min", type=int, default=models.MIN_COOL_MINUTES),
        picture_path=request.form.get("picture_path", ""),
        controller_address=request.form.get("controller_address", ""),
        price_per_min=request.form.get("price_per_min", type=float, default=0.0),
    )
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/api/controllers/scan")
def scan_controllers():
    exclude_bed_id = request.args.get("bed_id", type=int)
    port = models.get_serial_port()
    if not port:
        return jsonify({"error": "Не е зададен сериен порт. Задайте го в страница Студио."}), 400
    try:
        found = controller_link.scan(port)
    except controller_link.ControllerLinkError as exc:
        return jsonify({"error": str(exc)}), 503

    in_use = models.list_controller_addresses_in_use(exclude_bed_id=exclude_bed_id)
    for entry in found:
        entry["in_use_by_bed_id"] = in_use.get(entry["address"])
    return jsonify({"port": port, "controllers": found})


@app.route("/studio")
def studio():
    beds = models.list_beds()
    options = sales.list_recharge_options(include_inactive=True)
    return render_template(
        "studio.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        bed_count=models.get_bed_count(),
        bed_count_min=models.MIN_BEDS,
        bed_count_max=models.MAX_BEDS,
        serial_port=models.get_serial_port(),
        beds=beds,
        recharge_options=options,
        recharge_option_bed_prices={
            option["id"]: sales.list_recharge_option_bed_prices(option["id"]) for option in options
        },
        chip_readers=chipcard.list_readers(),
        chip_reader_name=models.get_chip_reader_name(),
        chip_studio_identity=models.get_chip_studio_identity(),
        chip_known_studio_numbers=models.get_chip_known_studio_numbers_text(),
        chip_psc=models.get_chip_psc(),
        error=request.args.get("error"),
        message=request.args.get("message"),
    )


@app.route("/studio/bed-count", methods=["POST"])
def studio_set_bed_count():
    current = models.get_bed_count()
    count = request.form.get("bed_count", type=int, default=current)
    models.set_bed_count(count)
    return redirect(url_for("studio"))


@app.route("/studio/serial-port", methods=["POST"])
def studio_set_serial_port():
    models.set_serial_port(request.form.get("serial_port", ""))
    return redirect(url_for("studio"))


@app.route("/studio/chip-reader", methods=["POST"])
def studio_set_chip_reader():
    models.set_chip_reader_name(request.form.get("chip_reader_name", ""))
    return redirect(url_for("studio"))


@app.route("/studio/chip-studio-identity", methods=["POST"])
def studio_set_chip_studio_identity():
    models.set_chip_studio_identity(
        request.form.get("chip_studio_name", ""),
        request.form.get("chip_studio_number", type=int, default=0),
    )
    return redirect(url_for("studio"))


@app.route("/studio/chip-known-studios", methods=["POST"])
def studio_set_chip_known_studios():
    models.set_chip_known_studio_numbers(request.form.get("chip_known_studio_numbers", ""))
    return redirect(url_for("studio"))


@app.route("/studio/chip-psc", methods=["POST"])
def studio_set_chip_psc():
    try:
        models.set_chip_psc(request.form.get("chip_studio_psc", ""))
    except ValueError as exc:
        return redirect(url_for("studio", error=str(exc)))
    return redirect(url_for("studio", message="Защитният код (PSC) на веригата е запазен."))


@app.route("/api/chipcard/read")
def chipcard_read():
    reader_name = models.get_chip_reader_name() or None
    try:
        card = chipcard.read_card(reader_name)
    except chipcard.ChipCardError as exc:
        return jsonify({"ok": False, "error": str(exc)}), 503
    known = sales.find_chip_card_by_client_number(card["client_number"])
    return jsonify({
        "ok": True,
        "card": card,
        "known": {"name": known["name"], "phone": known["phone"]} if known else None,
    })


@app.route("/api/chipcard/quote")
def chipcard_quote():
    bed_id = request.args.get("bed_id", type=int)
    total_min = request.args.get("total_min", type=int, default=models.DEFAULT_SESSION_MINUTES)
    chip_amount = request.args.get("chip_amount", type=float, default=0.0)
    try:
        return jsonify(sales.quote_chip_session(
            bed_id, total_min, chip_amount, models.get_chip_reader_name() or None
        ))
    except chipcard.ChipCardError as exc:
        return jsonify({"error": str(exc)}), 503


@app.route("/studio/recharge-options", methods=["POST"])
def studio_create_recharge_option():
    sales.create_recharge_option(
        name=request.form.get("name", ""),
        virtual_amount=request.form.get("virtual_amount", type=float, default=0.0),
        cash_price=request.form.get("cash_price", type=float, default=0.0),
    )
    return redirect(url_for("studio"))


@app.route("/studio/recharge-options/<int:option_id>/update", methods=["POST"])
def studio_update_recharge_option(option_id):
    sales.update_recharge_option(
        option_id,
        name=request.form.get("name", ""),
        virtual_amount=request.form.get("virtual_amount", type=float, default=0.0),
        cash_price=request.form.get("cash_price", type=float, default=0.0),
    )
    return redirect(url_for("studio"))


@app.route("/studio/recharge-options/<int:option_id>/active", methods=["POST"])
def studio_set_recharge_option_active(option_id):
    sales.set_recharge_option_active(option_id, request.form.get("active", type=int, default=1))
    return redirect(url_for("studio"))


@app.route("/studio/recharge-options/<int:option_id>/bed-prices", methods=["POST"])
def studio_set_recharge_option_bed_prices(option_id):
    bed_prices = {}
    for bed in models.list_beds():
        raw = request.form.get(f"bed_{bed['id']}", "").strip()
        bed_prices[bed["id"]] = float(raw) if raw else None
    sales.set_recharge_option_bed_prices(option_id, bed_prices)
    return redirect(url_for("studio"))


@app.route("/cosmetics")
def cosmetics_page():
    return render_template(
        "cosmetics.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        products=sales.list_products(),
        error=request.args.get("error"),
    )


@app.route("/cosmetics/products", methods=["POST"])
def cosmetics_create_product():
    sales.create_product(
        name=request.form.get("name", ""),
        sale_price=request.form.get("sale_price", type=float, default=0.0),
        initial_stock=request.form.get("initial_stock", type=int, default=0),
    )
    return redirect(url_for("cosmetics_page"))


@app.route("/cosmetics/products/<int:product_id>/update", methods=["POST"])
def cosmetics_update_product(product_id):
    sales.update_product(
        product_id,
        name=request.form.get("name", ""),
        sale_price=request.form.get("sale_price", type=float, default=0.0),
    )
    return redirect(url_for("cosmetics_page"))


@app.route("/cosmetics/products/<int:product_id>/restock", methods=["POST"])
def cosmetics_restock_product(product_id):
    sales.restock_product(product_id, request.form.get("add_qty", type=int, default=0))
    return redirect(url_for("cosmetics_page"))


@app.route("/cosmetics/products/<int:product_id>/adjust-stock", methods=["POST"])
def cosmetics_adjust_stock(product_id):
    try:
        sales.adjust_stock(
            product_id,
            new_stock_qty=request.form.get("new_stock_qty", type=int, default=0),
            reason=request.form.get("reason", ""),
        )
    except sales.PaymentError as exc:
        return redirect(url_for("cosmetics_page", error=str(exc)))
    return redirect(url_for("cosmetics_page"))


@app.route("/cosmetics/products/<int:product_id>/retire", methods=["POST"])
def cosmetics_retire_product(product_id):
    sales.set_product_active(product_id, 0)
    return redirect(url_for("cosmetics_page"))


@app.route("/cosmetics/checkout", methods=["POST"])
def cosmetics_checkout():
    product_ids = request.form.getlist("product_id", type=int)
    qtys = request.form.getlist("qty", type=int)
    try:
        sales.sell_products(
            zip(product_ids, qtys),
            card_id=request.form.get("card_id", type=int, default=None),
            card_amount=request.form.get("card_amount", type=float, default=0.0),
        )
    except sales.PaymentError as exc:
        return redirect(url_for("cosmetics_page", error=str(exc)))
    return redirect(url_for("cosmetics_page"))


@app.route("/services")
def services_page():
    return render_template(
        "services.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        services=sales.list_services(),
        error=request.args.get("error"),
    )


@app.route("/services/services", methods=["POST"])
def services_create_service():
    sales.create_service(
        name=request.form.get("name", ""),
        sale_price=request.form.get("sale_price", type=float, default=0.0),
    )
    return redirect(url_for("services_page"))


@app.route("/services/services/<int:service_id>/update", methods=["POST"])
def services_update_service(service_id):
    sales.update_service(
        service_id,
        name=request.form.get("name", ""),
        sale_price=request.form.get("sale_price", type=float, default=0.0),
    )
    return redirect(url_for("services_page"))


@app.route("/services/services/<int:service_id>/retire", methods=["POST"])
def services_retire_service(service_id):
    sales.set_service_active(service_id, 0)
    return redirect(url_for("services_page"))


@app.route("/services/checkout", methods=["POST"])
def services_checkout():
    service_ids = request.form.getlist("service_id", type=int)
    qtys = request.form.getlist("qty", type=int)
    try:
        sales.sell_services(
            zip(service_ids, qtys),
            card_id=request.form.get("card_id", type=int, default=None),
            card_amount=request.form.get("card_amount", type=float, default=0.0),
        )
    except sales.PaymentError as exc:
        return redirect(url_for("services_page", error=str(exc)))
    return redirect(url_for("services_page"))


CARDS_DEFAULT_LIMIT = 50


@app.route("/cards")
def cards_page():
    search = request.args.get("q", "").strip()
    return render_template(
        "cards.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        cards=sales.list_cards(search=search, limit=CARDS_DEFAULT_LIMIT),
        cards_default_limit=CARDS_DEFAULT_LIMIT,
        search=search,
        recharge_options=sales.list_recharge_options(),
        error=request.args.get("error"),
        message=request.args.get("message"),
        chip_refresh=request.args.get("chip_refresh") == "1",
    )


@app.route("/cards", methods=["POST"])
def cards_issue():
    try:
        card_id = sales.issue_card(
            card_number=request.form.get("card_number", ""),
            deposit_amount=request.form.get("deposit_amount", type=float, default=0.0),
            first_recharge_option_id=request.form.get("recharge_option_id", type=int, default=None),
            name=request.form.get("name", ""),
            phone=request.form.get("phone", ""),
        )
    except sales.PaymentError as exc:
        return redirect(url_for("cards_page", error=str(exc)))
    return redirect(url_for("card_detail", card_id=card_id))


@app.route("/cards/chip/issue", methods=["POST"])
def chip_card_issue():
    identity = models.get_chip_studio_identity()
    try:
        client_number = sales.issue_chip_card(
            name=request.form.get("name", ""),
            phone=request.form.get("phone", ""),
            deposit_amount=request.form.get("deposit_amount", type=float, default=0.0),
            recharge_option_id=request.form.get("recharge_option_id", type=int, default=None),
            reader_name=models.get_chip_reader_name() or None,
            studio_name=identity["name"], studio_number=identity["number"],
            allowed_studio_numbers=models.get_chip_known_studio_numbers(),
            chain_psc=bytes.fromhex(models.get_chip_psc()),
        )
    except (sales.PaymentError, chipcard.ChipCardError) as exc:
        return redirect(url_for("cards_page", error=str(exc)))
    return redirect(url_for(
        "cards_page", message=f"Издадена чип карта №{client_number}.", chip_refresh="1"
    ))


@app.route("/cards/chip/recharge", methods=["POST"])
def chip_card_recharge():
    try:
        new_balance = sales.recharge_chip_card(
            recharge_option_id=request.form.get("recharge_option_id", type=int, default=None),
            reader_name=models.get_chip_reader_name() or None,
            this_studio_number=models.get_chip_studio_identity()["number"],
            allowed_studio_numbers=models.get_chip_known_studio_numbers(),
        )
    except (sales.PaymentError, chipcard.ChipCardError) as exc:
        return redirect(url_for("cards_page", error=str(exc)))
    return redirect(url_for(
        "cards_page", message=f"Нов баланс по чип картата: {new_balance:.2f} €.", chip_refresh="1"
    ))


@app.route("/cards/chip/clear", methods=["POST"])
def chip_card_clear():
    try:
        client_number = sales.clear_chip_card(
            reader_name=models.get_chip_reader_name() or None,
            allowed_studio_numbers=models.get_chip_known_studio_numbers(),
        )
    except (sales.PaymentError, chipcard.ChipCardError) as exc:
        return redirect(url_for("cards_page", error=str(exc)))
    message = (
        f"Картата (бивш клиент №{client_number}) е нулирана и може да бъде издадена наново."
        if client_number is not None else "Картата е нулирана."
    )
    return redirect(url_for("cards_page", message=message, chip_refresh="1"))


@app.route("/cards/<int:card_id>")
def card_detail(card_id):
    card = sales.get_card(card_id)
    if card is None:
        abort(404)
    return render_template(
        "card_detail.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        card=card,
        recharge_options=sales.list_recharge_options(),
        error=request.args.get("error"),
    )


@app.route("/cards/<int:card_id>/update", methods=["POST"])
def card_update_details(card_id):
    try:
        sales.update_card_details(
            card_id,
            card_number=request.form.get("card_number", ""),
            name=request.form.get("name", ""),
            phone=request.form.get("phone", ""),
        )
    except sales.PaymentError as exc:
        return redirect(url_for("card_detail", card_id=card_id, error=str(exc)))
    return redirect(url_for("card_detail", card_id=card_id))


@app.route("/cards/<int:card_id>/recharge", methods=["POST"])
def card_recharge(card_id):
    try:
        sales.recharge_card(card_id, request.form.get("recharge_option_id", type=int, default=None))
    except sales.PaymentError as exc:
        return redirect(url_for("card_detail", card_id=card_id, error=str(exc)))
    return redirect(url_for("card_detail", card_id=card_id))


@app.route("/cards/<int:card_id>/return", methods=["POST"])
def card_return(card_id):
    try:
        sales.return_card(
            card_id, force_forfeit_balance=request.form.get("force_forfeit_balance", default="") == "1"
        )
    except sales.PaymentError as exc:
        return redirect(url_for("card_detail", card_id=card_id, error=str(exc)))
    return redirect(url_for("cards_page"))


_HISTORY_KIND_LABELS = {
    "session_payment": "Солариум",
    "product_sale": "Продажба",
    "service_sale": "Услуга",
    "card_recharge": "Презареждане",
    "card_deposit_charge": "Депозит",
    "card_deposit_refund": "Връщане на депозит",
    "card_balance_forfeit": "Анулиран баланс",
    "stock_adjustment": "Корекция на наличност",
    "chip_card_cleared": "Нулиране на картата",
}


def _history_totals(rows):
    return {
        "cash_total": sum(r["cash_amount"] for r in rows),
        "card_total": sum(r["card_amount"] for r in rows),
        "virtual_total": sum(r["virtual_amount"] or 0 for r in rows),
    }


@app.route("/cards/<int:card_id>/print")
def card_print(card_id):
    card = sales.get_card(card_id)
    if card is None:
        abort(404)
    history = sales.card_history(card_id=card_id)
    header_lines = [f"Карта №{card['id']}"]
    if card["card_number"]:
        header_lines.append(f"Номер: {card['card_number']}")
    if card["phone"]:
        header_lines.append(f"Телефон: {card['phone']}")
    return render_template(
        "card_print.html",
        title=card["name"] or f"Карта №{card['id']}",
        header_lines=header_lines,
        note=None,
        kind_labels=_HISTORY_KIND_LABELS,
        history=history,
        totals=_history_totals(history),
        generated_at=datetime.now().strftime("%d.%m.%Y %H:%M"),
    )


@app.route("/cards/chip/print")
def chip_card_print():
    client_number = request.args.get("client_number", type=int)
    studio_number = request.args.get("studio_number", type=int)
    if client_number is None or studio_number is None:
        abort(400)
    name = request.args.get("name", "")
    phone = request.args.get("phone", "")
    history = sales.card_history(chip_client_number=client_number, chip_studio_number=studio_number)
    header_lines = [f"Чип карта №{client_number}", f"Студио №{studio_number}"]
    if phone:
        header_lines.append(f"Телефон: {phone}")
    return render_template(
        "card_print.html",
        title=name or f"Чип карта №{client_number}",
        header_lines=header_lines,
        note=(
            "Показана е само историята, записана в тази студио. Ако картата е била "
            "използвана и в други студиа от веригата, тези записи не са налични тук."
        ),
        kind_labels=_HISTORY_KIND_LABELS,
        history=history,
        totals=_history_totals(history),
        generated_at=datetime.now().strftime("%d.%m.%Y %H:%M"),
    )


@app.route("/protocol")
def protocol():
    date = request.args.get("date") or datetime.now().strftime("%Y-%m-%d")
    return render_template(
        "protocol.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        date=date,
        entries=sales.list_sales_log(date=date),
        summary=sales.sales_log_summary(date=date),
        kind_labels=_HISTORY_KIND_LABELS,
    )


@app.route("/protocol/print")
def protocol_print():
    date = request.args.get("date") or datetime.now().strftime("%Y-%m-%d")
    summary = sales.sales_log_summary(date=date)
    return render_template(
        "card_print.html",
        title=f"Дневен отчет — {date}",
        header_lines=[],
        note=None,
        kind_labels=_HISTORY_KIND_LABELS,
        history=sales.list_sales_log(date=date),
        totals=summary["totals"],
        generated_at=datetime.now().strftime("%d.%m.%Y %H:%M"),
    )


@app.route("/stats")
def stats_page():
    date_to = request.args.get("date_to") or datetime.now().strftime("%Y-%m-%d")
    date_from = request.args.get("date_from") or (datetime.now() - timedelta(days=30)).strftime("%Y-%m-%d")
    return render_template(
        "stats.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        metrics=stats.METRICS,
        breakdowns=stats.BREAKDOWNS,
        allowed_breakdowns={m["id"]: [b["id"] for b in stats.allowed_breakdowns(m["id"])] for m in stats.METRICS},
        split_by_bed_breakdowns={
            m["id"]: [b["id"] for b in stats.BREAKDOWNS if stats.supports_split_by_bed(m["id"], b["id"])]
            for m in stats.METRICS
        },
        date_from=date_from,
        date_to=date_to,
    )


@app.route("/api/stats/report")
def api_stats_report():
    metric = request.args.get("metric", stats.METRICS[0]["id"])
    breakdown = request.args.get("breakdown", "none")
    date_from = request.args.get("date_from")
    date_to = request.args.get("date_to")
    split_by_bed = request.args.get("split_by_bed") == "1"
    if not date_from or not date_to:
        return jsonify({"error": "Моля, изберете период (начална и крайна дата)."}), 400
    try:
        return jsonify(stats.run_report(metric, breakdown, date_from, date_to, split_by_bed=split_by_bed))
    except ValueError as exc:
        return jsonify({"error": str(exc)}), 400


CARD_SEARCH_LIMIT = 20


@app.route("/api/cards/search")
def search_cards():
    search = request.args.get("q", "").strip()
    cards = sales.list_cards(status="active", search=search, limit=CARD_SEARCH_LIMIT)
    results = [
        {
            "id": c["id"],
            "label": " · ".join(part for part in [c["name"], c["phone"], c["card_number"]] if part)
            or f"№{c['id']}",
            "balance": c["balance"],
        }
        for c in cards
    ]
    return jsonify({"cards": results})


@app.route("/api/sessions/quote")
def quote_session():
    bed_id = request.args.get("bed_id", type=int)
    total_min = request.args.get("total_min", type=int, default=models.DEFAULT_SESSION_MINUTES)
    card_id = request.args.get("card_id", type=int)
    card_amount = request.args.get("card_amount", type=float, default=0.0)
    return jsonify(sales.quote_session_payment(bed_id, total_min, card_id, card_amount))


@app.route("/api/status")
def status():
    return jsonify(
        {
            "time": datetime.now().strftime("%H:%M:%S"),
            "beds": models.list_beds(),
        }
    )


def run_server(debug=DEBUG, open_browser=False):
    """Start the server. Shared by `python app.py` (dev workflow: debug
    mode, auto-reload) and run.py (the double-click launcher: no debug
    mode, no reloader, opens the browser once the server answers).

    Under the debug reloader there are two processes: a parent monitor
    (WERKZEUG_RUN_MAIN unset) and the child that actually serves requests
    (WERKZEUG_RUN_MAIN="true"). The backup scheduler and the browser-open
    both only run in the process that will actually stick around, so
    neither fires twice.
    """
    is_main_process = not debug or os.environ.get("WERKZEUG_RUN_MAIN") == "true"

    if is_main_process:
        db.start_backup_scheduler()

    if open_browser and is_main_process:
        _open_browser_when_ready(f"http://127.0.0.1:{PORT}/")

    app.run(debug=debug, use_reloader=debug, host="0.0.0.0", port=PORT)


def _open_browser_when_ready(url, timeout_seconds=15):
    def wait_and_open():
        deadline = time.monotonic() + timeout_seconds
        while time.monotonic() < deadline:
            try:
                urllib.request.urlopen(url, timeout=0.5)
                break
            except (OSError, urllib.error.URLError):
                time.sleep(0.25)  # server socket isn't listening yet - keep polling
        webbrowser.open(url)

    threading.Thread(target=wait_and_open, daemon=True).start()


if __name__ == "__main__":
    run_server(debug=DEBUG)
