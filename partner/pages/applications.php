<?php
declare(strict_types=1);

/**
 * List + detail view of visa applications belonging to this partner's
 * referred customers — scoped entirely through customers.
 * referred_by_partner_id, same as every other partner-scoped query in
 * this codebase. No new tables; the status timeline reuses the same
 * visa_application_history table the admin CRM already writes to.
 */

$partner = current_partner();
$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

$visaStatusBadgeMap = [
    'draft' => 'neutral',
    'documents_pending' => 'warning',
    'submitted' => 'info',
    'under_review' => 'info',
    'approved' => 'success',
    'completed' => 'success',
    'rejected' => 'danger',
    'cancelled' => 'danger',
];

if ($id !== null) {
    $stmt = $pdo->prepare(
        "SELECT va.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name,
                cust.customer_reference_no, cust.first_name, cust.last_name
         FROM visa_applications va
         JOIN countries c ON c.id = va.country_id
         JOIN visa_types vt ON vt.id = va.visa_type_id
         JOIN customers cust ON cust.id = va.customer_id
         WHERE va.id = :id AND va.deleted_at IS NULL AND cust.referred_by_partner_id = :partner_id"
    );
    $stmt->execute(['id' => $id, 'partner_id' => $partner['id']]);
    $app = $stmt->fetch();

    if (!$app) {
        render_partner_start('applications', 'Application Not Found');
        echo '<p class="empty-state">We couldn\'t find that application, or it isn\'t linked to one of your referrals.</p>';
        render_partner_end();
        exit;
    }

    $historyStmt = $pdo->prepare(
        'SELECT h.*, a.full_name AS changed_by_name FROM visa_application_history h
         LEFT JOIN admin_users a ON a.id = h.changed_by
         WHERE h.visa_application_id = :id ORDER BY h.changed_at DESC'
    );
    $historyStmt->execute(['id' => $id]);
    $history = $historyStmt->fetchAll();

    $documentsStmt = $pdo->prepare("SELECT * FROM documents WHERE visa_application_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC");
    $documentsStmt->execute(['id' => $id]);
    $documents = $documentsStmt->fetchAll();

    $quotesStmt = $pdo->prepare("SELECT * FROM visa_quotes WHERE visa_application_id = :id AND status != 'draft' ORDER BY created_at DESC");
    $quotesStmt->execute(['id' => $id]);
    $quotes = $quotesStmt->fetchAll();

    render_partner_start('applications', $app['visa_type_name'] . ' — ' . $app['country_name']);
    ?>
    <p><a href="/partner/applications/">&larr; All Applications</a></p>
    <div class="admin-form-card" style="max-width:720px;margin-bottom:var(--space-6)">
        <p><strong>Reference:</strong> <?= e($app['application_reference_no']) ?></p>
        <p><strong>Customer:</strong> <?= e($app['first_name'] . ' ' . ($app['last_name'] ?? '')) ?> (<?= e($app['customer_reference_no']) ?>)</p>
        <p><strong>Destination:</strong> <?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></p>
        <p><strong>Status:</strong> <?= status_badge((string) $app['status'], $visaStatusBadgeMap) ?></p>
        <p><strong>Submitted:</strong> <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?><?php if ($app['travel_date']): ?> &middot; <strong>Travel Date:</strong> <?= e(date('d M Y', strtotime((string) $app['travel_date']))) ?><?php endif; ?></p>
        <?php if ($app['notes']): ?><p><strong>Notes:</strong> <?= nl2br(e($app['notes'])) ?></p><?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Documents (<?= count($documents) ?>)</h2>
    <?php if (!$documents): ?>
    <p class="empty-state">No documents uploaded yet.</p>
    <?php else: ?>
    <table class="admin-table" style="margin-bottom:var(--space-6)"><thead><tr><th>Document</th><th>Status</th><th>Uploaded</th></tr></thead><tbody>
        <?php foreach ($documents as $doc): ?>
        <tr>
            <td><?= e($doc['document_type'] ?? $doc['original_filename']) ?></td>
            <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($doc['verification_status']) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Quotes (<?= count($quotes) ?>)</h2>
    <?php if (!$quotes): ?>
    <p class="empty-state">No quotes issued yet.</p>
    <?php else: ?>
    <table class="admin-table" style="margin-bottom:var(--space-6)"><thead><tr><th>Reference</th><th>Government Fee</th><th>Service Fee</th><th>Status</th></tr></thead><tbody>
        <?php foreach ($quotes as $q): ?>
        <tr>
            <td><?= e($q['quote_reference_no']) ?></td>
            <td><?= $q['government_fee'] !== null ? e($q['currency'] . ' ' . number_format((float) $q['government_fee'], 2)) : '—' ?></td>
            <td><?= $q['service_fee'] !== null ? e($q['currency'] . ' ' . number_format((float) $q['service_fee'], 2)) : '—' ?></td>
            <td><span class="badge <?= $q['status'] === 'accepted' ? 'badge-success' : ($q['status'] === 'rejected' ? 'badge-danger' : 'badge-info') ?>"><?= e($q['status']) ?></span></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Case Timeline</h2>
    <?php if (!$history): ?>
    <p class="empty-state">No status updates yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>From</th><th>To</th><th>When</th></tr></thead><tbody>
        <?php foreach ($history as $h): ?>
        <tr>
            <td><?= e($h['old_status'] !== null ? ucfirst(str_replace('_', ' ', (string) $h['old_status'])) : '—') ?></td>
            <td><?= e(ucfirst(str_replace('_', ' ', (string) $h['new_status']))) ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $h['changed_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php
    render_partner_end();
    exit;
}

// --- List ---
$stmt = $pdo->prepare(
    "SELECT va.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name,
            cust.first_name, cust.last_name
     FROM visa_applications va
     JOIN countries c ON c.id = va.country_id
     JOIN visa_types vt ON vt.id = va.visa_type_id
     JOIN customers cust ON cust.id = va.customer_id
     WHERE va.deleted_at IS NULL AND cust.referred_by_partner_id = :partner_id
     ORDER BY va.created_at DESC"
);
$stmt->execute(['partner_id' => $partner['id']]);
$applications = $stmt->fetchAll();

render_partner_start('applications', 'My Applications');
?>
<p style="margin-bottom:var(--space-5)"><a href="/partner/application-create/" class="btn btn-primary">+ New Application</a></p>
<?php if (!$applications): ?>
<p class="empty-state">No applications yet. Click "New Application" above to submit one on behalf of a referred customer.</p>
<?php else: ?>
<div class="table-wrap">
    <table class="admin-table">
        <thead><tr><th>Reference</th><th>Customer</th><th>Destination</th><th>Status</th><th>Submitted</th></tr></thead>
        <tbody>
        <?php foreach ($applications as $app): ?>
        <tr>
            <td><a href="/partner/applications/?id=<?= (int) $app['id'] ?>"><?= e($app['application_reference_no']) ?></a></td>
            <td><?= e($app['first_name'] . ' ' . ($app['last_name'] ?? '')) ?></td>
            <td><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></td>
            <td><?= status_badge((string) $app['status'], $visaStatusBadgeMap) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $app['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>
<?php render_partner_end(); ?>
