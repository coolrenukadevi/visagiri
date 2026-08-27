(function () {
    var form = document.getElementById('b2bLoginForm');
    if (!form) { return; }
    var submitBtn = document.getElementById('b2bLoginSubmit');
    var formError = document.getElementById('b2bLoginAlert');

    function setSubmitting(isSubmitting) {
        submitBtn.disabled = isSubmitting;
        submitBtn.querySelector('.b2b-btn-label').textContent = isSubmitting ? 'Logging in...' : 'Log In';
        submitBtn.querySelector('.b2b-btn-spinner').hidden = !isSubmitting;
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (submitBtn.disabled) { return; }
        formError.hidden = true;

        setSubmitting(true);
        var fd = new FormData(form);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'b2b-login-handler.php', true);
        xhr.onload = function () {
            var data = {};
            try { data = JSON.parse(xhr.responseText); } catch (err) { /* ignore */ }
            if (xhr.status >= 200 && xhr.status < 300 && data.success) {
                window.location = data.redirect || 'b2b-dashboard.php';
                return;
            }
            setSubmitting(false);
            formError.hidden = false;
            formError.textContent = data.message || 'We could not log you in. Please try again.';
        };
        xhr.onerror = function () {
            setSubmitting(false);
            formError.hidden = false;
            formError.textContent = 'Network error. Please try again.';
        };
        xhr.send(fd);
    });
})();
