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

  // Phase-aware countdown: preparation -> active tanning -> cooling.
  // startCardTicker is reusable so the main-screen poll below can restart a
  // card's ticker with fresh numbers whenever the server reports something
  // the local countdown couldn't have known on its own (a locally-started
  // session, a locally-pressed Stop, a corrected duration, ...), without
  // needing a page reload to get there.
  const STAGE_ORDER = ["prep", "active", "cooling"];
  const STAGE_LABELS = { prep: "Подготовка", active: "В сесия", cooling: "Охлаждане" };
  // Stop's behavior mirrors the controller's own physical button: during
  // active it only moves into cooling (the bed needs to cool down, not cut
  // off abruptly), so the label should say that rather than "Stop session"
  // - pressing it again once cooling is the second chance that actually ends it.
  const STOP_LABELS = { prep: "Спри сесията", active: "Спри и охлади", cooling: "Прекрати сесията" };

  function startCardTicker(el, { onFinish } = {}) {
    if (el._tickerTimer) {
      clearInterval(el._tickerTimer);
      el._tickerTimer = null;
    }

    const remainingText = el.querySelector(".remaining-text");
    const fill = el.querySelector(".progress-fill");
    const badge = el.querySelector(".status-badge");
    const skipPrepBtn = el.querySelector("#skip-prep-btn");
    const stopBtn = el.querySelector("#stop-btn");
    const stopBtnLabel = stopBtn ? stopBtn.querySelector("span") : null;
    const stopHint = el.querySelector("#stop-hint");

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
      if (skipPrepBtn) {
        skipPrepBtn.disabled = stage !== "prep";
      }
      if (stopBtnLabel) {
        stopBtnLabel.textContent = STOP_LABELS[stage];
      }
      if (stopHint) {
        stopHint.hidden = !(stage === "active" && durations.cooling > 0);
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

    el._tickerTimer = setInterval(() => {
      remainingSec -= 1;
      if (remainingSec <= 0) {
        let nextIndex = STAGE_ORDER.indexOf(stage) + 1;
        while (nextIndex < STAGE_ORDER.length && durations[STAGE_ORDER[nextIndex]] <= 0) {
          nextIndex += 1;
        }
        if (nextIndex >= STAGE_ORDER.length) {
          clearInterval(el._tickerTimer);
          el._tickerTimer = null;
          remainingSec = 0;
          render();
          el.classList.remove("js-countdown");
          if (onFinish) onFinish();
          return;
        }
        stage = STAGE_ORDER[nextIndex];
        remainingSec = durations[stage] * 60;
        applyStageClasses();
      }
      render();
    }, 1000);
  }

  document.querySelectorAll(".js-countdown").forEach((el) => {
    const isIndexCard = el.classList.contains("bed-card");
    startCardTicker(el, {
      // The bed detail page has no live-patch system of its own - reload to
      // pick up the now-idle controls. An index card just needs to look
      // idle; the poll below will confirm (or correct) it within seconds.
      onFinish: isIndexCard
        ? () => {
            el.classList.remove("phase-prep", "phase-active", "phase-cooling");
            const footer = el.querySelector(".bed-card__footer");
            if (footer) footer.hidden = true;
          }
        : () => setTimeout(() => window.location.reload(), 600),
    });
  });

  // Main screen live refresh: the controllers have their own physical
  // buttons, so a session can be set/started/stopped directly on a unit
  // with no PC involved at all. Poll the lightweight status endpoint often
  // and patch only the cards that actually changed, rather than reloading
  // the whole page on a timer - a full reload every few seconds would be
  // its own kind of annoying. A fetch() to our own server is cheap, so this
  // can run often; the real cost (talking to hardware) is throttled
  // server-side instead (see models.py), adaptively, based on how long
  // that actually takes - so this just needs to ask frequently and let the
  // server decide how fresh an answer it can afford to give.
  const bedGrid = document.querySelector(".bed-grid");
  if (bedGrid) {
    const STATUS_POLL_MS = 1000;
    const DRIFT_TOLERANCE_MIN = 1;

    function applyBedState(card, bed) {
      const footer = card.querySelector(".bed-card__footer");
      const nowRunning = bed.status === "running";

      if (nowRunning) {
        card.classList.add("js-countdown");
        card.dataset.stage = bed.stage;
        card.dataset.remainingMin = bed.remaining_min;
        card.dataset.prepMin = bed.prep_min_session;
        card.dataset.activeMin = bed.active_min_session;
        card.dataset.coolMin = bed.cool_min_session;
        if (footer) footer.hidden = false;
        startCardTicker(card, {
          onFinish: () => {
            card.classList.remove("phase-prep", "phase-active", "phase-cooling");
            if (footer) footer.hidden = true;
          },
        });
      } else {
        if (card._tickerTimer) {
          clearInterval(card._tickerTimer);
          card._tickerTimer = null;
        }
        card.classList.remove("js-countdown", "phase-prep", "phase-active", "phase-cooling");
        delete card.dataset.stage;
        if (footer) footer.hidden = true;
      }
    }

    async function pollStatus() {
      let data;
      try {
        const res = await fetch("/api/status");
        if (!res.ok) return;
        data = await res.json();
      } catch (err) {
        return; // transient network hiccup - just try again next tick
      }
      (data.beds || []).forEach((bed) => {
        const card = bedGrid.querySelector(`.bed-card[data-bed-id="${bed.id}"]`);
        if (!card) return;
        const currentStage = card.dataset.stage || null;
        const currentRemaining = Number(card.dataset.remainingMin || 0);
        const newStage = bed.status === "running" ? bed.stage : null;
        const stageChanged = currentStage !== newStage;
        const driftedTooFar = Math.abs(currentRemaining - (bed.remaining_min || 0)) > DRIFT_TOLERANCE_MIN;
        // Only touch a card when something meaningful actually changed -
        // most polls should be visually silent, letting the local ticker
        // keep counting smoothly rather than fighting it every 3 seconds.
        if (stageChanged || driftedTooFar) {
          applyBedState(card, bed);
        }
      });
    }

    setInterval(pollStatus, STATUS_POLL_MS);
  }

  // Controller address: a plain number input is the field that actually
  // gets submitted, so an address can always be typed directly (e.g. the
  // controller is known but currently unpowered, so it won't answer a
  // scan). The select next to it is just a convenience picker - scanning
  // the serial bus (0-14) fills it with whatever responds, and choosing an
  // option there copies the value into the real input.
  const controllerInput = document.getElementById("controller-address");
  const controllerPicker = document.getElementById("controller-address-picker");
  const controllerScanBtn = document.getElementById("controller-scan-btn");
  if (controllerInput && controllerPicker) {
    const realGroup = document.getElementById("controller-real-group") || controllerPicker;
    let scanned = false;
    let scanning = false;

    const setBusy = (busy) => {
      scanning = busy;
      controllerPicker.disabled = busy;
      if (controllerScanBtn) {
        controllerScanBtn.disabled = busy;
        controllerScanBtn.classList.toggle("controller-scan-btn--busy", busy);
      }
    };

    controllerPicker.addEventListener("change", () => {
      if (controllerPicker.value !== "") {
        controllerInput.value = controllerPicker.value;
      }
      controllerPicker.selectedIndex = 0;
    });

    const HW_STATUS_LABELS_BG = { free: "свободен", working: "активен", cooling: "охлаждане", waiting: "подготовка" };

    const runScan = async () => {
      if (scanning) return;
      scanned = true;
      setBusy(true);

      const placeholder = document.createElement("option");
      placeholder.textContent = "Сканиране на шината… (няколко секунди)";
      placeholder.disabled = true;
      realGroup.appendChild(placeholder);

      try {
        const res = await fetch(controllerPicker.dataset.scanUrl);
        const data = await res.json();
        placeholder.remove();

        if (!res.ok) {
          const errOpt = document.createElement("option");
          errOpt.textContent = `Сканирането пропадна: ${data.error || res.statusText}`;
          errOpt.disabled = true;
          realGroup.appendChild(errOpt);
        } else if (!data.controllers || data.controllers.length === 0) {
          const noneOpt = document.createElement("option");
          noneOpt.textContent = "Няма отговорили контролери";
          noneOpt.disabled = true;
          realGroup.appendChild(noneOpt);
        } else {
          data.controllers.forEach((ctrl) => {
            if (realGroup.querySelector(`option[value="${ctrl.address}"]`)) return;
            const opt = document.createElement("option");
            opt.value = ctrl.address;
            let label = `Адрес ${ctrl.address} — ${HW_STATUS_LABELS_BG[ctrl.status] || ctrl.status}`;
            if (ctrl.remaining_min) label += ` (${ctrl.remaining_min} мин)`;
            if (ctrl.in_use_by_bed_id) {
              label += ` · вече се използва от легло №${ctrl.in_use_by_bed_id}`;
              opt.disabled = true;
            }
            opt.textContent = label;
            realGroup.appendChild(opt);
          });
        }
      } catch (err) {
        placeholder.remove();
        const errOpt = document.createElement("option");
        errOpt.textContent = "Сканирането пропадна: мрежова грешка";
        errOpt.disabled = true;
        realGroup.appendChild(errOpt);
      } finally {
        setBusy(false);
        if (controllerPicker.showPicker) {
          try {
            controllerPicker.showPicker();
          } catch (err) {
            // ignore - user can just open the (now populated) select themselves
          }
        }
      }
    };

    controllerPicker.addEventListener("focus", () => {
      if (!scanned) runScan();
    });
    if (controllerScanBtn) {
      controllerScanBtn.addEventListener("click", runScan);
    }
  }

  // Hardware-error banner dismiss (set via ?hw_error= on the bed detail page)
  const hwErrorDismiss = document.getElementById("hw-error-dismiss");
  const hwErrorBanner = document.getElementById("hw-error-banner");
  if (hwErrorDismiss && hwErrorBanner) {
    hwErrorDismiss.addEventListener("click", () => hwErrorBanner.remove());
  }
})();
