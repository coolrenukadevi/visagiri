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

/**
 * Sidebar nav-group collapse/expand, persisted per-browser in
 * localStorage so a manager's preferred layout survives page loads —
 * matches the CMS blueprint's "remembered expansion state" rule.
 * Falls back to "all expanded" (the server-rendered default) if
 * localStorage is unavailable (private browsing, blocked storage).
 */
(function () {
    var STORAGE_KEY = 'visagiri_admin_nav_collapsed';

    function readCollapsedSet() {
        try {
            var raw = window.localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : {};
        } catch (e) {
            return {};
        }
    }

    function writeCollapsedSet(set) {
        try {
            window.localStorage.setItem(STORAGE_KEY, JSON.stringify(set));
        } catch (e) { /* storage unavailable — collapse state just won't persist */ }
    }

    function applyCollapsed(groupEl, collapsed) {
        groupEl.classList.toggle('is-collapsed', collapsed);
        var toggle = groupEl.querySelector('[data-nav-group-toggle]');
        if (toggle) toggle.setAttribute('aria-expanded', collapsed ? 'false' : 'true');
    }

    document.addEventListener('DOMContentLoaded', function () {
        var collapsedSet = readCollapsedSet();
        document.querySelectorAll('.admin-nav-group').forEach(function (groupEl) {
            var key = groupEl.dataset.groupKey;
            if (key && collapsedSet[key]) applyCollapsed(groupEl, true);
        });
    });

    document.addEventListener('click', function (event) {
        var toggle = event.target.closest('[data-nav-group-toggle]');
        if (!toggle) return;
        var groupEl = toggle.closest('.admin-nav-group');
        if (!groupEl) return;
        var key = groupEl.dataset.groupKey;
        var nowCollapsed = !groupEl.classList.contains('is-collapsed');
        applyCollapsed(groupEl, nowCollapsed);
        var set = readCollapsedSet();
        if (nowCollapsed) { set[key] = true; } else { delete set[key]; }
        writeCollapsedSet(set);
    });

    document.addEventListener('click', function (event) {
        if (event.target.id !== 'admin-sidebar-collapse-all') return;
        var allCollapsed = true;
        var set = {};
        document.querySelectorAll('.admin-nav-group').forEach(function (groupEl) {
            applyCollapsed(groupEl, allCollapsed);
            if (groupEl.dataset.groupKey) set[groupEl.dataset.groupKey] = true;
        });
        writeCollapsedSet(set);
        event.target.textContent = 'Expand all groups';
        event.target.id = 'admin-sidebar-expand-all';
    });
    document.addEventListener('click', function (event) {
        if (event.target.id !== 'admin-sidebar-expand-all') return;
        document.querySelectorAll('.admin-nav-group').forEach(function (groupEl) { applyCollapsed(groupEl, false); });
        writeCollapsedSet({});
        event.target.textContent = 'Collapse all groups';
        event.target.id = 'admin-sidebar-collapse-all';
    });
})();

/**
 * Dashboard Scan/Dig layer collapse — responsive default + persisted
 * manual override. The Super Admin needs Scan (analytics) and Dig
 * (recent enquiries/tasks) expanded by default on desktop for an
 * immediate operational overview; on tablet Dig folds first, on
 * mobile both start folded, since neither fits usefully at that
 * width without scrolling past it first. Once a person manually
 * expands/collapses a layer, that choice is remembered (localStorage)
 * and wins over the viewport default on every later visit — this is
 * a size-appropriate default, not a fixed rule.
 */
(function () {
    var STORAGE_KEY = 'visagiri_dashboard_layers';

    function readOverrides() {
        try {
            var raw = window.localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : {};
        } catch (e) {
            return {};
        }
    }

    function writeOverrides(overrides) {
        try {
            window.localStorage.setItem(STORAGE_KEY, JSON.stringify(overrides));
        } catch (e) { /* storage unavailable — choice just won't persist */ }
    }

    function defaultCollapsed(layerKey) {
        var width = window.innerWidth;
        if (width < 768) return true; // mobile — both start folded
        if (width < 1024) return layerKey === 'dig-tasks'; // tablet — Scan open, Dig folded
        return false; // desktop — both open
    }

    function applyLayer(layer, collapsed) {
        layer.classList.toggle('is-collapsed', collapsed);
        var toggle = layer.querySelector('[data-layer-toggle]');
        if (toggle && toggle.lastChild) toggle.lastChild.textContent = collapsed ? ' Expand' : ' Collapse';
    }

    function applyDefaults() {
        var overrides = readOverrides();
        document.querySelectorAll('.admin-layer[data-layer]').forEach(function (layer) {
            var key = layer.dataset.layer;
            var collapsed = Object.prototype.hasOwnProperty.call(overrides, key) ? overrides[key] : defaultCollapsed(key);
            applyLayer(layer, collapsed);
        });
    }

    document.addEventListener('DOMContentLoaded', applyDefaults);

    var resizeTimer = null;
    window.addEventListener('resize', function () {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function () {
            var overrides = readOverrides();
            document.querySelectorAll('.admin-layer[data-layer]').forEach(function (layer) {
                var key = layer.dataset.layer;
                if (Object.prototype.hasOwnProperty.call(overrides, key)) return; // manual choice wins, never overridden by resize
                applyLayer(layer, defaultCollapsed(key));
            });
        }, 150);
    });

    document.addEventListener('click', function (event) {
        var toggle = event.target.closest('[data-layer-toggle]');
        if (!toggle) return;
        var layer = toggle.closest('.admin-layer[data-layer]');
        if (!layer) return;
        var key = layer.dataset.layer;
        var collapsed = !layer.classList.contains('is-collapsed');
        applyLayer(layer, collapsed);
        var overrides = readOverrides();
        overrides[key] = collapsed;
        writeOverrides(overrides);
    });
})();

