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

/**
 * Confirm-before-submit for destructive admin forms (delete, suspend,
 * restore, etc). Inline onsubmit="return confirm(...)" attributes are
 * inline scripts and get silently blocked by the site's own CSP
 * (script-src 'self') — same class of bug already solved once on the
 * public site (see public/assets/js/site.js), and several admin pages
 * already carry a data-confirm="message" attribute expecting this
 * exact delegated listener, so this brings admin.js in line with that
 * existing convention rather than inventing a new one.
 */
document.addEventListener('submit', function (event) {
    var form = event.target;
    if (form instanceof HTMLFormElement && form.dataset.confirm && !window.confirm(form.dataset.confirm)) {
        event.preventDefault();
    }
});
