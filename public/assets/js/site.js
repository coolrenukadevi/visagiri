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

  // Mega-menus (Attestation Services, Company). Desktop already opens
  // on hover/focus-within via CSS (same pattern as the existing Visa
  // Services dropdown), which covers mouse and keyboard tabbing for
  // free. This layers click-to-toggle on top for touch/tablet devices
  // that don't fire :hover, plus outside-click and Escape to close —
  // mirroring the enquiry-widget toggle pattern below. Shared as one
  // function (rather than copy-pasted per menu) so a fix like the
  // Escape/:focus-within interaction below only ever needs to happen
  // in one place.
  var initMegaMenu = function (triggerId, menuId) {
    var megaMenuTrigger = document.getElementById(triggerId);
    var megaMenu = document.getElementById(menuId);
    if (!megaMenuTrigger || !megaMenu) {
      return;
    }
    var megaMenuItem = megaMenuTrigger.closest('.has-mega-menu');
    if (!megaMenuItem) {
      return;
    }
    var setMegaMenuOpen = function (open) {
      megaMenu.classList.toggle('is-open', open);
      megaMenuTrigger.setAttribute('aria-expanded', open ? 'true' : 'false');
    };
    megaMenuTrigger.addEventListener('click', function (event) {
      // Only intercept on devices without real hover (touch/tablet);
      // desktop mouse users get the plain link + hover-opened panel.
      if (window.matchMedia('(hover: none)').matches) {
        event.preventDefault();
        setMegaMenuOpen(!megaMenu.classList.contains('is-open'));
      }
    });
    document.addEventListener('click', function (event) {
      if (megaMenu.classList.contains('is-open') && !megaMenuItem.contains(event.target)) {
        setMegaMenuOpen(false);
      }
    });
    document.addEventListener('keydown', function (event) {
      if (event.key !== 'Escape') {
        return;
      }
      var isOpen = megaMenu.classList.contains('is-open') || megaMenuItem.contains(document.activeElement) || megaMenuItem.matches(':hover');
      if (isOpen) {
        setMegaMenuOpen(false);
        // :hover/:focus-within would otherwise keep the CSS-only panel
        // visible even after the class above is removed, since Escape
        // doesn't move the mouse or blur the trigger — force it closed
        // until the pointer/focus actually leaves the item.
        megaMenu.classList.add('is-force-closed');
        megaMenuTrigger.focus();
      }
    });
    megaMenuItem.addEventListener('mouseleave', function () {
      megaMenu.classList.remove('is-force-closed');
    });
    megaMenuItem.addEventListener('mouseenter', function () {
      megaMenu.classList.remove('is-force-closed');
    });
    megaMenuItem.addEventListener('focusout', function (event) {
      if (!megaMenuItem.contains(event.relatedTarget)) {
        megaMenu.classList.remove('is-force-closed');
      }
    });
  };
  initMegaMenu('attestation-mega-trigger', 'attestation-mega-menu');
  initMegaMenu('company-mega-trigger', 'company-mega-menu');
  initMegaMenu('countries-mega-trigger', 'countries-mega-menu');

  // Countries mega-menu live search. Same substring-match approach as
  // countries.js's /countries/ page filter, but scoped to the
  // mega-menu's own elements (distinct IDs — both this and the
  // /countries/ page's own search box exist in the DOM at once when
  // viewing /countries/ itself, so they can't share an id). Filters
  // country chips/links (data-mega-country-name) and hides an entire
  // column group (data-mega-country-col) when none of its entries
  // match; the "Find Visa By Purpose" list has no data-mega-country-*
  // attributes, so it's untouched by the country search, same as the
  // "View All" links, which stay usable regardless of the query.
  var megaCountryFilter = document.getElementById('mega-country-filter');
  if (megaCountryFilter) {
    var megaCountryEmpty = document.getElementById('mega-country-empty');
    var megaCountryItems = Array.prototype.slice.call(document.querySelectorAll('[data-mega-country-name]'));
    var megaCountryCols = Array.prototype.slice.call(document.querySelectorAll('[data-mega-country-col]'));
    megaCountryFilter.addEventListener('input', function () {
      var q = megaCountryFilter.value.trim().toLowerCase();
      var anyVisible = false;
      megaCountryItems.forEach(function (item) {
        var match = q === '' || item.getAttribute('data-mega-country-name').indexOf(q) !== -1;
        item.hidden = !match;
        if (match) {
          anyVisible = true;
        }
      });
      megaCountryCols.forEach(function (col) {
        var hasMatch = q === '' || col.querySelector('[data-mega-country-name]:not([hidden])') !== null;
        col.hidden = !hasMatch;
      });
      if (megaCountryEmpty) {
        megaCountryEmpty.hidden = anyVisible;
      }
    });
  }

  // Mobile Attestation accordion — closes any other open <details> in
  // the mobile nav when one is opened, so only one panel is expanded
  // at a time and the menu stays easy to scroll (native <details>
  // already handles the expand/collapse itself, matching the FAQ
  // accordion pattern elsewhere on the site — no JS needed for that
  // part).
  var mobileAccordions = document.querySelectorAll('.site-header__mobile-accordion > details');
  mobileAccordions.forEach(function (details) {
    details.addEventListener('toggle', function () {
      if (details.open) {
        mobileAccordions.forEach(function (other) {
          if (other !== details) {
            other.open = false;
          }
        });
      }
    });
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
