<?php
/**
 * Admin-only AJAX endpoint: looks up the applicable pricing rule for a
 * partner + service category, to prefill the quotation builder's fee
 * fields. Partner-specific rules win over the partner's tier-level
 * default. Staff-only (admin_require_login()) — this is the one place
 * base_price (internal cost) is allowed to be returned, since it's never
 * rendered on any partner-facing page.
 */
header('Content-Type: application/json');
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/b2b-db.php';
admin_require_login();

$pdo = b2b_db();
$partnerId = (int) ($_GET['partner_id'] ?? 0);
$serviceCategory = trim($_GET['service_category'] ?? '');

if (!$partnerId || !in_array($serviceCategory, B2B_SERVICES_OFFERED, true)) {
    echo json_encode(['found' => false]);
    exit;
}

$partnerStmt = $pdo->prepare('SELECT tier FROM b2b_partners WHERE id = ?');
$partnerStmt->execute([$partnerId]);
$tierName = $partnerStmt->fetchColumn();

$ruleStmt = $pdo->prepare('SELECT base_price, partner_price, markup_allowed FROM b2b_pricing_rules
    WHERE service_category = ? AND partner_id = ? ORDER BY created_at DESC LIMIT 1');
$ruleStmt->execute([$serviceCategory, $partnerId]);
$rule = $ruleStmt->fetch(PDO::FETCH_ASSOC);

if (!$rule && $tierName) {
    $tierStmt = $pdo->prepare('SELECT id FROM b2b_tiers WHERE name = ?');
    $tierStmt->execute([$tierName]);
    $tierId = $tierStmt->fetchColumn();
    if ($tierId) {
        $tierRuleStmt = $pdo->prepare('SELECT base_price, partner_price, markup_allowed FROM b2b_pricing_rules
            WHERE service_category = ? AND tier_id = ? AND partner_id IS NULL ORDER BY created_at DESC LIMIT 1');
        $tierRuleStmt->execute([$serviceCategory, $tierId]);
        $rule = $tierRuleStmt->fetch(PDO::FETCH_ASSOC);
    }
}

if (!$rule) {
    echo json_encode(['found' => false]);
    exit;
}

echo json_encode([
    'found' => true,
    'partner_price' => (float) $rule['partner_price'],
    'base_price' => (float) $rule['base_price'],
    'markup_allowed' => (bool) $rule['markup_allowed'],
]);
