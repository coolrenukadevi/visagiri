/**
 * Admin sidebar collapsible group toggles (Forex/Content/System). The
 * server already renders the group containing the current page open
 * (see includes/admin-layout.php) — this only handles click-to-toggle
 * on top of that, so the sidebar still works with JS disabled, just
 * without collapsing.
 */
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.admin-sidebar__group').forEach(function (toggle) {
        toggle.addEventListener('click', function () {
            var panel = document.getElementById(toggle.getAttribute('aria-controls'));
            if (!panel) return;
            var isOpen = panel.classList.toggle('is-open');
            toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
        });
    });
});
