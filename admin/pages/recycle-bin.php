<?php
declare(strict_types=1);

/**
 * Superadmin-only Recycle Bin: lists every soft-deleted record across
 * the CRM (any table with a deleted_at column) and restores one at a
 * time, step-up verified by a one-time code emailed to a fixed
 * operational address (RECYCLE_BIN_OTP_RECIPIENT) rather than the
 * acting admin's own inbox — so restoring a record can't be
 * self-approved from inside a single compromised admin session alone.
 *
 * Table names are never taken from user input — every query below
 * reaches into $registry by a literal PHP array key, and the request
 * is only accepted if it matches one of those literal keys, so there
 * is no path from $_GET/$_POST to a table name in SQL.
 */

require_permission('recycle_bin.manage');
if ((current_admin()['role_slug'] ?? null) !== 'super-admin') {
    http_response_code(403);
    exit('The Recycle Bin can only be used by a Super Admin.');
}

const RECYCLE_BIN_OTP_RECIPIENT = 'info@tripgation.com';
const RECYCLE_BIN_OTP_TTL_MINUTES = 10;
const RECYCLE_BIN_OTP_MAX_ATTEMPTS = 5;

/**
 * table_name => [label, reference/display column expression, whether
 * a deleted_by column exists to clear on restore]. Every entry here
 * is a real table with a real deleted_at column (see AUDIT.md /
 * schema*.sql) — nothing here is guessed.
 */
$registry = [
    'customers' => ['label' => 'Customers', 'display' => "CONCAT(customer_reference_no, ' — ', first_name, ' ', COALESCE(last_name, ''))", 'has_deleted_by' => true],
    'visa_applications' => ['label' => 'Visa Applications', 'display' => 'application_reference_no', 'has_deleted_by' => true],
    'general_enquiries' => ['label' => 'General & Attestation Enquiries', 'display' => "CONCAT(enquiry_reference_no, ' — ', name)", 'has_deleted_by' => true],
    'documents' => ['label' => 'Documents', 'display' => 'original_filename', 'has_deleted_by' => false],
    'partners' => ['label' => 'B2B Partners', 'display' => "CONCAT(partner_reference_no, ' — ', company_name)", 'has_deleted_by' => false],
    'partner_documents' => ['label' => 'Partner Documents', 'display' => 'original_filename', 'has_deleted_by' => false],
    'partner_enquiries' => ['label' => 'Partner Enquiries', 'display' => "CONCAT(reference_number, ' — ', company_name)", 'has_deleted_by' => true],
    'forex_requests' => ['label' => 'Forex Requests', 'display' => 'forex_reference_no', 'has_deleted_by' => true],
    'forex_documents' => ['label' => 'Forex Documents', 'display' => 'original_filename', 'has_deleted_by' => false],
    'hr_applications' => ['label' => 'HR Job Applications', 'display' => 'application_reference_no', 'has_deleted_by' => true],
    'hr_documents' => ['label' => 'HR Documents', 'display' => 'original_filename', 'has_deleted_by' => false],
    'grievances' => ['label' => 'Grievances', 'display' => "CONCAT(grievance_reference_no, ' — ', name)", 'has_deleted_by' => true],
    'enquiries' => ['label' => 'Enquiries (Visa + Apostille)', 'display' => "CONCAT(enquiry_number, ' — ', name)", 'has_deleted_by' => true],
];

$pdo = db();

