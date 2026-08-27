document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById('qeModal');
    if (!modal) { return; }

    var form = document.getElementById('qeForm');
    var success = document.getElementById('qeSuccess');
    var submitBtn = document.getElementById('qeSubmitBtn');
    var formError = document.getElementById('qeFormError');
    var step2Error = document.getElementById('qeStep2Error');
    var progressFill = document.getElementById('qeProgressFill');
    var stepNum = document.getElementById('qeStepNum');
    var stepName = document.getElementById('qeStepName');
    var lastFocusedEl = null;
    var currentStep = 1;
    var selectedService = null;
    var selectedPurpose = null;
    var progressStarted = false;
    var reachedSuccess = false;

    var STEP_NAMES = { 1: 'Service', 2: 'Requirements', 3: 'Contact Details' };

    function uuid() {
        if (window.crypto && window.crypto.randomUUID) { return window.crypto.randomUUID(); }
        return 'xxxxxxxxyxxxxyxxxxyxxxxyxxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0;
            var v = c === 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }

    // ---- Lightweight first-party analytics beacon (no PII) ----
    function track(eventType, extra) {
        extra = extra || {};
        var payload = new URLSearchParams({
            event_type: eventType,
            service: extra.service || selectedService || '',
            purpose: extra.purpose || selectedPurpose || '',
            page_url: window.location.pathname,
        });
        if (navigator.sendBeacon) {
            navigator.sendBeacon('analytics-event.php', payload);
        } else {
            fetch('analytics-event.php', { method: 'POST', body: payload, keepalive: true }).catch(function () {});
        }
    }

    function goToStep(n) {
        modal.querySelectorAll('.qe-step').forEach(function (el) {
            el.hidden = parseInt(el.getAttribute('data-step'), 10) !== n;
        });
        currentStep = n;
        stepNum.textContent = n;
        stepName.textContent = STEP_NAMES[n];
        progressFill.style.width = (n / 3 * 100) + '%';
        var heading = modal.querySelector('.qe-step[data-step="' + n + '"]:not([hidden]) h2, .qe-step2-panel[data-step2-for="' + selectedService + '"]:not([hidden]) h2');
        if (heading) { heading.setAttribute('tabindex', '-1'); heading.focus(); }
    }

    function showStep2Panel(serviceKey) {
        modal.querySelectorAll('.qe-step2-panel').forEach(function (panel) {
            panel.hidden = panel.getAttribute('data-step2-for') !== serviceKey;
        });
    }

    function resetModal() {
        form.reset();
        currentStep = 1;
        selectedService = null;
        selectedPurpose = null;
        progressStarted = false;
        reachedSuccess = false;
        form.hidden = false;
        success.hidden = true;
        formError.hidden = true;
        step2Error.textContent = '';
        modal.querySelectorAll('.qe-error').forEach(function (el) { el.textContent = ''; });
        modal.querySelectorAll('.is-invalid').forEach(function (el) { el.classList.remove('is-invalid'); });
        modal.querySelectorAll('.qe-service-card.is-selected').forEach(function (el) { el.classList.remove('is-selected'); });
        modal.querySelectorAll('.qe-option-btn.is-selected').forEach(function (el) { el.classList.remove('is-selected'); });
        modal.querySelectorAll('.qe-step2-panel').forEach(function (el) { el.hidden = true; });
        document.getElementById('qeService').value = '';
        document.getElementById('qePurpose').value = '';
        document.getElementById('qeSubmissionToken').value = uuid();

        var params = new URLSearchParams(window.location.search);
        document.getElementById('qeSourceUrl').value = window.location.pathname;
        document.getElementById('qeReferrer').value = document.referrer || '';
        document.getElementById('qeUtmSource').value = params.get('utm_source') || '';
        document.getElementById('qeUtmMedium').value = params.get('utm_medium') || '';
        document.getElementById('qeUtmCampaign').value = params.get('utm_campaign') || '';
        document.getElementById('qeUtmTerm').value = params.get('utm_term') || '';
        document.getElementById('qeUtmContent').value = params.get('utm_content') || '';
        document.getElementById('qeDevice').value = /Mobi|Android/i.test(navigator.userAgent) ? 'Mobile' : 'Desktop';

        var minDate = new Date().toISOString().split('T')[0];
        modal.querySelectorAll('input[type="date"]').forEach(function (el) { el.setAttribute('min', minDate); });

        setSubmitting(false);
        goToStep(1);
    }

    function openModal(trigger) {
        lastFocusedEl = document.activeElement;
        resetModal();
        modal.hidden = false;
        document.documentElement.classList.add('va-qe-modal-open');
        requestAnimationFrame(function () { modal.classList.add('is-open', 'is-visible'); });
        setTimeout(function () {
            var first = modal.querySelector('.qe-service-card');
            if (first) { first.focus(); }
        }, 260);
        track('get_assistance_click');

        if (trigger) {
            var presetService = trigger.getAttribute('data-qe-service');
            if (presetService) {
                var card = modal.querySelector('.qe-service-card[data-service="' + presetService + '"]');
                if (card) { card.click(); }
            }
        }
    }

    function closeModal() {
        if (progressStarted && !reachedSuccess) { track('form_abandoned'); }
        modal.classList.remove('is-visible');
        document.documentElement.classList.remove('va-qe-modal-open');
        setTimeout(function () {
            modal.classList.remove('is-open');
            modal.hidden = true;
            if (lastFocusedEl && typeof lastFocusedEl.focus === 'function') { lastFocusedEl.focus(); }
        }, 260);
    }

    document.addEventListener('click', function (e) {
        var trigger = e.target.closest('[data-open-quick-enquiry]');
        if (trigger) {
            e.preventDefault();
            openModal(trigger);
            return;
        }
        if (e.target.closest('[data-qe-close]')) {
            e.preventDefault();
            closeModal();
            return;
        }
        var serviceCard = e.target.closest('.qe-service-card');
        if (serviceCard && modal.contains(serviceCard)) {
            selectedService = serviceCard.getAttribute('data-service');
            document.getElementById('qeService').value = selectedService;
            modal.querySelectorAll('.qe-service-card').forEach(function (el) { el.classList.toggle('is-selected', el === serviceCard); });
            showStep2Panel(selectedService);
            progressStarted = true;
            track('service_selected');
            goToStep(2);
            return;
        }
        var optionBtn = e.target.closest('.qe-option-btn');
        if (optionBtn && modal.contains(optionBtn)) {
            selectedPurpose = optionBtn.getAttribute('data-purpose');
            document.getElementById('qePurpose').value = selectedPurpose;
            var panel = optionBtn.closest('.qe-step2-panel');
            panel.querySelectorAll('.qe-option-btn').forEach(function (el) { el.classList.toggle('is-selected', el === optionBtn); });
            step2Error.textContent = '';
            track('purpose_selected');
            return;
        }
        if (e.target.closest('[data-qe-back]')) {
            if (currentStep === 2) { goToStep(1); }
            else if (currentStep === 3) { goToStep(2); }
            return;
        }
        if (e.target.id === 'qeContinueBtn') {
            handleContinue();
        }
    });

    document.addEventListener('keydown', function (e) {
        if (!modal.classList.contains('is-open')) { return; }
        if (e.key === 'Escape') { closeModal(); return; }
        if (e.key === 'Tab') {
            var focusable = modal.querySelectorAll('button:not([hidden]):not([disabled]), a[href]:not([hidden]), input:not([hidden]):not([disabled]), select:not([hidden]):not([disabled]), textarea:not([hidden]):not([disabled])');
            focusable = Array.prototype.filter.call(focusable, function (el) { return el.offsetParent !== null; });
            if (!focusable.length) { return; }
            var first = focusable[0];
            var last = focusable[focusable.length - 1];
            if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
            else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
        }
    });

    function handleContinue() {
        var svc = QE_SERVICES[selectedService];
        step2Error.textContent = '';
        if (!svc.is_freeform) {
            if (!selectedPurpose) {
                step2Error.textContent = 'Please choose an option above.';
                return;
            }
            var panel = modal.querySelector('.qe-step2-panel[data-step2-for="' + selectedService + '"]');
            var missing = false;
            panel.querySelectorAll('.qe-dynamic-field[required]').forEach(function (el) {
                if (!el.value) { el.classList.add('is-invalid'); missing = true; } else { el.classList.remove('is-invalid'); }
            });
            if (missing) { step2Error.textContent = 'Please fill in the required fields.'; return; }
        } else {
            var textarea = modal.querySelector('.qe-step2-panel[data-step2-for="general"] textarea');
            if (!textarea.value.trim()) {
                textarea.classList.add('is-invalid');
                step2Error.textContent = 'Please tell us what you need help with.';
                return;
            }
            textarea.classList.remove('is-invalid');
        }
        goToStep(3);
    }

    // ---- Validation (step 3) ----
    function clearErrors() {
        modal.querySelectorAll('.qe-error').forEach(function (el) { el.textContent = ''; });
        modal.querySelectorAll('.is-invalid').forEach(function (el) { el.classList.remove('is-invalid'); });
        formError.hidden = true;
    }
    function setFieldError(name, msg) {
        var errEl = modal.querySelector('.qe-error[data-error-for="' + name + '"]');
        if (errEl) { errEl.textContent = msg; }
        var field = form.querySelector('[name="' + name + '"]');
        if (field) {
            var wrapper = field.closest('.qe-phone-input');
            (wrapper || field).classList.add('is-invalid');
        }
    }
    function validateStep3() {
        clearErrors();
        var ok = true;
        if (!form.full_name.value.trim()) { setFieldError('full_name', 'Please enter your full name.'); ok = false; }
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email.value.trim())) { setFieldError('email', 'Please enter a valid email address.'); ok = false; }
        if (!/^[6-9]\d{9}$/.test(form.mobile.value.trim())) { setFieldError('mobile', 'Enter a valid 10-digit Indian mobile number.'); ok = false; }
        return ok;
    }

    function setSubmitting(isSubmitting) {
        submitBtn.disabled = isSubmitting;
        submitBtn.querySelector('.qe-btn-label').textContent = isSubmitting ? 'Submitting…' : 'Submit Enquiry';
        submitBtn.querySelector('.qe-btn-spinner').hidden = !isSubmitting;
    }

    var firstInteractionTracked = false;
    form.addEventListener('focusin', function () {
        if (!firstInteractionTracked) { firstInteractionTracked = true; track('form_started'); }
    });

    function showSuccess(data) {
        reachedSuccess = true;
        form.hidden = true;
        success.hidden = false;
        document.getElementById('qeSuccessRef').textContent = data.enquiry_ref;
        document.getElementById('qeTrackBtn').href = 'track-application?code=' + encodeURIComponent(data.tracking_code || '');
        var waMsg = "Hello VisaGiri, I'd like to follow up on my enquiry " + data.enquiry_ref + ".";
        document.getElementById('qeWhatsAppBtn').href = data.whatsapp_url ? (data.whatsapp_url + '?text=' + encodeURIComponent(waMsg)) : ('https://wa.me/?text=' + encodeURIComponent(waMsg));
        track('form_completed', { service: data.service, purpose: data.purpose });
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (submitBtn.disabled) { return; }
        if (!validateStep3()) { return; }

        setSubmitting(true);
        formError.hidden = true;

        var fd = new FormData(form);
        // Collect the currently-visible service's dynamic extra fields under stable keys.
        var activePanel = modal.querySelector('.qe-step2-panel[data-step2-for="' + selectedService + '"]');
        if (activePanel) {
            activePanel.querySelectorAll('.qe-dynamic-field').forEach(function (el) {
                fd.append('field_' + el.getAttribute('data-field'), el.value);
            });
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'quick-enquiry-handler.php', true);
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
