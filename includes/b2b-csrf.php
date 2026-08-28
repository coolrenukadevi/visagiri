<?php
/**
 * CSRF protection for the B2B module only (Phase 15 §"security hardening"
 * — confirmed at the start of this build that no CSRF protection exists
 * anywhere else in this codebase; this is a net-new, B2B-scoped helper,
 * not a retrofit of existing admin/public forms).
 *
 * One token per PHP session, shared across the admin ($_SESSION['admin_user'])
 * and partner ($_SESSION['partner_user']) session namespaces since both
 * already share the same underlying PHP session mechanism — the token
 * itself carries no privilege, it just proves the request came from a
 * page this session actually rendered.
 *
 * Excluded by design, not by oversight:
 *  - b2b-document-upload.php — authorized by a per-application bearer
 *    token (ref+token), not a cookie session, so classic CSRF doesn't
 *    apply to it.
 *  - b2b-notifications.php's mark_read action — idempotent, affects only
 *    the caller's own read/unread flags, no state worth forging.
 */

function b2b_csrf_token(): string
{
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    if (empty($_SESSION['b2b_csrf_token'])) {
        $_SESSION['b2b_csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['b2b_csrf_token'];
}

/** Hidden form field to drop inside every B2B <form method="post">. */
function b2b_csrf_field(): string
{
    return '<input type="hidden" name="b2b_csrf" value="' . htmlspecialchars(b2b_csrf_token()) . '">';
}

function b2b_csrf_valid(): bool
{
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    $expected = $_SESSION['b2b_csrf_token'] ?? '';
    $submitted = $_POST['b2b_csrf'] ?? '';
    return $expected !== '' && $submitted !== '' && hash_equals($expected, $submitted);
}

/**
 * Call as the first line inside `if ($_SERVER['REQUEST_METHOD'] === 'POST')`
 * on a classic form-posting page. Exits with 403 on failure — same
 * ob_start()-must-run-first requirement as every other http_response_code()
 * call in this module if the page has already included a layout-top.php.
 */
function b2b_csrf_require_or_403(): void
{
    if (b2b_csrf_valid()) {
        return;
    }
    http_response_code(403);
    exit('Security check failed (invalid or expired form). Please refresh the page and try again.');
}

/** Same check for JSON AJAX endpoints, so the caller's fetch().then(r => r.json()) doesn't break on a plain-text body. */
function b2b_csrf_require_or_json403(): void
{
    if (b2b_csrf_valid()) {
        return;
    }
    http_response_code(403);
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Security check failed. Please refresh the page and try again.']);
    exit;
}
