<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();

$pdo = enquiry_db();
$ref = trim($_GET['ref'] ?? '');

$stmt = $pdo->prepare('SELECT * FROM enquiries WHERE enquiry_ref = ?');
$stmt->execute([$ref]);
$enquiry = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$enquiry) {
    http_response_code(404);
    echo 'Enquiry not found.';
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'update_status') {
        $status = trim($_POST['status'] ?? 'New');
        $consultant = trim($_POST['assigned_consultant'] ?? '');
        $followUp = trim($_POST['follow_up_date'] ?? '');
        $upd = $pdo->prepare('UPDATE enquiries SET status = ?, assigned_consultant = ?, follow_up_date = ? WHERE id = ?');
        $upd->execute([$status, $consultant, $followUp ?: null, $enquiry['id']]);
    } elseif ($action === 'add_note' && trim($_POST['note'] ?? '') !== '') {
        $ins = $pdo->prepare('INSERT INTO enquiry_notes (enquiry_id, note, created_by, created_at) VALUES (?, ?, ?, ?)');
        $ins->execute([$enquiry['id'], trim($_POST['note']), $_SESSION['admin_user'], gmdate('c')]);
    }
    header('Location: enquiry.php?ref=' . urlencode($ref));
    exit;
}

$docStmt = $pdo->prepare('SELECT * FROM enquiry_documents WHERE enquiry_id = ? ORDER BY uploaded_at ASC');
$docStmt->execute([$enquiry['id']]);
$documents = $docStmt->fetchAll(PDO::FETCH_ASSOC);

$noteStmt = $pdo->prepare('SELECT * FROM enquiry_notes WHERE enquiry_id = ? ORDER BY created_at DESC');
$noteStmt->execute([$enquiry['id']]);
$notes = $noteStmt->fetchAll(PDO::FETCH_ASSOC);

