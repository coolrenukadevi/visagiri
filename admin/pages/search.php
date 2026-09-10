<?php
declare(strict_types=1);

/**
 * Global cross-entity search — reuses the exact same LIKE '%term%'
 * pattern every per-page search box already uses (enquiries.php,
 * customers.php, partners.php, b2b-partners.php), not a new full-text
 * engine (none exists anywhere in this project). Each entity is only
 * searched if the logged-in admin already holds that entity's own
 * .view permission, so this can never surface a record a role couldn't
 * otherwise open directly — it's a shortcut into existing list/detail
 * pages, not a new access path. Results per entity are capped small
 * (8) since this renders on every keystroke-free page load, not a
 * paginated list.
 */

require_admin_login();

$q = trim((string) ($_GET['q'] ?? ''));
$pdo = db();

$results = [];

if (mb_strlen($q) >= 2) {
    $like = '%' . $q . '%';

    if (has_permission('enquiries.view')) {
        $stmt = $pdo->prepare(
            "SELECT id, enquiry_number AS ref, name AS title, email AS subtitle FROM enquiries
             WHERE deleted_at IS NULL AND (enquiry_number LIKE :q1 OR tracking_token LIKE :q2 OR name LIKE :q3 OR email LIKE :q4 OR mobile_number LIKE :q5)
             ORDER BY created_at DESC LIMIT 8"
        );
        $stmt->execute(['q1' => $like, 'q2' => $like, 'q3' => $like, 'q4' => $like, 'q5' => $like]);
        $results['Enquiries'] = ['rows' => $stmt->fetchAll(), 'link' => static fn(array $r) => '/admin/enquiries/?id=' . (int) $r['id'], 'view_all' => '/admin/enquiries/?q=' . urlencode($q)];
    }

    if (has_permission('customers.view')) {
        $stmt = $pdo->prepare(
            "SELECT id, customer_reference_no AS ref, CONCAT(first_name, ' ', last_name) AS title, email AS subtitle FROM customers
             WHERE deleted_at IS NULL AND (first_name LIKE :q1 OR last_name LIKE :q2 OR email LIKE :q3 OR mobile LIKE :q4 OR customer_reference_no LIKE :q5)
             ORDER BY created_at DESC LIMIT 8"
        );
        $stmt->execute(['q1' => $like, 'q2' => $like, 'q3' => $like, 'q4' => $like, 'q5' => $like]);
        $results['Customers'] = ['rows' => $stmt->fetchAll(), 'link' => static fn(array $r) => '/admin/customers/?action=view&id=' . (int) $r['id'], 'view_all' => '/admin/customers/?q=' . urlencode($q)];
    }

    if (has_permission('partners.view')) {
        $stmt = $pdo->prepare(
            "SELECT id, partner_reference_no AS ref, company_name AS title, email AS subtitle FROM partners
             WHERE deleted_at IS NULL AND (company_name LIKE :q1 OR contact_name LIKE :q2 OR email LIKE :q3 OR partner_reference_no LIKE :q4 OR mobile LIKE :q5)
             ORDER BY created_at DESC LIMIT 8"
        );
        $stmt->execute(['q1' => $like, 'q2' => $like, 'q3' => $like, 'q4' => $like, 'q5' => $like]);
        $results['Referral Partners'] = ['rows' => $stmt->fetchAll(), 'link' => static fn(array $r) => '/admin/partners/?action=view&id=' . (int) $r['id'], 'view_all' => '/admin/partners/?q=' . urlencode($q)];
    }

    if (has_permission('b2b_travel_partners.view')) {
        $stmt = $pdo->prepare(
            "SELECT id, partner_reference_no AS ref, legal_business_name AS title, business_email AS subtitle FROM b2b_partners
             WHERE deleted_at IS NULL AND (legal_business_name LIKE :q1 OR business_email LIKE :q2 OR partner_reference_no LIKE :q3 OR business_phone LIKE :q4)
             ORDER BY created_at DESC LIMIT 8"
        );
        $stmt->execute(['q1' => $like, 'q2' => $like, 'q3' => $like, 'q4' => $like]);
        $results['B2B Travel Partners'] = ['rows' => $stmt->fetchAll(), 'link' => static fn(array $r) => '/admin/b2b-partners/?action=view&id=' . (int) $r['id'], 'view_all' => '/admin/b2b-partners/?q=' . urlencode($q)];
    }
}

$totalResults = array_sum(array_map(static fn(array $r) => count($r['rows']), $results));

admin_header_start('Search', 'search');
?>
<form method="get" action="/admin/search/" class="admin-toolbar" style="margin-bottom:var(--space-5)">
    <input class="form-input" type="search" name="q" value="<?= e($q) ?>" placeholder="Search enquiries, customers, partners…" autofocus style="max-width:420px">
    <button type="submit" class="btn btn-outline btn-sm">Search</button>
</form>

<?php if ($q === ''): ?>
<p class="empty-state">Enter a name, email, mobile number, or reference number to search across enquiries, customers, and partners.</p>
<?php elseif (mb_strlen($q) < 2): ?>
<p class="empty-state">Enter at least 2 characters to search.</p>
<?php elseif ($totalResults === 0): ?>
<p class="empty-state">No results for "<?= e($q) ?>".</p>
<?php else: ?>
<?php foreach ($results as $label => $entity): ?>
<?php if (!$entity['rows']): continue; endif; ?>
<div class="admin-panel" style="margin-bottom:var(--space-5)">
    <h2 class="admin-panel__title"><?= e($label) ?></h2>
    <div class="admin-table-scroll">
    <table class="admin-table">
        <thead><tr><th>Reference</th><th>Name</th><th>Contact</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($entity['rows'] as $row): ?>
        <tr>
            <td><?= e($row['ref'] ?? '—') ?></td>
            <td><?= e($row['title'] ?? '—') ?></td>
            <td><?= e($row['subtitle'] ?? '—') ?></td>
            <td class="actions"><a href="<?= e($entity['link']($row)) ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php if (count($entity['rows']) === 8): ?>
    <p style="margin-top:var(--space-3)"><a href="<?= e($entity['view_all']) ?>">View all matches in <?= e($label) ?> &rarr;</a></p>
    <?php endif; ?>
</div>
<?php endforeach; ?>
<?php endif; ?>
<?php
admin_header_end();
