document.addEventListener('DOMContentLoaded', function () {
    var form = document.getElementById('b2bRegForm');
    if (!form) { return; }

    var success = document.getElementById('b2bRegSuccess');
    var submitBtn = document.getElementById('b2bSubmitBtn');
    var formError = document.getElementById('b2bFormError');
    var progressFill = document.getElementById('b2bProgressFill');
    var stepNum = document.getElementById('b2bStepNum');
    var stepName = document.getElementById('b2bStepName');
    var currentStep = 1;
    var emailVerified = false;
    var DRAFT_KEY = 'b2bPartnerRegDraft';

    var STEP_NAMES = { 1: 'Business Information', 2: 'Primary Contact', 3: 'Business Profile', 4: 'Declaration' };

    // ---- IATA conditional field ----
    form.querySelectorAll('input[name="iata_registered"]').forEach(function (radio) {
        radio.addEventListener('change', function () {
            document.getElementById('iataNumberField').hidden = (this.value !== '1');
        });
    });

    // ---- Auto-save draft to localStorage (spec: "auto-save drafts") ----
    function saveDraft() {
        try {
            var data = {};
            form.querySelectorAll('input, select, textarea').forEach(function (el) {
                if (el.type === 'password' || el.name === 'website_hp') { return; }
                if (el.type === 'checkbox' || el.type === 'radio') {
                    if (el.checked) { data[el.name] = data[el.name] || []; data[el.name].push(el.value); }
                } else {
                    data[el.name] = el.value;
                }
            });
            localStorage.setItem(DRAFT_KEY, JSON.stringify(data));
        } catch (e) { /* ignore storage errors (private mode, quota, etc.) */ }
    }

    function restoreDraft() {
        try {
            var raw = localStorage.getItem(DRAFT_KEY);
            if (!raw) { return; }
            var data = JSON.parse(raw);
            Object.keys(data).forEach(function (name) {
                var val = data[name];
                var els = form.querySelectorAll('[name="' + name.replace(/\[\]$/, '\\[\\]') + '"]');
                els.forEach(function (el) {
                    if (el.type === 'checkbox' || el.type === 'radio') {
                        el.checked = Array.isArray(val) ? val.indexOf(el.value) !== -1 : val === el.value;
                        if (el.type === 'radio' && el.checked) { el.dispatchEvent(new Event('change')); }
                    } else if (typeof val === 'string') {
                        el.value = val;
                    }
                });
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
        progressFill.style.width = (n / 4 * 100) + '%';
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
        var required = ['company_name', 'business_type', 'address', 'city', 'state', 'country', 'pin_code'];
        var ok = true;
        required.forEach(function (name) {
            var field = step.querySelector('[name="' + name + '"]');
            if (field && !field.value.trim()) { setFieldError(step, name, 'Required'); ok = false; }
        });
        if (!ok) { document.getElementById('b2bStep1Error').textContent = 'Please fill in all required fields.'; }
        else { document.getElementById('b2bStep1Error').textContent = ''; }
        return ok;
    }

    function validateStep2(requireOtp) {
        var step = form.querySelector('.b2b-reg-step[data-step="2"]');
        clearFieldErrors(step);
        var ok = true;
        if (!form.contact_name.value.trim()) { ok = false; }
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.contact_email.value.trim())) { setFieldError(step, 'contact_email', 'Enter a valid email address.'); ok = false; }
        if (!/^[6-9]\d{9}$/.test(form.contact_mobile.value.trim())) { ok = false; }
        if (!form.username.value.trim()) { setFieldError(step, 'username', 'Choose a username.'); ok = false; }
        if (form.password.value.length < 8) { ok = false; }
        if (form.password.value !== form.password_confirm.value) { setFieldError(step, 'password_confirm', 'Passwords do not match.'); ok = false; }
        var err = document.getElementById('b2bStep2Error');
        if (!ok) { err.textContent = 'Please correct the highlighted fields.'; return false; }
        if (requireOtp && !emailVerified) { err.textContent = 'Please verify your email before continuing.'; return false; }
        err.textContent = '';
        return true;
    }

    // ---- OTP flow ----
    var sendBtn = document.getElementById('b2bSendOtpBtn');
    var resendBtn = document.getElementById('b2bResendOtpBtn');
    var verifyBtn = document.getElementById('b2bVerifyOtpBtn');
    var otpSendRow = document.getElementById('b2bOtpSendRow');
    var otpEnterRow = document.getElementById('b2bOtpEnterRow');
    var otpStatus = document.getElementById('b2bOtpStatus');
    var otpBox = document.getElementById('b2bOtpBox');

    function sendOtp() {
        var email = form.contact_email.value.trim();
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            otpStatus.textContent = 'Enter a valid official email above first.';
            otpStatus.className = 'b2b-otp-status is-error';
            return;
        }
        otpStatus.textContent = 'Sending code...';
        otpStatus.className = 'b2b-otp-status';
        var fd = new URLSearchParams({ email: email, purpose: 'register' });
        fetch('b2b-otp-send.php', { method: 'POST', body: fd })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data.success) {
                    otpSendRow.hidden = true;
                    otpEnterRow.hidden = false;
                    otpStatus.textContent = data.message;
                    otpStatus.className = 'b2b-otp-status is-ok';
                } else {
                    otpStatus.textContent = data.message || 'Could not send code.';
                    otpStatus.className = 'b2b-otp-status is-error';
                }
            })
            .catch(function () {
                otpStatus.textContent = 'Network error. Please try again.';
                otpStatus.className = 'b2b-otp-status is-error';
            });
    }

    sendBtn.addEventListener('click', sendOtp);
    resendBtn.addEventListener('click', sendOtp);

    verifyBtn.addEventListener('click', function () {
        var email = form.contact_email.value.trim();
        var code = document.getElementById('b2bOtpCode').value.trim();
        if (code.length !== 6) {
            otpStatus.textContent = 'Enter the 6-digit code.';
            otpStatus.className = 'b2b-otp-status is-error';
            return;
        }
        var fd = new URLSearchParams({ email: email, purpose: 'register', code: code });
        fetch('b2b-otp-verify.php', { method: 'POST', body: fd })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data.success) {
                    emailVerified = true;
                    otpBox.classList.add('is-verified');
                    otpStatus.textContent = 'Email verified.';
                    otpStatus.className = 'b2b-otp-status is-ok';
                    otpEnterRow.hidden = true;
                } else {
                    otpStatus.textContent = data.message || 'Incorrect code.';
                    otpStatus.className = 'b2b-otp-status is-error';
                }
            })
            .catch(function () {
                otpStatus.textContent = 'Network error. Please try again.';
                otpStatus.className = 'b2b-otp-status is-error';
            });
    });

    // ---- Step navigation ----
    form.querySelectorAll('[data-b2b-next]').forEach(function (btn) {
        btn.addEventListener('click', function () {
            if (currentStep === 1 && !validateStep1()) { return; }
            if (currentStep === 2 && !validateStep2(true)) { return; }
            goToStep(currentStep + 1);
        });
    });
    form.querySelectorAll('[data-b2b-back]').forEach(function (btn) {
        btn.addEventListener('click', function () { goToStep(currentStep - 1); });
    });

    // ---- Submit ----
    function setSubmitting(isSubmitting) {
        submitBtn.disabled = isSubmitting;
        submitBtn.querySelector('.b2b-btn-label').textContent = isSubmitting ? 'Submitting...' : 'Submit Partner Application';
        submitBtn.querySelector('.b2b-btn-spinner').hidden = !isSubmitting;
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (submitBtn.disabled) { return; }
        if (!validateStep1() ) { goToStep(1); return; }
        if (!validateStep2(true)) { goToStep(2); return; }

        var declarationOk = form.declaration_confirmed.checked && form.agree_terms.checked && form.agree_privacy.checked
            && form.agree_partner_agreement.checked && form.agree_commission.checked && form.agree_doc_policy.checked && form.agree_data_protection.checked;
        formError.hidden = true;
        if (!declarationOk) {
            formError.hidden = false;
            formError.textContent = 'Please accept all terms and the declaration before submitting.';
            return;
        }

        setSubmitting(true);
        var fd = new FormData(form);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'b2b-partner-register-handler.php', true);
        xhr.onload = function () {
            setSubmitting(false);
            var data = {};
            try { data = JSON.parse(xhr.responseText); } catch (err) { /* ignore */ }
            if (xhr.status >= 200 && xhr.status < 300 && data.success) {
                try { localStorage.removeItem(DRAFT_KEY); } catch (e) {}
                form.hidden = true;
                document.getElementById('b2bRegProgress').hidden = true;
                success.hidden = false;
                document.getElementById('b2bSuccessRef').textContent = data.application_ref;
                document.getElementById('b2bSuccessDate').textContent = data.registration_date;
                document.getElementById('b2bSuccessStatus').textContent = data.status;
                success.scrollIntoView({ behavior: 'smooth' });
            } else if (data.errors) {
                formError.hidden = false;
                formError.textContent = data.message || 'Please correct the highlighted fields.';
            } else {
                formError.hidden = false;
                formError.textContent = data.message || 'We could not submit your application right now. Please try again.';
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