function recycle_bin_generate_code(): string
{
    return (string) random_int(100000, 999999);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $table = (string) ($_POST['table'] ?? '');
    $recordId = (int) ($_POST['record_id'] ?? 0);

    if (!array_key_exists($table, $registry) || !$recordId) {
        flash_set('admin_error', 'Invalid restore request.');
        redirect('/admin/recycle-bin/');
    }

    if ($postAction === 'request_otp') {
        // Confirm the record still exists and is still soft-deleted before issuing a code for it.
        $check = $pdo->prepare("SELECT id FROM `$table` WHERE id = :id AND deleted_at IS NOT NULL");
        $check->execute(['id' => $recordId]);
        if (!$check->fetch()) {
            flash_set('admin_error', 'That record is no longer in the Recycle Bin.');
            redirect('/admin/recycle-bin/');
        }

        // Invalidate any earlier unconsumed code for this exact record so only the newest one is live.
        $pdo->prepare(
            'UPDATE recycle_bin_otps SET consumed_at = NOW() WHERE admin_user_id = :admin AND table_name = :table AND record_id = :id AND consumed_at IS NULL'
        )->execute(['admin' => current_admin_id(), 'table' => $table, 'id' => $recordId]);

        $code = recycle_bin_generate_code();
        $pdo->prepare(
            'INSERT INTO recycle_bin_otps (admin_user_id, code_hash, table_name, record_id, expires_at)
             VALUES (:admin, :hash, :table, :id, DATE_ADD(NOW(), INTERVAL :ttl MINUTE))'
        )->execute([
            'admin' => current_admin_id(),
            'hash' => hash('sha256', $code),
            'table' => $table,
            'id' => $recordId,
            'ttl' => RECYCLE_BIN_OTP_TTL_MINUTES,
        ]);
        $otpId = (int) $pdo->lastInsertId();

        $admin = current_admin();
        $label = $registry[$table]['label'];
        send_mail(
            RECYCLE_BIN_OTP_RECIPIENT,
            'Visagiri Recycle Bin — Restore Code',
            '<p>' . e($admin['full_name'] ?? $admin['username']) . ' requested to restore a deleted record.</p>'
                . '<p><strong>Module:</strong> ' . e($label) . '<br><strong>Record ID:</strong> ' . $recordId . '</p>'
                . '<p><strong>One-time code:</strong> ' . e($code) . ' (valid ' . RECYCLE_BIN_OTP_TTL_MINUTES . ' minutes)</p>'
                . '<p>If this restore was not expected, ignore this email — the code expires on its own and nothing is changed unless it is entered.</p>',
            'Visagiri Admin'
        );
        log_action('recycle_bin_otp_requested', $table, $recordId);

        flash_set('admin_notice', 'A restore code was emailed to ' . RECYCLE_BIN_OTP_RECIPIENT . '. Enter it below to complete the restore.');
        redirect('/admin/recycle-bin/?table=' . urlencode($table) . '&otp_id=' . $otpId . '&record_id=' . $recordId);
    }

    if ($postAction === 'confirm_restore') {
        $otpId = (int) ($_POST['otp_id'] ?? 0);
        $code = trim((string) ($_POST['code'] ?? ''));

        // The expiry check is done entirely in SQL (NOW() > expires_at)
        // rather than via PHP's strtotime()/time() — this app runs with
        // date_default_timezone_set('Asia/Kolkata') (see includes/
        // config.php), so strtotime() on a MySQL-generated UTC-wall-clock
        // string would misinterpret it as IST and read every code as
        // already expired. Same reasoning as rate_limit_check()'s own
        // SQL-side window comparison in includes/security.php.
        $otpStmt = $pdo->prepare(
            'SELECT *, (NOW() > expires_at) AS is_expired FROM recycle_bin_otps
             WHERE id = :id AND admin_user_id = :admin AND table_name = :table AND record_id = :record_id'
        );
        $otpStmt->execute(['id' => $otpId, 'admin' => current_admin_id(), 'table' => $table, 'record_id' => $recordId]);
        $otp = $otpStmt->fetch();

        $fail = static function (string $message) use ($table, $recordId, $otpId): void {
            flash_set('admin_error', $message);
            redirect('/admin/recycle-bin/?table=' . urlencode($table) . '&otp_id=' . $otpId . '&record_id=' . $recordId);
        };

        if (!$otp) {
            flash_set('admin_error', 'Restore request not found. Please request a new code.');
            redirect('/admin/recycle-bin/');
        }
        if ($otp['consumed_at'] !== null) {
            $fail('This code has already been used or superseded. Please request a new one.');
        }
        if ((bool) $otp['is_expired']) {
            $fail('This code has expired. Please request a new one.');
        }
        if ((int) $otp['attempts'] >= RECYCLE_BIN_OTP_MAX_ATTEMPTS) {
            $fail('Too many incorrect attempts. Please request a new code.');
        }
        if (!hash_equals($otp['code_hash'], hash('sha256', $code))) {
            $pdo->prepare('UPDATE recycle_bin_otps SET attempts = attempts + 1 WHERE id = :id')->execute(['id' => $otpId]);
            $fail('Incorrect code.');
        }

        $hasDeletedBy = $registry[$table]['has_deleted_by'];
        $sql = $hasDeletedBy
            ? "UPDATE `$table` SET deleted_at = NULL, deleted_by = NULL WHERE id = :id"
            : "UPDATE `$table` SET deleted_at = NULL WHERE id = :id";
        $pdo->prepare($sql)->execute(['id' => $recordId]);

        $pdo->prepare('UPDATE recycle_bin_otps SET consumed_at = NOW() WHERE id = :id')->execute(['id' => $otpId]);
        log_action('restore', $table, $recordId);

        flash_set('admin_notice', 'Record restored from the Recycle Bin.');
        redirect('/admin/recycle-bin/?table=' . urlencode($table));
    }
}

