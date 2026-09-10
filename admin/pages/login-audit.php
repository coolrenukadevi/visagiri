<?php
declare(strict_types=1);

/**
 * Login audit trail + active sessions. login_attempts (every attempt,
 * success and fail, with IP + user agent) and user_sessions (every
 * live session) already existed and were already being written to on
 * every login (includes/auth.php) — this page is the first place
 * either is actually surfaced to an admin.
 *
 * Location is resolved lazily and only on request (the "Resolve"
 * button per row), never eagerly for the whole page: a page load here
 * is always just an indexed DB query, never N outbound HTTP calls with
 * their own timeouts stacked on top of a single page render. See
 * includes/geolocation.php's own doc comment for why: this sandbox
 * (and possibly the client's shared host) may have no outbound network
 * access at all, and a login-audit page must stay fast and reliable
 * even when that's true.
 */

require_permission('audit.view');

$pdo = db();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'resolve_ip') {
        $ip = trim((string) ($_POST['ip'] ?? ''));
        if ($ip !== '') {
            resolve_ip_location($ip);
        }
        redirect('/admin/login-audit/' . (isset($_POST['redirect_qs']) ? '?' . $_POST['redirect_qs'] : ''));
    }

    if ($postAction === 'revoke_session') {
        require_permission('users.manage');
        $sessionId = (int) ($_POST['session_id'] ?? 0);
        if ($sessionId) {
            $pdo->prepare('UPDATE user_sessions SET expired_at = NOW() WHERE id = :id AND expired_at IS NULL')->execute(['id' => $sessionId]);
            log_action('revoke_session', 'user_sessions', $sessionId);
            flash_set('admin_notice', 'Session revoked.');
        }
        redirect('/admin/login-audit/');
    }
}

$usernameFilter = trim((string) ($_GET['username'] ?? ''));
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = [];
$params = [];
if ($usernameFilter !== '') {
    $where[] = 'la.username = :username';
    $params['username'] = $usernameFilter;
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM login_attempts la $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT la.*, g.country, g.region, g.city, g.lookup_status
     FROM login_attempts la
     LEFT JOIN ip_geolocation_cache g ON g.ip_address = la.ip_address
     $whereSql ORDER BY la.attempted_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$attempts = $stmt->fetchAll();

// First-seen (username, ip) pairs among successful logins, so a
// displayed row can be flagged "New IP" the one time it's genuinely
// the first successful login from that address — a single grouped
// query rather than one subquery per row.
$firstSeenStmt = $pdo->query(
    "SELECT username, ip_address, MIN(attempted_at) AS first_seen FROM login_attempts WHERE success = 1 AND ip_address IS NOT NULL GROUP BY username, ip_address"
);
$firstSeen = [];
foreach ($firstSeenStmt->fetchAll() as $row) {
    $firstSeen[$row['username'] . '|' . $row['ip_address']] = $row['first_seen'];
}

$usernames = $pdo->query('SELECT DISTINCT username FROM login_attempts ORDER BY username')->fetchAll(PDO::FETCH_COLUMN);

// last_activity_at is also bounded to the last 24h: PHP's own session
// garbage collection reclaims session data well before that, so a
// user_sessions row past that point is a stale DB record left behind
// by a browser tab closed without clicking Logout, not a genuinely
// live session — showing it as "Active" would be misleading.
$sessions = has_permission('users.manage')
    ? $pdo->query(
        "SELECT us.*, a.full_name, a.username FROM user_sessions us
         JOIN admin_users a ON a.id = us.admin_user_id
         WHERE us.expired_at IS NULL AND us.last_activity_at > NOW() - INTERVAL 24 HOUR
         ORDER BY us.last_activity_at DESC"
      )->fetchAll()
    : [];

$qs = $usernameFilter !== '' ? 'username=' . urlencode($usernameFilter) : '';

admin_header_start('Login Audit', 'login-audit');
admin_subnav('system', 'login-audit');
?>
<?php if ($sessions): ?>
<div class="admin-panel" style="margin-bottom:var(--space-5)">
    <h2 class="admin-panel__title">Active Sessions</h2>
    <div class="admin-table-scroll">
    <table class="admin-table">
        <thead><tr><th>User</th><th>IP Address</th><th>Signed In</th><th>Last Activity</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($sessions as $s): ?>
        <tr>
            <td><?= e($s['full_name']) ?> <span style="color:var(--text-muted)">(<?= e($s['username']) ?>)</span></td>
            <td><?= e($s['ip_address'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $s['created_at']))) ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $s['last_activity_at']))) ?></td>
            <td class="actions">
                <form method="post" action="/admin/login-audit/" data-confirm="Force-logout this session?">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="revoke_session">
                    <input type="hidden" name="session_id" value="<?= (int) $s['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Revoke</button>
                </form>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
</div>
<?php endif; ?>

<div class="admin-toolbar">
    <form method="get" action="/admin/login-audit/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <select class="form-select" name="username">
            <option value="">All users</option>
            <?php foreach ($usernames as $u): ?>
            <option value="<?= e($u) ?>"<?= $usernameFilter === $u ? ' selected' : '' ?>><?= e($u) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-outline">Filter</button>
    </form>
</div>
<div class="admin-table-scroll">
<table class="admin-table">
    <thead><tr><th>When</th><th>Username</th><th>Result</th><th>IP Address</th><th>Location</th><th>User Agent</th></tr></thead>
    <tbody>
    <?php foreach ($attempts as $a):
        $isNewIp = $a['success'] && $a['ip_address'] && ($firstSeen[$a['username'] . '|' . $a['ip_address']] ?? null) === $a['attempted_at'];
        $geo = ['status' => $a['lookup_status'] ?? null, 'country' => $a['country'], 'region' => $a['region'], 'city' => $a['city']];
    ?>
        <tr>
            <td><?= e(date('d M Y H:i:s', strtotime((string) $a['attempted_at']))) ?></td>
            <td><?= e($a['username']) ?><?php if ($isNewIp): ?> <span class="badge badge-warning">New IP</span><?php endif; ?></td>
            <td><?= $a['success'] ? '<span class="badge badge-success">Success</span>' : '<span class="badge badge-danger">Failed</span>' ?></td>
            <td><?= e($a['ip_address'] ?? '—') ?></td>
            <td>
                <?php if ($a['lookup_status'] !== null): ?>
                <?= e(format_ip_location($geo)) ?>
                <?php elseif ($a['ip_address']): ?>
                <form method="post" action="/admin/login-audit/" style="display:inline">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="resolve_ip">
                    <input type="hidden" name="ip" value="<?= e($a['ip_address']) ?>">
                    <input type="hidden" name="redirect_qs" value="<?= e($qs) ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Resolve</button>
                </form>
                <?php else: ?>—<?php endif; ?>
            </td>
            <td><?= e(substr((string) ($a['user_agent'] ?? '—'), 0, 60)) ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$attempts): ?>
        <tr><td colspan="6"><p class="empty-state">No login attempts recorded yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
</div>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/login-audit/?page=<?= $p ?><?= $usernameFilter !== '' ? '&username=' . urlencode($usernameFilter) : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
