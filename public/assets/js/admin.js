/**
 * Topbar profile dropdown (name/avatar -> Profile/Settings/Logout).
 * Click-to-toggle, closes on an outside click or Escape — the same
 * interaction pattern as the public site's mega-menus, just simpler
 * (one panel, no hover-intent).
 */
document.addEventListener('DOMContentLoaded', function () {
    var trigger = document.getElementById('admin-profile-trigger');
    var menu = document.getElementById('admin-profile-menu');
    if (!trigger || !menu) return;

    function closeMenu() {
        menu.classList.remove('is-open');
        trigger.setAttribute('aria-expanded', 'false');
    }

    trigger.addEventListener('click', function (event) {
        event.stopPropagation();
        var isOpen = menu.classList.toggle('is-open');
        trigger.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });

    document.addEventListener('click', function (event) {
        if (!menu.contains(event.target) && event.target !== trigger) closeMenu();
    });

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') closeMenu();
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
