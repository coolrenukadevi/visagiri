(function () {
  'use strict';

  var wizard = document.querySelector('[data-enquiry-wizard]');
  if (!wizard) {
    return;
  }

  var form = document.getElementById('enquiry-form');
  var steps = Array.prototype.slice.call(wizard.querySelectorAll('.enquiry-step'));
  var stepperItems = Array.prototype.slice.call(wizard.querySelectorAll('.enrollment-steps__item'));
  var rules = {};
  var rulesEl = document.getElementById('enquiry-document-rules-data');
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
    wizard.scrollIntoView({ behavior: 'smooth', block: 'start' });
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
    var summary = document.getElementById('enquiry-review-summary');
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

  wizard.querySelectorAll('[data-step-next]').forEach(function (btn) {
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

  wizard.querySelectorAll('[data-step-back]').forEach(function (btn) {
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

  var submitBtn = document.getElementById('enquiry-submit-btn');
  form.addEventListener('submit', function () {
    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.textContent = 'Submitting Enquiry…';
    }
  });

  toggleServicePanels();
})();
