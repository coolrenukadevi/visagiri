(function () {
  'use strict';

  var modal = document.getElementById('enquiry-modal');
  if (!modal) {
    return;
  }

  var dialog = modal.querySelector('.enquiry-modal__dialog');
  var steps = {};
  modal.querySelectorAll('[data-enquiry-modal-step]').forEach(function (el) {
    steps[el.getAttribute('data-enquiry-modal-step')] = el;
  });

  var wizardContainer = modal.querySelector('[data-enquiry-modal-wizard-container]');
  var wizardInstance = null;
  var wizardLoadedFor = null; // cache key: 'service|country|visaType|checklistRef', or null

  var simpleForm = document.getElementById('enquiry-modal-simple-form');
  var simpleEyebrow = modal.querySelector('[data-enquiry-modal-simple-eyebrow]');
  var simpleTitle = modal.querySelector('[data-enquiry-modal-simple-title]');
  var simpleService = document.getElementById('enquiry-modal-simple-service');
  var simpleSubmitBtn = document.getElementById('enquiry-modal-simple-submit');

  var SIMPLE_COPY = {
    forex: { eyebrow: 'Forex', title: 'Tell us about your forex requirement' },
    general: { eyebrow: 'General Enquiry', title: 'Tell us what you need' },
  };
  var WIZARD_COPY = {
    visa: { eyebrow: 'Visa Services', title: 'Request a Visa Quote' },
    apostille: { eyebrow: 'Apostille & Attestation', title: 'Request Apostille Assistance' },
  };
  var wizardEyebrow = modal.querySelector('[data-enquiry-modal-wizard-eyebrow]');
  var wizardTitle = modal.querySelector('[data-enquiry-modal-wizard-title]');

  var lastFocused = null;

  function showStep(name) {
    Object.keys(steps).forEach(function (key) {
      steps[key].hidden = key !== name;
    });
    modal.querySelector('.enquiry-modal__scroll').scrollTop = 0;
  }

  function openModal() {
    lastFocused = document.activeElement;
    modal.hidden = false;
    document.body.classList.add('enquiry-modal-open');
    var firstTile = modal.querySelector('[data-enquiry-service]');
    if (firstTile) {
      firstTile.focus();
    }
    document.addEventListener('keydown', onKeydown);
  }

  function closeModal() {
    modal.hidden = true;
    document.body.classList.remove('enquiry-modal-open');
    document.removeEventListener('keydown', onKeydown);
    if (lastFocused && typeof lastFocused.focus === 'function') {
      lastFocused.focus();
    }
  }

  function onKeydown(e) {
    if (e.key === 'Escape') {
      closeModal();
      return;
    }
    if (e.key === 'Tab') {
      var focusable = Array.prototype.slice.call(
        dialog.querySelectorAll('a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])')
      ).filter(function (el) { return el.offsetParent !== null; });
      if (!focusable.length) {
        return;
      }
      var first = focusable[0];
      var last = focusable[focusable.length - 1];
      if (e.shiftKey && document.activeElement === first) {
        e.preventDefault();
        last.focus();
      } else if (!e.shiftKey && document.activeElement === last) {
        e.preventDefault();
        first.focus();
      }
    }
  }

  document.querySelectorAll('[data-open-enquiry-modal]').forEach(function (trigger) {
    trigger.addEventListener('click', function (e) {
      e.preventDefault();
      showStep('picker');
      openModal();
    });
  });

  // Used by /visa/{country}/{type}/ pages' "Enquire Now & Unlock Full
  // Checklist" button — opens straight into the visa wizard, prefilled
  // for the country/visa type/checklist already established by the
  // page, skipping the 4-tile picker the generic trigger above shows.
  document.querySelectorAll('[data-open-enquiry-modal-checklist]').forEach(function (trigger) {
    trigger.addEventListener('click', function (e) {
      e.preventDefault();
      openModal();
      loadWizard('visa', {
        country: trigger.getAttribute('data-country') || '',
        visaType: trigger.getAttribute('data-visa-type') || '',
        checklistRef: trigger.getAttribute('data-checklist-ref') || '',
      });
    });
  });

  modal.querySelectorAll('[data-enquiry-modal-close]').forEach(function (btn) {
    btn.addEventListener('click', closeModal);
  });

  modal.querySelectorAll('[data-enquiry-modal-back]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      showStep('picker');
    });
  });

  function loadWizard(service, context) {
    context = context || {};
    var copy = WIZARD_COPY[service] || WIZARD_COPY.visa;
    wizardEyebrow.textContent = copy.eyebrow;
    wizardTitle.textContent = copy.title;
    showStep('wizard');

    // Cache key includes the context so a checklist-context open (with
    // country/visa_type/checklist_ref prefilled) never reuses a plain
    // wizard instance loaded earlier without that context, or vice versa.
    var cacheKey = service + '|' + (context.country || '') + '|' + (context.visaType || '') + '|' + (context.checklistRef || '');
    if (wizardLoadedFor === cacheKey) {
      if (wizardInstance) {
        wizardInstance.setServiceCategory(service);
      }
      return;
    }
    wizardContainer.innerHTML = '<p class="enquiry-modal__loading">Loading form&hellip;</p>';
    var url = '/enquire/wizard/?service=' + encodeURIComponent(service);
    if (context.country) { url += '&country=' + encodeURIComponent(context.country); }
    if (context.visaType) { url += '&visa_type=' + encodeURIComponent(context.visaType); }
    if (context.checklistRef) { url += '&checklist_ref=' + encodeURIComponent(context.checklistRef); }
    fetch(url, {
      headers: { 'X-Requested-With': 'fetch' },
      credentials: 'same-origin',
    })
      .then(function (resp) { return resp.text(); })
      .then(function (html) {
        wizardContainer.innerHTML = html;
        wizardLoadedFor = cacheKey;
        wizardInstance = window.VisagiriEnquiryWizard.init(wizardContainer, {
          onSuccess: function (data) { showSuccess(data); },
          // No onError here on purpose: leaving it unset makes
          // enquiry-wizard.js fall through to its own default
          // showFormErrors(), which inserts the real validation
          // messages at the top of the wizard and scrolls to them —
          // exactly what should happen inside the modal too. An empty
          // onError callback here would silently swallow every
          // server-side validation error instead (a real bug this
          // comment used to paper over — the "already renders its own
          // inline errors" claim was true only when onError is absent).
        });
        if (wizardInstance) {
          wizardInstance.setServiceCategory(service);
        }
      })
      .catch(function () {
        wizardContainer.innerHTML = '<div class="alert alert-danger">Could not load the enquiry form. Please refresh the page and try again, or visit <a href="/enquire/">/enquire/</a> directly.</div>';
      });
  }

  function loadSimpleForm(service) {
    var copy = SIMPLE_COPY[service] || SIMPLE_COPY.general;
    simpleEyebrow.textContent = copy.eyebrow;
    simpleTitle.textContent = copy.title;
    simpleService.value = service;
    showStep('simple-form');
  }

  modal.querySelectorAll('[data-enquiry-service]').forEach(function (tile) {
    tile.addEventListener('click', function () {
      var service = tile.getAttribute('data-enquiry-service');
      if (service === 'visa' || service === 'apostille') {
        loadWizard(service);
      } else {
        loadSimpleForm(service);
      }
    });
  });

  function showSimpleFormErrors(errors) {
    simpleForm.querySelectorAll('.enquiry-modal-ajax-error').forEach(function (el) { el.remove(); });
    var fragment = document.createDocumentFragment();
    errors.forEach(function (message) {
      var div = document.createElement('div');
      div.className = 'alert alert-danger enquiry-modal-ajax-error';
      div.textContent = message;
      fragment.appendChild(div);
    });
    simpleForm.insertBefore(fragment, simpleForm.firstChild);
  }

  if (simpleForm) {
    simpleForm.addEventListener('submit', function (e) {
      e.preventDefault();
      simpleSubmitBtn.disabled = true;
      simpleSubmitBtn.textContent = 'Sending…';

      var formData = new FormData(simpleForm);
      fetch('/contact/', {
        method: 'POST',
        body: formData,
        headers: { 'X-Requested-With': 'fetch' },
        credentials: 'same-origin',
      })
        .then(function (resp) { return resp.json(); })
        .then(function (data) {
          simpleSubmitBtn.disabled = false;
          simpleSubmitBtn.textContent = 'Send Message';
          if (data && data.success) {
            simpleForm.reset();
            showSuccess(data);
          } else {
            showSimpleFormErrors((data && data.errors && data.errors.length) ? data.errors : ['Something went wrong sending your message. Please try again, or reach us on WhatsApp.']);
          }
        })
        .catch(function () {
          simpleSubmitBtn.disabled = false;
          simpleSubmitBtn.textContent = 'Send Message';
          showSimpleFormErrors(['Something went wrong sending your message. Please check your connection and try again.']);
        });
    });
  }

  function showSuccess(data) {
    modal.querySelector('[data-enquiry-modal-success-ref]').textContent = data.reference || '';

    var trackRow = modal.querySelector('[data-enquiry-modal-success-track-row]');
    var trackSpan = modal.querySelector('[data-enquiry-modal-success-track]');
    if (data.tracking_token) {
      trackSpan.textContent = data.tracking_token;
      trackRow.hidden = false;
    } else {
      trackRow.hidden = true;
    }

    var pdfLink = modal.querySelector('[data-enquiry-modal-success-pdf]');
    if (data.pdf_url) {
      pdfLink.href = data.pdf_url;
      pdfLink.hidden = false;
    } else {
      pdfLink.hidden = true;
    }

    var trackLink = modal.querySelector('[data-enquiry-modal-success-track-link]');
    if (data.track_url) {
      trackLink.href = data.track_url;
      trackLink.hidden = false;
    } else {
      trackLink.hidden = true;
    }

    var checklistLink = modal.querySelector('[data-enquiry-modal-success-checklist]');
    var checklistNote = modal.querySelector('[data-enquiry-modal-success-checklist-note]');
    if (data.checklist_unlocked && data.checklist_url) {
      checklistLink.href = data.checklist_url;
      checklistLink.hidden = false;
      checklistNote.textContent = 'Your complete visa checklist is now available.';
      checklistNote.hidden = false;
    } else {
      checklistLink.hidden = true;
      checklistNote.hidden = true;
    }

    showStep('success');
  }
})();