$activeTable = array_key_exists($_GET['table'] ?? '', $registry) ? $_GET['table'] : null;
$pendingOtpId = isset($_GET['otp_id']) ? (int) $_GET['otp_id'] : 0;
$pendingRecordId = isset($_GET['record_id']) ? (int) $_GET['record_id'] : 0;

// Counts across every table for the overview cards, always computed
// (cheap — indexed on deleted_at everywhere it's used for lookups).
$counts = [];
foreach ($registry as $table => $meta) {
    $counts[$table] = (int) $pdo->query("SELECT COUNT(*) FROM `$table` WHERE deleted_at IS NOT NULL")->fetchColumn();
}

admin_header_start('Recycle Bin', 'recycle-bin');
?>
<p style="color:var(--color-text-muted);max-width:60ch">Every restore requires a one-time code emailed to <strong><?= e(RECYCLE_BIN_OTP_RECIPIENT) ?></strong> — not your own inbox — so a single admin session can't silently undo a deletion on its own.</p>

<div class="admin-card-grid" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:var(--space-4);margin:var(--space-5) 0">
    <?php foreach ($registry as $table => $meta): ?>
    <a href="/admin/recycle-bin/?table=<?= e($table) ?>" class="card" style="text-decoration:none;color:inherit;<?= $activeTable === $table ? 'border-color:var(--color-primary)' : '' ?>">
        <strong><?= e($meta['label']) ?></strong>
        <p style="margin:var(--space-2) 0 0;font-size:1.5rem"><?= $counts[$table] ?></p>
        <p style="margin:0;color:var(--color-text-muted);font-size:0.85rem">deleted record<?= $counts[$table] === 1 ? '' : 's' ?></p>
    </a>
    <?php endforeach; ?>
</div>

<?php if ($activeTable): ?>
<h2><?= e($registry[$activeTable]['label']) ?></h2>
<?php
$listStmt = $pdo->prepare(
    "SELECT id, {$registry[$activeTable]['display']} AS display_label, deleted_at FROM `$activeTable` WHERE deleted_at IS NOT NULL ORDER BY deleted_at DESC LIMIT 200"
);
$listStmt->execute();
$rows = $listStmt->fetchAll();
?>
<?php if ($rows): ?>
<table class="admin-table">
    <thead><tr><th>Record</th><th>Deleted At</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($rows as $row): ?>
    <tr>
        <td><?= e((string) $row['display_label']) ?> <span style="color:var(--color-text-muted)">(#<?= (int) $row['id'] ?>)</span></td>
        <td><?= e(date('d M Y H:i', strtotime((string) $row['deleted_at']))) ?></td>
        <td class="actions">
            <?php if ($pendingOtpId && $pendingRecordId === (int) $row['id']): ?>
            <form method="post" action="/admin/recycle-bin/?table=<?= e($activeTable) ?>" style="display:flex;gap:var(--space-2);align-items:center">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="confirm_restore">
                <input type="hidden" name="table" value="<?= e($activeTable) ?>">
                <input type="hidden" name="record_id" value="<?= (int) $row['id'] ?>">
                <input type="hidden" name="otp_id" value="<?= $pendingOtpId ?>">
                <input class="form-input" type="text" name="code" placeholder="6-digit code" maxlength="6" pattern="[0-9]{6}" required style="width:120px">
                <button type="submit" class="btn btn-primary btn-sm">Confirm Restore</button>
            </form>
            <?php else: ?>
            <form method="post" action="/admin/recycle-bin/?table=<?= e($activeTable) ?>">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="request_otp">
                <input type="hidden" name="table" value="<?= e($activeTable) ?>">
                <input type="hidden" name="record_id" value="<?= (int) $row['id'] ?>">
                <button type="submit" class="btn btn-outline btn-sm">Restore…</button>
            </form>
            <?php endif; ?>
        </td>
    </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">Nothing deleted here.</p>
<?php endif; ?>
<?php endif; ?>
<?php
admin_header_end();
