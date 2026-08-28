    </div>
  </div>
</div>

<script src="<?= asset('js/main.js') ?>" defer></script>
<script>
document.getElementById('logout-link').addEventListener('click', function (e) {
  e.preventDefault();
  fetch('/api/auth/logout', { method: 'POST', credentials: 'same-origin' })
    .finally(function () { window.location.href = '/'; });
});
</script>
</body>
</html>