function admin_status_class(string $status): string
{
    return 'status-' . strtolower(str_replace(' ', '-', $status));
}
function fmt(?string $v): string
{
    return $v !== null && $v !== '' ? htmlspecialchars($v) : '&mdash;';
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex, nofollow">
<title><?php echo htmlspecialchars($enquiry['enquiry_ref']); ?> &ndash; Admin</title>
<link rel="stylesheet" href="../assets/css/all.min.css">
<link rel="stylesheet" href="assets/admin.css">
</head>
<body>
<div class="admin-shell">
    <div class="admin-sidebar">
        <span class="brand">VISA AGENCY</span>
        <a href="dashboard.php"><i class="fa-solid fa-inbox"></i> Enquiries</a>
        <a href="logout.php">Log Out</a>
    </div>
    <div class="admin-main">
        <a href="dashboard.php" class="admin-back">&larr; Back to all enquiries</a>
        <div class="admin-topbar">
            <h1><?php echo htmlspecialchars($enquiry['enquiry_ref']); ?>
                <span class="admin-status <?php echo admin_status_class($enquiry['status']); ?>"><?php echo htmlspecialchars($enquiry['status']); ?></span>
            </h1>
            <span class="who">Submitted <?php echo htmlspecialchars(substr($enquiry['created_at'], 0, 16)); ?> UTC</span>
        </div>

        <div class="admin-card">
            <h3 style="margin-top:0;">Customer &amp; Travel Details</h3>
            <div class="admin-detail-grid">
                <div class="admin-detail-item"><label>Full Name</label><div class="val"><?php echo fmt($enquiry['full_name']); ?></div></div>
                <div class="admin-detail-item"><label>Email</label><div class="val"><?php echo fmt($enquiry['email']); ?></div></div>
                <div class="admin-detail-item"><label>Mobile</label><div class="val"><?php echo fmt($enquiry['mobile']); ?></div></div>
                <div class="admin-detail-item"><label>Preferred Contact Method</label><div class="val"><?php echo fmt($enquiry['contact_method']); ?></div></div>
                <div class="admin-detail-item"><label>Country of Residence</label><div class="val"><?php echo fmt($enquiry['country_residence']); ?></div></div>
                <div class="admin-detail-item"><label>Service Required</label><div class="val"><?php echo fmt($enquiry['service_required']); ?></div></div>
                <div class="admin-detail-item"><label>Destination Country</label><div class="val"><?php echo fmt($enquiry['destination_country']); ?></div></div>
                <div class="admin-detail-item"><label>Visa Type</label><div class="val"><?php echo fmt($enquiry['visa_type']); ?></div></div>
                <div class="admin-detail-item"><label>Expected Travel Date</label><div class="val"><?php echo fmt($enquiry['travel_date']); ?></div></div>
                <div class="admin-detail-item"><label>Number of Travellers</label><div class="val"><?php echo fmt((string) $enquiry['travellers']); ?></div></div>
                <div class="admin-detail-item"><label>Purpose of Travel</label><div class="val"><?php echo fmt($enquiry['purpose']); ?></div></div>
                <div class="admin-detail-item"><label>Source Page</label><div class="val"><?php echo fmt($enquiry['source_url']); ?></div></div>
            </div>
            <?php if (!empty($enquiry['message'])): ?>
            <div class="admin-detail-item" style="margin-top:14px;"><label>Additional Requirements / Message</label><div class="val"><?php echo nl2br(fmt($enquiry['message'])); ?></div></div>
            <?php endif; ?>
        </div>

        <div class="admin-card">
            <h3 style="margin-top:0;">Uploaded Documents</h3>
            <?php if (empty($documents)): ?>
            <p style="color:#94A0BD;font-size:13px;">No documents were attached to this enquiry.</p>
            <?php else: ?>
            <div class="admin-doc-list">
                <?php foreach ($documents as $doc): ?>
                <a href="document.php?id=<?php echo (int) $doc['id']; ?>">
                    <i class="fa-solid fa-file-arrow-down"></i>
                    <?php echo htmlspecialchars($doc['original_filename']); ?>
                    <span class="cat"><?php echo htmlspecialchars($doc['category']); ?> &middot; <?php echo round($doc['file_size'] / 1024); ?> KB</span>
                </a>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>

        <div class="admin-card">
            <h3 style="margin-top:0;">Status &amp; Assignment</h3>
            <form method="post">
                <input type="hidden" name="action" value="update_status">
                <div class="admin-form-row">
                    <select name="status">
                        <?php foreach (['New', 'Contacted', 'In Progress', 'Converted', 'Closed'] as $s): ?>
                        <option value="<?php echo $s; ?>" <?php echo $enquiry['status'] === $s ? 'selected' : ''; ?>><?php echo $s; ?></option>
                        <?php endforeach; ?>
                    </select>
                    <input type="text" name="assigned_consultant" placeholder="Assigned consultant" value="<?php echo htmlspecialchars($enquiry['assigned_consultant'] ?? ''); ?>">
                    <input type="date" name="follow_up_date" value="<?php echo htmlspecialchars($enquiry['follow_up_date'] ?? ''); ?>">
                    <button type="submit" class="admin-save-btn">Save</button>
                </div>
            </form>
        </div>

        <div class="admin-card">
            <h3 style="margin-top:0;">Notes &amp; Follow-up History</h3>
            <div class="admin-notes">
                <?php if (empty($notes)): ?>
                <p style="color:#94A0BD;font-size:13px;">No notes yet.</p>
                <?php endif; ?>
                <?php foreach ($notes as $note): ?>
                <div class="admin-note">
                    <div class="meta"><?php echo htmlspecialchars($note['created_by']); ?> &middot; <?php echo htmlspecialchars(substr($note['created_at'], 0, 16)); ?> UTC</div>
                    <?php echo nl2br(htmlspecialchars($note['note'])); ?>
                </div>
                <?php endforeach; ?>
            </div>
            <form method="post" class="admin-note-form">
                <input type="hidden" name="action" value="add_note">
                <textarea name="note" placeholder="Add a note about this enquiry..." required></textarea>
                <button type="submit" class="admin-save-btn">Add Note</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
