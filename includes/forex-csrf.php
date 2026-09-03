<?php
/**
 * CSRF protection for the Forex customer-portal login flow, mirroring
 * includes/b2b-csrf.php exactly (same shape, own token/session key so the
 * two modules' tokens can never be swapped for each other).
 *
 * Excluded by design: forex-document-upload.php and forex-documents.php —
 * authorized by a per-request bearer token (ref+upload_token), not a
 * cookie session, so classic CSRF doesn't apply to them (same reasoning
 * as b2b-document-upload.php's exclusion).
 */

function forex_csrf_token(): string
{
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    if (empty($_SESSION['forex_csrf_token'])) {
        $_SESSION['forex_csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['forex_csrf_token'];
}

/** Hidden form field to drop inside every Forex portal <form method="post">. */
function forex_csrf_field(): string
{
    return '<input type="hidden" name="forex_csrf" value="' . htmlspecialchars(forex_csrf_token()) . '">';
}

function forex_csrf_valid(): bool
{
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    $expected = $_SESSION['forex_csrf_token'] ?? '';
    $submitted = $_POST['forex_csrf'] ?? '';
    return $expected !== '' && $submitted !== '' && hash_equals($expected, $submitted);
}

/** Same check for JSON AJAX endpoints, so the caller's fetch().then(r => r.json()) doesn't break on a plain-text body. */
function forex_csrf_require_or_json403(): void
{
    if (forex_csrf_valid()) {
        return;
    }
    http_response_code(403);
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Security check failed. Please refresh the page and try again.']);
    exit;
}
