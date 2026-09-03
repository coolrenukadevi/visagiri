document.addEventListener('DOMContentLoaded', function () {
    var mobileForm = document.getElementById('fxLoginMobileForm');
    if (!mobileForm) { return; }

    var otpForm = document.getElementById('fxLoginOtpForm');
    var errorBox = document.getElementById('fxLoginError');
    var sendBtn = document.getElementById('fxLoginSendBtn');
    var verifyBtn = document.getElementById('fxLoginVerifyBtn');
    var otpSub = document.getElementById('fxLoginOtpSub');
    var otpMobileField = document.getElementById('fxLoginOtpMobile');
    var otpInput = document.getElementById('fxLoginOtp');
    var resendBtn = document.getElementById('fxLoginResendBtn');
    var backBtn = document.getElementById('fxLoginBackBtn');
    var resendCooldownUntil = 0;

    function setError(msg) {
        errorBox.textContent = msg || '';
    }

    function setBusy(btn, busy) {
        btn.disabled = busy;
        btn.querySelector('.b2b-btn-label').textContent = busy ? 'Please wait...' : (btn === sendBtn ? 'Send Login Code' : 'Verify & Log In');
        btn.querySelector('.b2b-btn-spinner').hidden = !busy;
    }

    function postJson(url, data, cb) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', url);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
            var body = {};
            try { body = JSON.parse(xhr.responseText); } catch (e) { body = { success: false, message: 'Unexpected error. Please try again.' }; }
            cb(xhr.status, body);
        };
        xhr.onerror = function () { cb(0, { success: false, message: 'Network error. Please check your connection and try again.' }); };
        var params = [];
        Object.keys(data).forEach(function (k) { params.push(encodeURIComponent(k) + '=' + encodeURIComponent(data[k])); });
        xhr.send(params.join('&'));
    }

    function requestOtp(mobile) {
        setError('');
        setBusy(sendBtn, true);
        postJson('forex-otp-send.php', { mobile: mobile, forex_csrf: FX_CSRF }, function (status, body) {
            setBusy(sendBtn, false);
            if (!body.success) {
                setError(body.message || 'Something went wrong. Please try again.');
                return;
            }
            otpMobileField.value = mobile;
            otpSub.textContent = body.masked_email
                ? 'Enter the 6-digit code we emailed to ' + body.masked_email + '.'
                : 'If this mobile number has a Forex request on file, a code has been emailed to the registered address.';
            mobileForm.hidden = true;
            otpForm.hidden = false;
            otpInput.focus();
            resendCooldownUntil = Date.now() + 30000;
        });
    }

    mobileForm.addEventListener('submit', function (e) {
        e.preventDefault();
        var mobile = document.getElementById('fxLoginMobile').value.trim();
        if (!/^\d{10}$/.test(mobile.replace(/\D/g, '').slice(-10))) {
            setError('Please enter a valid 10-digit mobile number.');
            return;
        }
        requestOtp(mobile.replace(/\D/g, '').slice(-10));
    });

    otpForm.addEventListener('submit', function (e) {
        e.preventDefault();
        setError('');
        var code = otpInput.value.trim();
        if (!/^\d{6}$/.test(code)) {
            setError('Please enter the 6-digit code.');
            return;
        }
        setBusy(verifyBtn, true);
        postJson('forex-otp-login.php', { mobile: otpMobileField.value, code: code, forex_csrf: FX_CSRF }, function (status, body) {
            if (!body.success) {
                setBusy(verifyBtn, false);
                setError(body.message || 'That code is incorrect or has expired.');
                return;
            }
            window.location.href = body.redirect || 'forex-my-requests';
        });
    });

    resendBtn.addEventListener('click', function () {
        if (Date.now() < resendCooldownUntil) {
            setError('Please wait a few seconds before requesting another code.');
            return;
        }
        requestOtp(otpMobileField.value);
    });

    backBtn.addEventListener('click', function () {
        setError('');
        otpForm.hidden = true;
        mobileForm.hidden = false;
        otpInput.value = '';
    });
});
