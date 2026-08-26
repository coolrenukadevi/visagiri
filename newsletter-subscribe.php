<?php
/**
 * POST-only endpoint for the footer newsletter form. Stores a real,
 * deduplicated subscriber record — no fake/no-op submission handling.
 */

header('Content-Type: application/json');

require_once __DIR__ . '/includes/enquiry-db.php';

function newsletter_fail(string $message, int $code = 422): void
{
    http_response_code($code);
    echo json_encode(['success' => false, 'message' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    newsletter_fail('Method not allowed.', 405);
}

// Honeypot: real visitors never fill this hidden field.
if (!empty($_POST['website'])) {
    echo json_encode(['success' => true]);
    exit;
}

$email = trim($_POST['email'] ?? '');
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    newsletter_fail('Please enter a valid email address.');
}

$sourceUrl = substr(trim($_POST['source_url'] ?? ''), 0, 500);

$pdo = enquiry_db();
$stmt = $pdo->prepare('SELECT id, is_active FROM newsletter_subscribers WHERE email = ?');
$stmt->execute([$email]);
$existing = $stmt->fetch(PDO::FETCH_ASSOC);

if ($existing) {
    if (!$existing['is_active']) {
        $pdo->prepare('UPDATE newsletter_subscribers SET is_active = 1, source_url = ?, created_at = ? WHERE id = ?')
            ->execute([$sourceUrl, gmdate('c'), $existing['id']]);
    }
} else {
    $pdo->prepare('INSERT INTO newsletter_subscribers (email, source_url, is_active, created_at) VALUES (?, ?, 1, ?)')
        ->execute([$email, $sourceUrl, gmdate('c')]);
}

echo json_encode(['success' => true, 'message' => "You're subscribed. Thanks for joining!"]);
