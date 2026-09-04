<?php
declare(strict_types=1);

function asset(string $path): string
{
    return BASE_PATH . '/assets/' . ltrim($path, '/');
}

function url(string $path = ''): string
{
    return BASE_PATH . '/' . ltrim($path, '/');
}

function e(?string $value): string
{
    return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}

function current_page(): string
{
    return basename(parse_url($_SERVER['REQUEST_URI'] ?? '', PHP_URL_PATH) ?: 'index.php');
}

/**
 * Renders the Videshia brand mark (gradient V + wordmark) as live SVG/HTML
 * rather than a flattened image, so it stays crisp and themeable.
 */
function videshia_logo(string $size = 'md', string $theme = 'light', bool $tagline = false): string
{
    $dims = [
        'sm' => ['mark' => 28, 'word' => 18],
        'md' => ['mark' => 38, 'word' => 24],
        'lg' => ['mark' => 56, 'word' => 34],
        'xl' => ['mark' => 76, 'word' => 46],
    ][$size] ?? ['mark' => 38, 'word' => 24];

    $wordColor = $theme === 'dark' ? '#F3F7FC' : '#0A1B3D';
    $dotColor = '#17C3C9';
    $uid = 'lg' . substr(md5((string) mt_rand()), 0, 6);

    $mark = <<<SVG
    <svg width="{$dims['mark']}" height="{$dims['mark']}" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
        <defs>
            <linearGradient id="{$uid}-navy" x1="8" y1="8" x2="56" y2="112" gradientUnits="userSpaceOnUse">
                <stop offset="0" stop-color="#0A2456"/>
                <stop offset="1" stop-color="#1568A8"/>
            </linearGradient>
            <linearGradient id="{$uid}-teal" x1="112" y1="8" x2="58" y2="112" gradientUnits="userSpaceOnUse">
                <stop offset="0" stop-color="#1ECAD1"/>
                <stop offset="1" stop-color="#0A69AC"/>
            </linearGradient>
            <linearGradient id="{$uid}-edge" x1="48" y1="92" x2="60" y2="112" gradientUnits="userSpaceOnUse">
                <stop offset="0" stop-color="#CFF8F6"/>
                <stop offset="1" stop-color="#CFF8F6" stop-opacity="0"/>
            </linearGradient>
        </defs>
        <path d="M6 8 L40 8 L64 112 L44 112 Z" fill="url(#{$uid}-navy)"/>
        <path d="M114 8 L82 8 L56 112 L60 112 Z" fill="url(#{$uid}-teal)"/>
        <path d="M48 94 L62 94 L58 112 L50 112 Z" fill="url(#{$uid}-edge)" opacity="0.55"/>
    </svg>
    SVG;

    $overlap = (int) round($dims['mark'] * 0.2);

    $out = '<span class="brand" aria-label="' . SITE_NAME . '.com">';
    $out .= '<span class="brand-mark" style="margin-right:-' . $overlap . 'px">' . $mark . '</span>';
    $out .= '<span class="brand-word" style="font-size:' . $dims['word'] . 'px;color:' . $wordColor . '">ideshia<span style="color:' . $dotColor . '">.com</span></span>';
    $out .= '</span>';

    if ($tagline) {
        $tone = $theme === 'dark' ? 'rgba(243,247,252,.72)' : 'rgba(10,27,61,.68)';
        $out .= '<p class="brand-tagline" style="color:' . $tone . '">Visa Consultancy &middot; Document Guidance &middot; 24&times;7 Support</p>';
    }

    return $out;
}

function flash_set(string $key, string $message): void
{
    $_SESSION['flash'][$key] = $message;
}

function flash_get(string $key): ?string
{
    if (empty($_SESSION['flash'][$key])) {
        return null;
    }
    $message = $_SESSION['flash'][$key];
    unset($_SESSION['flash'][$key]);
    return $message;
}
