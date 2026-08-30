<?php
/**
 * Central site configuration.
 *
 * Changing contact details here updates them everywhere on the site — there
 * are no hard-coded phone numbers or addresses in the templates.
 *
 * SECRETS: never put API credentials in this file. They are read from the
 * environment (see .env.example) so they stay out of the repo and out of any
 * file the web server could ever serve.
 */
declare(strict_types=1);

// ---- Canonical origin -------------------------------------------------
// One preferred host + scheme. Everything canonical/OG/schema/sitemap is
// built from this, so there is exactly one indexable variant of each page.
define('SITE_SCHEME', 'https');
define('SITE_HOST',   'www.convercession.com');
define('SITE_ORIGIN', SITE_SCHEME . '://' . SITE_HOST);

// Trailing-slash policy: NO trailing slash (except the root "/").
define('TRAILING_SLASH', false);

// ---- Company ----------------------------------------------------------
const SITE = [
    'name'        => 'Convercession',
    'legal_name'  => 'Convercession',
    'parent'      => 'Tripgation® Private Limited',
    'cin'         => 'U63030UP2020PTC128661',
    'tagline'     => 'AI-Powered Visa & Global Mobility Platform',
    'phone'       => '+91-7065-819-819',
    'phone_href'  => '+917065819819',
    'email'       => 'hello@convercession.com',
    'address'     => [
        'street'   => '203, Sharda Mansion Apartment, Kailashpuri, Kankarbagh, Hanuman Nagar',
        'locality' => 'Patna',
        'region'   => 'Bihar',
        'postcode' => '800020',
        'country'  => 'IN',
    ],
    'social' => [
        'Facebook'    => 'https://facebook.com/convercession',
        'X / Twitter' => 'https://x.com/convercession',
        'Instagram'   => 'https://instagram.com/convercession',
    ],
];

// ---- Environment ------------------------------------------------------
/**
 * Reads a config value from the real environment first, then from a .env file
 * beside this one. Kept deliberately tiny — no dependency needed.
 */
function env(string $key, ?string $default = null): ?string
{
    static $file = null;
    $v = getenv($key);
    if ($v !== false && $v !== '') {
        return $v;
    }
    if ($file === null) {
        $file = [];
        $path = dirname(__DIR__) . '/.env';
        if (is_readable($path)) {
            foreach (file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
                $line = trim($line);
                if ($line === '' || $line[0] === '#' || !str_contains($line, '=')) {
                    continue;
                }
                [$k, $val] = explode('=', $line, 2);
                $file[trim($k)] = trim($val, " \t\"'");
            }
        }
    }
    return $file[$key] ?? $default;
}

// ---- Paths ------------------------------------------------------------
define('ROOT_PATH',  dirname(__DIR__));
define('CACHE_PATH', ROOT_PATH . '/cache');
define('LOG_PATH',   ROOT_PATH . '/cache/error.log');

// ---- URL helpers ------------------------------------------------------
/** Absolute canonical URL for a site-relative path. */
function canonical(string $path = '/'): string
{
    $path = '/' . ltrim($path, '/');
    if ($path !== '/' ) {
        $path = rtrim($path, '/');
        if (TRAILING_SLASH) {
            $path .= '/';
        }
    }
    return SITE_ORIGIN . $path;
}

/** Site-relative clean URL (what goes in href=""). Never contains ".php". */
function url(string $path = '/'): string
{
    $path = '/' . ltrim($path, '/');
    return $path === '/' ? '/' : rtrim($path, '/');
}

function e(?string $s): string
{
    return htmlspecialchars((string) $s, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

/** Log server-side without ever leaking detail to the visitor. */
function log_error(string $message): void
{
    @error_log('[' . gmdate('c') . '] ' . $message . PHP_EOL, 3, LOG_PATH);
}
