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
    let searchTimer = null;
    let quoteTimer = null;

    const totalMin = () => (sessionLengthInput ? parseFloat(sessionLengthInput.value || "0") : 0);

    function updateCashDueLocally() {
      const flatTotal = totalMin() * pricePerMin;
      const cardAmount = parseFloat(paymentCardAmountInput.value || "0");
      const cash = Math.max(0, flatTotal - cardAmount);
      paymentCashDue.textContent = `${cash.toFixed(2)} лв`;
    }

    function renderCardBalanceInfo(data) {
      if (!paymentCardIdInput.value || data.card_balance_after === undefined) {
        paymentCardBalanceInfo.hidden = true;
        return;
      }
      paymentCardBalanceAmount.textContent = `${data.card_balance_after.toFixed(2)} лв`;
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
          paymentCashDue.textContent = `${data.cash_amount.toFixed(2)} лв`;
          renderCardBalanceInfo(data);
        } catch (err) {
          // leave the local estimate in place on a transient network hiccup
        }
      }, 150);
    }

    function updateCardAmountBounds() {
      const max = Math.max(0, Math.min(selectedBalance, totalMin() * pricePerMin));
      paymentCardAmountInput.max = max.toFixed(2);
      if (parseFloat(paymentCardAmountInput.value) > max) {
        paymentCardAmountInput.value = max;
      }
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
            opt.textContent = `${card.label} — баланс ${card.balance.toFixed(2)} лв`;
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

    paymentCardAmountInput.addEventListener("input", () => {
      updateCashDueLocally();
      fetchQuote();
    });

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

  // Collapsible "add product" panel on the Cosmetics page - same show/hide
  // idiom as the bed-settings panel above.
  const productFormToggle = document.getElementById("product-form-toggle");
  const productFormPanel = document.getElementById("product-form-panel");
  if (productFormToggle && productFormPanel) {
    productFormToggle.addEventListener("click", () => {
      const willOpen = productFormPanel.hidden;
      productFormPanel.hidden = !willOpen;
      productFormToggle.setAttribute("aria-expanded", String(willOpen));
      productFormToggle.classList.toggle("settings-toggle--open", willOpen);
    });
  }

  // Cosmetics checkout: pick products from a searchable list (double-click
  // adds one unit), double-click a basket line to remove one, then pay
  // with an optional card (searched the same way as the session-start
  // page) plus cash for the rest - built for a catalog of 100+ products,
  // where a one-card-per-product grid with an inline sell form per item
  // stopped being usable.
  const productSearchInput = document.getElementById("product-search");
  const productListEl = document.getElementById("product-list");
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
      checkoutCashDue.textContent = `${cash.toFixed(2)} лв`;
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
      checkoutCardBalanceAmount.textContent = `${(cardBalance - cardAmount).toFixed(2)} лв`;
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
        totalEl.textContent = `${(line.price * line.qty).toFixed(2)} лв`;
        row.append(nameEl, qtyEl, totalEl);
        row.addEventListener("dblclick", () => removeFromBasket(line.id));
        basketListEl.appendChild(row);
      });
      basketEmptyEl.hidden = count > 0;
      basketTotalEl.textContent = `${basketTotal().toFixed(2)} лв`;
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
            opt.textContent = `${card.label} — баланс ${card.balance.toFixed(2)} лв`;
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
        pid.name = "product_id";
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

  // Chip-card test read on the Studio page - lets staff confirm the
  // reader/card setup actually works before relying on it for payment.
  const chipTestReadBtn = document.getElementById("chip-test-read-btn");
  const chipTestResult = document.getElementById("chip-test-result");
  const chipTestResultBody = document.getElementById("chip-test-result-body");
  const chipTestError = document.getElementById("chip-test-error");
  const chipTestErrorText = document.getElementById("chip-test-error-text");

  if (chipTestReadBtn) {
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
        chipTestResultBody.innerHTML = "";
        CHIP_FIELD_LABELS.forEach(([key, label]) => {
          let value = data.card[key];
          if (key === "balance") value = value === null ? "— (невалиден)" : `${value.toFixed(2)} лв`;
          if (key === "client_number" || key === "card_number") value = value === null ? "— (не е зададен)" : value;
          if (key === "ok") value = value ? "OK" : "ГРЕШКА / заключена";
          const row = document.createElement("tr");
          const th = document.createElement("th");
          th.scope = "row";
          th.textContent = label;
          const td = document.createElement("td");
          td.textContent = value;
          row.append(th, td);
          chipTestResultBody.appendChild(row);
        });
        chipTestResult.hidden = false;
      } catch (err) {
        chipTestErrorText.textContent = "Мрежова грешка при четене на картата.";
        chipTestError.hidden = false;
      } finally {
        chipTestReadBtn.disabled = false;
      }
    });
  }
})();
