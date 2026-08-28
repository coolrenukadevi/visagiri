(function () {
    var form = document.getElementById('b2bForgotForm');
    if (!form) { return; }

    var steps = form.querySelectorAll('[data-fp-step]');
    function goToStep(n) {
        steps.forEach(function (s) { s.hidden = s.getAttribute('data-fp-step') !== String(n); });
    }

    var emailInput = document.getElementById('fpEmail');
    var sendBtn = document.getElementById('fpSendBtn');
    var resendBtn = document.getElementById('fpResendBtn');
    var step1Error = document.getElementById('fpStep1Error');
    var step2Error = document.getElementById('fpStep2Error');
    var resetBtn = document.getElementById('fpResetBtn');

    function setBtnBusy(btn, isBusy, busyLabel, idleLabel) {
        btn.disabled = isBusy;
        btn.querySelector('.b2b-btn-label').textContent = isBusy ? busyLabel : idleLabel;
        btn.querySelector('.b2b-btn-spinner').hidden = !isBusy;
    }

    function sendCode() {
        var email = emailInput.value.trim();
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            step1Error.hidden = false;
            step1Error.textContent = 'Please enter a valid email address.';
            return;
        }
        step1Error.hidden = true;
        setBtnBusy(sendBtn, true, 'Sending...', 'Send Reset Code');
        var fd = new URLSearchParams({ email: email, purpose: 'password_reset', b2b_csrf: form.b2b_csrf.value });
        fetch('b2b-otp-send.php', { method: 'POST', body: fd })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                setBtnBusy(sendBtn, false, 'Sending...', 'Send Reset Code');
                if (data.success) {
                    goToStep(2);
                } else {
                    step1Error.hidden = false;
                    step1Error.textContent = data.message || 'Could not send code. Please try again.';
                }
            })
            .catch(function () {
                setBtnBusy(sendBtn, false, 'Sending...', 'Send Reset Code');
                step1Error.hidden = false;
                step1Error.textContent = 'Network error. Please try again.';
            });
    }

    sendBtn.addEventListener('click', sendCode);
    resendBtn.addEventListener('click', sendCode);

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (resetBtn.disabled) { return; }

        var code = document.getElementById('fpCode').value.trim();
        var password = document.getElementById('fpPassword').value;
        var confirm = document.getElementById('fpPasswordConfirm').value;

        step2Error.hidden = true;
        if (code.length !== 6) {
            step2Error.hidden = false;
            step2Error.textContent = 'Enter the 6-digit code.';
            return;
        }
        if (password.length < 8) {
            step2Error.hidden = false;
            step2Error.textContent = 'Password must be at least 8 characters.';
            return;
        }
        if (password !== confirm) {
            step2Error.hidden = false;
            step2Error.textContent = 'Passwords do not match.';
            return;
        }

        setBtnBusy(resetBtn, true, 'Resetting...', 'Reset Password');
        var fd = new URLSearchParams({
            email: emailInput.value.trim(),
            code: code,
            new_password: password,
            new_password_confirm: confirm,
            b2b_csrf: form.b2b_csrf.value
        });
        fetch('b2b-reset-password.php', { method: 'POST', body: fd })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                setBtnBusy(resetBtn, false, 'Resetting...', 'Reset Password');
                if (data.success) {
                    goToStep(3);
                } else {
                    step2Error.hidden = false;
                    step2Error.textContent = data.message || 'Could not reset your password. Please try again.';
                }
            })
            .catch(function () {
                setBtnBusy(resetBtn, false, 'Resetting...', 'Reset Password');
                step2Error.hidden = false;
                step2Error.textContent = 'Network error. Please try again.';
            });
    });
})();
