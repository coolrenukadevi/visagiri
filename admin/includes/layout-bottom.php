        </div>
    </div>
</div>

<div class="crm-confirm-backdrop" id="crmConfirmBackdrop" hidden>
    <div class="crm-confirm-box">
        <p id="crmConfirmMessage">Are you sure?</p>
        <div class="crm-confirm-actions">
            <button type="button" class="crm-btn crm-btn-ghost" id="crmConfirmCancel">Cancel</button>
            <button type="button" class="crm-btn crm-btn-danger" id="crmConfirmOk">Confirm</button>
        </div>
    </div>
</div>
<div class="crm-toast" id="crmToast" hidden></div>

<script>
(function () {
    var toggle = document.getElementById('crmSidebarToggle');
    var sidebar = document.getElementById('crmSidebar');
    if (toggle && sidebar) {
        toggle.addEventListener('click', function () { sidebar.classList.toggle('is-open'); });
    }

    // ---- Global search ----
    var searchInput = document.getElementById('crmGlobalSearch');
    var searchResults = document.getElementById('crmSearchResults');
    var searchTimer = null;
    if (searchInput) {
        searchInput.addEventListener('input', function () {
            clearTimeout(searchTimer);
            var q = searchInput.value.trim();
            if (q.length < 2) { searchResults.hidden = true; return; }
            searchTimer = setTimeout(function () {
                fetch('search.php?q=' + encodeURIComponent(q))
                    .then(function (r) { return r.json(); })
                    .then(function (data) {
                        if (!data.results || !data.results.length) {
                            searchResults.innerHTML = '<div class="crm-search-empty">No matches found.</div>';
                        } else {
                            searchResults.innerHTML = data.results.map(function (r) {
                                return '<a href="enquiry.php?ref=' + encodeURIComponent(r.ref) + '" class="crm-search-row">' +
                                    '<span class="ssr-name">' + r.name + '</span>' +
                                    '<span class="ssr-meta">' + r.ref + ' &middot; ' + r.destination + ' &middot; ' + r.mobile + '</span>' +
                                    '</a>';
                            }).join('');
                        }
                        searchResults.hidden = false;
                    });
            }, 250);
        });
        document.addEventListener('click', function (e) {
            if (!e.target.closest('.crm-global-search')) { searchResults.hidden = true; }
        });
    }

    // ---- Notifications ----
    var notifBtn = document.getElementById('crmNotifBtn');
    var notifPanel = document.getElementById('crmNotifPanel');
    if (notifBtn) {
        notifBtn.addEventListener('click', function () {
            if (!notifPanel.hidden) { notifPanel.hidden = true; return; }
            fetch('notifications.php?action=list')
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    if (!data.notifications || !data.notifications.length) {
                        notifPanel.innerHTML = '<div class="crm-notif-empty">No notifications yet.</div>';
                    } else {
                        notifPanel.innerHTML = data.notifications.map(function (n) {
                            var link = n.enquiry_ref ? 'enquiry.php?ref=' + encodeURIComponent(n.enquiry_ref) : '#';
                            return '<a href="' + link + '" class="crm-notif-row ' + (n.is_read ? '' : 'is-unread') + '">' +
                                '<span class="nr-msg">' + n.message + '</span>' +
                                '<span class="nr-time">' + n.time_ago + '</span></a>';
                        }).join('');
                    }
                    notifPanel.hidden = false;
                    fetch('notifications.php?action=mark_read', { method: 'POST' });
                    var badge = notifBtn.querySelector('.crm-badge');
                    if (badge) { badge.remove(); }
                });
        });
        document.addEventListener('click', function (e) {
            if (!e.target.closest('#crmNotifBtn') && !e.target.closest('#crmNotifPanel')) { notifPanel.hidden = true; }
        });
    }

    // ---- Confirm dialog (used by delete/archive actions across pages) ----
    window.crmConfirm = function (message, onConfirm) {
        var backdrop = document.getElementById('crmConfirmBackdrop');
        document.getElementById('crmConfirmMessage').textContent = message;
        backdrop.hidden = false;
        function cleanup() {
            backdrop.hidden = true;
            okBtn.removeEventListener('click', onOk);
            cancelBtn.removeEventListener('click', onCancel);
        }
        var okBtn = document.getElementById('crmConfirmOk');
        var cancelBtn = document.getElementById('crmConfirmCancel');
        function onOk() { cleanup(); onConfirm(); }
        function onCancel() { cleanup(); }
        okBtn.addEventListener('click', onOk);
        cancelBtn.addEventListener('click', onCancel);
    };

    window.crmToast = function (message, isError) {
        var toast = document.getElementById('crmToast');
        toast.textContent = message;
        toast.className = 'crm-toast is-visible' + (isError ? ' is-error' : '');
        toast.hidden = false;
        setTimeout(function () { toast.hidden = true; }, 3200);
    };

    document.querySelectorAll('[data-confirm]').forEach(function (el) {
        el.addEventListener('click', function (e) {
            e.preventDefault();
            var message = el.getAttribute('data-confirm');
            var href = el.getAttribute('href') || el.getAttribute('data-href');
            window.crmConfirm(message, function () {
                if (el.tagName === 'FORM' || el.closest('form')) {
                    (el.closest('form') || el).submit();
                } else if (href) {
                    window.location = href;
                }
            });
        });
    });
})();
</script>
</body>
</html>
