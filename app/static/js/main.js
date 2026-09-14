(function () {
  // Live clock
  const clockEl = document.getElementById("clock");
  function tickClock() {
    const now = new Date();
    const pad = (n) => String(n).padStart(2, "0");
    clockEl.textContent = `${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`;
  }
  tickClock();
  setInterval(tickClock, 1000);

  // Sidebar navigation switching
  const navItems = document.querySelectorAll(".nav-item[data-target]");
  const bottomButtons = document.querySelectorAll(".bottom-btn[data-target]");
  const views = document.querySelectorAll(".view[data-view]");

  function showView(id) {
    views.forEach((v) => (v.hidden = v.dataset.view !== id));
    navItems.forEach((n) => n.classList.toggle("active", n.dataset.target === id));
  }

  navItems.forEach((btn) => btn.addEventListener("click", () => showView(btn.dataset.target)));
  bottomButtons.forEach((btn) =>
    btn.addEventListener("click", () => {
      if (document.getElementById(`view-${btn.dataset.target}`)) {
        showView(btn.dataset.target);
      }
    })
  );

  // Countdown simulation for active bed(s)
  document.querySelectorAll(".js-countdown").forEach((card) => {
    const remainingText = card.querySelector(".remaining-text");
    const fill = card.querySelector(".progress-fill");
    if (!remainingText || !fill) return;

    const totalMin = parseFloat(fill.dataset.totalMin);
    let remainingSec = parseFloat(fill.dataset.remainingMin) * 60;

    function render() {
      const min = Math.floor(remainingSec / 60);
      remainingText.textContent = `Остават ${min} мин`;
      const pct = Math.max(0, Math.min(100, ((totalMin * 60 - remainingSec) / (totalMin * 60)) * 100));
      fill.style.width = `${pct}%`;
    }

    render();
    const timer = setInterval(() => {
      remainingSec -= 1;
      if (remainingSec <= 0) {
        remainingSec = 0;
        render();
        clearInterval(timer);
        card.classList.remove("bed-card--active");
        return;
      }
      render();
    }, 1000);
  });

  // Start/Stop session button on the bed detail page (demo only, not persisted)
  const startBtn = document.querySelector(".action-btn--start");
  const stopBtn = document.querySelector(".action-btn--stop");
  if (startBtn) {
    startBtn.addEventListener("click", () => {
      const panel = startBtn.closest(".status-panel");
      panel.classList.add("status-panel--running");
      const badge = panel.querySelector(".status-badge");
      badge.textContent = "In session";
      badge.classList.remove("status-badge--idle");
      badge.classList.add("status-badge--running");
      startBtn.remove();
    });
  }
  if (stopBtn) {
    stopBtn.addEventListener("click", () => {
      const panel = stopBtn.closest(".status-panel");
      panel.classList.remove("status-panel--running", "js-countdown");
      const badge = panel.querySelector(".status-badge");
      badge.textContent = "Idle";
      badge.classList.remove("status-badge--running");
      badge.classList.add("status-badge--idle");
      panel.querySelector(".bed-remaining")?.remove();
      panel.querySelector(".progress-track")?.remove();
      stopBtn.remove();
    });
  }
})();
