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

    // Mark box is traced directly from the source logo artwork (not hand-drawn),
    // so it keeps that file's exact silhouette — including the fold notch where
    // the two strokes meet. Natural aspect ratio is ~120:108.93, not square.
    $markW = $dims['mark'];
    $markH = round($markW * 108.93 / 120, 2);

    $wordColor = $theme === 'dark' ? '#F3F7FC' : '#0A1B3D';
    $dotColor = '#17C3C9';
    $uid = 'lg' . substr(md5((string) mt_rand()), 0, 6);

    $mark = <<<SVG
    <svg width="{$markW}" height="{$markH}" viewBox="0 0 120 108.93" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
        <defs>
            <linearGradient id="{$uid}-navy" x1="2" y1="2" x2="55" y2="106" gradientUnits="userSpaceOnUse">
                <stop offset="0" stop-color="#0A2456"/>
                <stop offset="1" stop-color="#1568A8"/>
            </linearGradient>
            <linearGradient id="{$uid}-teal" x1="118" y1="2" x2="60" y2="106" gradientUnits="userSpaceOnUse">
                <stop offset="0" stop-color="#1ECAD1"/>
                <stop offset="1" stop-color="#0A69AC"/>
            </linearGradient>
        </defs>
        <path d="M1.32 2.26 C0.04 2.75 0 3.95 1.13 6.14 C1.69 7.19 3.58 10.81 5.31 14.12 C7 17.43 8.89 20.97 9.45 22.03 C10.02 23.04 13.82 30.42 17.92 38.41 C22.03 46.39 27.11 56.29 29.22 60.43 C31.33 64.57 35.13 71.95 37.62 76.81 C40.1 81.67 42.66 86.56 43.26 87.66 L44.36 89.69 L45.11 88.6 C45.52 88.03 47.71 83.85 49.97 79.37 C52.19 74.85 54.07 71.24 54.14 71.31 C54.26 71.39 53.05 73.95 47.48 85.66 C44.81 91.31 44.81 90.82 47.67 96.73 C50.72 102.94 51.66 104.34 53.47 105.54 C54.71 106.37 58.25 107.69 59.23 107.69 C59.38 107.69 59.53 96.02 59.53 81.74 L59.53 55.84 L47.63 31.78 C41.12 18.53 35.32 7.15 34.83 6.51 C33.55 4.82 31.06 3.2 28.65 2.49 C26.96 2 24.59 1.88 14.38 1.92 C7.64 1.92 1.73 2.07 1.32 2.26 Z" fill="url(#{$uid}-navy)"/>
        <path d="M92.44 1.66 C90.37 2.3 87.66 4.29 86.45 5.99 C85.92 6.78 81.29 15.93 76.17 26.39 C71.01 36.82 65.7 47.52 64.39 50.15 C62.24 54.48 62.05 55.05 62.43 55.99 C67.17 67.74 76.13 86.56 77.11 86.87 C77.38 86.98 85.62 70.9 98.54 45.03 C119.13 3.69 119.47 2.97 118.87 2.07 L118.27 1.13 L106.11 1.17 C97.3 1.17 93.57 1.32 92.44 1.66 Z M59.53 81.86 L59.53 107.8 L61.49 107.57 C63.82 107.27 66.87 105.84 68.26 104.41 C69.39 103.21 76.1 90.18 76.1 89.16 C76.1 88.79 75.46 87.09 74.63 85.4 C71.5 78.73 61.86 59.57 60.73 57.83 L59.53 55.95 L59.53 81.86 Z" fill="url(#{$uid}-teal)"/>
    </svg>
    SVG;

    $overlap = (int) round($markW * 0.18);

    $out = '<span class="brand" aria-label="' . SITE_NAME . '.com">';
    $out .= '<span class="brand-mark" style="margin-right:-' . $overlap . 'px">' . $mark . '</span>';
    $out .= '<span class="brand-word" style="font-size:' . $dims['word'] . 'px;color:' . $wordColor . '">ideshia<span style="color:' . $dotColor . '">.com</span></span>';
    $out .= '</span>';

    if ($tagline) {
        $tone = $theme === 'dark' ? 'rgba(243,247,252,.75)' : 'rgba(10,27,61,.7)';
        $subTone = $theme === 'dark' ? 'rgba(243,247,252,.5)' : 'rgba(10,27,61,.48)';
        $out .= '<p class="brand-tagline" style="color:' . $tone . '">Premium Visa Consultancy</p>';
        $out .= '<p class="brand-subtagline" style="color:' . $subTone . '">Expert Consultants &middot; Document Support &middot; Global Coverage</p>';
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
