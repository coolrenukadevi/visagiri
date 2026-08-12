/*
 * Site-wide vanilla JS — Phase 4. No framework, no dependencies.
 * Progressive enhancement only: header/nav are usable without this
 * running (the mobile panel just starts closed).
 */
(function () {
  'use strict';

  var header = document.getElementById('site-header');
  if (header) {
    var onScroll = function () {
      header.classList.toggle('is-scrolled', window.scrollY > 12);
    };
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
  }

  var burger = document.getElementById('site-header-burger');
  var mobilePanel = document.getElementById('site-header-mobile');
  if (burger && mobilePanel) {
    burger.addEventListener('click', function () {
      var isOpen = mobilePanel.classList.toggle('is-open');
      burger.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });
  }

  // Confirm-before-submit for destructive forms (document removal,
  // account suspension, etc). Inline onsubmit="return confirm(...)"
  // attributes are inline scripts and get silently blocked by our own
  // CSP (script-src 'self') — same class of bug as the Phase 7
  // country-search fix, so this lives here as a delegated listener
  // instead: add data-confirm="message" to any form that needs it.
  document.addEventListener('submit', function (event) {
    var form = event.target;
    if (form instanceof HTMLFormElement && form.dataset.confirm && !window.confirm(form.dataset.confirm)) {
      event.preventDefault();
    }
  });

  // Floating enquiry widget (WhatsApp/Call/Email).
  var enquiryWidget = document.getElementById('enquiry-widget');
  var enquiryToggle = document.getElementById('enquiry-widget-toggle');
  if (enquiryWidget && enquiryToggle) {
    var setOpen = function (open) {
      enquiryWidget.classList.toggle('is-open', open);
      enquiryToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    };
    enquiryToggle.addEventListener('click', function () {
      setOpen(!enquiryWidget.classList.contains('is-open'));
    });
    document.addEventListener('click', function (event) {
      if (enquiryWidget.classList.contains('is-open') && !enquiryWidget.contains(event.target)) {
        setOpen(false);
      }
    });
    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && enquiryWidget.classList.contains('is-open')) {
        setOpen(false);
        enquiryToggle.focus();
      }
    });
  }
})();
