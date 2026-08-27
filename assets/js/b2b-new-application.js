(function () {
    var form = document.getElementById('ppNewAppForm');
    if (!form) { return; }
    var submitBtn = document.getElementById('ppNewAppSubmit');
    var formError = document.getElementById('ppNewAppError');
    var success = document.getElementById('ppNewAppSuccess');

    function setSubmitting(isSubmitting) {
        submitBtn.disabled = isSubmitting;
        submitBtn.querySelector('.b2b-btn-label').textContent = isSubmitting ? 'Submitting...' : 'Submit Application';
        submitBtn.querySelector('.b2b-btn-spinner').hidden = !isSubmitting;
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (submitBtn.disabled) { return; }
        formError.hidden = true;
        form.querySelectorAll('.b2b-error').forEach(function (el) { el.textContent = ''; });
        form.querySelectorAll('.is-invalid').forEach(function (el) { el.classList.remove('is-invalid'); });

        setSubmitting(true);
        var fd = new FormData(form);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'b2b-new-application-handler.php', true);
        xhr.onload = function () {
            setSubmitting(false);
            var data = {};
            try { data = JSON.parse(xhr.responseText); } catch (err) { /* ignore */ }
            if (xhr.status >= 200 && xhr.status < 300 && data.success) {
                form.hidden = true;
                document.getElementById('ppNewAppRef').textContent = data.enquiry_ref;
                success.hidden = false;
                success.scrollIntoView({ behavior: 'smooth' });
            } else if (data.errors) {
                formError.hidden = false;
                formError.textContent = data.message || 'Please correct the highlighted fields.';
                Object.keys(data.errors).forEach(function (field) {
                    var errEl = form.querySelector('[data-error-for="' + field + '"]');
                    var input = form.querySelector('[name="' + field + '"]');
                    if (errEl) { errEl.textContent = data.errors[field]; }
                    if (input) { input.classList.add('is-invalid'); }
                });
            } else {
                formError.hidden = false;
                formError.textContent = data.message || 'We could not submit this application right now. Please try again.';
            }
        };
        xhr.onerror = function () {
            setSubmitting(false);
            formError.hidden = false;
            formError.textContent = 'Network error. Please try again.';
        };
        xhr.send(fd);
    });
})();
