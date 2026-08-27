        </div>
    </div>
</div>
<script>
(function () {
    var toggle = document.getElementById('ppSidebarToggle');
    var sidebar = document.getElementById('ppSidebar');
    if (toggle && sidebar) {
        toggle.addEventListener('click', function () { sidebar.classList.toggle('is-open'); });
    }

    var notifBtn = document.getElementById('ppNotifBtn');
    var notifPanel = document.getElementById('ppNotifPanel');
    if (notifBtn) {
        notifBtn.addEventListener('click', function () {
            if (!notifPanel.hidden) { notifPanel.hidden = true; return; }
            fetch('b2b-notifications.php?action=list')
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    if (!data.notifications || !data.notifications.length) {
                        notifPanel.innerHTML = '<div class="pp-notif-empty">No notifications yet.</div>';
                    } else {
                        notifPanel.innerHTML = data.notifications.map(function (n) {
                            return '<div class="pp-notif-row ' + (n.is_read ? '' : 'is-unread') + '">' +
                                '<span class="nr-msg">' + n.message + '</span>' +
                                '<span class="nr-time">' + n.time_ago + '</span></div>';
                        }).join('');
                    }
                    notifPanel.hidden = false;
                    fetch('b2b-notifications.php?action=mark_read', { method: 'POST' });
                    var badge = notifBtn.querySelector('.pp-badge');
                    if (badge) { badge.remove(); }
                });
        });
        document.addEventListener('click', function (e) {
            if (!e.target.closest('#ppNotifBtn') && !e.target.closest('#ppNotifPanel')) { notifPanel.hidden = true; }
        });
    }
})();
</script>
</body>
</html>
