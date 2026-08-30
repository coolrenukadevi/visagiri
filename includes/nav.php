<?php
/** Navigation data + renderers, shared by header and footer. */
require_once __DIR__ . '/config.php';

function nav_data(): array
{
    static $d = null;
    if ($d === null) {
        $raw = @file_get_contents(ROOT_PATH . '/data/generated/navigation.json');
        $d = $raw ? (json_decode($raw, true) ?: ['nav' => [], 'footer' => []]) : ['nav' => [], 'footer' => []];
    }
    return $d;
}

function regions_data(): array
{
    static $r = null;
    if ($r === null) {
        $raw = @file_get_contents(ROOT_PATH . '/data/regions.json');
        $r = $raw ? (json_decode($raw, true) ?: []) : [];
        foreach (array_keys($r) as $k) {
            if (str_starts_with($k, '_')) unset($r[$k]);
        }
    }
    return $r;
}

function cv_slug(string $s): string
{
    // Must produce byte-identical slugs to the JS slugify in js/data.js —
    // "Curaçao" -> "curacao", not "cura-ao". intl is NOT assumed present
    // (many shared hosts ship without it), so fall back to iconv, then to a
    // plain strip. Getting this wrong silently 404s accented countries.
    if (class_exists('\\Normalizer')) {
        $n = \Normalizer::normalize($s, \Normalizer::FORM_D);
        if ($n !== false) {
            $s = preg_replace('/\p{Mn}+/u', '', $n) ?? $s;
        }
    }
    $ascii = @iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $s);
    if ($ascii !== false && $ascii !== '') {
        $s = $ascii;
    }
    $s = strtolower($s);
    $s = str_replace('&', 'and', $s);
    $s = preg_replace('/[^a-z0-9]+/', '-', $s);
    return trim((string) $s, '-');
}

/** Clean URL for a nav item; strips any legacy .php and applies params. */
function nav_href(array $item): string
{
    $href = (string) ($item['href'] ?? '#');
    // Strip BOTH .php and .html — nav data predates the PHP migration and a
    // stale .html href silently produces a duplicate indexable URL.
    $href = preg_replace('/\.(php|html)($|\?|#)/', '$2', $href);
    $qs = [];
    if (!empty($item['param'])) $qs['visaType'] = $item['param'];
    if (!empty($item['tab']))   $qs['tab'] = $item['tab'];
    if ($qs) {
        $href .= (str_contains($href, '?') ? '&' : '?') . http_build_query($qs);
    }
    return $href;
}
