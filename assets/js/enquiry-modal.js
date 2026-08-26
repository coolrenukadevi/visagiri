document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById('enquiryModal');
    if (!modal) { return; }

    var form = document.getElementById('enquiryForm');
    var successPanel = document.getElementById('enquirySuccess');
    var submitBtn = document.getElementById('enquirySubmitBtn');
    var formError = document.getElementById('enquiryFormError');
    var MAX_FILE_BYTES = 5 * 1024 * 1024;
    var ALLOWED_EXT = ['pdf', 'jpg', 'jpeg', 'png'];
    var lastFocusedEl = null;

    // ---- Open / close ----
    function uuid() {
        if (window.crypto && window.crypto.randomUUID) { return window.crypto.randomUUID(); }
        return 'xxxxxxxxyxxxxyxxxxyxxxxyxxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0;
            var v = c === 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }

    function resetForm() {
        form.reset();
        form.hidden = false;
        successPanel.hidden = true;
        formError.hidden = true;
        formError.textContent = '';
        modal.querySelectorAll('.enquiry-error').forEach(function (el) { el.textContent = ''; });
        modal.querySelectorAll('.is-invalid').forEach(function (el) { el.classList.remove('is-invalid'); });
        modal.querySelectorAll('.enquiry-upload-list').forEach(function (el) { el.innerHTML = ''; });
        modal.querySelectorAll('.enquiry-upload-box').forEach(function (box) {
            box._files = [];
        });
        document.getElementById('enquirySubmissionToken').value = uuid();

        var params = new URLSearchParams(window.location.search);
        document.getElementById('enquirySourceUrl').value = window.location.pathname;
        document.getElementById('enquiryUtmSource').value = params.get('utm_source') || '';
        document.getElementById('enquiryUtmMedium').value = params.get('utm_medium') || '';
        document.getElementById('enquiryUtmCampaign').value = params.get('utm_campaign') || '';
        document.getElementById('enquiryUtmTerm').value = params.get('utm_term') || '';
        document.getElementById('enquiryUtmContent').value = params.get('utm_content') || '';

        var minDate = new Date().toISOString().split('T')[0];
        document.getElementById('enqTravelDate').setAttribute('min', minDate);

        setSubmitting(false);
    }

    // Services with no meaningful destination country / visa type (Apostille,
    // Forex, Insurance, Flight/Hotel, General enquiries) — hide those two
    // fields instead of forcing an irrelevant selection, and fall back to a
    // sentinel value server-side (enquiry-handler.php mirrors this list).
    var NON_VISA_SERVICES = ['General Enquiry', 'Apostille & Attestation', 'Forex Assistance', 'Travel Insurance', 'Flight & Hotel Assistance', 'Other Services'];
    var destinationField = document.getElementById('enqDestinationCountry');
    var visaTypeField = document.getElementById('enqVisaType');
    var destinationWrapper = destinationField ? destinationField.closest('.enquiry-field') : null;
    var visaTypeWrapper = visaTypeField ? visaTypeField.closest('.enquiry-field') : null;

    function applyServiceVisibility() {
        var isNonVisa = NON_VISA_SERVICES.indexOf(form.service_required.value) !== -1;
        if (destinationWrapper) { destinationWrapper.hidden = isNonVisa; }
        if (visaTypeWrapper) { visaTypeWrapper.hidden = isNonVisa; }
        if (destinationField) { destinationField.required = !isNonVisa; }
        if (visaTypeField) { visaTypeField.required = !isNonVisa; }
    }

    if (form.service_required) {
        form.service_required.addEventListener('change', applyServiceVisibility);
    }

    function openModal(trigger) {
        lastFocusedEl = document.activeElement;
        resetForm();
        if (trigger) {
            var country = trigger.getAttribute('data-country');
            var visaType = trigger.getAttribute('data-visa-type');
            var purpose = trigger.getAttribute('data-purpose');
            var service = trigger.getAttribute('data-service');
            if (country) {
                var countrySelect = document.getElementById('enqDestinationCountry');
                if (countrySelect) { countrySelect.value = country; }
            }
            if (visaType) {
                var visaSelect = document.getElementById('enqVisaType');
                if (visaSelect) { visaSelect.value = visaType; }
            }
            if (purpose) {
                var purposeInput = document.getElementById('enqPurpose');
                if (purposeInput) { purposeInput.value = purpose; }
            }
            if (service) {
                var serviceSelect = document.getElementById('enqServiceRequired');
                if (serviceSelect) { serviceSelect.value = service; }
            }
        }
        applyServiceVisibility();
        modal.hidden = false;
        document.documentElement.classList.add('va-enquiry-modal-open');
        requestAnimationFrame(function () {
            modal.classList.add('is-open', 'is-visible');
        });
        setTimeout(function () {
            var first = form.querySelector('input, select, textarea');
            if (first) { first.focus(); }
        }, 300);
    }

    function closeModal() {
        modal.classList.remove('is-visible');
        document.documentElement.classList.remove('va-enquiry-modal-open');
        setTimeout(function () {
            modal.classList.remove('is-open');
            modal.hidden = true;
            if (lastFocusedEl && typeof lastFocusedEl.focus === 'function') {
                lastFocusedEl.focus();
            }
        }, 280);
    }

    document.addEventListener('click', function (e) {
        var trigger = e.target.closest('a.theme-btn[href="contact"], [data-open-enquiry]');
        if (trigger) {
            e.preventDefault();
            openModal(trigger);
            return;
        }
        if (e.target.closest('[data-enquiry-close]')) {
            e.preventDefault();
            closeModal();
        }
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && modal.classList.contains('is-open')) {
            closeModal();
        }
    });

    // ---- File upload boxes ----
    modal.querySelectorAll('.enquiry-upload-box').forEach(function (box) {
        box._files = [];
        var input = box.querySelector('input[type="file"]');
        var drop = box.querySelector('.enquiry-upload-drop');
        var list = box.querySelector('.enquiry-upload-list');
        var multiple = box.getAttribute('data-multiple') === 'true';
        var label = box.getAttribute('data-label');

        drop.addEventListener('click', function () { input.click(); });
        drop.addEventListener('dragover', function (e) { e.preventDefault(); box.classList.add('is-dragover'); });
        drop.addEventListener('dragleave', function () { box.classList.remove('is-dragover'); });
        drop.addEventListener('drop', function (e) {
            e.preventDefault();
            box.classList.remove('is-dragover');
            handleFiles(e.dataTransfer.files);
        });
        input.addEventListener('change', function () {
            handleFiles(input.files);
        });

        function humanSize(bytes) {
            if (bytes < 1024) { return bytes + ' B'; }
            if (bytes < 1024 * 1024) { return (bytes / 1024).toFixed(1) + ' KB'; }
            return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
        }

        function renderList() {
            list.innerHTML = '';
            box._files.forEach(function (entry, idx) {
                var chip = document.createElement('div');
                chip.className = 'enquiry-upload-chip' + (entry.error ? ' chip-error' : '');
                chip.innerHTML =
                    '<i class="fa-solid ' + (entry.error ? 'fa-triangle-exclamation' : 'fa-file') + ' file-icon"></i>' +
                    '<span class="chip-name">' + escapeHtml(entry.file.name) + '</span>' +
                    '<span class="chip-size">' + (entry.error ? entry.error : humanSize(entry.file.size)) + '</span>' +
                    '<button type="button" class="chip-remove" aria-label="Remove file"><i class="fa-solid fa-xmark"></i></button>';
                chip.querySelector('.chip-remove').addEventListener('click', function () {
                    box._files.splice(idx, 1);
                    syncInputFiles();
                    renderList();
                });
                list.appendChild(chip);
            });
        }

        function syncInputFiles() {
            var dt = new DataTransfer();
            box._files.forEach(function (entry) {
                if (!entry.error) { dt.items.add(entry.file); }
            });
            input.files = dt.files;
        }

        function handleFiles(fileList) {
            var incoming = Array.prototype.slice.call(fileList);
            if (!multiple) {
                box._files = [];
            }
            incoming.forEach(function (file) {
                var ext = file.name.split('.').pop().toLowerCase();
                var error = null;
                if (ALLOWED_EXT.indexOf(ext) === -1) {
                    error = 'Unsupported type';
                } else if (file.size > MAX_FILE_BYTES) {
                    error = 'Over 5MB limit';
                }
                if (!multiple) { box._files = []; }
                box._files.push({ file: file, error: error });
            });
            syncInputFiles();
            renderList();
        }
    });

    function escapeHtml(str) {
        var div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    // ---- Validation ----
    function clearErrors() {
        modal.querySelectorAll('.enquiry-error').forEach(function (el) { el.textContent = ''; });
        modal.querySelectorAll('.is-invalid').forEach(function (el) { el.classList.remove('is-invalid'); });
        formError.hidden = true;
    }

    function setFieldError(name, msg) {
        var errEl = modal.querySelector('.enquiry-error[data-error-for="' + name + '"]');
        if (errEl) { errEl.textContent = msg; }
        var field = form.querySelector('[name="' + name + '"]');
        if (field) {
            var wrapper = field.closest('.enquiry-phone-input');
            (wrapper || field).classList.add('is-invalid');
        }
    }

    function validate() {
        clearErrors();
        var ok = true;
        var fullName = form.full_name.value.trim();
        if (!fullName) { setFieldError('full_name', 'Please enter your full name.'); ok = false; }

        var email = form.email.value.trim();
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) { setFieldError('email', 'Please enter a valid email address.'); ok = false; }

        var mobile = form.mobile.value.trim();
        if (!/^[6-9]\d{9}$/.test(mobile)) { setFieldError('mobile', 'Enter a valid 10-digit Indian mobile number.'); ok = false; }

        var passport = form.passport_number.value.trim();
        if (!/^[A-Za-z0-9]{6,12}$/.test(passport)) { setFieldError('passport_number', 'Please enter a valid passport number.'); ok = false; }

        if (!form.service_required.value) { setFieldError('service_required', 'Please select a service.'); ok = false; }
        var isNonVisa = NON_VISA_SERVICES.indexOf(form.service_required.value) !== -1;
        if (!isNonVisa) {
            if (!form.destination_country.value) { setFieldError('destination_country', 'Please select your destination.'); ok = false; }
            if (!form.visa_type.value) { setFieldError('visa_type', 'Please select a visa type.'); ok = false; }
        }

        var travelDate = form.travel_date.value;
        if (!travelDate) { setFieldError('travel_date', 'Please choose your expected travel date.'); ok = false; }

        var travellers = parseInt(form.travellers.value, 10);
        if (!travellers || travellers < 1) { setFieldError('travellers', 'Please enter the number of travellers.'); ok = false; }

        if (!form.consent_accurate.checked || !form.consent_contact.checked) {
            setFieldError('consent', 'Please accept both consent statements to continue.');
            ok = false;
        }

        return ok;
    }

    function setSubmitting(isSubmitting) {
        submitBtn.disabled = isSubmitting;
        submitBtn.querySelector('.enquiry-btn-label').textContent = isSubmitting ? 'Submitting…' : 'Submit Enquiry';
        submitBtn.querySelector('.enquiry-btn-spinner').hidden = !isSubmitting;
    }

    function showSuccess(data) {
        form.hidden = true;
        successPanel.hidden = false;
        document.getElementById('enquirySuccessCode').textContent = data.tracking_code;
        document.getElementById('esFullName').textContent = data.full_name;
        document.getElementById('esPassport').textContent = data.passport_masked;
        document.getElementById('esMobile').textContent = data.mobile_masked;
        document.getElementById('esEmail').textContent = data.email_masked;
        document.getElementById('esCountry').textContent = data.destination_country;
        document.getElementById('esVisaType').textContent = data.visa_type;
        var submitted = new Date(data.submitted_at);
        document.getElementById('esSubmittedAt').textContent = isNaN(submitted.getTime())
            ? data.submitted_at
            : submitted.toLocaleString('en-IN', { dateStyle: 'medium', timeStyle: 'short' });

        document.getElementById('esTrackBtn').href = 'track-application?code=' + encodeURIComponent(data.tracking_code);
        document.getElementById('esDownloadBtn').href = 'confirmation?code=' + encodeURIComponent(data.tracking_code);

        var warnEl = document.getElementById('enquirySuccessWarnings');
        if (data.warnings && data.warnings.length) {
            warnEl.hidden = false;
            warnEl.textContent = 'Note: ' + data.warnings.join(' ');
        } else {
            warnEl.hidden = true;
        }
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (submitBtn.disabled) { return; }
        if (!validate()) { return; }

        setSubmitting(true);
        formError.hidden = true;

        var fd = new FormData(form);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'enquiry-handler.php', true);
        xhr.onload = function () {
            setSubmitting(false);
            var data = {};
            try { data = JSON.parse(xhr.responseText); } catch (err) { /* ignore */ }
            if (xhr.status >= 200 && xhr.status < 300 && data.success) {
                showSuccess(data);
            } else if (data.errors) {
                Object.keys(data.errors).forEach(function (key) { setFieldError(key, data.errors[key]); });
                formError.hidden = false;
                formError.textContent = data.message || 'Please correct the highlighted fields.';
            } else {
                formError.hidden = false;
                formError.textContent = data.message || 'We could not submit your enquiry right now. Please try again or contact our support team.';
            }
        };
        xhr.onerror = function () {
            setSubmitting(false);
            formError.hidden = false;
            formError.textContent = "We couldn't submit your enquiry right now. Please try again or contact our support team.";
        };
        xhr.send(fd);
    });
});
