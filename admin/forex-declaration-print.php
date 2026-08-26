<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
admin_require_login();

$ref = trim($_GET['ref'] ?? '');
$pdo = forex_db();
$stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE forex_ref = ?');
$stmt->execute([$ref]);
$request = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$request) {
    http_response_code(404);
    exit('Forex request not found.');
}

$declStmt = $pdo->prepare('SELECT d.*, t.body_html FROM forex_declarations d
    LEFT JOIN forex_declaration_templates t ON t.id = d.template_id
    WHERE d.forex_request_id = ? ORDER BY d.id DESC LIMIT 1');
$declStmt->execute([$request['id']]);
$declaration = $declStmt->fetch(PDO::FETCH_ASSOC);
if (!$declaration) {
    http_response_code(404);
    exit('No declaration record exists for this request.');
}

$rendered = forex_render_declaration($declaration['body_html'], [
    'forex_reference' => $request['forex_ref'],
    'customer_name' => $declaration['customer_name'],
    'passport_number' => $declaration['passport_number'] ?: '—',
    'country' => $declaration['destination_country'],
    'travel_date' => $request['departure_date'] ?: 'as per travel plan',
    'currency' => $request['currency_code'],
    'amount' => number_format((float) $request['amount_required'], 2),
    'declaration_date' => date('d F Y', strtotime($declaration['declaration_date'] ?: 'today')),
]);
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Declaration — <?php echo htmlspecialchars($request['forex_ref']); ?></title>
<meta name="robots" content="noindex, nofollow">
<style>
    body { font-family: Arial, Helvetica, sans-serif; max-width: 720px; margin: 40px auto; padding: 0 20px; color: #101828; line-height: 1.6; }
    .decl-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #101828; padding-bottom: 16px; margin-bottom: 24px; }
    .decl-header img { height: 30px; }
    .decl-print-btn { margin-bottom: 24px; }
    .decl-print-btn button { padding: 10px 20px; border-radius: 6px; border: none; background: #2456D8; color: #fff; font-size: 14px; cursor: pointer; }
    @media print { .decl-print-btn { display: none; } }
    h3 { color: #101828; }
</style>
</head>
<body>
<div class="decl-print-btn"><button onclick="window.print()">Print / Save as PDF</button></div>
<div class="decl-header">
    <strong>VisaAgency.in</strong>
    <span>Forex Ref: <?php echo htmlspecialchars($request['forex_ref']); ?></span>
</div>
<?php echo $rendered; ?>
</body>
</html>
