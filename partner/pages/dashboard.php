<?php
declare(strict_types=1);

$partner = current_partner();

if (!is_partner_active()) {
    render_partner_start('dashboard', 'Dashboard');
    ?>
    <div class="card" style="max-width:520px">
        <?php if ($partner['status'] === 'suspended'): ?>
        <p>Your partner account has been suspended. Contact Visagiri support if you believe this is a mistake.</p>
        <?php else: ?>
        <p><strong>Your registration is pending review.</strong> Our team verifies every new partner before activating referral tracking and commission data. This usually doesn't take long — check back soon.</p>
        <?php endif; ?>
    </div>
    <?php
    render_partner_end();
    exit;
}

$referredStmt = db()->prepare(
    "SELECT c.id, c.customer_reference_no, c.first_name, c.last_name, c.created_at,
            (SELECT COUNT(*) FROM visa_applications va WHERE va.customer_id = c.id AND va.deleted_at IS NULL) AS application_count
     FROM customers c WHERE c.referred_by_partner_id = :id ORDER BY c.created_at DESC"
);
$referredStmt->execute(['id' => $partner['id']]);
$referredCustomers = $referredStmt->fetchAll();

$commissionsStmt = db()->prepare(
    "SELECT pc.*, va.application_reference_no, c.first_name, c.last_name
     FROM partner_commissions pc
     JOIN visa_applications va ON va.id = pc.visa_application_id
     JOIN customers c ON c.id = va.customer_id
     WHERE pc.partner_id = :id ORDER BY pc.created_at DESC"
);
$commissionsStmt->execute(['id' => $partner['id']]);
$commissions = $commissionsStmt->fetchAll();

$totalPaid = 0.0;
$totalPending = 0.0;
foreach ($commissions as $c) {
    if ($c['amount_due'] === null) {
        continue;
    }
    if ($c['status'] === 'paid') {
        $totalPaid += (float) $c['amount_due'];
    } else {
        $totalPending += (float) $c['amount_due'];
    }
}

$referralLink = APP_URL . '/register/?ref=' . $partner['partner_reference_no'];

render_partner_start('dashboard', 'Welcome, ' . $partner['company_name']);
?>
<div class="card" style="margin-bottom:var(--space-6)">
    <div class="card-title">Your Referral Link</div>
    <p style="color:var(--text-muted)">Share this link — customers who register through it are automatically credited to your account.</p>
    <input class="form-input" type="text" readonly value="<?= e($referralLink) ?>" onclick="this.select()">
</div>

<div class="stats-grid" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:var(--space-4);margin-bottom:var(--space-6)">
    <div class="card"><div class="card-title" style="font-size:var(--font-size-2xl)"><?= count($referredCustomers) ?></div><p>Referred Customers</p></div>
    <div class="card"><div class="card-title" style="font-size:var(--font-size-2xl)">₹<?= number_format($totalPaid, 2) ?></div><p>Commission Paid</p></div>
    <div class="card"><div class="card-title" style="font-size:var(--font-size-2xl)">₹<?= number_format($totalPending, 2) ?></div><p>Commission Pending/Approved</p></div>
</div>

<h2 class="country-directory__subheading">Referred Customers</h2>
<?php if (!$referredCustomers): ?>
<p class="empty-state">No referrals yet. Share your referral link above to get started.</p>
<?php else: ?>
<div class="table-wrap" style="margin-bottom:var(--space-6)">
    <table class="admin-table">
        <thead><tr><th>Customer</th><th>Applications</th><th>Referred</th></tr></thead>
        <tbody>
        <?php foreach ($referredCustomers as $c): ?>
        <tr>
            <td><?= e($c['first_name'] . ' ' . ($c['last_name'] ?? '')) ?> (<?= e($c['customer_reference_no']) ?>)</td>
            <td><?= (int) $c['application_count'] ?></td>
            <td><?= e(date('d M Y', strtotime((string) $c['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>

<h2 class="country-directory__subheading">Commissions</h2>
<?php if (!$commissions): ?>
<p class="empty-state">No commissions recorded yet — these appear once a referred customer's application generates commission-eligible revenue and our team sets the amount.</p>
<?php else: ?>
<div class="table-wrap">
    <table class="admin-table">
        <thead><tr><th>Customer</th><th>Application</th><th>Amount</th><th>Status</th></tr></thead>
        <tbody>
        <?php foreach ($commissions as $c): ?>
        <tr>
            <td><?= e($c['first_name'] . ' ' . ($c['last_name'] ?? '')) ?></td>
            <td><?= e($c['application_reference_no']) ?></td>
            <td><?= $c['amount_due'] !== null ? e($c['currency'] . ' ' . number_format((float) $c['amount_due'], 2)) : 'Pending review' ?></td>
            <td><span class="badge <?= $c['status'] === 'paid' ? 'badge-success' : ($c['status'] === 'approved' ? 'badge-info' : 'badge-warning') ?>"><?= e($c['status']) ?></span></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>
<?php render_partner_end(); ?>
