<?php
/**
 * OAuth entry and exit points. Never rendered — always redirects.
 *
 *   /auth/{provider}           start sign-in
 *   /auth/callback/{provider}  provider sends the visitor back here
 *   /logout                    end the session
 *
 * .htaccess rewrites those clean URLs to this file with ?action= and ?provider=.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/oauth.php';

// These pages must never be cached — a cached callback or logout would replay
// somebody else's session state on a shared machine.
header('Cache-Control: no-store, private');
header('Pragma: no-cache');

function auth_redirect(string $path): never
{
    header('Location: ' . $path, true, 302);
    exit;
}

function login_error(string $code, string $next = ''): never
{
    $q = ['error' => $code];
    if ($next !== '' && $next !== '/account') {
        $q['next'] = $next;
    }
    auth_redirect(url('/login') . '?' . http_build_query($q));
}

$action   = (string) ($_GET['action'] ?? '');
$provider = (string) ($_GET['provider'] ?? '');
$next     = auth_safe_next($_GET['next'] ?? null);

// ---------------------------------------------------------------- logout
if ($action === 'logout') {
    // POST + CSRF token: a plain <a href="/logout"> can be triggered by any
    // page on the internet (or prefetched by a browser), which is a nuisance
    // rather than a breach, but signing people out unasked is still a bug.
    if (($_SERVER['REQUEST_METHOD'] ?? 'GET') !== 'POST' || !auth_csrf_valid($_POST['csrf'] ?? null)) {
        auth_redirect(url('/account'));
    }
    auth_logout();
    auth_redirect(url('/') . '?signed_out=1');
}

// ------------------------------------------------------- start / callback
$p = oauth_provider($provider);
if (!$p) {
    auth_redirect(url('/login'));
}
if (!oauth_configured($p)) {
    login_error('unconfigured', $next);
}
if (!auth_db()) {
    // No user store means a "successful" sign-in would vanish on the next
    // request. Say so instead of pretending it worked.
    login_error('unavailable', $next);
}

if ($action === 'start') {
    if (auth_user()) {
        auth_redirect(url($next));
    }
    auth_redirect(oauth_authorize_url($provider, $p, $next));
}

if ($action === 'callback') {
    [$profile, $err] = oauth_handle_callback($provider, $p, $_GET);
    if ($err !== '' || $profile === null) {
        login_error($err ?: 'unknown');
    }

    [$user, $outcome] = auth_upsert_user($profile);
    if (!$user) {
        login_error('unavailable');
    }

    auth_login($user);
    $dest = auth_safe_next($profile['next'] ?? '/account');
    // `welcome` only drives a one-off greeting on the account page. The
    // separator depends on whether the destination already carries a query.
    if ($outcome === 'created') {
        $dest .= (str_contains($dest, '?') ? '&' : '?') . 'welcome=1';
    }
    auth_redirect(url($dest));
}

auth_redirect(url('/login'));
