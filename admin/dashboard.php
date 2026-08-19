<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();

$pdo = enquiry_db();

$status = trim($_GET['status'] ?? '');
$search = trim($_GET['q'] ?? '');

$sql = 'SELECT * FROM enquiries WHERE 1=1';
$params = [];
if ($status !== '') {
    $sql .= ' AND status = :status';
    $params['status'] = $status;
}
if ($search !== '') {
    $sql .= ' AND (full_name LIKE :q OR email LIKE :q OR mobile LIKE :q OR enquiry_ref LIKE :q OR destination_country LIKE :q)';
    $params['q'] = '%' . $search . '%';
}
$sql .= ' ORDER BY created_at DESC LIMIT 200';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$enquiries = $stmt->fetchAll(PDO::FETCH_ASSOC);

$totalCount = (int) $pdo->query('SELECT COUNT(*) FROM enquiries')->fetchColumn();
$newCount = (int) $pdo->query("SELECT COUNT(*) FROM enquiries WHERE status = 'New'")->fetchColumn();

function admin_status_class(string $status): string
{
    return 'status-' . strtolower(str_replace(' ', '-', $status));
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex, nofollow">
<title>Enquiries &ndash; Admin</title>
<link rel="stylesheet" href="../assets/css/all.min.css">
<link rel="stylesheet" href="assets/admin.css">
</head>
<body>
<div class="admin-shell">
    <div class="admin-sidebar">
        <span class="brand">VISA AGENCY CRM</span>
        <a href="index.php"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
        <a href="dashboard.php" class="active"><i class="fa-solid fa-inbox"></i> Enquiries</a>
        <a href="logout.php">Log Out</a>
    </div>
    <div class="admin-main">
        <div class="admin-topbar">
            <h1>Enquiries <small style="color:#94A0BD;font-weight:400;">(<?php echo $totalCount; ?> total, <?php echo $newCount; ?> new)</small></h1>
            <span class="who">Signed in as <?php echo htmlspecialchars($_SESSION['admin_user']); ?></span>
        </div>

        <div class="admin-card">
            <form class="admin-filters" method="get">
                <input type="text" name="q" placeholder="Search name, email, mobile, ref..." value="<?php echo htmlspecialchars($search); ?>">
                <select name="status">
                    <option value="">All statuses</option>
                    <?php foreach (['New', 'Contacted', 'In Progress', 'Converted', 'Closed'] as $s): ?>
                    <option value="<?php echo $s; ?>" <?php echo $status === $s ? 'selected' : ''; ?>><?php echo $s; ?></option>
                    <?php endforeach; ?>
                </select>
                <button type="submit" class="admin-save-btn">Filter</button>
            </form>

            <?php if (empty($enquiries)): ?>
            <div class="admin-empty">No enquiries found.</div>
            <?php else: ?>
            <div style="overflow-x:auto;">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Ref</th>
                        <th>Name</th>
                        <th>Mobile</th>
                        <th>Destination</th>
                        <th>Service</th>
                        <th>Travel Date</th>
                        <th>Status</th>
                        <th>Submitted</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($enquiries as $row): ?>
                    <tr onclick="window.location='enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>'" style="cursor:pointer;">
                        <td><a href="enquiry.php?ref=<?php echo urlencode($row['enquiry_ref']); ?>"><?php echo htmlspecialchars($row['enquiry_ref']); ?></a></td>
                        <td><?php echo htmlspecialchars($row['full_name']); ?></td>
                        <td><?php echo htmlspecialchars($row['mobile']); ?></td>
                        <td><?php echo htmlspecialchars($row['destination_country']); ?></td>
                        <td><?php echo htmlspecialchars($row['service_required']); ?></td>
                        <td><?php echo htmlspecialchars($row['travel_date']); ?></td>
                        <td><span class="admin-status <?php echo admin_status_class($row['status']); ?>"><?php echo htmlspecialchars($row['status']); ?></span></td>
                        <td><?php echo htmlspecialchars(substr($row['created_at'], 0, 16)); ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            </div>
            <?php endif; ?>
        </div>
    </div>
</div>
</body>
</html>
