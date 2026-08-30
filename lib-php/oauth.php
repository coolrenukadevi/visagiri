<?php
/**
 * OAuth 2.0 sign-in for Google, Facebook and X (Twitter).
 *
 * One Authorization Code + PKCE flow covers all three; only the endpoints and
 * the shape of the profile response differ, so each provider is a data entry
 * (OAUTH_PROVIDERS) plus a small profile mapper.
 *
 *   /login            -> user picks a provider
 *   /auth/{provider}  -> we redirect to the provider with state + PKCE
 *   /auth/callback/{provider} -> provider redirects back with ?code
 *                        we exchange the code SERVER-SIDE for a token, fetch
 *                        the profile, then create the local session
 *
 * Security properties, and why each is here:
 *  - The client SECRET never leaves the server. The browser only ever sees the
 *    public client id in a redirect URL.
 *  - `state` is a random value bound to the session; a callback whose state
 *    doesn't match is discarded. This is what stops login CSRF, where an
 *    attacker gets you to complete THEIR sign-in and then acts as you.
 *  - PKCE (S256) means an intercepted authorization code is useless without
 *    the verifier, which stayed in the session. X mandates it; Google and
 *    Facebook accept it, so all three get it.
 *  - state/verifier/nonce are single-use: consumed the moment the callback
 *    reads them, so a replayed callback URL cannot sign anyone in twice.
 *  - No token is persisted. We need identity once, at sign-in; storing access
 *    tokens we never use would only create something worth stealing.
 *
 * Credentials come from the environment (see .env.example). Until they are
 * set, a provider reports itself unconfigured and its button explains that,
 * rather than sending people into a broken redirect.
 */
declare(strict_types=1);

require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/auth.php';

const OAUTH_HTTP_TIMEOUT = 8;         // seconds, hard cap on any provider call
const OAUTH_STATE_TTL    = 600;       // 10 min to complete a sign-in

/**
 * Provider registry.
 *
 * `scopes` are the minimum needed to identify someone:
 *   Google   — OIDC identity + email
 *   Facebook — public profile + email
 *   X        — read the signed-in user's own profile. X does NOT return an
 *              email address through this API without elevated access, so an
 *              X sign-in creates an account with no email until the person
 *              also links Google or Facebook. That is a real product
 *              constraint, not something to paper over with a fake address.
 */
function oauth_providers(): array
{
    return [
        'google' => [
            'label'     => 'Google',
            'authorize' => 'https://accounts.google.com/o/oauth2/v2/auth',
            'token'     => 'https://oauth2.googleapis.com/token',
            'userinfo'  => 'https://openidconnect.googleapis.com/v1/userinfo',
            'scopes'    => 'openid email profile',
            'client_id' => env('GOOGLE_CLIENT_ID'),
            'secret'    => env('GOOGLE_CLIENT_SECRET'),
            'auth_style' => 'post',    // credentials in the POST body
            'extra_auth' => ['nonce' => true, 'prompt' => 'select_account'],
        ],
        'facebook' => [
            'label'     => 'Facebook',
            'authorize' => 'https://www.facebook.com/v21.0/dialog/oauth',
            'token'     => 'https://graph.facebook.com/v21.0/oauth/access_token',
            'userinfo'  => 'https://graph.facebook.com/v21.0/me?fields=id,name,email,picture.type(large)',
            'scopes'    => 'public_profile,email',
            'client_id' => env('FACEBOOK_APP_ID'),
            'secret'    => env('FACEBOOK_APP_SECRET'),
            'auth_style' => 'post',
            'extra_auth' => [],
        ],
        'x' => [
            'label'     => 'X',
            'authorize' => 'https://x.com/i/oauth2/authorize',
            'token'     => 'https://api.x.com/2/oauth2/token',
            'userinfo'  => 'https://api.x.com/2/users/me?user.fields=profile_image_url,name,username',
            'scopes'    => 'users.read tweet.read',
            'client_id' => env('X_CLIENT_ID'),
            'secret'    => env('X_CLIENT_SECRET'),
            'auth_style' => 'basic',   // X wants HTTP Basic on the token call
            'extra_auth' => [],
        ],
    ];
}

function oauth_provider(string $name): ?array
{
    return oauth_providers()[$name] ?? null;
}

/** True when this provider has both halves of its credential pair. */
function oauth_configured(array $p): bool
{
    return !empty($p['client_id']) && !empty($p['secret']);
}

function oauth_any_configured(): bool
{
    foreach (oauth_providers() as $p) {
        if (oauth_configured($p)) {
            return true;
        }
    }
    return false;
}

/**
 * The redirect URI registered with each provider.
 *
 * Built from SITE_ORIGIN, not from the incoming Host header: a request header
 * is attacker-controlled, and letting it into an OAuth redirect URI is how
 * codes get sent to somebody else's domain.
 */
function oauth_redirect_uri(string $provider): string
{
    return SITE_ORIGIN . '/auth/callback/' . $provider;
}

