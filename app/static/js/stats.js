(() => {
  const config = window.STATS_CONFIG;
  if (!config) return;

  const metricSelect = document.getElementById("stats-metric");
  const breakdownSelect = document.getElementById("stats-breakdown");
  const splitByBedField = document.getElementById("stats-split-by-bed-field");
  const splitByBedCheckbox = document.getElementById("stats-split-by-bed");
  const dateFromInput = document.getElementById("stats-date-from");
  const dateToInput = document.getElementById("stats-date-to");
  const canvas = document.getElementById("stats-chart");
  const emptyState = document.getElementById("stats-empty");
  const errorBanner = document.getElementById("stats-error");
  const errorText = document.getElementById("stats-error-text");

  const breakdownLabel = (id) => {
    const found = config.breakdownLabels.find((b) => b.id === id);
    return found ? found.label : id;
  };

  const seriesColor = (index) => {
    const slot = (index % 8) + 1;
    return getComputedStyle(document.documentElement).getPropertyValue(`--series-${slot}`).trim();
  };

  function populateBreakdownOptions() {
    const allowed = config.allowedBreakdowns[metricSelect.value] || [];
    const previous = breakdownSelect.value;
    breakdownSelect.innerHTML = "";
    allowed.forEach((id) => {
      const opt = document.createElement("option");
      opt.value = id;
      opt.textContent = breakdownLabel(id);
      breakdownSelect.appendChild(opt);
    });
    breakdownSelect.value = allowed.includes(previous) ? previous : allowed[0];
  }

  function updateSplitByBedVisibility() {
    const supported = (config.splitByBedBreakdowns[metricSelect.value] || []).includes(breakdownSelect.value);
    splitByBedField.hidden = !supported;
    if (!supported) splitByBedCheckbox.checked = false;
  }

  let chart = null;

  function renderChart(result) {
    const categories = result.categories || [];
    const series = result.series || [];
    const hasData = categories.length > 0 && series.some((s) => s.data.some((v) => v));

    emptyState.hidden = hasData;
    canvas.parentElement.style.display = hasData ? "" : "none";
    if (!hasData) {
      if (chart) { chart.destroy(); chart = null; }
      return;
    }

    const datasets = series.map((s, i) => ({
      label: s.label,
      data: s.data,
      backgroundColor: seriesColor(i),
      borderRadius: 4,
      borderSkipped: false,
      maxBarThickness: 56,
    }));

    if (chart) chart.destroy();
    chart = new Chart(canvas, {
      type: "bar",
      data: { labels: categories, datasets },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: series.length > 1, labels: { color: "#9fb0bd" } },
          tooltip: {
            callbacks: {
              label: (ctx) => `${ctx.dataset.label}: ${ctx.parsed.y} ${result.unit}`,
            },
          },
        },
        scales: {
          x: { ticks: { color: "#9fb0bd" }, grid: { color: "#23384a" } },
          y: {
            beginAtZero: true,
            ticks: { color: "#9fb0bd" },
            grid: { color: "#23384a" },
            title: { display: true, text: result.unit, color: "#6d8494" },
          },
        },
      },
    });
  }

  function showError(message) {
    errorText.textContent = message;
    errorBanner.hidden = false;
  }

  function hideError() {
    errorBanner.hidden = true;
  }

  function fetchAndRender() {
    const params = new URLSearchParams({
      metric: metricSelect.value,
      breakdown: breakdownSelect.value,
      date_from: dateFromInput.value,
      date_to: dateToInput.value,
      split_by_bed: splitByBedCheckbox.checked ? "1" : "0",
    });
    fetch(`${config.reportUrl}?${params}`)
      .then((resp) => resp.json().then((body) => ({ ok: resp.ok, body })))
      .then(({ ok, body }) => {
        if (!ok) throw new Error(body.error || "Грешка при зареждане на статистиката.");
        hideError();
        renderChart(body);
      })
      .catch((err) => showError(err.message));
  }

  function onMetricChange() {
    populateBreakdownOptions();
    updateSplitByBedVisibility();
    fetchAndRender();
  }

  function onBreakdownChange() {
    updateSplitByBedVisibility();
    fetchAndRender();
  }

  metricSelect.addEventListener("change", onMetricChange);
  breakdownSelect.addEventListener("change", onBreakdownChange);
  splitByBedCheckbox.addEventListener("change", fetchAndRender);
  dateFromInput.addEventListener("change", fetchAndRender);
  dateToInput.addEventListener("change", fetchAndRender);

  populateBreakdownOptions();
  updateSplitByBedVisibility();
  fetchAndRender();
})();
