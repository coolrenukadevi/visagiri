/**
 * Topbar dropdowns (notification bell, profile menu). Click-to-toggle,
 * closes on an outside click or Escape — the same interaction pattern
 * as the public site's mega-menus, just simpler (one panel, no
 * hover-intent). Each dropdown gets its own trigger/menu pair but
 * shares this one setup function rather than duplicating the listener
 * logic per dropdown.
 */
function setupAdminDropdown(triggerId, menuId) {
    var trigger = document.getElementById(triggerId);
    var menu = document.getElementById(menuId);
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
}

document.addEventListener('DOMContentLoaded', function () {
    setupAdminDropdown('admin-profile-trigger', 'admin-profile-menu');
    setupAdminDropdown('admin-bell-trigger', 'admin-bell-menu');
});

/**
 * Polls the unread notification count every 45s so a new enquiry's
 * bell badge appears without a manual page refresh — plain polling,
 * not WebSocket/SSE, since this app has no persistent-connection
 * infrastructure anywhere else and one small periodic GET is the
 * proportionate amount of complexity for "the bell number stays
 * current." Never touches the dropdown's already-rendered list itself
 * (that's server-rendered on page load) — only the badge number/visibility.
 */
document.addEventListener('DOMContentLoaded', function () {
    var badge = document.getElementById('admin-bell-badge');
    if (!badge) return;

    function refreshUnreadCount() {
        fetch('/admin/notifications-unread-count/', { credentials: 'same-origin' })
            .then(function (res) { return res.ok ? res.json() : null; })
            .then(function (data) {
                if (!data) return;
                if (data.count > 0) {
                    badge.hidden = false;
                    badge.textContent = data.count > 99 ? '99+' : String(data.count);
                } else {
                    badge.hidden = true;
                }
            })
            .catch(function () { /* silent — the badge just keeps its last known value */ });
    }

    setInterval(refreshUnreadCount, 45000);
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
