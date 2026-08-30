/*
 * Homepage-only behaviour: the 4-tab hero search widget, quicklinks, and the
 * callback banner. Loaded after data.js + common.js.
 */
(() => {
  "use strict";
  const D = window.ConvercessionData;

  window.CVinitAutocomplete({ hiddenId: "visaCountry", items: D.COUNTRIES, popular: D.POPULAR_COUNTRIES, emptyLabel: "All countries A–Z" });
  window.CVpopulateSelect(document.getElementById("visaCity"), D.EMBASSY_CITIES, "Select city");
  window.CVinitAutocomplete({ hiddenId: "visaType", items: D.VISA_TYPES });

  // ---- Hero search tabs ----
  const tabs = document.querySelectorAll(".tab");
  const fieldGroups = document.querySelectorAll(".search-fields");
  const submitLabel = document.getElementById("searchSubmitLabel");
  function setActiveTab(tab) {
    tabs.forEach((t) => {
      const isActive = t === tab;
      t.classList.toggle("active", isActive);
      t.setAttribute("aria-selected", String(isActive));
    });
    fieldGroups.forEach((group) => {
      group.classList.toggle("active", group.dataset.tab === tab.dataset.tab);
    });
    if (submitLabel && tab.dataset.label) submitLabel.textContent = tab.dataset.label;
  }
  tabs.forEach((tab) => tab.addEventListener("click", () => setActiveTab(tab)));
  const visaTab = document.querySelector('.tab[data-tab="visa"]');

  // ---- Visa type quicklinks (hero pills + visa-type cards) preset the search form ----
  document.querySelectorAll(".visa-quick-btn, .visatype-card").forEach((btn) => {
    btn.addEventListener("click", () => {
      if (visaTab) setActiveTab(visaTab);
      if (btn.dataset.visatype) window.CVsetAutocompleteValue("visaType", btn.dataset.visatype);
      document.getElementById("search")?.scrollIntoView({ behavior: "smooth" });
    });
  });

  // ---- Popular destination cards preset the country field ----
  document.querySelectorAll(".visa-card").forEach((card) => {
    card.addEventListener("click", () => {
      if (visaTab) setActiveTab(visaTab);
      if (card.dataset.country) window.CVsetAutocompleteValue("visaCountry", card.dataset.country);
      document.getElementById("search")?.scrollIntoView({ behavior: "smooth" });
    });
  });

  // ---- Search form submit ----
  const searchForm = document.getElementById("searchForm");
  if (searchForm) {
    searchForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const activeTab = document.querySelector(".tab.active");
      const tabName = activeTab ? activeTab.dataset.tab : "visa";

      if (tabName === "visa") {
        const country = document.getElementById("visaCountry").value;
        const visaType = document.getElementById("visaType").value;
        const city = document.getElementById("visaCity").value;
        window.CVgoToVisaPage(country, visaType, city ? { city } : {});
        return;
      }

      // Visa Tracking / Invoice Details / Payment are demo-only — no backend to hit yet.
      const label = document.getElementById("searchSubmitLabel");
      const original = activeTab && activeTab.dataset.label ? activeTab.dataset.label : label.textContent;
      label.textContent = "Please wait…";
      window.setTimeout(() => { label.textContent = original; }, 900);
    });
  }

  // ---- Callback form ----
  const dealForm = document.getElementById("dealForm");
  const dealNote = document.getElementById("dealNote");
  if (dealForm && dealNote) {
    dealForm.addEventListener("submit", (e) => {
      e.preventDefault();
      dealNote.textContent = "✅ Thanks! A Convercession visa consultant will call you back shortly.";
      dealForm.reset();
    });
  }
})();
