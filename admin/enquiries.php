<?php
$ADMIN_PAGE_TITLE = 'Enquiries';
$ADMIN_ACTIVE_NAV = isset($_GET['mine']) ? 'my-enquiries' : 'enquiries';
$ADMIN_BREADCRUMB = ['CRM', 'Enquiries'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/countries-data.php';

$status = trim($_GET['status'] ?? '');
$visaCategory = trim($_GET['visa_category'] ?? '');
$country = trim($_GET['country'] ?? '');
$assignedTo = trim($_GET['assigned_to'] ?? '');
$priority = trim($_GET['priority'] ?? '');
$source = trim($_GET['source'] ?? '');
$dateRange = trim($_GET['date_range'] ?? '');
$dateFrom = trim($_GET['date_from'] ?? '');
$dateTo = trim($_GET['date_to'] ?? '');
$search = trim($_GET['q'] ?? '');
$mine = isset($_GET['mine']);

$where = ['e.archived_at IS NULL'];
$params = [];

if (!admin_can_view_all() || $mine) {
    $where[] = 'e.assigned_to = :me';
    $params['me'] = admin_name();
}
if ($status !== '') { $where[] = 'e.status = :status'; $params['status'] = $status; }
if ($visaCategory !== '') { $where[] = 'e.visa_category = :visa_category'; $params['visa_category'] = $visaCategory; }
if ($country !== '') { $where[] = 'e.destination_country = :country'; $params['country'] = $country; }
if ($assignedTo !== '') { $where[] = 'e.assigned_to = :assigned_to'; $params['assigned_to'] = $assignedTo; }
if ($priority !== '') { $where[] = 'e.priority = :priority'; $params['priority'] = $priority; }
if ($source !== '') { $where[] = 'e.source = :source'; $params['source'] = $source; }
if ($search !== '') {
    $where[] = '(e.full_name LIKE :q OR e.email LIKE :q OR e.mobile LIKE :q OR e.enquiry_ref LIKE :q OR e.passport_number LIKE :q)';
    $params['q'] = '%' . $search . '%';
}

$today = gmdate('Y-m-d');
if ($dateRange === 'today') {
    $where[] = "date(e.created_at) = date(:today)"; $params['today'] = $today;
} elseif ($dateRange === 'yesterday') {
    $where[] = "date(e.created_at) = date(:yday)"; $params['yday'] = gmdate('Y-m-d', strtotime('-1 day'));
} elseif ($dateRange === 'this_week') {
    $where[] = "date(e.created_at) >= date(:weekstart)"; $params['weekstart'] = gmdate('Y-m-d', strtotime('monday this week'));
} elseif ($dateRange === 'this_month') {
    $where[] = "date(e.created_at) >= date(:monthstart)"; $params['monthstart'] = gmdate('Y-m-01');
} elseif ($dateRange === 'custom' && $dateFrom !== '' && $dateTo !== '') {
    $where[] = "date(e.created_at) BETWEEN date(:dfrom) AND date(:dto)";
    $params['dfrom'] = $dateFrom;
    $params['dto'] = $dateTo;
}

$whereSql = implode(' AND ', $where);

$sql = "SELECT e.*,
        (SELECT COUNT(*) FROM enquiry_documents d WHERE d.enquiry_id = e.id) AS doc_total,
        (SELECT COUNT(*) FROM enquiry_documents d WHERE d.enquiry_id = e.id AND d.status = 'Verified') AS doc_verified,
        (SELECT MAX(f.follow_up_date) FROM follow_ups f WHERE f.enquiry_id = e.id) AS last_follow_up
    FROM enquiries e WHERE $whereSql ORDER BY e.created_at DESC LIMIT 300";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$enquiries = $stmt->fetchAll(PDO::FETCH_ASSOC);

$pipelineCounts = [];
$pipelineWhere = admin_can_view_all() && !$mine ? 'archived_at IS NULL' : 'archived_at IS NULL AND assigned_to = :me2';
$pipelineParams = admin_can_view_all() && !$mine ? [] : ['me2' => admin_name()];
foreach (CRM_STATUSES as $s) {
    if ($s === 'Lost') continue; // shown separately, not part of the linear pipeline
    $stmt2 = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE $pipelineWhere AND status = :s2");
    $stmt2->execute(array_merge($pipelineParams, ['s2' => $s]));
    $pipelineCounts[$s] = (int) $stmt2->fetchColumn();
}

$assignableUsers = $pdo->query("SELECT DISTINCT name, role FROM users ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);

function crm_time_ago_admin(string $iso): string
{
    $diff = time() - strtotime($iso);
    if ($diff < 60) return 'just now';
    if ($diff < 3600) return floor($diff / 60) . 'm ago';
    if ($diff < 86400) return floor($diff / 3600) . 'h ago';
    return floor($diff / 86400) . 'd ago';
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Visa Enquiries</h1>
        <p class="crm-page-subtitle">Manage, assign and track all visa service enquiries from one place.</p>
    </div>
    <div class="crm-page-actions">
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenNewEnquiry"><i class="fa-solid fa-plus"></i> New Enquiry</button>
        <a href="export.php?<?php echo htmlspecialchars($_SERVER['QUERY_STRING'] ?? ''); ?>" class="crm-btn crm-btn-ghost"><i class="fa-solid fa-file-export"></i> Export</a>
    </div>
</div>

<div class="crm-pipeline">
    <?php foreach ($pipelineCounts as $s => $c): ?>
    <a href="enquiries.php?<?php echo $mine ? 'mine=1&' : ''; ?>status=<?php echo urlencode($s); ?>" class="crm-pipeline-stage <?php echo $status === $s ? 'active' : ''; ?>">
        <span class="pipeline-count"><?php echo $c; ?></span>
        <span class="pipeline-label"><?php echo htmlspecialchars($s); ?></span>
    </a>
    <?php endforeach; ?>
</div>

<form class="crm-card" method="get" id="crmFilterForm">
    <?php if ($mine): ?><input type="hidden" name="mine" value="1"><?php endif; ?>
    <div class="crm-filter-bar">
        <input type="text" name="q" placeholder="Search name, email, mobile, ref, passport..." value="<?php echo htmlspecialchars($search); ?>" style="min-width:220px;">
        <select name="status">
            <option value="">All Statuses</option>
            <?php foreach (CRM_STATUSES as $s): ?>
            <option value="<?php echo $s; ?>" <?php echo $status === $s ? 'selected' : ''; ?>><?php echo $s; ?></option>
            <?php endforeach; ?>
        </select>
        <select name="visa_category">
            <option value="">All Visa Categories</option>
            <?php foreach (CRM_VISA_CATEGORIES as $c): ?>
            <option value="<?php echo $c; ?>" <?php echo $visaCategory === $c ? 'selected' : ''; ?>><?php echo $c; ?></option>
            <?php endforeach; ?>
        </select>
        <input type="text" name="country" list="crmCountryList" placeholder="Country" value="<?php echo htmlspecialchars($country); ?>" style="width:150px;">
        <datalist id="crmCountryList">
            <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?><option value="<?php echo htmlspecialchars($c['name']); ?>"><?php endforeach; ?>
        </datalist>
        <select name="assigned_to">
            <option value="">Assigned To (Anyone)</option>
            <?php foreach ($assignableUsers as $u): ?>
            <option value="<?php echo htmlspecialchars($u['name']); ?>" <?php echo $assignedTo === $u['name'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($u['name']); ?> (<?php echo htmlspecialchars($u['role']); ?>)</option>
            <?php endforeach; ?>
        </select>
        <select name="priority">
            <option value="">All Priorities</option>
            <?php foreach (CRM_PRIORITIES as $p): ?>
            <option value="<?php echo $p; ?>" <?php echo $priority === $p ? 'selected' : ''; ?>><?php echo $p; ?></option>
            <?php endforeach; ?>
        </select>
        <select name="source">
            <option value="">All Sources</option>
            <?php foreach (CRM_SOURCES as $s): ?>
            <option value="<?php echo $s; ?>" <?php echo $source === $s ? 'selected' : ''; ?>><?php echo $s; ?></option>
            <?php endforeach; ?>
        </select>
        <select name="date_range" id="crmDateRange">
            <option value="">Any Date</option>
            <option value="today" <?php echo $dateRange === 'today' ? 'selected' : ''; ?>>Today</option>
            <option value="yesterday" <?php echo $dateRange === 'yesterday' ? 'selected' : ''; ?>>Yesterday</option>
            <option value="this_week" <?php echo $dateRange === 'this_week' ? 'selected' : ''; ?>>This Week</option>
            <option value="this_month" <?php echo $dateRange === 'this_month' ? 'selected' : ''; ?>>This Month</option>
            <option value="custom" <?php echo $dateRange === 'custom' ? 'selected' : ''; ?>>Custom Range</option>
        </select>
        <span id="crmCustomDateWrap" style="display:<?php echo $dateRange === 'custom' ? 'inline-flex' : 'none'; ?>;gap:6px;">
            <input type="date" name="date_from" value="<?php echo htmlspecialchars($dateFrom); ?>">
            <input type="date" name="date_to" value="<?php echo htmlspecialchars($dateTo); ?>">
        </span>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Apply Filters</button>
        <a href="enquiries.php<?php echo $mine ? '?mine=1' : ''; ?>" class="crm-btn crm-btn-ghost crm-btn-sm">Reset</a>
    </div>
</form>

<div class="crm-bulk-bar" id="crmBulkBar">
    <span id="crmBulkCount">0 selected</span>
    <select id="crmBulkStatus"><option value="">Change Status...</option><?php foreach (CRM_STATUSES as $s): ?><option value="<?php echo $s; ?>"><?php echo $s; ?></option><?php endforeach; ?></select>
    <select id="crmBulkPriority"><option value="">Change Priority...</option><?php foreach (CRM_PRIORITIES as $p): ?><option value="<?php echo $p; ?>"><?php echo $p; ?></option><?php endforeach; ?></select>
    <select id="crmBulkAssign"><option value="">Assign To...</option><?php foreach ($assignableUsers as $u): ?><option value="<?php echo htmlspecialchars($u['name']); ?>"><?php echo htmlspecialchars($u['name']); ?></option><?php endforeach; ?></select>
    <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" id="crmBulkArchive"><i class="fa-solid fa-box-archive"></i> Archive</button>
</div>

<div class="crm-card" style="padding:0;">
    <?php if (empty($enquiries)): ?>
    <div class="crm-empty">No enquiries match these filters.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead>
            <tr>
                <th><input type="checkbox" id="crmSelectAll"></th>
                <th>Enquiry ID</th>
                <th>Customer</th>
                <th>Contact</th>
                <th>Country</th>
                <th>Visa Type</th>
                <th>Travel Date</th>
                <th>Status</th>
                <th>Priority</th>
                <th>Assigned To</th>
                <th>Last Follow-up</th>
                <th>Documents</th>
                <th>Created</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($enquiries as $row): ?>
            <tr>
                <td><input type="checkbox" class="crm-row-check" value="<?php echo (int) $row['id']; ?>"></td>
                <td><a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>"><?php echo htmlspecialchars($row['enquiry_ref']); ?></a></td>
                <td class="crm-cell-name"><?php echo htmlspecialchars($row['full_name']); ?></td>
                <td><?php echo htmlspecialchars($row['mobile']); ?></td>
                <td><?php echo htmlspecialchars($row['destination_country']); ?></td>
                <td><?php echo htmlspecialchars($row['visa_type']); ?></td>
                <td><?php echo htmlspecialchars($row['travel_date']); ?></td>
                <td><span class="crm-status-badge <?php echo crm_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span></td>
                <td><span class="crm-priority-badge priority-<?php echo strtolower($row['priority']); ?>"><?php echo htmlspecialchars($row['priority']); ?></span></td>
                <td><?php echo $row['assigned_to'] ? htmlspecialchars($row['assigned_to']) : '<span class="crm-cell-sub">Unassigned</span>'; ?></td>
                <td><?php echo $row['last_follow_up'] ? htmlspecialchars($row['last_follow_up']) : '<span class="crm-cell-sub">&mdash;</span>'; ?></td>
                <td><?php echo (int) $row['doc_verified']; ?>/<?php echo (int) $row['doc_total']; ?></td>
                <td class="crm-cell-sub"><?php echo crm_time_ago_admin($row['created_at']); ?></td>
                <td>
                    <div class="crm-action-menu-wrap">
                        <button type="button" class="crm-action-menu-btn" data-menu-toggle><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        <div class="crm-action-menu" hidden>
                            <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>"><i class="fa-solid fa-eye"></i> View</a>
                            <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>#followup"><i class="fa-solid fa-phone-volume"></i> Follow-up</a>
                            <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>#documents"><i class="fa-solid fa-folder-open"></i> Documents</a>
                            <a href="tel:<?php echo htmlspecialchars($row['mobile']); ?>"><i class="fa-solid fa-phone"></i> Call</a>
                            <a href="https://wa.me/<?php echo preg_replace('/\D/', '', $row['mobile']); ?>" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
                            <a href="mailto:<?php echo htmlspecialchars($row['email']); ?>"><i class="fa-solid fa-envelope"></i> Email</a>
                            <hr>
                            <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>&archive=1" data-confirm="Archive this enquiry?" class="danger"><i class="fa-solid fa-box-archive"></i> Archive</a>
                        </div>
                    </div>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <div style="padding:16px;">
    <?php foreach ($enquiries as $row): ?>
    <div class="crm-row-card">
        <div class="rc-top">
            <div><div class="rc-name"><?php echo htmlspecialchars($row['full_name']); ?></div><div class="rc-ref"><?php echo htmlspecialchars($row['enquiry_ref']); ?></div></div>
            <span class="crm-status-badge <?php echo crm_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span>
        </div>
        <div class="rc-meta"><?php echo htmlspecialchars($row['destination_country']); ?> &middot; <?php echo htmlspecialchars($row['visa_type']); ?> &middot; <?php echo htmlspecialchars($row['travel_date']); ?></div>
        <div class="rc-actions">
            <a href="tel:<?php echo htmlspecialchars($row['mobile']); ?>"><i class="fa-solid fa-phone"></i></a>
            <a href="https://wa.me/<?php echo preg_replace('/\D/', '', $row['mobile']); ?>"><i class="fa-brands fa-whatsapp"></i></a>
            <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>#followup"><i class="fa-solid fa-phone-volume"></i></a>
            <a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>#documents"><i class="fa-solid fa-folder-open"></i></a>
        </div>
    </div>
    <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/enquiry-drawer.php'; ?>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var dateRange = document.getElementById('crmDateRange');
    var customWrap = document.getElementById('crmCustomDateWrap');
    if (dateRange) {
        dateRange.addEventListener('change', function () {
            customWrap.style.display = dateRange.value === 'custom' ? 'inline-flex' : 'none';
        });
    }

    document.querySelectorAll('[data-menu-toggle]').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            var menu = btn.nextElementSibling;
            document.querySelectorAll('.crm-action-menu').forEach(function (m) { if (m !== menu) m.hidden = true; });
            menu.hidden = !menu.hidden;
        });
    });
    document.addEventListener('click', function () {
        document.querySelectorAll('.crm-action-menu').forEach(function (m) { m.hidden = true; });
    });

    var selectAll = document.getElementById('crmSelectAll');
    var checks = document.querySelectorAll('.crm-row-check');
    var bulkBar = document.getElementById('crmBulkBar');
    var bulkCount = document.getElementById('crmBulkCount');
    function updateBulk() {
        var selected = Array.prototype.filter.call(checks, function (c) { return c.checked; });
        bulkBar.classList.toggle('is-visible', selected.length > 0);
        bulkCount.textContent = selected.length + ' selected';
    }
    if (selectAll) {
        selectAll.addEventListener('change', function () {
            checks.forEach(function (c) { c.checked = selectAll.checked; });
            updateBulk();
        });
    }
    checks.forEach(function (c) { c.addEventListener('change', updateBulk); });

    function selectedIds() {
        return Array.prototype.filter.call(checks, function (c) { return c.checked; }).map(function (c) { return c.value; });
    }
    function bulkPost(action, value) {
        var ids = selectedIds();
        if (!ids.length) return;
        fetch('bulk.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action: action, value: value, ids: ids })
        }).then(function (r) { return r.json(); }).then(function (data) {
            if (data.success) { window.crmToast(data.message || 'Updated.'); setTimeout(function () { window.location.reload(); }, 700); }
            else { window.crmToast(data.message || 'Failed.', true); }
        });
    }
    document.getElementById('crmBulkStatus').addEventListener('change', function () { if (this.value) bulkPost('status', this.value); });
    document.getElementById('crmBulkPriority').addEventListener('change', function () { if (this.value) bulkPost('priority', this.value); });
    document.getElementById('crmBulkAssign').addEventListener('change', function () { if (this.value) bulkPost('assign', this.value); });
    document.getElementById('crmBulkArchive').addEventListener('click', function () {
        window.crmConfirm('Archive ' + selectedIds().length + ' selected enquiries?', function () { bulkPost('archive', ''); });
    });

    var openBtn = document.getElementById('crmOpenNewEnquiry');
    if (openBtn) { openBtn.addEventListener('click', function () { window.crmOpenEnquiryDrawer(); }); }
    <?php if (isset($_GET['new'])): ?>
    window.addEventListener('load', function () { window.crmOpenEnquiryDrawer(); });
    <?php endif; ?>
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
