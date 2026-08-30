/*
 * Shared behaviour for every page: homepage, generated country/visa pages,
 * and the fallback request page. Loaded after data.js.
 */
(() => {
  "use strict";
  const D = window.ConvercessionData;

  // ---- Desktop mega-menu (click to open, one at a time) ----
  const megaItems = document.querySelectorAll(".main-nav > li.has-mega");
  function closeAllMega() {
    megaItems.forEach((li) => {
      li.classList.remove("open");
      li.querySelector(":scope > .nav-trigger")?.setAttribute("aria-expanded", "false");
    });
  }

  /*
   * Keep every mega panel inside the viewport.
   *
   * A closed panel is `visibility: hidden`, not `display: none`, so it still
   * takes part in layout — a mid-nav panel aligned to the left of its trigger
   * pushed the document 36-80px wider than the window and produced a real
   * horizontal scrollbar on every desktop page. Alignment therefore has to be
   * correct whether the panel is open or not.
   *
   * Measured from the TRIGGER, never from the panel's current position, so the
   * function is idempotent and safe to re-run on resize.
   */
  function alignMegaPanels() {
    const pad = 8;
    megaItems.forEach((li) => {
      const panel = li.querySelector(":scope > .mega");
      if (!panel || getComputedStyle(panel).display === "none") return;
      panel.style.left = "";
      const w = panel.offsetWidth;
      const anchor = li.getBoundingClientRect();
      const overflowsRight = anchor.left + w > window.innerWidth - pad;
      const fitsFlipped = anchor.right - w >= pad;
      panel.classList.toggle("mega-right", overflowsRight && fitsFlipped);
      // Neither edge works (very narrow desktop): pin it to the viewport's left
      // margin. `left` is relative to the li, hence the offset arithmetic.
      if (overflowsRight && !fitsFlipped) panel.style.left = Math.round(pad - anchor.left) + "px";
    });
  }
  alignMegaPanels();
  let alignTimer;
  window.addEventListener("resize", () => {
    clearTimeout(alignTimer);
    alignTimer = setTimeout(alignMegaPanels, 120);
  });

  megaItems.forEach((li) => {
    const trigger = li.querySelector(":scope > .nav-trigger");
    trigger?.addEventListener("click", (e) => {
      e.stopPropagation();
      const willOpen = !li.classList.contains("open");
      closeAllMega();
      if (willOpen) {
        li.classList.add("open");
        trigger.setAttribute("aria-expanded", "true");
        alignMegaPanels();
      }
    });
  });
  document.addEventListener("click", (e) => {
    if (!e.target.closest(".main-nav > li.has-mega")) closeAllMega();
  });
  document.addEventListener("keydown", (e) => { if (e.key === "Escape") closeAllMega(); });

  // ---- Mobile nav: rebuild the mega-menu as stacked accordions ----
  // (The desktop markup can't just be cloned — a 3-column hover panel is
  // unusable at 375px, so each top-level entry becomes a tap-to-expand section.)
  const navToggle = document.getElementById("navToggle");
  const mainNav = document.getElementById("mainNav");
  const mobileNav = document.getElementById("mobileNav");
  if (navToggle && mainNav && mobileNav) {
    // No "Home" entry, in the drawer or the desktop bar: the logo is the home
    // link on every page, and a separate one was asked to be removed.
    const parts = [];
    Array.from(mainNav.children).forEach((li) => {
      const mega = li.querySelector(":scope > .mega");
      if (!mega) {
        const a = li.querySelector(":scope > a");
        if (a) parts.push(`<div class="m-section"><a class="m-trigger" href="${a.getAttribute("href")}" style="text-decoration:none;">${a.textContent.trim()}</a></div>`);
        return;
      }
      const label = li.querySelector(":scope > .nav-trigger").textContent.trim();
      const cols = Array.from(mega.querySelectorAll(".mega-col")).map((col) => {
        const heading = col.querySelector("h4");
        const links = Array.from(col.querySelectorAll("li")).map((item) => {
          const a = item.querySelector("a");
          if (a) return `<a href="${a.getAttribute("href")}">${a.textContent.trim()}</a>`;
          const todo = item.querySelector(".is-todo");
          return todo ? `<span class="is-todo">${todo.textContent.trim()}</span>` : "";
        }).join("");
        return `${heading ? `<h5>${heading.textContent.trim()}</h5>` : ""}${links}`;
      }).join("");
      const foot = mega.querySelector(".mega-foot a");
      const footHtml = foot ? `<a href="${foot.getAttribute("href")}" style="font-weight:700;color:var(--brand-blue);">${foot.textContent.trim()}</a>` : "";
      parts.push(`<div class="m-section">
        <button type="button" class="m-trigger">${label}</button>
        <div class="m-panel">${cols}${footHtml}</div>
      </div>`);
    });
    // The header magnifier is hidden below 1080px, so the drawer carries search.
    parts.push(`<div class="m-actions">
      <button type="button" class="btn btn-sm btn-outline-brand" id="mobileSearchBtn">Search the site</button>
      <a href="/track-visa" class="btn btn-sm btn-outline-brand">Track Visa</a>
      <a href="/visa-finder" class="btn btn-sm btn-primary">Check Visa</a>
    </div>`);
    mobileNav.innerHTML = parts.join("");

    mobileNav.querySelectorAll(".m-trigger").forEach((trigger) => {
      if (trigger.tagName === "BUTTON") {
        trigger.addEventListener("click", () => trigger.closest(".m-section").classList.toggle("open"));
      }
    });
    mobileNav.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => {
        mobileNav.hidden = true;
        navToggle.setAttribute("aria-expanded", "false");
      });
    });
    navToggle.addEventListener("click", () => {
      const open = mobileNav.hidden;
      mobileNav.hidden = !open;
      navToggle.setAttribute("aria-expanded", String(open));
    });
  }

  /* ---- Flag emoji support ----------------------------------------
   * Windows ships no flag glyphs, so 🇰🇪 renders there as two boxed letters —
   * on a page listing 216 countries that looks broken rather than plain.
   *
   * Detect it once by drawing a flag to a canvas and comparing it with the
   * same pair rendered as separate regional indicators: where flags are
   * supported the two differ, because the pair composes into one glyph. If
   * they match, nothing composed, and the CSS swaps in a country-code chip.
   * ------------------------------------------------------------- */
  (() => {
    function supportsFlagEmoji() {
      try {
        const c = document.createElement("canvas");
        c.width = 40; c.height = 20;
        const ctx = c.getContext("2d", { willReadFrequently: true });
        if (!ctx) return true;   // can't tell — assume yes, emoji is the norm
        ctx.font = "16px sans-serif";
        ctx.textBaseline = "top";
        const draw = (s) => {
          ctx.clearRect(0, 0, 40, 20);
          ctx.fillText(s, 0, 0);
          return c.toDataURL();
        };
        // U+1F1E8 U+1F1E6 is the CA flag; joined by a zero-width non-joiner it
        // cannot compose, so it always renders as two letters.
        return draw("\u{1F1E8}\u{1F1E6}") !== draw("\u{1F1E8}‌\u{1F1E6}");
      } catch (_) {
        return true;
      }
    }
    if (!supportsFlagEmoji()) document.documentElement.classList.add("no-flag-emoji");
  })();

  /* ---- Avatar fallback -------------------------------------------
   * Provider profile images are hosted by Google/Facebook/X and do rot —
   * they 404 when someone changes their picture or tightens privacy. A broken
   * image icon in the header looks like a broken site, so swap in the lettered
   * circle the server already rendered the data for.
   * ------------------------------------------------------------- */
  document.querySelectorAll("img.js-avatar").forEach((img) => {
    const swap = () => {
      const span = document.createElement("span");
      span.className = img.dataset.fallbackClass || "";
      span.setAttribute("aria-hidden", "true");
      span.textContent = img.dataset.initial || "";
      img.replaceWith(span);
    };
    img.addEventListener("error", swap, { once: true });
    // A cached failure can land before this listener is attached.
    if (img.complete && img.naturalWidth === 0) swap();
  });

  /* ---------------------------------------------------------------
   * Smart site search (header magnifier, or the "/" key)
   *
   * The index is assembled at runtime from three sources rather than
   * hand-maintained:
   *   1. every link already in the mega-menu and footer  -> real pages only
   *   2. D.COUNTRIES                                     -> 216 country guides
   *   3. D.EMBASSY_CITIES                                -> consulate lookups
   * Because (1) is harvested from the DOM, the search can never offer a page
   * the navigation doesn't actually link to.
   * ------------------------------------------------------------- */
  (() => {
    const box = document.getElementById("siteSearch");
    const input = document.getElementById("siteSearchInput");
    const list = document.getElementById("siteSearchResults");
    const btn = document.getElementById("headerSearchBtn");
    if (!box || !input || !list) return;

    const index = [];
    const seen = new Set();
    const add = (label, href, group, keywords) => {
      const key = group + "|" + href + "|" + label;
      if (seen.has(key)) return;
      seen.add(key);
      index.push({ label, href, group, hay: (label + " " + (keywords || "")).toLowerCase() });
    };

    document.querySelectorAll(".mega a.mega-link, .footer-col a").forEach((a) => {
      const href = a.getAttribute("href") || "";
      const label = a.textContent.replace(/\s+/g, " ").trim().replace(/\s*\(\d+\)$/, "");
      if (!href.startsWith("/") || !label) return;
      add(label, href, "Pages");
    });
    (D?.COUNTRIES || []).forEach((c) => add(c, "/visa/" + D.slugify(c), "Countries", "visa requirements documents"));
    (D?.EMBASSY_CITIES || []).forEach((c) => add(c + " — embassy & consulate", "/embassies", "Embassies", "consulate vac appointment"));

    // Three-tier ranking: exact prefix beats a word-boundary hit, which beats a
    // loose substring. Without this, typing "un" surfaced Brunei before the
    // United States — the same ranking the country autocomplete uses.
    function rank(item, q) {
      const h = item.hay;
      if (h.startsWith(q)) return 0;
      if (new RegExp("\\b" + q.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")).test(h)) return 1;
      return h.includes(q) ? 2 : -1;
    }

    let results = [];
    let active = -1;

    function render(q) {
      results = [];
      if (q.length >= 1) {
        const scored = [];
        for (const item of index) {
          const r = rank(item, q);
          if (r >= 0) scored.push([r, item]);
        }
        scored.sort((a, b) => a[0] - b[0] || a[1].label.length - b[1].label.length);
        results = scored.slice(0, 12).map((s) => s[1]);
      }
      active = results.length ? 0 : -1;
      input.setAttribute("aria-expanded", String(results.length > 0));
      if (!q) {
        list.innerHTML = "";
        return;
      }
      if (!results.length) {
        list.innerHTML = `<li class="ss-empty">No match for &ldquo;${q.replace(/[<&]/g, "")}&rdquo;. <a href="/visa-finder">Use the Visa Finder</a> or <a href="/contact">ask a consultant</a>.</li>`;
        return;
      }
      list.innerHTML = results.map((r, i) => `
        <li role="option" id="ss-opt-${i}" aria-selected="${i === active}" class="${i === active ? "is-active" : ""}">
          <a href="${r.href}"><span class="ss-label">${r.label}</span><span class="ss-group">${r.group}</span></a>
        </li>`).join("");
    }

    function move(delta) {
      if (!results.length) return;
      active = (active + delta + results.length) % results.length;
      [...list.children].forEach((li, i) => {
        li.classList.toggle("is-active", i === active);
        li.setAttribute("aria-selected", String(i === active));
      });
      list.children[active]?.scrollIntoView({ block: "nearest" });
    }

    function open() {
      box.hidden = false;
      document.body.classList.add("no-scroll");
      btn?.setAttribute("aria-expanded", "true");
      input.value = "";
      render("");
      input.focus();
    }
    function close() {
      box.hidden = true;
      document.body.classList.remove("no-scroll");
      btn?.setAttribute("aria-expanded", "false");
      btn?.focus();
    }

    btn?.addEventListener("click", open);
    document.getElementById("mobileSearchBtn")?.addEventListener("click", () => {
      const drawer = document.getElementById("mobileNav");
      if (drawer) {
        drawer.hidden = true;
        document.getElementById("navToggle")?.setAttribute("aria-expanded", "false");
      }
      open();
    });
    document.getElementById("siteSearchClose")?.addEventListener("click", close);
    box.addEventListener("mousedown", (e) => { if (e.target === box) close(); });
    input.addEventListener("input", () => render(input.value.trim().toLowerCase()));
    input.addEventListener("keydown", (e) => {
      if (e.key === "ArrowDown") { e.preventDefault(); move(1); }
      else if (e.key === "ArrowUp") { e.preventDefault(); move(-1); }
      else if (e.key === "Enter") {
        if (active >= 0 && results[active]) { e.preventDefault(); window.location.href = results[active].href; }
        // otherwise the form submits to /visa-finder?q=… as the no-JS path does
      } else if (e.key === "Escape") { e.preventDefault(); close(); }
    });
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && !box.hidden) { close(); return; }
      // "/" is the conventional search shortcut — ignored while typing.
      const t = e.target;
      const typing = t && (t.tagName === "INPUT" || t.tagName === "TEXTAREA" || t.tagName === "SELECT" || t.isContentEditable);
      if (e.key === "/" && !typing && box.hidden) { e.preventDefault(); open(); }
    });
  })();

  // ---- Customer / employee account dialogs (utility bar) ----
  // Same fixed-overlay + centered-panel pattern as site search above; opening
  // one closes the other rather than letting both stack.
  (() => {
    const closers = [];
    function wireDialog(boxId, triggerId) {
      const box = document.getElementById(boxId);
      const trigger = document.getElementById(triggerId);
      if (!box || !trigger) return;

      function close() {
        if (box.hidden) return;
        box.hidden = true;
        document.body.classList.remove("no-scroll");
        trigger.setAttribute("aria-expanded", "false");
      }
      function open() {
        closers.forEach((c) => c !== close && c());
        box.hidden = false;
        document.body.classList.add("no-scroll");
        trigger.setAttribute("aria-expanded", "true");
        box.querySelector(".auth-menu-item, .auth-dialog-close")?.focus();
      }
      closers.push(close);

      trigger.addEventListener("click", () => (box.hidden ? open() : close()));
      box.querySelectorAll("[data-close-dialog]").forEach((btn) => btn.addEventListener("click", close));
      box.addEventListener("mousedown", (e) => { if (e.target === box) close(); });
      document.addEventListener("keydown", (e) => { if (e.key === "Escape" && !box.hidden) close(); });
    }
    wireDialog("customerLoginDialog", "customerLoginBtn");
    wireDialog("employeeLoginDialog", "employeeLoginBtn");
  })();

  // ---- Generic <select> populators, reused by hero search + sticky search ----
  function populateSelect(select, items, placeholder) {
    if (!select) return;
    select.innerHTML = "";
    if (placeholder) {
      const ph = document.createElement("option");
      ph.value = "";
      ph.textContent = placeholder;
      select.appendChild(ph);
    }
    items.forEach((name) => {
      const opt = document.createElement("option");
      opt.textContent = name;
      select.appendChild(opt);
    });
  }

  function populateCountrySelect(select, placeholder) {
    if (!select) return;
    select.innerHTML = "";
    if (placeholder) {
      const ph = document.createElement("option");
      ph.value = "";
      ph.textContent = placeholder;
      select.appendChild(ph);
    }
    const popularGroup = document.createElement("optgroup");
    popularGroup.label = "Popular visa destinations";
    D.POPULAR_COUNTRIES.forEach((name) => {
      const opt = document.createElement("option");
      opt.textContent = name;
      popularGroup.appendChild(opt);
    });
    select.appendChild(popularGroup);

    const allGroup = document.createElement("optgroup");
    allGroup.label = "All countries & territories A–Z";
    D.COUNTRIES.forEach((name) => {
      const opt = document.createElement("option");
      opt.textContent = name;
      allGroup.appendChild(opt);
    });
    select.appendChild(allGroup);
  }
  window.CVpopulateSelect = populateSelect;
  window.CVpopulateCountrySelect = populateCountrySelect;

  // ---- Autocomplete (Country / Visa Type) ----
  // Pairs a visible text <input id="{hiddenId}Input"> with a hidden <input id="{hiddenId}">
  // that holds the actual value — every existing bit of code that reads
  // `document.getElementById('visaCountry').value` keeps working unchanged,
  // it just now reads a hidden input instead of a <select>.
  function initAutocomplete({ hiddenId, items, popular, emptyLabel }) {
    const input = document.getElementById(hiddenId + "Input");
    const hidden = document.getElementById(hiddenId);
    const list = document.getElementById(hiddenId + "List");
    if (!input || !hidden || !list) return;

    let options = [];
    let activeIndex = -1;

    function renderGroup(label, names) {
      if (!names.length) return;
      const heading = document.createElement("li");
      heading.className = "autocomplete-group-label";
      heading.setAttribute("role", "presentation");
      heading.textContent = label;
      list.appendChild(heading);
      names.forEach((name) => {
        const li = document.createElement("li");
        li.className = "autocomplete-option";
        li.setAttribute("role", "option");
        li.id = `${hiddenId}List-opt-${options.length}`;
        li.textContent = name;
        li.addEventListener("mousedown", (e) => { e.preventDefault(); select(name); });
        list.appendChild(li);
        options.push({ el: li, value: name });
      });
    }

    function render(query) {
      const q = query.trim().toLowerCase();
      list.innerHTML = "";
      options = [];
      activeIndex = -1;
      if (!q) {
        if (popular && popular.length) renderGroup("Popular", popular);
        renderGroup(popular && popular.length ? (emptyLabel || "All") : (emptyLabel || "All"), items);
      } else {
        // Rank "starts with" above merely "contains" — otherwise typing "un" surfaces
        // Brunei/Burundi/Hungary/Tunisia (which just happen to contain "un") ahead of
        // United States/Kingdom/Arab Emirates, which is what the user is actually typing.
        // A middle tier catches word-boundary matches, e.g. "arab" -> "United Arab Emirates".
        const startsWith = [];
        const wordStartsWith = [];
        const contains = [];
        items.forEach((name) => {
          const lower = name.toLowerCase();
          if (lower.startsWith(q)) startsWith.push(name);
          else if (lower.split(/\s+/).some((word) => word.startsWith(q))) wordStartsWith.push(name);
          else if (lower.includes(q)) contains.push(name);
        });
        const matches = [...startsWith, ...wordStartsWith, ...contains];
        if (!matches.length) {
          const empty = document.createElement("li");
          empty.className = "autocomplete-empty";
          empty.textContent = `No match for "${query.trim()}"`;
          list.appendChild(empty);
        } else {
          renderGroup(`${matches.length} match${matches.length === 1 ? "" : "es"}`, matches.slice(0, 40));
        }
      }
    }

    function open() { render(input.value); list.hidden = false; input.setAttribute("aria-expanded", "true"); }
    function close() { list.hidden = true; input.setAttribute("aria-expanded", "false"); activeIndex = -1; }
    function select(name) {
      input.value = name;
      hidden.value = name;
      hidden.dispatchEvent(new Event("change", { bubbles: true }));
      close();
    }
    function setActive(idx) {
      options.forEach((o) => o.el.classList.remove("active"));
      activeIndex = idx;
      const opt = options[idx];
      if (opt) {
        opt.el.classList.add("active");
        opt.el.scrollIntoView({ block: "nearest" });
        input.setAttribute("aria-activedescendant", opt.el.id);
      } else {
        input.removeAttribute("aria-activedescendant");
      }
    }

    input.addEventListener("input", () => {
      hidden.value = ""; // typing invalidates the previous exact selection until they pick one again
      render(input.value);
      list.hidden = false;
      input.setAttribute("aria-expanded", "true");
    });
    input.addEventListener("focus", open);
    input.addEventListener("blur", () => window.setTimeout(close, 120));
    input.addEventListener("keydown", (e) => {
      if (list.hidden && (e.key === "ArrowDown" || e.key === "ArrowUp")) { open(); return; }
      if (e.key === "ArrowDown") { e.preventDefault(); setActive(Math.min(activeIndex + 1, options.length - 1)); }
      else if (e.key === "ArrowUp") { e.preventDefault(); setActive(Math.max(activeIndex - 1, 0)); }
      else if (e.key === "Enter") { if (activeIndex >= 0 && options[activeIndex]) { e.preventDefault(); select(options[activeIndex].value); } }
      else if (e.key === "Escape") { close(); }
    });
    document.addEventListener("click", (e) => {
      if (!input.contains(e.target) && !list.contains(e.target)) close();
    });

    if (hidden.value) input.value = hidden.value;
  }
  window.CVinitAutocomplete = initAutocomplete;

  // Used by quicklinks/cards elsewhere to set an autocomplete field's value
  // programmatically (keeps the visible input text and hidden value in sync).
  function setAutocompleteValue(hiddenId, value) {
    const hidden = document.getElementById(hiddenId);
    const visible = document.getElementById(hiddenId + "Input");
    if (hidden) hidden.value = value;
    if (visible) visible.value = value;
  }
  window.CVsetAutocompleteValue = setAutocompleteValue;

  // ---- Smart search redirect: country -> its one page, with the requested visa
  // type passed as a query param so the page opens on the matching tab. ----
  function goToVisaPage(country, visaType, extra) {
    if (!country || !visaType) {
      window.location.href = "/visa/request-info";
      return;
    }
    const countrySlug = D.slugify(country);
    const qs = new URLSearchParams({ country, visaType, ...(extra || {}) }).toString();
    if (D.GENERATED_PAGES.includes(countrySlug)) {
      window.location.href = `/visa/${countrySlug}?${qs}`;
    } else {
      // Not built yet — send the visitor to the enquiry-only fallback rather than a 404.
      window.location.href = `/visa/request-info?${qs}`;
    }
  }
  window.CVgoToVisaPage = goToVisaPage;

  // ---- Sticky visa search bar (present on every generated visa/country page) ----
  const stickyBar = document.getElementById("stickySearch");
  if (stickyBar) {
    initAutocomplete({ hiddenId: "stickyCountry", items: D.COUNTRIES, popular: D.POPULAR_COUNTRIES, emptyLabel: "All countries A–Z" });
    populateSelect(document.getElementById("stickyCity"), D.EMBASSY_CITIES, "Embassy / VAC city");
    initAutocomplete({ hiddenId: "stickyVisaType", items: D.VISA_TYPES });

    const hero = document.querySelector(".hero, .page-hero");
    if (hero && "IntersectionObserver" in window) {
      const obs = new IntersectionObserver(
        ([entry]) => stickyBar.classList.toggle("is-visible", !entry.isIntersecting),
        { rootMargin: "-72px 0px 0px 0px" }
      );
      obs.observe(hero);
    } else {
      stickyBar.classList.add("is-visible");
    }

    // No-JS path of the header search posts to /visa-finder?q=… — carry that
    // term straight into the country field so the fallback lands somewhere
    // useful instead of an empty form.
    const q = new URLSearchParams(window.location.search).get("q");
    if (q) {
      const cInput = document.getElementById("stickyCountryInput");
      if (cInput) {
        cInput.value = q;
        cInput.dispatchEvent(new Event("input", { bubbles: true }));
      }
    }

    const stickyForm = document.getElementById("stickySearchForm");
    if (stickyForm) {
      stickyForm.addEventListener("submit", (e) => {
        e.preventDefault();
        const country = document.getElementById("stickyCountry").value;
        const city = document.getElementById("stickyCity").value;
        const visaType = document.getElementById("stickyVisaType").value;
        goToVisaPage(country, visaType, city ? { city } : {});
      });
    }
  }

  // ---- Visa-type tabs (one country page, one tab per visa type) ----
  const visatabs = document.querySelectorAll(".visatab");
  if (visatabs.length) {
    const panels = document.querySelectorAll("[data-visatab-panel]");
    const enqVisaSelect = document.getElementById("enqVisaType");

    function activateVisatab(tab) {
      if (!tab) return;
      visatabs.forEach((t) => {
        const isActive = t === tab;
        t.classList.toggle("active", isActive);
        t.setAttribute("aria-selected", String(isActive));
      });
      panels.forEach((p) => { p.hidden = p.dataset.visatabPanel !== tab.dataset.visatab; });
      // Keep the enquiry widget's visa type in sync with whichever tab is open,
      // so submitting after switching tabs reflects what the visitor is actually looking at.
      if (enqVisaSelect) enqVisaSelect.value = tab.textContent.trim();
    }
    visatabs.forEach((tab) => tab.addEventListener("click", () => activateVisatab(tab)));

    // "Go to the checklist" must land on the checklist of whichever tab is
    // open. Without this it always jumps to the first panel's #documents,
    // which is the wrong one as soon as the visitor switches visa type.
    document.querySelectorAll('a[href="#documents"]').forEach((link) => {
      link.addEventListener("click", (e) => {
        const target = document.querySelector(".visatab-panel:not([hidden]) .checklist-section");
        if (!target) return;
        e.preventDefault();
        target.scrollIntoView({ behavior: "smooth", block: "start" });
      });
    });

    // Deep link from the search (?visaType=Business+Visa) opens the matching tab.
    const requestedVisaType = new URLSearchParams(window.location.search).get("visaType");
    if (requestedVisaType) {
      const requestedSlug = D.slugify(requestedVisaType);
      const match = Array.from(visatabs).find((t) => t.dataset.visatab === requestedSlug);
      if (match) activateVisatab(match);
      // No match (this country doesn't offer that visa type) — the first tab
      // stays active by default rather than sending the visitor to a dead end.
    }
  }

  /* ---- Document checklist ----------------------------------------
   * Each checklist is independent: keyed on country + visa type, so ticking
   * items for a Kenya tourist visa does not touch the Kenya business list.
   *
   * State lives in localStorage and nowhere else. This is somebody's visa
   * paperwork; there is no reason for it to reach a server, and the page says
   * so. Storage can also be unavailable (private mode, blocked cookies), so
   * every access is guarded — a checklist that throws is worse than one that
   * simply forgets.
   * ------------------------------------------------------------- */
  document.querySelectorAll("[data-checklist]").forEach((root) => {
    const key = "cv_docs:" + root.dataset.checklist;
    const boxes = () => Array.from(root.querySelectorAll("input[type=checkbox][data-doc]"));
    const bar = root.querySelector("[data-checklist-bar]");
    const count = root.querySelector("[data-checklist-count]");
    const profileSelect = root.querySelector("[data-checklist-profile]");
    const profileSections = Array.from(root.querySelectorAll("[data-profile-section]"));
    const natSelect = root.querySelector("[data-checklist-nationality]");
    const natSections = Array.from(root.querySelectorAll("[data-nationality-section]"));

    const read = () => {
      try { return JSON.parse(localStorage.getItem(key) || "{}"); } catch (_) { return {}; }
    };
    const write = (state) => {
      try { localStorage.setItem(key, JSON.stringify(state)); } catch (_) { /* storage full or blocked */ }
    };

    function refresh() {
      // Only count what is actually on screen: a hidden profile section is not
      // part of this applicant's list, so counting it would make the progress
      // bar unreachable.
      const visible = boxes().filter((b) => !b.closest("[hidden]"));
      const done = visible.filter((b) => b.checked).length;
      const total = visible.length;
      if (bar) bar.style.width = total ? Math.round((done / total) * 100) + "%" : "0%";
      if (count) count.textContent = `${done} of ${total} gathered`;
      root.classList.toggle("is-complete", total > 0 && done === total);
    }

    function showProfile(value) {
      profileSections.forEach((s) => { s.hidden = s.dataset.profileSection !== value; });
    }
    // India is the server-rendered default; switching to another passport
    // swaps the Funds section and drops the India-specific block.
    function showNationality(value) {
      natSections.forEach((s) => { s.hidden = s.dataset.nationalitySection !== value; });
    }

    function applyProfile(value) {
      showProfile(value);
      const state = read();
      state._profile = value;
      write(state);
      refresh();
    }
    function applyNationality(value) {
      showNationality(value);
      const state = read();
      state._nationality = value;
      write(state);
      refresh();
    }

    // Restore
    const saved = read();
    boxes().forEach((b) => { b.checked = !!saved[b.dataset.doc]; });
    if (profileSelect && saved._profile) {
      profileSelect.value = saved._profile;
      showProfile(saved._profile);
    }
    if (natSelect && saved._nationality) {
      natSelect.value = saved._nationality;
      showNationality(saved._nationality);
    }
    refresh();

    root.addEventListener("change", (e) => {
      const b = e.target;
      if (b.matches("input[type=checkbox][data-doc]")) {
        const state = read();
        if (b.checked) state[b.dataset.doc] = 1; else delete state[b.dataset.doc];
        write(state);
        refresh();
      } else if (b.matches("[data-checklist-profile]")) {
        applyProfile(b.value);
      } else if (b.matches("[data-checklist-nationality]")) {
        applyNationality(b.value);
      }
    });

    root.querySelector("[data-checklist-reset]")?.addEventListener("click", () => {
      boxes().forEach((b) => { b.checked = false; });
      // Reset clears ticks, not the two "who is applying" answers — retyping
      // those every time you start over would be the annoying reading of it.
      const { _profile, _nationality } = read();
      const keep = {};
      if (_profile) keep._profile = _profile;
      if (_nationality) keep._nationality = _nationality;
      write(keep);
      refresh();
    });
  });

  /* ---- Country index filter ---------------------------------------
   * 216 links is a lot to scan. The box is rendered hidden and revealed here,
   * so a visitor without JS never sees a filter that cannot filter — every
   * link is in the HTML either way.
   * ------------------------------------------------------------- */
  (() => {
    const wrap = document.querySelector(".country-filter");
    const input = document.getElementById("countryFilter");
    if (!wrap || !input) return;
    wrap.hidden = false;

    const links = Array.from(document.querySelectorAll("[data-country]"));
    const blocks = Array.from(document.querySelectorAll(".region-card, .az-block"));
    const countEl = document.querySelector("[data-filter-count]");
    const emptyEl = document.querySelector("[data-filter-empty]");
    const total = new Set(links.map((a) => a.dataset.country)).size;

    function apply() {
      const q = input.value.trim().toLowerCase();
      let shown = 0;
      links.forEach((a) => {
        const hit = !q || a.dataset.country.includes(q);
        a.hidden = !hit;
        if (hit) shown++;
      });
      // Hide a region or letter block that has nothing left in it, so the page
      // does not fill with empty headings while you type.
      blocks.forEach((b) => {
        b.hidden = q !== "" && !b.querySelector("[data-country]:not([hidden])");
      });
      const unique = q ? shown : total;
      if (countEl) countEl.textContent = q ? `${unique} match${unique === 1 ? "" : "es"}` : `${total} destinations`;
      if (emptyEl) emptyEl.hidden = !(q && shown === 0);
    }
    input.addEventListener("input", apply);
    input.addEventListener("keydown", (e) => {
      if (e.key === "Escape") { input.value = ""; apply(); }
      if (e.key === "Enter") {
        const first = links.find((a) => !a.hidden);
        if (first) window.location.href = first.getAttribute("href");
      }
    });
  })();

  // ---- Breadcrumb, related-pages links need no JS — plain <a> markup ----

  // ---- Share / Print / Save page ----
  document.querySelectorAll("[data-action='share-page']").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const shareData = { title: document.title, url: window.location.href };
      if (navigator.share) {
        try { await navigator.share(shareData); } catch (_) { /* user cancelled */ }
      } else {
        await navigator.clipboard?.writeText(shareData.url);
        btn.dataset.originalLabel = btn.dataset.originalLabel || btn.textContent;
        btn.textContent = "Link copied";
        window.setTimeout(() => { btn.textContent = btn.dataset.originalLabel; }, 1600);
      }
    });
  });
  document.querySelectorAll("[data-action='print-page']").forEach((btn) => {
    btn.addEventListener("click", () => window.print());
  });
  document.querySelectorAll("[data-action='save-page']").forEach((btn) => {
    btn.addEventListener("click", () => {
      const saved = JSON.parse(localStorage.getItem("cv_saved_pages") || "[]");
      const entry = { url: window.location.pathname, title: document.title, savedAt: Date.now() };
      if (!saved.some((p) => p.url === entry.url)) {
        saved.unshift(entry);
        localStorage.setItem("cv_saved_pages", JSON.stringify(saved.slice(0, 50)));
      }
      btn.dataset.originalLabel = btn.dataset.originalLabel || btn.textContent;
      btn.textContent = "Saved";
      window.setTimeout(() => { btn.textContent = btn.dataset.originalLabel; }, 1600);
    });
  });

  // ---- Recently viewed pages (tracked on every visa/country page, rendered on request) ----
  const pageMeta = document.querySelector('meta[name="cv-page-title"]');
  if (pageMeta) {
    const recent = JSON.parse(localStorage.getItem("cv_recently_viewed") || "[]")
      .filter((p) => p.url !== window.location.pathname);
    recent.unshift({ url: window.location.pathname, title: pageMeta.content, viewedAt: Date.now() });
    localStorage.setItem("cv_recently_viewed", JSON.stringify(recent.slice(0, 12)));
  }
  document.querySelectorAll("[data-render='recently-viewed']").forEach((container) => {
    const wrapper = container.closest("[data-section='recently-viewed']");
    const recent = JSON.parse(localStorage.getItem("cv_recently_viewed") || "[]")
      .filter((p) => p.url !== window.location.pathname)
      .slice(0, 5);
    if (!recent.length) { wrapper?.setAttribute("hidden", ""); return; }
    wrapper?.removeAttribute("hidden");
    container.innerHTML = recent.map((p) => `<a href="${p.url}" class="related-link">${p.title}</a>`).join("");
  });

  // ---- FAQ accordions ----
  document.querySelectorAll(".faq-item").forEach((item) => {
    const q = item.querySelector(".faq-q");
    q?.addEventListener("click", () => {
      const open = item.classList.toggle("open");
      q.setAttribute("aria-expanded", String(open));
    });
  });

  // ---- Compare visa types (checkbox tray -> comparison table) ----
  const compareTray = document.getElementById("compareTray");
  if (compareTray) {
    const MAX_COMPARE = 3;
    const state = new Set();
    function renderTray() {
      compareTray.querySelector("[data-compare-count]").textContent = state.size;
      compareTray.classList.toggle("is-visible", state.size > 0);
      compareTray.querySelector("[data-compare-btn]").disabled = state.size < 2;
    }
    document.querySelectorAll("[data-compare-checkbox]").forEach((cb) => {
      cb.addEventListener("change", () => {
        if (cb.checked) {
          if (state.size >= MAX_COMPARE) { cb.checked = false; return; }
          state.add(cb.value);
        } else {
          state.delete(cb.value);
        }
        renderTray();
      });
    });
    compareTray.querySelector("[data-compare-btn]")?.addEventListener("click", () => {
      alert("Compare view: " + Array.from(state).join(" vs ") + "\n\n(Comparison table is not wired to live data yet — see DEVELOPMENT.md.)");
    });
  }

  // ---- Visa enquiry widget (visa/country pages only) ----
  const enquiryForm = document.getElementById("enquiryForm");
  if (enquiryForm) {
    const destSelect = document.getElementById("enqDestination");
    const visaSelect = document.getElementById("enqVisaType");
    populateCountrySelect(destSelect, "Select destination country");
    populateSelect(visaSelect, D.VISA_TYPES, "Select visa type");

    // Pre-fill from the URL query string (what the visitor actually searched
    // for) first, falling back to the page's static build-time default —
    // otherwise a search for "Kenya Business Visa" would land here still
    // showing "Tourist Visa" because that's the first tab on the page.
    const params = new URLSearchParams(window.location.search);
    const presetCountry = params.get("country") || enquiryForm.dataset.country;
    const presetVisa = params.get("visaType") || enquiryForm.dataset.visaType;
    if (presetCountry && destSelect) destSelect.value = presetCountry;
    if (presetVisa && visaSelect) visaSelect.value = presetVisa;

    // Prevent past travel dates.
    const dateInput = document.getElementById("enqTravelDate");
    if (dateInput) dateInput.min = new Date().toISOString().slice(0, 10);

    // Client-side max upload size (100 MB per spec) — real virus/malware scanning
    // and storage happen server-side; this only stops obviously oversized uploads early.
    const MAX_UPLOAD_BYTES = 100 * 1024 * 1024;
    enquiryForm.querySelectorAll("input[type='file']").forEach((input) => {
      input.addEventListener("change", () => {
        const tooBig = Array.from(input.files || []).find((f) => f.size > MAX_UPLOAD_BYTES);
        if (tooBig) {
          alert(`"${tooBig.name}" is over the 100 MB upload limit. Please choose a smaller file.`);
          input.value = "";
        }
      });
    });

    // Honeypot spam field — real bot/rate-limit protection needs a server (see DEVELOPMENT.md).
    let lastSubmitAt = 0;
    enquiryForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const honeypot = enquiryForm.querySelector("input[name='company_website']");
      if (honeypot && honeypot.value) return; // silently drop bot submissions
      const now = Date.now();
      if (now - lastSubmitAt < 4000) return; // basic duplicate-submit guard
      lastSubmitAt = now;

      const mobile = document.getElementById("enqMobile");
      const email = document.getElementById("enqEmail");
      const mobileOk = /^[+]?[\d\s-]{7,15}$/.test(mobile.value.trim());
      const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim());
      if (!mobileOk) { mobile.focus(); mobile.setCustomValidity("Enter a valid mobile number"); mobile.reportValidity(); return; }
      mobile.setCustomValidity("");
      if (!emailOk) { email.focus(); email.setCustomValidity("Enter a valid email address"); email.reportValidity(); return; }
      email.setCustomValidity("");

      const ref = "VISA-" + new Date().toISOString().slice(0, 10).replace(/-/g, "") + "-" +
        String(Math.floor(Math.random() * 9000) + 1000);

      // NOTE: this is a front-end stub. Wire this fetch() to your real backend endpoint
      // once it exists — see "Enquiry backend" in DEVELOPMENT.md for the email / Google
      // Sheets / Google Drive workflow this needs to trigger server-side.
      console.log("[enquiry submitted — demo only, not sent anywhere]", {
        reference: ref,
        name: document.getElementById("enqName")?.value,
        mobile: mobile.value,
        email: email.value,
        nationality: document.getElementById("enqNationality")?.value,
        residence: document.getElementById("enqResidence")?.value,
        destination: destSelect?.value,
        visaType: visaSelect?.value,
        travelDate: dateInput?.value,
        duration: document.getElementById("enqDuration")?.value,
        travellers: document.getElementById("enqTravellers")?.value,
        purpose: document.getElementById("enqPurpose")?.value,
        message: document.getElementById("enqMessage")?.value,
      });

      const successEl = document.getElementById("enquirySuccess");
      const refEl = document.getElementById("enquiryRef");
      if (refEl) refEl.textContent = ref;
      if (successEl) {
        enquiryForm.hidden = true;
        successEl.hidden = false;
        successEl.scrollIntoView({ behavior: "smooth", block: "center" });
      }
    });
  }

  // ---- Scroll reveal animation ----
  const revealTargets = document.querySelectorAll(
    ".visatype-card, .visa-card, .step, .value-card, .office-card, .trust-item, .info-card, .doc-group, .faq-item"
  );
  revealTargets.forEach((el) => el.classList.add("reveal"));
  if ("IntersectionObserver" in window) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12 });
    revealTargets.forEach((el) => observer.observe(el));
  } else {
    revealTargets.forEach((el) => el.classList.add("is-visible"));
  }

  // ---- Footer year ----
  const yearEl = document.getElementById("year");
  if (yearEl) yearEl.textContent = new Date().getFullYear();
})();
