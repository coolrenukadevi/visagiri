document.addEventListener('DOMContentLoaded', function () {
    var form = document.getElementById('fxEnquiryForm');
    if (!form) { return; }

    var success = document.getElementById('fxRegSuccess');
    var submitBtn = document.getElementById('fxSubmitBtn');
    var formError = document.getElementById('fxFormError');
    var progressFill = document.getElementById('fxProgressFill');
    var stepNum = document.getElementById('fxStepNum');
    var stepName = document.getElementById('fxStepName');
    var currentStep = 1;
    var DRAFT_KEY = 'fxEnquiryDraft';

    var STEP_NAMES = { 1: 'Your Details', 2: 'Forex Requirement' };

    function saveDraft() {
        try {
            var data = {};
            form.querySelectorAll('input, select, textarea').forEach(function (el) {
                if (el.name === 'website_hp') { return; }
                data[el.name] = el.value;
            });
            localStorage.setItem(DRAFT_KEY, JSON.stringify(data));
        } catch (e) { /* ignore storage errors */ }
    }
    function restoreDraft() {
        try {
            var raw = localStorage.getItem(DRAFT_KEY);
            if (!raw) { return; }
            var data = JSON.parse(raw);
            Object.keys(data).forEach(function (name) {
                var el = form.querySelector('[name="' + name + '"]');
                if (el && typeof data[name] === 'string') { el.value = data[name]; }
            });
        } catch (e) { /* ignore malformed/absent draft */ }
    }
    restoreDraft();
    form.addEventListener('input', saveDraft);
    form.addEventListener('change', saveDraft);

    function goToStep(n) {
        form.querySelectorAll('.b2b-reg-step').forEach(function (el) {
            el.hidden = parseInt(el.getAttribute('data-step'), 10) !== n;
        });
        document.querySelectorAll('[data-step-dot]').forEach(function (dot) {
            dot.classList.toggle('is-active', parseInt(dot.getAttribute('data-step-dot'), 10) <= n);
        });
        currentStep = n;
        stepNum.textContent = n;
        stepName.textContent = STEP_NAMES[n];
        progressFill.style.width = (n / 2 * 100) + '%';
        var heading = form.querySelector('.b2b-reg-step[data-step="' + n + '"] h2');
        if (heading) { heading.setAttribute('tabindex', '-1'); heading.focus(); }
        window.scrollTo({ top: form.offsetTop - 100, behavior: 'smooth' });
    }

    function clearFieldErrors(step) {
        step.querySelectorAll('.b2b-error').forEach(function (el) { el.textContent = ''; });
        step.querySelectorAll('.is-invalid').forEach(function (el) { el.classList.remove('is-invalid'); });
    }
    function setFieldError(step, name, msg) {
        var errEl = step.querySelector('.b2b-error[data-error-for="' + name + '"]');
        if (errEl) { errEl.textContent = msg; }
        var field = step.querySelector('[name="' + name + '"]');
        if (field) { (field.closest('.b2b-phone-input') || field).classList.add('is-invalid'); }
    }

    function validateStep1() {
        var step = form.querySelector('.b2b-reg-step[data-step="1"]');
        clearFieldErrors(step);
        var ok = true;
        if (!form.full_name.value.trim()) { setFieldError(step, 'full_name', 'Required'); ok = false; }
        if (!/^[6-9]\d{9}$/.test(form.mobile.value.trim())) { setFieldError(step, 'mobile', 'Enter a valid 10-digit mobile number.'); ok = false; }
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email.value.trim())) { setFieldError(step, 'email', 'Enter a valid email address.'); ok = false; }
        if (!form.city.value.trim()) { ok = false; }
        var err = document.getElementById('fxStep1Error');
        err.textContent = ok ? '' : 'Please correct the highlighted fields.';
        return ok;
    }

    function validateStep2() {
        var required = ['service_type', 'purpose', 'currency_code', 'amount_required', 'country_visit'];
        var ok = true;
        required.forEach(function (name) {
            var field = form.querySelector('[name="' + name + '"]');
            if (field && !field.value.trim()) { ok = false; field.classList.add('is-invalid'); }
            else if (field) { field.classList.remove('is-invalid'); }
        });
        return ok;
    }

    form.querySelectorAll('[data-fx-next]').forEach(function (btn) {
        btn.addEventListener('click', function () {
            if (currentStep === 1 && !validateStep1()) { return; }
            goToStep(currentStep + 1);
        });
    });
    form.querySelectorAll('[data-fx-back]').forEach(function (btn) {
        btn.addEventListener('click', function () { goToStep(currentStep - 1); });
    });

    function setSubmitting(isSubmitting) {
        submitBtn.disabled = isSubmitting;
        submitBtn.querySelector('.b2b-btn-label').textContent = isSubmitting ? 'Submitting...' : 'Submit Forex Enquiry';
        submitBtn.querySelector('.b2b-btn-spinner').hidden = !isSubmitting;
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (submitBtn.disabled) { return; }
        if (!validateStep1()) { goToStep(1); return; }
        if (!validateStep2()) {
            formError.hidden = false;
            formError.textContent = 'Please fill in all required forex requirement fields.';
            return;
        }
        formError.hidden = true;

        setSubmitting(true);
        var fd = new FormData(form);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'forex-enquiry-handler.php', true);
        xhr.onload = function () {
            setSubmitting(false);
            var data = {};
            try { data = JSON.parse(xhr.responseText); } catch (err) { /* ignore */ }
            if (xhr.status >= 200 && xhr.status < 300 && data.success) {
                try { localStorage.removeItem(DRAFT_KEY); } catch (e) {}
                form.hidden = true;
                document.getElementById('fxRegProgress').hidden = true;
                success.hidden = false;
                document.getElementById('fxSuccessRef').textContent = data.forex_ref;
                document.getElementById('fxSuccessDate').textContent = data.submitted_date;
                document.getElementById('fxSuccessStatus').textContent = data.status;
                var uploadLink = document.getElementById('fxUploadDocsLink');
                if (uploadLink && data.upload_token) {
                    uploadLink.href = 'forex-documents?ref=' + encodeURIComponent(data.forex_ref) + '&token=' + encodeURIComponent(data.upload_token);
                }
                success.scrollIntoView({ behavior: 'smooth' });
            } else {
                formError.hidden = false;
                formError.textContent = data.message || 'We could not submit your enquiry right now. Please try again.';
            }
        };
        xhr.onerror = function () {
            setSubmitting(false);
            formError.hidden = false;
            formError.textContent = 'Network error. Please try again.';
        };
        xhr.send(fd);
    });
});