// ---------------------------------------------------------------------
// Step 1 — send the visitor to the provider
// ---------------------------------------------------------------------

function oauth_authorize_url(string $providerName, array $p, string $next): string
{
    auth_session_start();

    $state    = bin2hex(random_bytes(32));
    $verifier = rtrim(strtr(base64_encode(random_bytes(64)), '+/', '-_'), '=');
    $challenge = rtrim(strtr(base64_encode(hash('sha256', $verifier, true)), '+/', '-_'), '=');

    $_SESSION['oauth'] = [
        'provider' => $providerName,
        'state'    => $state,
        'verifier' => $verifier,
        'next'     => auth_safe_next($next),
        'issued'   => time(),
    ];

    $q = [
        'response_type'         => 'code',
        'client_id'             => $p['client_id'],
        'redirect_uri'          => oauth_redirect_uri($providerName),
        'scope'                 => $p['scopes'],
        'state'                 => $state,
        'code_challenge'        => $challenge,
        'code_challenge_method' => 'S256',
    ];
    if (!empty($p['extra_auth']['nonce'])) {
        $nonce = bin2hex(random_bytes(16));
        $_SESSION['oauth']['nonce'] = $nonce;
        $q['nonce'] = $nonce;
    }
    if (!empty($p['extra_auth']['prompt'])) {
        $q['prompt'] = $p['extra_auth']['prompt'];
    }

    return $p['authorize'] . '?' . http_build_query($q, '', '&', PHP_QUERY_RFC3986);
}

// ---------------------------------------------------------------------
// Step 2 — handle the callback
// ---------------------------------------------------------------------

/**
 * Validates the callback and returns a normalised profile.
 *
 * @return array{0:?array,1:string} [profile, error] — error is a short code
 *         for the login page; details go to the log, never to the visitor.
 */
function oauth_handle_callback(string $providerName, array $p, array $query): array
{
    auth_session_start();

    $pending = $_SESSION['oauth'] ?? null;
    // Single-use: consume it now, so a replayed callback URL finds nothing.
    unset($_SESSION['oauth']);

    if (!is_array($pending) || ($pending['provider'] ?? '') !== $providerName) {
        return [null, 'session'];
    }
    if (time() - (int) ($pending['issued'] ?? 0) > OAUTH_STATE_TTL) {
        return [null, 'expired'];
    }
    if (!isset($query['state']) || !is_string($query['state'])
        || !hash_equals((string) $pending['state'], $query['state'])) {
        log_error("oauth[{$providerName}]: state mismatch");
        return [null, 'state'];
    }
    if (isset($query['error'])) {
        // The visitor pressed Cancel, or the app is misconfigured upstream.
        log_error("oauth[{$providerName}]: provider returned " . substr((string) $query['error'], 0, 120));
        return [null, $query['error'] === 'access_denied' ? 'cancelled' : 'provider'];
    }
    if (empty($query['code']) || !is_string($query['code'])) {
        return [null, 'provider'];
    }

    $token = oauth_exchange_code($providerName, $p, $query['code'], (string) $pending['verifier']);
    if ($token === null) {
        return [null, 'token'];
    }

    $profile = oauth_fetch_profile($providerName, $p, $token);
    if ($profile === null) {
        return [null, 'profile'];
    }

    return [$profile + ['next' => $pending['next'] ?? '/account'], ''];
}

function oauth_exchange_code(string $providerName, array $p, string $code, string $verifier): ?string
{
    $body = [
        'grant_type'    => 'authorization_code',
        'code'          => $code,
        'redirect_uri'  => oauth_redirect_uri($providerName),
        'code_verifier' => $verifier,
        'client_id'     => $p['client_id'],
    ];
    $headers = ['Accept: application/json'];
    $userpwd = null;

    if (($p['auth_style'] ?? 'post') === 'basic') {
        $userpwd = $p['client_id'] . ':' . $p['secret'];
    } else {
        $body['client_secret'] = $p['secret'];
    }

    $res = oauth_http($p['token'], [
        'post'    => http_build_query($body, '', '&', PHP_QUERY_RFC3986),
        'headers' => array_merge($headers, ['Content-Type: application/x-www-form-urlencoded']),
        'userpwd' => $userpwd,
    ]);
    if ($res === null) {
        return null;
    }
    $data = json_decode($res, true);
    if (!is_array($data) || empty($data['access_token']) || !is_string($data['access_token'])) {
        log_error("oauth[{$providerName}]: token response had no access_token");
        return null;
    }
    return $data['access_token'];
}

/**
 * Fetches the profile with the access token and normalises it.
 *
 * Google's userinfo endpoint is used rather than decoding the id_token: it
 * returns the same claims over an authenticated TLS call to Google, which
 * avoids hand-rolling JWT signature verification (and the classic `alg: none`
 * mistake) without pulling in a dependency.
 *
 * @return array{provider:string,id:string,email:?string,email_verified:bool,name:string,avatar:string}|null
 */
