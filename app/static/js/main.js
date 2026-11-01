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
      const shown = input.dataset.decimals ? value.toFixed(Number(input.dataset.decimals)) : value;
      if (valueEl) valueEl.textContent = `${shown}${suffix}`;
    };
    input.addEventListener("input", update);
    update();
  });

  // Drum picker: a scroll-snap vertical wheel, replacing the plain-text
  // value badge on session-length/prep-min/cool-min (data-drum="true")
  // with a spinnable one. It's a second, more precise way to set the
  // same underlying range input that dragging the slider or clicking a
  // tick mark already do - all three stay in sync purely through the
  // input's own native "input" event, so neither this nor the tick
  // handler below needs to know about price recompute, fill %, or any
  // other listener already attached elsewhere (session-length's cash-due
  // recompute, for one) - dispatching that event is enough for all of
  // it to just happen, same as if the slider had been dragged by hand.
  const DRUM_ROW_H = 28;
  const drumResyncFns = [];

  function initDrumPicker(input) {
    const valueEl = document.getElementById(input.dataset.valueTarget);
    if (!valueEl) return null;
    const min = Number(input.min);
    const max = Number(input.max);

    const viewport = document.createElement("div");
    viewport.className = "drum-picker__viewport";
    // One tab stop for the whole drum, not one per value - 35 stops to
    // tab past just to get from session length to the Start button would
    // make keyboard use worse, not better. Arrow keys (wired below) are
    // the actual keyboard interaction once it's focused, same as a
    // native <input type="range">, so it's marked up as the nearest ARIA
    // equivalent for a discrete value picker.
    viewport.tabIndex = 0;
    viewport.setAttribute("role", "spinbutton");
    viewport.setAttribute("aria-valuemin", String(min));
    viewport.setAttribute("aria-valuemax", String(max));
    const fieldLabel = input.closest(".slider-field")?.querySelector(".slider-field__label");
    if (fieldLabel) viewport.setAttribute("aria-label", fieldLabel.textContent.trim());
    const list = document.createElement("div");
    list.className = "drum-picker__list";
    for (let v = min; v <= max; v++) {
      const item = document.createElement("button");
      item.type = "button";
      item.tabIndex = -1; // reachable by click/touch only - see viewport.tabIndex above
      item.className = "drum-picker__item";
      item.textContent = String(v);
      item.dataset.value = String(v);
      list.appendChild(item);
    }
    viewport.appendChild(list);
    const highlight = document.createElement("div");
    highlight.className = "drum-picker__highlight";
    viewport.appendChild(highlight);
    const container = document.createElement("div");
    container.className = "drum-picker";
    container.appendChild(viewport);
    valueEl.replaceWith(container);

    let syncingFromInput = false;
    let settleTimer = null;

    function setActiveItem(value) {
      list.querySelectorAll(".drum-picker__item--active").forEach((el) => {
        el.classList.remove("drum-picker__item--active");
      });
      const item = list.querySelector(`[data-value="${value}"]`);
      if (item) item.classList.add("drum-picker__item--active");
      viewport.setAttribute("aria-valuenow", String(value));
    }

    function scrollToValue(value, smooth) {
      const clamped = Math.max(min, Math.min(max, Math.round(value)));
      viewport.scrollTo({ top: (clamped - min) * DRUM_ROW_H, behavior: smooth ? "smooth" : "auto" });
      setActiveItem(clamped);
    }

    function valueFromScroll() {
      const idx = Math.round(viewport.scrollTop / DRUM_ROW_H);
      return min + Math.max(0, Math.min(max - min, idx));
    }

    viewport.addEventListener("scroll", () => {
      if (syncingFromInput) return;
      clearTimeout(settleTimer);
      settleTimer = setTimeout(() => {
        const value = valueFromScroll();
        setActiveItem(value);
        if (Number(input.value) !== value) {
          input.value = String(value);
          input.dispatchEvent(new Event("input", { bubbles: true }));
        }
      }, 120);
    });

    list.addEventListener("click", (evt) => {
      const item = evt.target.closest(".drum-picker__item");
      if (!item) return;
      scrollToValue(Number(item.dataset.value), true);
    });

    viewport.addEventListener("keydown", (evt) => {
      // A native <input> submits its form on Enter; a plain div (what
      // the drum's viewport is, for scroll-snap) never does, no matter
      // its tabIndex - has to be wired up by hand to match.
      // requestSubmit() (not submit()) so it goes through the normal
      // submit button rather than bypassing it, same end result as
      // clicking "Старт на сесията" (or "Запази настройките" for the
      // prep/cool drums, which live in the settings form instead) by hand.
      if (evt.key === "Enter") {
        evt.preventDefault();
        viewport.closest("form")?.requestSubmit();
        return;
      }
      if (evt.key !== "ArrowUp" && evt.key !== "ArrowDown") return;
      evt.preventDefault();
      // Same "set .value, dispatch a real input event" path as a tick
      // click (below) or dragging the native slider - the input's own
      // "input" listener (above) is what actually moves the drum, via an
      // instant (non-smooth) scroll. Driving the scroll directly from
      // here instead, smoothly, raced against rapid repeated key presses:
      // a smooth scroll fires many intermediate "scroll" events, each
      // resetting that listener's settle timer, so a quick burst of
      // arrow presses could leave it never settling - and therefore
      // never actually reaching input.value - at all.
      const delta = evt.key === "ArrowUp" ? -1 : 1;
      const clamped = Math.max(min, Math.min(max, Number(input.value) + delta));
      if (clamped !== Number(input.value)) {
        input.value = String(clamped);
        input.dispatchEvent(new Event("input", { bubbles: true }));
      }
    });

    input.addEventListener("input", () => {
      syncingFromInput = true;
      scrollToValue(Number(input.value), false);
      clearTimeout(settleTimer);
      settleTimer = setTimeout(() => { syncingFromInput = false; }, 150);
    });

    const resync = () => scrollToValue(Number(input.value), false);
    drumResyncFns.push(resync);
    resync();
    return viewport;
  }

  // Keyboard flow for starting a session: Tab reaches a bed card on the
  // main screen and Enter opens it (both native <a> behavior, no JS
  // needed) - landing here, on session length, is the next natural step,
  // so its drum is focused automatically rather than making a keyboard
  // user tab past the card-search field first to reach it. initDrumPicker
  // runs once per input (not twice for session-length) and its return
  // value is kept around just long enough to find that one by id.
  const drumViewports = new Map();
  document.querySelectorAll('.range-input[data-drum="true"]').forEach((input) => {
    const viewport = initDrumPicker(input);
    if (viewport) drumViewports.set(input.id, viewport);
  });
  drumViewports.get("session-length")?.focus();

  // Clicking a tick-mark number jumps the slider straight there - same
  // "set .value, dispatch a real input event" approach as the drum
  // picker above, so it's automatically in sync with both. Not a tab
  // stop of its own (see drum items above, same reasoning) - the drum's
  // arrow keys already reach every value a tick would jump to.
  document.querySelectorAll(".slider-field__tick[data-for]").forEach((tick) => {
    tick.tabIndex = -1;
    const input = document.getElementById(tick.dataset.for);
    if (!input) return;
    tick.addEventListener("click", () => {
      input.value = tick.dataset.value;
      input.dispatchEvent(new Event("input", { bubbles: true }));
    });
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
      // prep-min/cool-min's drum pickers were initialized while this
      // panel was hidden (display:none) - scrolling a hidden element
      // doesn't reliably stick, so re-apply their position now that it
      // actually has layout.
      if (willOpen) drumResyncFns.forEach((fn) => fn());
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
  const LINK_STATUS_LABELS = {
    online: "Връзка с контролера: активна",
    offline: "Няма връзка с контролера",
    unknown: "Връзката с контролера още не е проверена",
  };

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
      // Minutes can only be added while preparing - once tanning starts
      // (on its own, or via "Старт сега"), take the controls away.
      if (stage !== "prep" && !el.classList.contains("bed-card")) {
        ["extend-toggle", "extend-panel", "main-time-line"].forEach((id) => {
          const node = document.getElementById(id);
          if (node) node.hidden = true;
        });
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
        // The link dot updates every poll regardless - whether a real
        // bed's controller is answering can change independently of
        // session state (it can go offline mid-session, too), and a
        // demo bed never has one to begin with (bed.link_status is null).
        const dot = card.querySelector(".link-dot");
        if (dot && bed.link_status) {
          dot.className = `link-dot link-dot--${bed.link_status}`;
          dot.title = LINK_STATUS_LABELS[bed.link_status] || "";
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

  // Bed photo drag-and-drop: browsers never expose a dropped file's real
  // filesystem path (the same restriction the field's own hint text
  // explains), so a drop can't "autofill the path" the way pasting one
  // does - instead it uploads the file's actual bytes to the server
  // (see /bed/<id>/photo/upload in app.py) and fills the text field with
  // the resulting /static/... URL, same as if that path had been typed.
  // Only the file touches disk here; it's still not saved to the bed's
  // record until "Запази настройките" is submitted, same as every other
  // field on this form.
  const photoDropZone = document.getElementById("photo-drop-zone");
  if (photoDropZone) {
    const picturePathInput = document.getElementById("picture-path-input");
    const photoFileInput = document.getElementById("photo-file-input");
    const photoBrowseBtn = document.getElementById("photo-browse-btn");
    const photoUploadError = document.getElementById("photo-upload-error");
    const photoUploadErrorText = document.getElementById("photo-upload-error-text");
    const uploadUrl = photoDropZone.dataset.uploadUrl;
    let previewObjectUrl = null;

    function showPhotoError(message) {
      photoUploadErrorText.textContent = message;
      photoUploadError.hidden = false;
    }

    async function uploadPhoto(file) {
      photoUploadError.hidden = true;
      if (!file.type.startsWith("image/")) {
        showPhotoError("Файлът не изглежда да е изображение.");
        return;
      }

      // Instant local preview while the upload is in flight, so staff
      // sees feedback immediately rather than waiting on the round trip.
      if (previewObjectUrl) URL.revokeObjectURL(previewObjectUrl);
      previewObjectUrl = URL.createObjectURL(file);
      const previewImg = document.querySelector(".bed-photo");
      if (previewImg) previewImg.src = previewObjectUrl;

      const formData = new FormData();
      formData.append("photo", file);
      try {
        const res = await fetch(uploadUrl, { method: "POST", body: formData });
        const data = await res.json();
        if (!data.ok) {
          showPhotoError(data.error || "Качването се провали.");
          return;
        }
        picturePathInput.value = data.picture_path;
        if (previewImg) previewImg.src = data.picture_path;
      } catch (err) {
        showPhotoError("Мрежова грешка при качване на файла.");
      }
    }

    photoBrowseBtn.addEventListener("click", () => photoFileInput.click());
    photoFileInput.addEventListener("change", () => {
      if (photoFileInput.files[0]) uploadPhoto(photoFileInput.files[0]);
      photoFileInput.value = "";
    });

    ["dragenter", "dragover"].forEach((evtName) => {
      photoDropZone.addEventListener(evtName, (evt) => {
        evt.preventDefault();
        photoDropZone.classList.add("photo-drop-zone--active");
      });
    });
    ["dragleave", "dragend"].forEach((evtName) => {
      photoDropZone.addEventListener(evtName, () => {
        photoDropZone.classList.remove("photo-drop-zone--active");
      });
    });
    photoDropZone.addEventListener("drop", (evt) => {
      evt.preventDefault();
      photoDropZone.classList.remove("photo-drop-zone--active");
      const file = evt.dataTransfer.files[0];
      if (file) uploadPhoto(file);
    });
  }

  // Error banner dismiss (hw_error / payment_error / generic ?error= on
  // various pages) - class-based so more than one banner can appear on a
  // page without id collisions.
  document.querySelectorAll(".hw-error-banner").forEach((banner) => {
    const dismiss = banner.querySelector(".hw-error-dismiss");
    if (dismiss) dismiss.addEventListener("click", () => banner.remove());
  });

  // Barcode-scanned fields elsewhere (e.g. pasting a card number while
  // issuing or editing a card): the scanner's trailing Enter would
  // otherwise submit that form immediately, possibly before the other
  // fields (deposit, name, ...) have been filled in. The card-search field
  // above has its own smarter Enter handling instead of this generic one.
  document.querySelectorAll(".js-barcode-field").forEach((input) => {
    input.addEventListener("keydown", (evt) => {
      if (evt.key === "Enter") evt.preventDefault();
    });
  });

  // Session payment: a client card is found by typing part of its number,
  // owner name, or phone (a plain <select> of every active card doesn't
  // scale once a studio has issued hundreds of cards - same reasoning as
  // the search box on the Cards page). The card-amount slider is bounded
  // by the selected card's balance (and by what the session could possibly
  // cost), and a cash-due readout updates locally for instant feedback,
  // then refines via a server quote (which accounts for per-recharge-option
  // bed rates the client has no way to compute on its own).
  // Minutes the payment covers: the whole session when starting, but only
  // the minutes above what's already paid when adding to a session in
  // preparation (data-base-min, see _session_form.html).
  function billableMin(input) {
    if (!input) return 0;
    const base = parseFloat(input.dataset.baseMin || "0");
    return Math.max(0, parseFloat(input.value || "0") - base);
  }

  // Forms with data-confirm ask first in a Yes/No dialog (#confirm-dialog)
  // rather than the browser's confirm(), whose OK/Cancel can't be relabeled.
  // "Не" is focused by default, so a stray Enter never deletes anything.
  const confirmDialog = document.getElementById("confirm-dialog");
  if (confirmDialog) {
    let pendingForm = null;
    document.querySelectorAll("form[data-confirm]").forEach((form) => {
      form.addEventListener("submit", (evt) => {
        evt.preventDefault();
        pendingForm = form;
        document.getElementById("confirm-dialog-text").textContent = form.dataset.confirm;
        document.getElementById("confirm-dialog-yes").textContent = form.dataset.confirmYes || "Да, изтрий";
        confirmDialog.showModal();
        document.getElementById("confirm-dialog-no").focus();
      });
    });
    document.getElementById("confirm-dialog-no").addEventListener("click", () => confirmDialog.close());
    document.getElementById("confirm-dialog-yes").addEventListener("click", () => {
      confirmDialog.close();
      if (pendingForm) pendingForm.submit(); // submit() skips the listener above
    });
    // Esc closes the dialog natively without submitting - same as "Не".
  }

  const extendToggle = document.getElementById("extend-toggle");
  const extendPanel = document.getElementById("extend-panel");
  if (extendToggle && extendPanel) {
    extendToggle.addEventListener("click", () => {
      const willOpen = extendPanel.hidden;
      extendPanel.hidden = !willOpen;
      extendToggle.setAttribute("aria-expanded", String(willOpen));
      if (willOpen) {
        drumResyncFns.forEach((fn) => fn()); // the drum was laid out while hidden
        drumViewports.get("session-length")?.focus();
      }
    });
  }
  const extraMinEl = document.getElementById("session-extra-min");
  const extendLengthInput = document.getElementById("session-length");
  if (extraMinEl && extendLengthInput) {
    extendLengthInput.addEventListener("input", () => {
      extraMinEl.textContent = String(billableMin(extendLengthInput));
    });
  }

  const paymentCardIdInput = document.getElementById("payment-card-id");
  const paymentCardSearchInput = document.getElementById("payment-card-search");
  const paymentCardResults = document.getElementById("payment-card-results");
  const paymentCardAmountField = document.getElementById("payment-card-amount-field");
  const paymentCardAmountInput = document.getElementById("payment-card-amount");
  const paymentCashDue = document.getElementById("payment-cash-due");
  const paymentCardBalanceInfo = document.getElementById("payment-card-balance-info");
  const paymentCardBalanceAmount = document.getElementById("payment-card-balance-amount");
  const paymentCardBalanceMinutes = document.getElementById("payment-card-balance-minutes");
  const sessionLengthInput = document.getElementById("session-length");

  if (
    paymentCardIdInput && paymentCardSearchInput && paymentCardResults &&
    paymentCardAmountField && paymentCardAmountInput && paymentCashDue
  ) {
    const pricePerMin = parseFloat(paymentCardSearchInput.dataset.pricePerMin || "0");
    const bedId = paymentCardSearchInput.dataset.bedId;
    let selectedBalance = 0;
    // Card balance is used first: a freshly selected card starts at the
    // most it can cover, and keeps tracking that maximum as the session
    // length changes - until staff deliberately move the slider below it.
    let cardAtMax = true;
    let searchTimer = null;
    let quoteTimer = null;
    const paymentCardAmountValue = document.getElementById("card-amount-value");
    const paymentCashDueRow = document.getElementById("payment-cash-due-row");

    const totalMin = () => billableMin(sessionLengthInput);

    function updateCashDueLocally() {
      const flatTotal = totalMin() * pricePerMin;
      const cardAmount = parseFloat(paymentCardAmountInput.value || "0");
      const cash = Math.max(0, flatTotal - cardAmount);
      paymentCashDue.textContent = `${cash.toFixed(2)} €`;
    }

    function renderCardBalanceInfo(data) {
      if (!paymentCardIdInput.value || data.card_balance_after === undefined) {
        paymentCardBalanceInfo.hidden = true;
        return;
      }
      paymentCardBalanceAmount.textContent = `${data.card_balance_after.toFixed(2)} €`;
      paymentCardBalanceMinutes.textContent = `(≈ ${data.card_minutes_after.toFixed(1)} мин на това легло)`;
      paymentCardBalanceInfo.hidden = false;
    }

    function fetchQuote() {
      if (!bedId) return;
      const cardId = paymentCardIdInput.value;
      const params = new URLSearchParams({
        bed_id: bedId,
        total_min: totalMin(),
        card_id: cardId || "",
        card_amount: cardId ? paymentCardAmountInput.value || "0" : "0",
      });
      clearTimeout(quoteTimer);
      quoteTimer = setTimeout(async () => {
        try {
          const res = await fetch(`/api/sessions/quote?${params.toString()}`);
          if (!res.ok) return;
          const data = await res.json();
          paymentCashDue.textContent = `${data.cash_amount.toFixed(2)} €`;
          renderCardBalanceInfo(data);
        } catch (err) {
          // leave the local estimate in place on a transient network hiccup
        }
      }, 150);
    }

    function updateCardAmountBounds() {
      const max = Math.max(0, Math.min(selectedBalance, totalMin() * pricePerMin));
      paymentCardAmountInput.max = max.toFixed(2);
      if (cardAtMax || parseFloat(paymentCardAmountInput.value) > max) {
        paymentCardAmountInput.value = max.toFixed(2);
      }
      paymentCardAmountInput.dispatchEvent(new Event("input"));
    }

    function setCardAmount(toMax) {
      if (!paymentCardIdInput.value) return;
      cardAtMax = toMax;
      paymentCardAmountInput.value = toMax ? paymentCardAmountInput.max : 0;
      paymentCardAmountInput.dispatchEvent(new Event("input"));
    }

    function clearSelection() {
      paymentCardIdInput.value = "";
      selectedBalance = 0;
      paymentCardAmountField.hidden = true;
      paymentCardAmountInput.value = 0;
      paymentCardBalanceInfo.hidden = true;
      updateCardAmountBounds();
      updateCashDueLocally();
      fetchQuote();
    }

    function selectCard(option) {
      paymentCardIdInput.value = option.value;
      selectedBalance = parseFloat(option.dataset.balance || "0");
      paymentCardSearchInput.value = option.dataset.label || option.textContent;
      paymentCardResults.hidden = true;
      paymentCardAmountField.hidden = false;
      cardAtMax = true;
      updateCardAmountBounds();
      updateCashDueLocally();
      fetchQuote();
    }

    async function runCardSearch(q) {
      try {
        const res = await fetch(`/api/cards/search?q=${encodeURIComponent(q)}`);
        if (!res.ok) return;
        const data = await res.json();
        paymentCardResults.innerHTML = "";
        if (!data.cards || data.cards.length === 0) {
          const opt = document.createElement("option");
          opt.textContent = "Няма намерени карти";
          opt.disabled = true;
          paymentCardResults.appendChild(opt);
        } else {
          data.cards.forEach((card) => {
            const opt = document.createElement("option");
            opt.value = card.id;
            opt.dataset.balance = card.balance;
            opt.dataset.label = card.label;
            opt.textContent = `${card.label} — баланс ${card.balance.toFixed(2)} €`;
            paymentCardResults.appendChild(opt);
          });
        }
        paymentCardResults.hidden = false;
      } catch (err) {
        // transient network hiccup - leave whatever results were already shown
      }
    }

    paymentCardSearchInput.addEventListener("input", () => {
      if (paymentCardIdInput.value) clearSelection();
      const q = paymentCardSearchInput.value.trim();
      clearTimeout(searchTimer);
      searchTimer = setTimeout(() => runCardSearch(q), 200);
    });

    paymentCardSearchInput.addEventListener("focus", () => {
      if (!paymentCardIdInput.value) runCardSearch(paymentCardSearchInput.value.trim());
    });

    // A barcode reader "types" the card number into whatever field has
    // focus and finishes with an Enter keystroke - inside this <form>,
    // that's enough to submit it immediately (starting the session with
    // whatever was selected, or with nothing) before staff can react.
    // Swallow that Enter, and since a scanned number almost always narrows
    // the search to exactly one card, use it to select that card right
    // away instead - the staff still presses Start themselves.
    paymentCardSearchInput.addEventListener("keydown", async (evt) => {
      if (evt.key !== "Enter") return;
      evt.preventDefault();
      clearTimeout(searchTimer);
      await runCardSearch(paymentCardSearchInput.value.trim());
      const opts = paymentCardResults.options;
      if (opts.length === 1 && opts[0].value) {
        selectCard(opts[0]);
      }
    });

    paymentCardResults.addEventListener("change", () => {
      const opt = paymentCardResults.selectedOptions[0];
      if (opt && opt.value) selectCard(opt);
    });

    paymentCardAmountInput.addEventListener("input", (evt) => {
      // Only a real drag/keypress changes the preference - programmatic
      // updates (synthetic events) already set cardAtMax themselves.
      if (evt.isTrusted) {
        cardAtMax = parseFloat(paymentCardAmountInput.value) >= parseFloat(paymentCardAmountInput.max);
      }
      updateCashDueLocally();
      fetchQuote();
    });

    if (paymentCardAmountValue) {
      paymentCardAmountValue.addEventListener("dblclick", () => setCardAmount(true));
    }
    if (paymentCashDueRow) {
      paymentCashDueRow.addEventListener("dblclick", () => setCardAmount(false));
    }

    document.addEventListener("click", (evt) => {
      if (evt.target !== paymentCardSearchInput && !paymentCardResults.contains(evt.target)) {
        paymentCardResults.hidden = true;
      }
    });

    if (sessionLengthInput) {
      sessionLengthInput.addEventListener("input", () => {
        updateCardAmountBounds();
        updateCashDueLocally();
        fetchQuote();
      });
    }

    updateCashDueLocally();
  }

  // Chip card payment on the session-start form - the physical card IS
  // the balance, so there's no search: just read whatever's inserted.
  // Mutually exclusive with the virtual card above - picking one clears
  // the other, since starting a session only ever applies one payment
  // source (see models.start_session_with_payment).
  const paymentChipReadBtn = document.getElementById("payment-chip-read-btn");
  const paymentChipAmountField = document.getElementById("payment-chip-amount-field");
  const paymentChipAmountInput = document.getElementById("payment-chip-amount");
  const paymentChipInfo = document.getElementById("payment-chip-info");

  if (paymentChipReadBtn && paymentChipAmountField && paymentChipAmountInput && paymentChipInfo) {
    const chipBedId = paymentChipReadBtn.dataset.bedId;
    const chipPricePerMin = parseFloat(paymentChipReadBtn.dataset.pricePerMin || "0");
    let chipBalance = 0;
    let chipClientNumber = null;
    let chipQuoteTimer = null;
    let chipAtMax = true; // same card-first rule as the virtual card above
    const paymentChipAmountValue = document.getElementById("chip-amount-value");
    const paymentChipCashDueRow = document.getElementById("payment-cash-due-row");

    const chipTotalMin = () => billableMin(sessionLengthInput);

    function clearVirtualCardForChip() {
      if (paymentCardIdInput && paymentCardIdInput.value) {
        paymentCardIdInput.value = "";
        if (paymentCardSearchInput) paymentCardSearchInput.value = "";
        if (paymentCardAmountField) paymentCardAmountField.hidden = true;
        if (paymentCardAmountInput) paymentCardAmountInput.value = 0;
        if (paymentCardBalanceInfo) paymentCardBalanceInfo.hidden = true;
      }
    }

    function clearChipSelection() {
      chipClientNumber = null;
      chipBalance = 0;
      paymentChipAmountField.hidden = true;
      paymentChipAmountInput.value = 0;
    }

    function updateChipAmountBounds() {
      const max = Math.max(0, Math.min(chipBalance, chipTotalMin() * chipPricePerMin));
      paymentChipAmountInput.max = max.toFixed(2);
      if (chipAtMax || parseFloat(paymentChipAmountInput.value) > max) {
        paymentChipAmountInput.value = max.toFixed(2);
      }
      paymentChipAmountInput.dispatchEvent(new Event("input"));
    }

    function setChipAmount(toMax) {
      if (chipClientNumber === null) return;
      chipAtMax = toMax;
      paymentChipAmountInput.value = toMax ? paymentChipAmountInput.max : 0;
      paymentChipAmountInput.dispatchEvent(new Event("input"));
    }

    function fetchChipQuote() {
      if (!chipBedId || chipClientNumber === null) return;
      const params = new URLSearchParams({
        bed_id: chipBedId,
        total_min: chipTotalMin(),
        chip_amount: paymentChipAmountInput.value || "0",
      });
      clearTimeout(chipQuoteTimer);
      chipQuoteTimer = setTimeout(async () => {
        try {
          const res = await fetch(`/api/chipcard/quote?${params.toString()}`);
          if (!res.ok) return;
          const data = await res.json();
          if (data.error) return;
          if (paymentCashDue) paymentCashDue.textContent = `${data.cash_amount.toFixed(2)} €`;
          paymentChipInfo.textContent =
            `Чип карта №${data.client_number}${data.client_name ? " — " + data.client_name : ""} ` +
            `— остатък ${data.card_balance_after.toFixed(2)} €`;
        } catch (err) {
          // leave the local estimate in place on a transient network hiccup
        }
      }, 150);
    }

    paymentChipReadBtn.addEventListener("click", async () => {
      paymentChipReadBtn.disabled = true;
      try {
        const res = await fetch("/api/chipcard/read");
        const data = await res.json();
        if (!data.ok) {
          clearChipSelection();
          paymentChipInfo.textContent = data.error || "Грешка при четене.";
          paymentChipInfo.hidden = false;
          return;
        }
        const card = data.card;
        if (card.client_number === null) {
          clearChipSelection();
          paymentChipInfo.textContent = "Картата не е издадена. Издайте я от страница Карти.";
          paymentChipInfo.hidden = false;
          return;
        }
        if (card.balance === null) {
          clearChipSelection();
          paymentChipInfo.textContent = "Балансът на картата не може да бъде прочетен.";
          paymentChipInfo.hidden = false;
          return;
        }
        clearVirtualCardForChip();
        chipClientNumber = card.client_number;
        chipBalance = card.balance;
        const name = (data.known && data.known.name) || card.client_name || "";
        paymentChipInfo.textContent =
          `Чип карта №${card.client_number}${name ? " — " + name : ""} — баланс ${card.balance.toFixed(2)} €`;
        paymentChipInfo.hidden = false;
        paymentChipAmountField.hidden = false;
        chipAtMax = true;
        updateChipAmountBounds();
        fetchChipQuote();
      } catch (err) {
        clearChipSelection();
        paymentChipInfo.textContent = "Мрежова грешка при четене на картата.";
        paymentChipInfo.hidden = false;
      } finally {
        paymentChipReadBtn.disabled = false;
      }
    });

    paymentChipAmountInput.addEventListener("input", (evt) => {
      if (evt.isTrusted) {
        chipAtMax = parseFloat(paymentChipAmountInput.value) >= parseFloat(paymentChipAmountInput.max);
      }
      fetchChipQuote();
    });

    if (paymentChipAmountValue) {
      paymentChipAmountValue.addEventListener("dblclick", () => setChipAmount(true));
    }
    if (paymentChipCashDueRow) {
      paymentChipCashDueRow.addEventListener("dblclick", () => setChipAmount(false));
    }

    if (sessionLengthInput) {
      sessionLengthInput.addEventListener("input", () => {
        if (chipClientNumber !== null) {
          updateChipAmountBounds();
          fetchChipQuote();
        }
      });
    }

    // Typing in the virtual-card search (above) means staff want that
    // instead - drop any chip selection so only one payment source applies.
    if (paymentCardSearchInput) {
      paymentCardSearchInput.addEventListener("input", () => {
        if (chipClientNumber !== null) {
          clearChipSelection();
          paymentChipInfo.hidden = true;
        }
      });
    }
  }

  // Collapsible "add product"/"add service" panel on the Cosmetics and
  // Services pages - same show/hide idiom as the bed-settings panel above.
  function initCollapsibleFormToggle(toggleId, panelId) {
    const toggle = document.getElementById(toggleId);
    const panel = document.getElementById(panelId);
    if (!toggle || !panel) return;
    toggle.addEventListener("click", () => {
      const willOpen = panel.hidden;
      panel.hidden = !willOpen;
      toggle.setAttribute("aria-expanded", String(willOpen));
      toggle.classList.toggle("settings-toggle--open", willOpen);
    });
  }
  initCollapsibleFormToggle("product-form-toggle", "product-form-panel");
  initCollapsibleFormToggle("service-form-toggle", "service-form-panel");

  // Basket checkout: pick items from a searchable list (double-click adds
  // one unit), double-click a basket line to remove one, then pay with an
  // optional card (searched the same way as the session-start page) plus
  // cash for the rest - built for a catalog of 100+ items, where a
  // one-card-per-item grid with an inline sell form per item stopped
  // being usable. Shared by Cosmetics (products, stock-limited - items
  // carry a data-stock cap) and Services (no stock concept at all - a
  // row with no data-stock attribute parses as NaN, and qty >= NaN is
  // always false, so the same cap check is naturally a no-op for them).
  // The two pages never share a tab, so it's safe for them to also share
  // the basket/checkout element ids below (basket-list, checkout-*) -
  // only the item-list ids and the hidden field name submitted differ,
  // which is what cfg parameterizes.
  function initPosBasket(cfg) {
  const productSearchInput = document.getElementById(cfg.searchId);
  const productListEl = document.getElementById(cfg.listId);
  const basketListEl = document.getElementById("basket-list");
  const basketEmptyEl = document.getElementById("basket-empty");
  const basketTotalEl = document.getElementById("basket-total");
  const checkoutSubmitBtn = document.getElementById("checkout-submit-btn");
  const checkoutForm = document.getElementById("checkout-form");
  const checkoutCardIdInput = document.getElementById("checkout-card-id");
  const checkoutCardSearchInput = document.getElementById("checkout-card-search");
  const checkoutCardResults = document.getElementById("checkout-card-results");
  const checkoutCardAmountField = document.getElementById("checkout-card-amount-field");
  const checkoutCardAmountInput = document.getElementById("checkout-card-amount");
  const checkoutCardBalanceInfo = document.getElementById("checkout-card-balance-info");
  const checkoutCardBalanceAmount = document.getElementById("checkout-card-balance-amount");
  const checkoutCashDue = document.getElementById("checkout-cash-due");

  if (productListEl && basketListEl) {
    const basket = new Map(); // product_id (string) -> {id, name, price, qty}
    let cardBalance = 0;
    let cardSearchTimer = null;

    function basketTotal() {
      let total = 0;
      basket.forEach((line) => { total += line.price * line.qty; });
      return total;
    }

    function updateCardAmountBounds() {
      const max = Math.max(0, Math.min(cardBalance, basketTotal()));
      checkoutCardAmountInput.max = max.toFixed(2);
      if (parseFloat(checkoutCardAmountInput.value) > max) {
        checkoutCardAmountInput.value = max;
      }
      checkoutCardAmountInput.dispatchEvent(new Event("input"));
    }

    function updateCashDue() {
      const cardAmount = checkoutCardIdInput.value ? parseFloat(checkoutCardAmountInput.value || "0") : 0;
      const cash = Math.max(0, basketTotal() - cardAmount);
      checkoutCashDue.textContent = `${cash.toFixed(2)} €`;
    }

    function updateCardBalanceInfo() {
      if (!checkoutCardIdInput.value) {
        checkoutCardBalanceInfo.hidden = true;
        return;
      }
      // A product sale deducts 1:1 from the card (no per-bed rate to
      // convert through), so unlike the session-start page this needs no
      // server round trip - plain local subtraction is exact.
      const cardAmount = parseFloat(checkoutCardAmountInput.value || "0");
      checkoutCardBalanceAmount.textContent = `${(cardBalance - cardAmount).toFixed(2)} €`;
      checkoutCardBalanceInfo.hidden = false;
    }

    function renderBasket() {
      basketListEl.querySelectorAll(".basket-row").forEach((el) => el.remove());
      let count = 0;
      basket.forEach((line) => {
        count += line.qty;
        const row = document.createElement("div");
        row.className = "basket-row";
        row.title = "Двоен клик за премахване на 1 бр.";
        const nameEl = document.createElement("span");
        nameEl.className = "basket-row__name";
        nameEl.textContent = line.name;
        const qtyEl = document.createElement("span");
        qtyEl.className = "basket-row__qty";
        qtyEl.textContent = `x${line.qty}`;
        const totalEl = document.createElement("span");
        totalEl.className = "basket-row__total";
        totalEl.textContent = `${(line.price * line.qty).toFixed(2)} €`;
        row.append(nameEl, qtyEl, totalEl);
        row.addEventListener("dblclick", () => removeFromBasket(line.id));
        basketListEl.appendChild(row);
      });
      basketEmptyEl.hidden = count > 0;
      basketTotalEl.textContent = `${basketTotal().toFixed(2)} €`;
      checkoutSubmitBtn.disabled = count === 0;
      updateCardAmountBounds();
      updateCashDue();
      updateCardBalanceInfo();
    }

    function addToBasket(row) {
      const id = row.dataset.productId;
      const stock = parseInt(row.dataset.stock, 10);
      const existing = basket.get(id);
      const qty = existing ? existing.qty : 0;
      if (qty >= stock) return; // can't add past the stock on hand
      basket.set(id, { id, name: row.dataset.name, price: parseFloat(row.dataset.price), qty: qty + 1 });
      renderBasket();
    }

    function removeFromBasket(id) {
      const existing = basket.get(id);
      if (!existing) return;
      if (existing.qty <= 1) {
        basket.delete(id);
      } else {
        existing.qty -= 1;
      }
      renderBasket();
    }

    productListEl.querySelectorAll(".product-row").forEach((row) => {
      row.addEventListener("dblclick", (evt) => {
        if (evt.target.closest(".product-restock-form") || evt.target.closest(".product-adjust-toggle")) return;
        addToBasket(row);
      });
    });

    // Stock correction (e.g. after a physical inventory count finds less
    // on the shelf than the system expects) - a small per-row toggle
    // reveals a form to set the counted quantity directly, with an
    // optional reason, rather than making staff compute +/- deltas.
    productListEl.querySelectorAll(".product-adjust-toggle").forEach((btn) => {
      btn.addEventListener("click", () => {
        const panel = btn.closest(".product-item").querySelector(".product-adjust-form");
        if (panel) panel.hidden = !panel.hidden;
      });
    });

    if (productSearchInput) {
      productSearchInput.addEventListener("input", () => {
        const q = productSearchInput.value.trim().toLowerCase();
        productListEl.querySelectorAll(".product-row").forEach((row) => {
          const item = row.closest(".product-item");
          item.hidden = q.length > 0 && !row.dataset.name.toLowerCase().includes(q);
        });
      });
    }

    // Card payment - the same type-to-search picker as the session-start
    // page (see above), reused as-is via the generic /api/cards/search endpoint.
    function clearCardSelection() {
      checkoutCardIdInput.value = "";
      cardBalance = 0;
      checkoutCardAmountField.hidden = true;
      checkoutCardAmountInput.value = 0;
      updateCardAmountBounds();
      updateCashDue();
      updateCardBalanceInfo();
    }

    function selectCheckoutCard(option) {
      checkoutCardIdInput.value = option.value;
      cardBalance = parseFloat(option.dataset.balance || "0");
      checkoutCardSearchInput.value = option.dataset.label || option.textContent;
      checkoutCardResults.hidden = true;
      checkoutCardAmountField.hidden = false;
      updateCardAmountBounds();
      updateCashDue();
      updateCardBalanceInfo();
    }

    async function runCheckoutCardSearch(q) {
      try {
        const res = await fetch(`/api/cards/search?q=${encodeURIComponent(q)}`);
        if (!res.ok) return;
        const data = await res.json();
        checkoutCardResults.innerHTML = "";
        if (!data.cards || data.cards.length === 0) {
          const opt = document.createElement("option");
          opt.textContent = "Няма намерени карти";
          opt.disabled = true;
          checkoutCardResults.appendChild(opt);
        } else {
          data.cards.forEach((card) => {
            const opt = document.createElement("option");
            opt.value = card.id;
            opt.dataset.balance = card.balance;
            opt.dataset.label = card.label;
            opt.textContent = `${card.label} — баланс ${card.balance.toFixed(2)} €`;
            checkoutCardResults.appendChild(opt);
          });
        }
        checkoutCardResults.hidden = false;
      } catch (err) {
        // transient network hiccup - leave whatever results were already shown
      }
    }

    checkoutCardSearchInput.addEventListener("input", () => {
      if (checkoutCardIdInput.value) clearCardSelection();
      const q = checkoutCardSearchInput.value.trim();
      clearTimeout(cardSearchTimer);
      cardSearchTimer = setTimeout(() => runCheckoutCardSearch(q), 200);
    });

    checkoutCardSearchInput.addEventListener("focus", () => {
      if (!checkoutCardIdInput.value) runCheckoutCardSearch(checkoutCardSearchInput.value.trim());
    });

    // Same barcode-scanner accommodation as the session-start card field:
    // swallow the scanner's trailing Enter and use it to select the scan's
    // (usually unambiguous) single match instead of letting it fall
    // through to some other default action on the page.
    checkoutCardSearchInput.addEventListener("keydown", async (evt) => {
      if (evt.key !== "Enter") return;
      evt.preventDefault();
      clearTimeout(cardSearchTimer);
      await runCheckoutCardSearch(checkoutCardSearchInput.value.trim());
      const opts = checkoutCardResults.options;
      if (opts.length === 1 && opts[0].value) {
        selectCheckoutCard(opts[0]);
      }
    });

    checkoutCardResults.addEventListener("change", () => {
      const opt = checkoutCardResults.selectedOptions[0];
      if (opt && opt.value) selectCheckoutCard(opt);
    });

    checkoutCardAmountInput.addEventListener("input", () => {
      updateCashDue();
      updateCardBalanceInfo();
    });

    document.addEventListener("click", (evt) => {
      if (evt.target !== checkoutCardSearchInput && !checkoutCardResults.contains(evt.target)) {
        checkoutCardResults.hidden = true;
      }
    });

    checkoutSubmitBtn.addEventListener("click", () => {
      if (basket.size === 0) return;
      checkoutForm.innerHTML = "";
      basket.forEach((line) => {
        const pid = document.createElement("input");
        pid.type = "hidden";
        pid.name = cfg.hiddenFieldName;
        pid.value = line.id;
        checkoutForm.appendChild(pid);
        const qty = document.createElement("input");
        qty.type = "hidden";
        qty.name = "qty";
        qty.value = line.qty;
        checkoutForm.appendChild(qty);
      });
      const cid = document.createElement("input");
      cid.type = "hidden";
      cid.name = "card_id";
      cid.value = checkoutCardIdInput.value || "";
      checkoutForm.appendChild(cid);
      const camt = document.createElement("input");
      camt.type = "hidden";
      camt.name = "card_amount";
      camt.value = checkoutCardAmountInput.value || "0";
      checkoutForm.appendChild(camt);
      checkoutForm.submit();
    });

    renderBasket();
  }
  }

  initPosBasket({ searchId: "product-search", listId: "product-list", hiddenFieldName: "product_id" });
  initPosBasket({ searchId: "service-search", listId: "service-list", hiddenFieldName: "service_id" });

  // Shared chip-card result table - used by both the Studio test-read
  // panel and the Cards page's issue/recharge panel, so a card's full
  // detail (including the PSC and studio identity, needed for a chain of
  // studios sharing one PSC - see sales.py's _studio_note) always looks
  // the same wherever it's read.
  const CHIP_FIELD_LABELS = [
    ["client_name", "Име на клиента"],
    ["client_number", "Номер на клиента"],
    ["balance", "Баланс"],
    ["card_number", "Номер на картата"],
    ["studio_name", "Студио"],
    ["studio_number", "Номер на студиото"],
    ["psc", "PSC"],
    ["err_counter", "Брояч за грешки"],
    ["ok", "Статус"],
  ];

  function renderChipCardTableRows(tbody, card, knownName) {
    tbody.innerHTML = "";
    CHIP_FIELD_LABELS.forEach(([key, label]) => {
      let value = card[key];
      if (key === "client_name" && knownName) value = knownName;
      if (key === "balance") value = value === null ? "— (невалиден)" : `${value.toFixed(2)} €`;
      if (key === "client_number" || key === "card_number") value = value === null ? "— (не е зададен)" : value;
      if (key === "ok") value = value ? "OK" : "ГРЕШКА / заключена";
      const row = document.createElement("tr");
      const th = document.createElement("th");
      th.scope = "row";
      th.textContent = label;
      const td = document.createElement("td");
      td.textContent = value;
      row.append(th, td);
      tbody.appendChild(row);
    });
  }

  // Chip-card test read on the Studio page - lets staff confirm the
  // reader/card setup actually works before relying on it for payment.
  const chipTestReadBtn = document.getElementById("chip-test-read-btn");
  const chipTestResult = document.getElementById("chip-test-result");
  const chipTestResultBody = document.getElementById("chip-test-result-body");
  const chipTestError = document.getElementById("chip-test-error");
  const chipTestErrorText = document.getElementById("chip-test-error-text");

  if (chipTestReadBtn) {
    chipTestReadBtn.addEventListener("click", async () => {
      chipTestReadBtn.disabled = true;
      chipTestError.hidden = true;
      chipTestResult.hidden = true;
      try {
        const res = await fetch("/api/chipcard/read");
        const data = await res.json();
        if (!data.ok) {
          chipTestErrorText.textContent = data.error || "Грешка при четене.";
          chipTestError.hidden = false;
          return;
        }
        renderChipCardTableRows(chipTestResultBody, data.card, data.known && data.known.name);
        chipTestResult.hidden = false;
      } catch (err) {
        chipTestErrorText.textContent = "Мрежова грешка при четене на картата.";
        chipTestError.hidden = false;
      } finally {
        chipTestReadBtn.disabled = false;
      }
    });
  }

  // Chip card (Cards page): one "read" button drives both flows - a
  // blank/unregistered card gets the issue form, an already-issued one
  // gets the recharge form, decided by what comes back from the reader.
  // After a successful issue/recharge the page reloads (plain POST
  // +redirect, like every other form here) with a data-auto-refresh flag
  // on this button, so the full card detail reappears automatically
  // instead of staff having to press "read" again to see what just
  // changed.
  const chipCardReadBtn = document.getElementById("chip-card-read-btn");
  const chipCardError = document.getElementById("chip-card-error");
  const chipCardErrorText = document.getElementById("chip-card-error-text");
  const chipCardInfo = document.getElementById("chip-card-info");
  const chipCardInfoBody = document.getElementById("chip-card-info-body");
  const chipIssueForm = document.getElementById("chip-issue-form");
  const chipRechargeForm = document.getElementById("chip-recharge-form");
  const chipClearForm = document.getElementById("chip-clear-form");
  const chipPrintHistoryLink = document.getElementById("chip-print-history-link");

  if (chipCardReadBtn) {
    async function readChipCard() {
      chipCardReadBtn.disabled = true;
      chipCardError.hidden = true;
      chipCardInfo.hidden = true;
      chipIssueForm.hidden = true;
      chipRechargeForm.hidden = true;
      chipClearForm.hidden = true;
      if (chipPrintHistoryLink) chipPrintHistoryLink.hidden = true;
      try {
        const res = await fetch("/api/chipcard/read");
        const data = await res.json();
        if (!data.ok) {
          chipCardErrorText.textContent = data.error || "Грешка при четене.";
          chipCardError.hidden = false;
          return;
        }
        const card = data.card;
        renderChipCardTableRows(chipCardInfoBody, card, data.known && data.known.name);
        chipCardInfo.hidden = false;
        if (card.client_number === null) {
          chipIssueForm.hidden = false;
        } else {
          chipRechargeForm.hidden = false;
          chipClearForm.hidden = false;
          if (chipPrintHistoryLink) {
            const name = (data.known && data.known.name) || card.client_name || "";
            const phone = (data.known && data.known.phone) || "";
            const params = new URLSearchParams({
              client_number: card.client_number,
              studio_number: card.studio_number,
              name, phone,
            });
            chipPrintHistoryLink.href = `/cards/chip/print?${params}`;
            chipPrintHistoryLink.hidden = false;
          }
        }
      } catch (err) {
        chipCardErrorText.textContent = "Мрежова грешка при четене на картата.";
        chipCardError.hidden = false;
      } finally {
        chipCardReadBtn.disabled = false;
      }
    }

    chipCardReadBtn.addEventListener("click", readChipCard);
    if (chipCardReadBtn.dataset.autoRefresh === "true") {
      readChipCard();
    }
  }
})();