/** Mobile hamburger — toggles the sidebar drawer via a body class (see admin-dashboard.css). */
document.addEventListener('DOMContentLoaded', function () {
    var toggle = document.getElementById('admin-mobile-nav-toggle');
    if (!toggle) return;
    toggle.addEventListener('click', function () {
        var isOpen = document.body.classList.toggle('admin-mobile-nav-open');
        toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    });
    document.addEventListener('click', function (event) {
        if (!document.body.classList.contains('admin-mobile-nav-open')) return;
        var sidebar = document.getElementById('admin-sidebar');
        if (sidebar && !sidebar.contains(event.target) && event.target !== toggle && !toggle.contains(event.target)) {
            document.body.classList.remove('admin-mobile-nav-open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    });
});

/**
 * Global search command palette (Ctrl/Cmd+K) — opens a modal that
 * submits to the same real /admin/search/ page every visible "Search"
 * box already posts to (permission-scoped server-side there), so this
 * is a faster way to reach that one real search, not a second search
 * implementation.
 */
document.addEventListener('DOMContentLoaded', function () {
    var backdrop = document.getElementById('admin-cmdk-backdrop');
    var input = document.getElementById('admin-cmdk-input');
    var trigger = document.getElementById('admin-cmdk-trigger');
    if (!backdrop || !input) return;

    function openCmdk() {
        backdrop.classList.add('is-open');
        input.value = '';
        input.focus();
    }
    function closeCmdk() {
        backdrop.classList.remove('is-open');
    }

    if (trigger) trigger.addEventListener('click', openCmdk);

    document.addEventListener('keydown', function (event) {
        var isCmdK = (event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'k';
        if (isCmdK) {
            event.preventDefault();
            backdrop.classList.contains('is-open') ? closeCmdk() : openCmdk();
        } else if (event.key === 'Escape' && backdrop.classList.contains('is-open')) {
            closeCmdk();
        }
    });

    backdrop.addEventListener('click', function (event) {
        if (event.target === backdrop) closeCmdk();
    });
});

/**
 * Focus Mode — hides KPIs/charts/analytics/team-performance, keeping
 * only the SLA banner, Top Priorities, Tasks and Unassigned Cases (see
 * body.focus-mode rules in admin-dashboard.css). Session-only
 * (sessionStorage), matches "dismiss for the session" language used
 * for the SLA banner rather than a permanent per-user setting.
 */
document.addEventListener('DOMContentLoaded', function () {
    var btn = document.getElementById('admin-focus-toggle');
    if (!btn) return;
    var active = false;
    try { active = window.sessionStorage.getItem('visagiri_focus_mode') === '1'; } catch (e) {}
    if (active) {
        document.body.classList.add('focus-mode');
        btn.classList.add('is-active');
        btn.textContent = 'Exit Focus Mode';
    }
    btn.addEventListener('click', function () {
        var isActive = document.body.classList.toggle('focus-mode');
        btn.classList.toggle('is-active', isActive);
        btn.textContent = isActive ? 'Exit Focus Mode' : 'Focus Mode';
        try { window.sessionStorage.setItem('visagiri_focus_mode', isActive ? '1' : '0'); } catch (e) {}
    });
});

/**
 * SLA banner session dismissal — hides the banner for this tab/session
 * only; never marks the underlying breaches resolved (that still
 * requires actually clearing the SLA on each case).
 */
document.addEventListener('DOMContentLoaded', function () {
    var banner = document.getElementById('admin-sla-banner');
    var dismissBtn = document.getElementById('admin-sla-banner-dismiss');
    if (!banner || !dismissBtn) return;
    try {
        if (window.sessionStorage.getItem('visagiri_sla_banner_dismissed') === banner.dataset.signature) {
            banner.hidden = true;
        }
    } catch (e) {}
    dismissBtn.addEventListener('click', function () {
        banner.hidden = true;
        try { window.sessionStorage.setItem('visagiri_sla_banner_dismissed', banner.dataset.signature || '1'); } catch (e) {}
    });
});

/**
 * Customize Dashboard — real show/hide + reorder, persisted per
 * browser via localStorage (data-widget-id marks each movable panel).
 * Reorder uses native HTML5 drag-and-drop (no library, matches this
 * project's zero-dependency stance). "Restore defaults" clears the
 * saved layout so the server-rendered order/visibility shows again.
 */
(function () {
    var STORAGE_KEY = 'visagiri_dashboard_layout';

    function readLayout() {
        try {
            var raw = window.localStorage.getItem(STORAGE_KEY);
            return raw ? JSON.parse(raw) : null;
        } catch (e) { return null; }
    }
    function writeLayout(layout) {
        try { window.localStorage.setItem(STORAGE_KEY, JSON.stringify(layout)); } catch (e) {}
    }

    function applyLayout() {
        var layout = readLayout();
        if (!layout) return;
        var container = document.getElementById('admin-dashboard-widgets');
        if (!container) return;
        var widgets = {};
        container.querySelectorAll('[data-widget-id]').forEach(function (w) { widgets[w.dataset.widgetId] = w; });
        (layout.order || []).forEach(function (id) {
            if (widgets[id]) container.appendChild(widgets[id]);
        });
        (layout.hidden || []).forEach(function (id) {
            if (widgets[id]) widgets[id].setAttribute('data-hidden', 'true');
        });
    }

    document.addEventListener('DOMContentLoaded', applyLayout);

    document.addEventListener('click', function (event) {
        if (event.target.id !== 'admin-customize-toggle') return;
        document.body.classList.toggle('customize-mode');
        var isOn = document.body.classList.contains('customize-mode');
        event.target.textContent = isOn ? 'Done Customizing' : 'Customize';
        event.target.classList.toggle('btn-primary', isOn);
    });

    document.addEventListener('click', function (event) {
        var hideBtn = event.target.closest('[data-widget-hide]');
        if (hideBtn) {
            var widget = hideBtn.closest('[data-widget-id]');
            if (!widget) return;
            widget.setAttribute('data-hidden', 'true');
            var layout = readLayout() || { order: [], hidden: [] };
            layout.hidden = layout.hidden || [];
            if (layout.hidden.indexOf(widget.dataset.widgetId) === -1) layout.hidden.push(widget.dataset.widgetId);
            writeLayout(layout);
            return;
        }
        var showBtn = event.target.closest('[data-widget-show]');
        if (showBtn) {
            var widget2 = showBtn.closest('[data-widget-id]');
            if (!widget2) return;
            widget2.removeAttribute('data-hidden');
            var layout2 = readLayout() || { order: [], hidden: [] };
            layout2.hidden = (layout2.hidden || []).filter(function (id) { return id !== widget2.dataset.widgetId; });
            writeLayout(layout2);
            return;
        }
        if (event.target.id === 'admin-customize-restore') {
            try { window.localStorage.removeItem(STORAGE_KEY); } catch (e) {}
            window.location.reload();
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        var container = document.getElementById('admin-dashboard-widgets');
        if (!container) return;
        var dragged = null;
        container.querySelectorAll('[data-widget-id]').forEach(function (widget) {
            widget.setAttribute('draggable', 'false');
        });
        container.addEventListener('dragstart', function (event) {
            var widget = event.target.closest('[data-widget-id]');
            if (!widget || !document.body.classList.contains('customize-mode')) return;
            dragged = widget;
            event.dataTransfer.effectAllowed = 'move';
        });
        container.addEventListener('dragover', function (event) {
            if (!dragged || !document.body.classList.contains('customize-mode')) return;
            event.preventDefault();
            var target = event.target.closest('[data-widget-id]');
            if (!target || target === dragged) return;
            var rect = target.getBoundingClientRect();
            var after = (event.clientY - rect.top) / rect.height > 0.5;
            container.insertBefore(dragged, after ? target.nextSibling : target);
        });
        container.addEventListener('dragend', function () {
            if (!dragged) return;
            dragged = null;
            var order = Array.prototype.map.call(container.querySelectorAll('[data-widget-id]'), function (w) { return w.dataset.widgetId; });
            var layout = readLayout() || {};
            layout.order = order;
            writeLayout(layout);
        });
        // Enable drag only on the handle to avoid hijacking clicks/links inside widgets.
        container.addEventListener('mousedown', function (event) {
            var handle = event.target.closest('[data-widget-drag-handle]');
            if (!handle) return;
            var widget = handle.closest('[data-widget-id]');
            if (widget) widget.setAttribute('draggable', 'true');
        });
        container.addEventListener('mouseup', function () {
            container.querySelectorAll('[data-widget-id]').forEach(function (w) { w.setAttribute('draggable', 'false'); });
        });
    });
})();
