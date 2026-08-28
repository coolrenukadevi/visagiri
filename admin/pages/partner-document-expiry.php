<?php
declare(strict_types=1);

/**
 * Ops view of every partner document with an expiry date on file
 * (partner_documents.expiry_date, present since Phase 2 but never
 * surfaced anywhere until now) — expired first, then soonest-to-expire,
 * so staff can chase renewals (IATA certificates, licenses) before
 * they lapse. No email/cron reminders — this is the "in-app panel"
 * scope from the roadmap, not an automated notification system.
 */

require_permission('partners.view');

$pdo = db();

$documents = $pdo->query(
    "SELECT d.*, p.id AS partner_id, p.company_name, p.partner_reference_no
     FROM partner_documents d
     JOIN partners p ON p.id = d.partner_id
     WHERE d.expiry_date IS NOT NULL AND d.deleted_at IS NULL AND p.deleted_at IS NULL
     ORDER BY d.expiry_date ASC"
)->fetchAll();

admin_header_start('Document Expiry', 'partner-document-expiry');
?>
<p style="color:var(--text-muted);margin-bottom:var(--space-4)">Partner documents with an expiry date on file, soonest first. Documents without an expiry date (most uploads) don't appear here.</p>
<?php if (!$documents): ?>
<p class="empty-state">No partner documents have an expiry date recorded yet.</p>
<?php else: ?>
<table class="admin-table">
    <thead><tr><th>Partner</th><th>Document</th><th>Expiry Date</th><th>Status</th></tr></thead>
    <tbody>
    <?php foreach ($documents as $d):
        $daysLeft = (int) floor((strtotime((string) $d['expiry_date']) - strtotime(date('Y-m-d'))) / 86400);
        if ($daysLeft < 0) {
            $badgeClass = 'badge-danger';
            $statusText = 'Expired ' . abs($daysLeft) . ' day' . (abs($daysLeft) === 1 ? '' : 's') . ' ago';
        } elseif ($daysLeft <= 30) {
            $badgeClass = 'badge-warning';
            $statusText = 'Expires in ' . $daysLeft . ' day' . ($daysLeft === 1 ? '' : 's');
        } else {
            $badgeClass = 'badge-success';
            $statusText = 'Expires in ' . $daysLeft . ' days';
        }
    ?>
        <tr>
            <td><a href="/admin/partners/?action=view&id=<?= (int) $d['partner_id'] ?>"><?= e($d['company_name']) ?></a> (<?= e($d['partner_reference_no']) ?>)</td>
            <td><?= e(PARTNER_DOCUMENT_TYPES[$d['document_type']] ?? $d['document_type']) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $d['expiry_date']))) ?></td>
            <td><span class="badge <?= $badgeClass ?>"><?= e($statusText) ?></span></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php endif; ?>
<?php
admin_header_end();
