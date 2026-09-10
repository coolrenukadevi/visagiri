(function () {
  'use strict';

  /**
   * Drives one Visa/Apostille enquiry wizard instance. Scoped entirely
   * to `root` (never document.getElementById/document.querySelector)
   * so this can run against the standalone /enquire/ page's wizard AND
   * a second copy lazy-loaded into the sitewide "Enquire Now" modal
   * without the two ever interfering with each other, even though both
   * copies share the same element ids (querySelector scoped to a root
   * element only searches that root's descendants, so duplicate ids
   * elsewhere in the document are harmless here).
   *
   * options.onSuccess(data) / options.onError(errors) let the modal
   * render its own success/error panel; the standalone page passes
   * neither and gets the original full-page-navigation behavior.
   */
  function initEnquiryWizard(root, options) {
    options = options || {};
    var form = root.querySelector('#enquiry-form');
    if (!form) {
      return null;
    }
    var steps = Array.prototype.slice.call(root.querySelectorAll('.enquiry-step'));
    var stepperItems = Array.prototype.slice.call(root.querySelectorAll('.enrollment-steps__item'));
    var rules = {};
    var rulesEl = root.querySelector('.enquiry-document-rules-data');
    if (rulesEl) {
      try {
        rules = JSON.parse(rulesEl.textContent) || {};
      } catch (e) {
        rules = {};
      }
    }

    function currentStepIndex() {
      for (var i = 0; i < steps.length; i++) {
        if (!steps[i].hidden) {
          return i;
        }
      }
      return 0;
    }

    function showStep(index) {
      steps.forEach(function (el, i) {
        el.hidden = i !== index;
      });
      stepperItems.forEach(function (el, i) {
        el.classList.remove('is-current', 'is-done');
        if (i === index) {
          el.classList.add('is-current');
        } else if (i < index) {
          el.classList.add('is-done');
        }
      });
      if (index === 3) {
        renderReviewSummary();
      }
      root.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function activeServiceCategory() {
      var checked = form.querySelector('[data-service-toggle]:checked');
      return checked ? checked.value : 'visa';
    }

    function toggleServicePanels() {
      var category = activeServiceCategory();
      form.querySelectorAll('[data-service-panel]').forEach(function (panel) {
        panel.hidden = panel.getAttribute('data-service-panel') !== category;
      });
      updateRequiredHints();
    }

    function updateRequiredHints() {
      var category = activeServiceCategory();
      var visaTypeSelect = form.querySelector('[data-visa-type-select]');
      var visaTypeSlug = visaTypeSelect ? visaTypeSelect.value : '';
      var docRules = category === 'apostille' ? (rules.__apostille__ || {}) : (rules[visaTypeSlug] || {});

      form.querySelectorAll('[data-doc-label]').forEach(function (label) {
        var cat = label.getAttribute('data-doc-label');
        var existing = label.querySelector('.required-mark');
        if (docRules[cat]) {
          if (!existing) {
            var mark = document.createElement('span');
            mark.className = 'required-mark';
            mark.textContent = ' *';
            label.appendChild(mark);
          }
        } else if (existing) {
          existing.remove();
        }
      });
    }

    function validateVisibleStep(index) {
      var step = steps[index];
      var requiredInputs = Array.prototype.slice.call(step.querySelectorAll('[required]'));
      for (var i = 0; i < requiredInputs.length; i++) {
        var input = requiredInputs[i];
        if (input.closest('[data-service-panel][hidden]')) {
          continue;
        }
        if (!input.checkValidity()) {
          input.reportValidity();
          return false;
        }
      }
      if (index === 1) {
        var category = activeServiceCategory();
        if (category === 'visa') {
          var required = ['destination_country', 'visa_type', 'passport_number', 'passport_issued_from', 'journey_date'];
          for (var j = 0; j < required.length; j++) {
            var field = form.elements[required[j]];
            if (field && field.value.trim() === '') {
              field.focus();
              alert('Please complete all required fields before continuing.');
              return false;
            }
          }
        } else {
          var apRequired = ['apostille_service_type', 'apostille_document_type'];
          for (var k = 0; k < apRequired.length; k++) {
            var apField = form.elements[apRequired[k]];
            if (apField && apField.value.trim() === '') {
              apField.focus();
              alert('Please complete all required fields before continuing.');
              return false;
            }
          }
        }
      }
      return true;
    }

    function renderReviewSummary() {
      var summary = root.querySelector('#enquiry-review-summary');
      if (!summary) {
        return;
      }
      var category = activeServiceCategory();
      var rows = [
        ['Name', form.elements.name.value],
        ['Mobile', form.elements.mobile_country_code.value + ' ' + form.elements.mobile_number.value],
        ['Email', form.elements.email.value],
        ['City / State', form.elements.current_city.value + ', ' + form.elements.current_state.value],
      ];
      if (category === 'visa') {
        rows.push(['Service', 'Visa Enquiry']);
        rows.push(['Country', selectedLabel('destination_country')]);
        rows.push(['Visa Type', selectedLabel('visa_type')]);
        rows.push(['Passport Number', form.elements.passport_number.value]);
        rows.push(['Passport Issued From', form.elements.passport_issued_from.value]);
        rows.push(['Date of Journey', form.elements.journey_date.value]);
        rows.push(['Number of Pax', form.elements.pax_count.value]);
      } else {
        rows.push(['Service', 'Apostille / Document Legalisation']);
        rows.push(['Apostille Service', selectedLabel('apostille_service_type')]);
        rows.push(['Document Type', selectedLabel('apostille_document_type')]);
        rows.push(['Number of Documents', form.elements.apostille_document_count.value]);
        rows.push(['Destination Country', selectedLabel('apostille_destination_country')]);
      }

      var fileNames = [];
      form.querySelectorAll('input[type="file"]').forEach(function (input) {
        if (input.files && input.files.length) {
          fileNames.push(input.files[0].name);
        }
      });
      rows.push(['Documents Attached', fileNames.length ? fileNames.join(', ') : 'None']);

      summary.innerHTML = rows.map(function (row) {
        return '<div class="enquiry-review-row"><span class="enquiry-review-label">' + escapeHtml(row[0]) + '</span><span class="enquiry-review-value">' + escapeHtml(row[1] || '—') + '</span></div>';
      }).join('');
    }

    function selectedLabel(fieldName) {
      var field = form.elements[fieldName];
      if (!field || field.selectedIndex < 0) {
        return '';
      }
      var option = field.options[field.selectedIndex];
      return option ? option.textContent : '';
    }

    function escapeHtml(str) {
      var div = document.createElement('div');
      div.textContent = str;
      return div.innerHTML;
    }

    function showFormErrors(errors) {
      root.querySelectorAll('.enquiry-wizard-ajax-error').forEach(function (el) {
        el.remove();
      });
      if (!errors || !errors.length) {
        return;
      }
      var container = document.createDocumentFragment();
      errors.forEach(function (message) {
        var div = document.createElement('div');
        div.className = 'alert alert-danger enquiry-wizard-ajax-error';
        div.textContent = message;
        container.appendChild(div);
      });
      root.insertBefore(container, root.firstChild);
      root.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    root.querySelectorAll('[data-step-next]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var index = currentStepIndex();
        if (!validateVisibleStep(index)) {
          return;
        }
        if (index < steps.length - 1) {
          showStep(index + 1);
        }
      });
    });

    root.querySelectorAll('[data-step-back]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var index = currentStepIndex();
        if (index > 0) {
          showStep(index - 1);
        }
      });
    });

    form.querySelectorAll('[data-service-toggle]').forEach(function (radio) {
      radio.addEventListener('change', toggleServicePanels);
    });
    var visaTypeSelect = form.querySelector('[data-visa-type-select]');
    if (visaTypeSelect) {
      visaTypeSelect.addEventListener('change', updateRequiredHints);
    }

    var submitBtn = root.querySelector('#enquiry-submit-btn');
    var isAjax = form.hasAttribute('data-ajax-submit');

    form.addEventListener('submit', function (e) {
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.textContent = 'Submitting Enquiry…';
      }

      if (!isAjax) {
        return; // standalone page: let the browser do its normal POST + redirect-after-post.
      }

      e.preventDefault();
      var formData = new FormData(form);
      fetch(form.getAttribute('action'), {
        method: 'POST',
        body: formData,
        headers: { 'X-Requested-With': 'fetch' },
        credentials: 'same-origin',
      })
        .then(function (resp) { return resp.json(); })
        .then(function (data) {
          if (data && data.success) {
            if (typeof options.onSuccess === 'function') {
              options.onSuccess(data);
            }
          } else {
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.textContent = 'Submit Enquiry';
            }
            var errors = (data && data.errors) || ['Something went wrong submitting your enquiry. Please try again, or reach us on WhatsApp.'];
            if (typeof options.onError === 'function') {
              options.onError(errors);
            } else {
              showFormErrors(errors);
            }
          }
        })
        .catch(function () {
          if (submitBtn) {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Submit Enquiry';
          }
          var errors = ['Something went wrong submitting your enquiry. Please check your connection and try again.'];
          if (typeof options.onError === 'function') {
            options.onError(errors);
          } else {
            showFormErrors(errors);
          }
        });
    });

    toggleServicePanels();

    return {
      root: root,
      form: form,
      showStep: showStep,
      activeServiceCategory: activeServiceCategory,
      setServiceCategory: function (category) {
        var radio = form.querySelector('[data-service-toggle][value="' + category + '"]');
        if (radio) {
          radio.checked = true;
          toggleServicePanels();
        }
      },
    };
  }

  window.VisagiriEnquiryWizard = { init: initEnquiryWizard };

  // Standalone page (/enquire/): auto-init against the one wizard
  // already present in the DOM at load time, exactly as before this
  // was refactored into a reusable function.
  var staticWizard = document.querySelector('[data-enquiry-wizard]');
  if (staticWizard) {
    initEnquiryWizard(staticWizard, {});
  }
})();
