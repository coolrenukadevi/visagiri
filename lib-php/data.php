<?php
/** Reads the generated JSON content (single source of truth shared with JS). */
declare(strict_types=1);
require_once __DIR__ . '/../includes/config.php';

function content(): array
{
    static $c = null;
    if ($c === null) {
        $raw = @file_get_contents(ROOT_PATH . '/data/generated/countries.json');
        $c = $raw ? (json_decode($raw, true) ?: []) : [];
        $c += ['countries' => [], 'standardDocs' => [], 'embassyCities' => [], 'searchable' => []];
    }
    return $c;
}

function all_countries(): array { return content()['countries']; }

function country_by_slug(string $slug): ?array
{
    foreach (all_countries() as $c) {
        if (($c['slug'] ?? '') === $slug) return $c;
    }
    return null;
}

/**
 * One at-a-glance fact (fee, processing time, validity, entry type).
 *
 * Only a visa type marked `verified` — one whose figures came through the
 * import pipeline from a source somebody actually checked — has a value worth
 * printing. Everything else returns known=false, and the page states that the
 * figure is confirmed for the applicant's nationality instead of showing a
 * number.
 *
 * This is deliberate. A fee or a processing time is the kind of fact people
 * book non-refundable travel around: a plausible-looking wrong one does more
 * damage than an honest blank, and the "(sample)" suffix this replaces was far
 * too easy to skim past.
 *
 * @return array{known:bool,value:string}
 */
function visa_fact(array $visaType, string $field, string $fallback): array
{
    $value = trim((string) ($visaType[$field] ?? ''));
    $isPlaceholder = $value === ''
        || stripos($value, 'sample') !== false
        || stripos($value, 'xxxx') !== false;

    if (!empty($visaType['verified']) && !$isPlaceholder) {
        return ['known' => true, 'value' => $value];
    }
    return ['known' => false, 'value' => $fallback];
}

/** True when nothing on this country's page has been source-verified yet. */
function country_is_generic(array $country): bool
{
    foreach ($country['visaTypes'] ?? [] as $v) {
        if (!empty($v['verified'])) return false;
    }
    return true;
}

/** Countries sharing a region with $slug, for a genuinely related list. */
function related_countries(string $slug, int $limit = 8): array
{
    require_once __DIR__ . '/../includes/nav.php';
    $regions = regions_data();
    $bySlug = [];
    foreach (all_countries() as $c) {
        $bySlug[$c['slug']] = $c;
    }
    foreach ($regions as $names) {
        $slugs = array_map('cv_slug', $names);
        if (!in_array($slug, $slugs, true)) {
            continue;
        }
        // Same region, so "related" means something — the old list was just
        // the first six countries alphabetically, identical on every page.
        $out = [];
        foreach ($slugs as $s) {
            if ($s !== $slug && isset($bySlug[$s])) {
                $out[] = $bySlug[$s];
            }
        }
        if (!$out) {
            break;
        }
        // Rotate by a hash of the slug: every country shows a different set,
        // but the same set on every render. Randomising here would change the
        // page's links on each request, which is bad for both caching and
        // anyone trying to reproduce what they saw.
        $offset = (int) hexdec(substr(md5($slug), 0, 4)) % count($out);
        $out = array_merge(array_slice($out, $offset), array_slice($out, 0, $offset));
        return array_slice($out, 0, $limit);
    }
    $all = array_values(array_filter(all_countries(), static fn($c) => $c['slug'] !== $slug));
    return array_slice($all, 0, $limit);
}
