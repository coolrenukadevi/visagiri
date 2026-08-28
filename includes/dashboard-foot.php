    </div>
  </div>
</div>

<script src="<?= asset('js/main.js') ?>" defer></script>
<script nonce="<?= csp_nonce() ?>">
document.getElementById('logout-link').addEventListener('click', function (e) {
  e.preventDefault();
  fetch('/api/auth/logout', { method: 'POST', credentials: 'same-origin' })
    .finally(function () { window.location.href = '/'; });
});
document.querySelectorAll('.js-auto-submit').forEach(function (el) {
  el.addEventListener('change', function () { el.form.submit(); });
});
</script>
</body>
</html>