function oauth_fetch_profile(string $providerName, array $p, string $token): ?array
{
    $res = oauth_http($p['userinfo'], ['headers' => [
        'Authorization: Bearer ' . $token,
        'Accept: application/json',
    ]]);
    if ($res === null) {
        return null;
    }
    $d = json_decode($res, true);
    if (!is_array($d)) {
        log_error("oauth[{$providerName}]: profile was not JSON");
        return null;
    }

    $profile = match ($providerName) {
        'google' => [
            'id'             => (string) ($d['sub'] ?? ''),
            'email'          => isset($d['email']) ? (string) $d['email'] : null,
            // Google sends this as a real boolean; some clients see "true".
            'email_verified' => filter_var($d['email_verified'] ?? false, FILTER_VALIDATE_BOOL),
            'name'           => (string) ($d['name'] ?? ''),
            'avatar'         => (string) ($d['picture'] ?? ''),
        ],
        'facebook' => [
            'id'    => (string) ($d['id'] ?? ''),
            // Facebook only returns an email it has already confirmed, and
            // omits the field entirely for phone-only accounts.
            'email' => isset($d['email']) ? (string) $d['email'] : null,
            'email_verified' => isset($d['email']) && $d['email'] !== '',
            'name'   => (string) ($d['name'] ?? ''),
            'avatar' => (string) ($d['picture']['data']['url'] ?? ''),
        ],
        'x' => [
            'id'             => (string) ($d['data']['id'] ?? ''),
            'email'          => null,   // not available on this API tier
            'email_verified' => false,
            'name'           => (string) ($d['data']['name'] ?? $d['data']['username'] ?? ''),
            'avatar'         => (string) ($d['data']['profile_image_url'] ?? ''),
        ],
        default => null,
    };

    if ($profile === null || $profile['id'] === '') {
        log_error("oauth[{$providerName}]: profile had no stable user id");
        return null;
    }
    // Only ever store an https image URL — an http one would break the page's
    // security context, and anything else is not a URL we should be rendering.
    if ($profile['avatar'] !== '' && !str_starts_with($profile['avatar'], 'https://')) {
        $profile['avatar'] = '';
    }
    if ($profile['email'] !== null && !filter_var($profile['email'], FILTER_VALIDATE_EMAIL)) {
        $profile['email'] = null;
        $profile['email_verified'] = false;
    }
    $profile['name'] = mb_substr(trim($profile['name']), 0, 120);
    $profile['provider'] = $providerName;

    return $profile;
}

/**
 * One place for every outbound provider call.
 *
 * TLS verification stays ON, redirects are NOT followed (a token endpoint that
 * redirects is a signal something is wrong, not something to chase), and the
 * response body is capped so a hostile or broken endpoint cannot exhaust
 * memory. Failures return null; the caller decides what the visitor sees.
 */
function oauth_http(string $url, array $opt = []): ?string
{
    if (!function_exists('curl_init')) {
        log_error('oauth: ext-curl is required');
        return null;
    }
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => OAUTH_HTTP_TIMEOUT,
        CURLOPT_CONNECTTIMEOUT => OAUTH_HTTP_TIMEOUT,
        CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_HTTPHEADER     => $opt['headers'] ?? ['Accept: application/json'],
        CURLOPT_USERAGENT      => 'Convercession/1.0 (+' . SITE_ORIGIN . ')',
    ]);
    if (isset($opt['post'])) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $opt['post']);
    }
    if (!empty($opt['userpwd'])) {
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_USERPWD, $opt['userpwd']);
    }

    $body = curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $err  = curl_error($ch);
    curl_close($ch);

    if ($body === false) {
        log_error('oauth: request to ' . parse_url($url, PHP_URL_HOST) . ' failed — ' . $err);
        return null;
    }
    if ($code < 200 || $code >= 300) {
        // Log the status and a short excerpt — enough to debug a
        // misconfigured app, without dumping tokens into the log file.
        log_error('oauth: ' . parse_url($url, PHP_URL_HOST) . " returned HTTP {$code}: " . substr((string) $body, 0, 200));
        return null;
    }
    if (strlen((string) $body) > 65536) {
        log_error('oauth: response from ' . parse_url($url, PHP_URL_HOST) . ' was implausibly large');
        return null;
    }
    return (string) $body;
}

/** Visitor-facing text for a failed sign-in. Never leaks provider internals. */
function oauth_error_message(string $code): string
{
    return match ($code) {
        'cancelled'   => 'Sign-in was cancelled. You can try again or use a different provider.',
        'expired'     => 'That sign-in took too long and expired. Please try again.',
        'state', 'session' => 'We could not verify that sign-in request. Please start again from this page.',
        'token', 'profile', 'provider' => 'The sign-in provider could not be reached just now. Please try again in a moment.',
        'unconfigured' => 'That sign-in method is not switched on yet. Please use another option or contact us.',
        'unavailable' => 'Sign-in is temporarily unavailable. Please try again shortly.',
        default       => 'Something went wrong signing you in. Please try again.',
    };
}
