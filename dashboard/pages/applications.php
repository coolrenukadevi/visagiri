<?php
declare(strict_types=1);

$customer = current_customer();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

if ($id !== null) {
    $stmt = db()->prepare(
        "SELECT va.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name
         FROM visa_applications va
         JOIN countries c ON c.id = va.country_id
         JOIN visa_types vt ON vt.id = va.visa_type_id
         WHERE va.id = :id AND va.customer_id = :customer_id AND va.deleted_at IS NULL"
    );
    $stmt->execute(['id' => $id, 'customer_id' => $customer['id']]);
    $app = $stmt->fetch();

    if (!$app) {
        render_dashboard_start('applications', 'Application Not Found');
        echo '<p class="empty-state">We couldn\'t find that application, or it doesn\'t belong to your account.</p>';
        render_dashboard_end();
        exit;
    }

    $applicantsStmt = db()->prepare('SELECT * FROM visa_applicants WHERE visa_application_id = :id ORDER BY id ASC');
    $applicantsStmt->execute(['id' => $id]);
    $applicants = $applicantsStmt->fetchAll();

    $docsStmt = db()->prepare("SELECT * FROM documents WHERE visa_application_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC");
    $docsStmt->execute(['id' => $id]);
    $documents = $docsStmt->fetchAll();

    $quoteStmt = db()->prepare("SELECT * FROM visa_quotes WHERE visa_application_id = :id ORDER BY created_at DESC LIMIT 1");
    $quoteStmt->execute(['id' => $id]);
    $quote = $quoteStmt->fetch();

    render_dashboard_start('applications', $app['visa_type_name'] . ' — ' . $app['country_name']);
    ?>
    <p><a href="/dashboard/applications/">&larr; All Applications</a></p>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="application-card__top">
            <div>
                <span class="application-card__id"><?= e($app['application_reference_no']) ?></span>
                <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></div>
            </div>
            <span class="badge <?= application_status_badge_class($app['status']) ?>"><?= e(str_replace('_', ' ', $app['status'])) ?></span>
        </div>
        <?php if (!in_array($app['status'], ['rejected', 'cancelled'], true)): ?>
        <div class="application-card__meta" style="margin-top:var(--space-4)">
            <span>Applied: <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?></span>
            <?php if ($app['travel_date']): ?><span>Travel Date: <?= e(date('d M Y', strtotime((string) $app['travel_date']))) ?></span><?php endif; ?>
        </div>
        <div class="application-card__progress" style="margin-top:var(--space-3)"><div class="application-card__progress-bar" style="width:<?= application_progress_percent($app['status']) ?>%"></div></div>
        <?php endif; ?>
    </div>

    <?php if ($applicants): ?>
    <h2 class="country-directory__subheading">Applicants</h2>
    <ul style="margin-bottom:var(--space-6)">
        <?php foreach ($applicants as $a): ?>
        <li><?= e($a['full_name']) ?><?= $a['relationship_to_primary'] ? ' (' . e($a['relationship_to_primary']) . ')' : '' ?></li>
        <?php endforeach; ?>
    </ul>
    <?php endif; ?>

    <?php if ($quote && ($quote['government_fee'] !== null || $quote['service_fee'] !== null)): ?>
    <h2 class="country-directory__subheading">Quote</h2>
    <div class="card" style="margin-bottom:var(--space-6)">
        <?php if ($quote['government_fee'] !== null): ?><p>Government Fee: <?= e($quote['currency']) ?> <?= number_format((float) $quote['government_fee'], 2) ?></p><?php endif; ?>
        <?php if ($quote['service_fee'] !== null): ?><p>Service Fee: <?= e($quote['currency']) ?> <?= number_format((float) $quote['service_fee'], 2) ?></p><?php endif; ?>
        <?php if ($quote['notes']): ?><p><?= nl2br(e($quote['notes'])) ?></p><?php endif; ?>
    </div>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Documents (<?= count($documents) ?>)</h2>
    <?php if (!$documents): ?>
    <p class="empty-state">No documents uploaded yet.</p>
    <?php else: ?>
    <div class="table-wrap" style="margin-bottom:var(--space-4)">
        <table class="admin-table">
            <thead><tr><th>Document</th><th>Status</th><th>Uploaded</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($documents as $doc): ?>
            <tr>
                <td><?= e($doc['document_type'] ?? $doc['original_filename']) ?></td>
                <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($doc['verification_status']) ?></span></td>
                <td><?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?></td>
                <td><a href="/dashboard/document-download/?id=<?= (int) $doc['id'] ?>">Download</a></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <?php endif; ?>
    <a href="/dashboard/document-upload/?application_id=<?= (int) $app['id'] ?>" class="btn btn-outline">Upload a Document</a>

    <div style="margin-top:var(--space-6)">
        <a href="/dashboard/messages/?application_id=<?= (int) $app['id'] ?>" class="btn btn-primary">View Messages</a>
    </div>
    <?php
    render_dashboard_end();
    exit;
}

// List view.
$stmt = db()->prepare(
    "SELECT va.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM visa_applications va
     JOIN countries c ON c.id = va.country_id
     JOIN visa_types vt ON vt.id = va.visa_type_id
     WHERE va.customer_id = :id AND va.deleted_at IS NULL
     ORDER BY va.created_at DESC"
);
$stmt->execute(['id' => $customer['id']]);
$applications = $stmt->fetchAll();

render_dashboard_start('applications', 'My Applications');
?>
<?php if (!$applications): ?>
<p class="empty-state">You don't have any visa applications yet. <a href="/enquire/">Submit an enquiry</a> to get started.</p>
<?php else: ?>
<?php foreach ($applications as $app): ?>
<a href="/dashboard/applications/?id=<?= (int) $app['id'] ?>" class="card application-card">
    <div class="application-card__top">
        <div>
            <span class="application-card__id"><?= e($app['application_reference_no']) ?></span>
            <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></div>
        </div>
        <span class="badge <?= application_status_badge_class($app['status']) ?>"><?= e(str_replace('_', ' ', $app['status'])) ?></span>
    </div>
    <?php if (!in_array($app['status'], ['rejected', 'cancelled'], true)): ?>
    <div class="application-card__meta">
        <span>Applied: <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?></span>
        <span>Progress: <?= application_progress_percent($app['status']) ?>%</span>
    </div>
    <div class="application-card__progress"><div class="application-card__progress-bar" style="width:<?= application_progress_percent($app['status']) ?>%"></div></div>
    <?php endif; ?>
</a>
<?php endforeach; ?>
<?php endif; ?>
<?php render_dashboard_end(); ?>
