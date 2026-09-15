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

  // Sidebar navigation switching (for the client-side placeholder views only)
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

  // Generic slick range sliders (session length, bed count, prep/cool time, ...)
  document.querySelectorAll(".range-input").forEach((input) => {
    const valueEl = document.getElementById(input.dataset.valueTarget);
    const suffix = input.dataset.suffix || "";
    const update = () => {
      const value = Number(input.value);
      const min = Number(input.min);
      const max = Number(input.max);
      const pct = max > min ? ((value - min) / (max - min)) * 100 : 0;
      input.style.setProperty("--fill", `${pct}%`);
      if (valueEl) valueEl.textContent = `${value}${suffix}`;
    };
    input.addEventListener("input", update);
    update();
  });

  // Settings panel toggle on the bed detail page
  const settingsToggle = document.getElementById("settings-toggle");
  const settingsPanel = document.getElementById("bed-settings-panel");
  if (settingsToggle && settingsPanel) {
    settingsToggle.addEventListener("click", () => {
      const willOpen = settingsPanel.hidden;
      settingsPanel.hidden = !willOpen;
      settingsToggle.setAttribute("aria-expanded", String(willOpen));
      settingsToggle.classList.toggle("settings-toggle--open", willOpen);
    });
  }

  // Phase-aware countdown: preparation -> active tanning -> cooling
  const STAGE_ORDER = ["prep", "active", "cooling"];
  const STAGE_LABELS = { prep: "Preparing", active: "In session", cooling: "Cooling down" };

  document.querySelectorAll(".js-countdown").forEach((el) => {
    const remainingText = el.querySelector(".remaining-text");
    const fill = el.querySelector(".progress-fill");
    const badge = el.querySelector(".status-badge");

    const durations = {
      prep: parseFloat(el.dataset.prepMin || "0"),
      active: parseFloat(el.dataset.activeMin || "0"),
      cooling: parseFloat(el.dataset.coolMin || "0"),
    };
    let stage = el.dataset.stage;
    let remainingSec = parseFloat(el.dataset.remainingMin || "0") * 60;

    function applyStageClasses() {
      el.classList.remove("phase-prep", "phase-active", "phase-cooling");
      el.classList.add(`phase-${stage}`);
      if (badge) {
        badge.classList.remove("status-badge--prep", "status-badge--active", "status-badge--cooling");
        badge.classList.add(`status-badge--${stage}`);
        badge.textContent = STAGE_LABELS[stage];
      }
    }

    function render() {
      if (remainingText) {
        remainingText.textContent = `Остават ${Math.max(0, Math.round(remainingSec / 60))} мин`;
      }
      if (fill) {
        const totalStageSec = (durations[stage] || 0) * 60;
        const pct = totalStageSec > 0
          ? Math.max(0, Math.min(100, ((totalStageSec - remainingSec) / totalStageSec) * 100))
          : 100;
        fill.style.width = `${pct}%`;
      }
    }

    applyStageClasses();
    render();

    const timer = setInterval(() => {
      remainingSec -= 1;
      if (remainingSec <= 0) {
        let nextIndex = STAGE_ORDER.indexOf(stage) + 1;
        while (nextIndex < STAGE_ORDER.length && durations[STAGE_ORDER[nextIndex]] <= 0) {
          nextIndex += 1;
        }
        if (nextIndex >= STAGE_ORDER.length) {
          clearInterval(timer);
          remainingSec = 0;
          render();
          // Session finished server-side too; reload to pick up the idle state.
          setTimeout(() => window.location.reload(), 600);
          return;
        }
        stage = STAGE_ORDER[nextIndex];
        remainingSec = durations[stage] * 60;
        applyStageClasses();
      }
      render();
    }, 1000);
  });
})();
