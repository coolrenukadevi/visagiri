<?php
declare(strict_types=1);

/**
 * Catalog data lookups — countries, visa types, FAQs, contact points,
 * and visa requirements, all backed by MySQL now that the database is
 * back (see AUDIT.md, "MySQL restored"). Same function names/shapes
 * as the static-array version this replaces, so every page that
 * consumes them (header, footer, home, countries, visa, visa-type,
 * faq, sitemap) needed no changes at all — only this file's
 * implementation changed.
 */

/** @return list<array<string,mixed>> */
function countries_all(): array
{
    static $countries = null;
    if ($countries === null) {
        $countries = db()->query(
            'SELECT c.id, c.name, c.slug, c.iso2, c.iso3, r.name AS region,
                    c.is_popular_destination, c.is_schengen, c.is_active
             FROM countries c
             LEFT JOIN regions r ON r.id = c.region_id
             WHERE c.is_active = 1
             ORDER BY r.name, c.name'
        )->fetchAll();
        foreach ($countries as &$c) {
            $c['is_popular_destination'] = (bool) $c['is_popular_destination'];
            $c['is_schengen'] = (bool) $c['is_schengen'];
            $c['is_active'] = (bool) $c['is_active'];
        }
        unset($c);
    }
    return $countries;
}

function country_by_slug(string $slug): ?array
{
    foreach (countries_all() as $c) {
        if ($c['slug'] === $slug) {
            return $c;
        }
    }
    return null;
}

/** @return list<array<string,mixed>> */
function visa_types_all(): array
{
    static $types = null;
    if ($types === null) {
        $types = db()->query(
            'SELECT id, name, slug, description, icon, sort_order, is_active
             FROM visa_types WHERE is_active = 1 ORDER BY sort_order'
        )->fetchAll();
        foreach ($types as &$t) {
            $t['sort_order'] = (int) $t['sort_order'];
            $t['is_active'] = (bool) $t['is_active'];
        }
        unset($t);
    }
    return $types;
}

function visa_type_by_slug(string $slug): ?array
{
    foreach (visa_types_all() as $t) {
        if ($t['slug'] === $slug) {
            return $t;
        }
    }
    return null;
}

/** General FAQs (no country/visa-type tag). */
function faqs_general(): array
{
    static $faqs = null;
    if ($faqs === null) {
        $faqs = db()->query(
            'SELECT question, answer FROM visa_faqs
             WHERE is_active = 1 AND country_id IS NULL AND visa_type_id IS NULL
             ORDER BY sort_order'
        )->fetchAll();
    }
    return $faqs;
}

/** FAQs relevant to a specific country/visa-type page: general ones plus any tagged to that country or type. */
function fetch_relevant_faqs(?int $countryId = null, ?int $visaTypeId = null): array
{
    $stmt = db()->prepare(
        'SELECT question, answer FROM visa_faqs
         WHERE is_active = 1 AND (
             (country_id IS NULL AND visa_type_id IS NULL)
             OR country_id = :country_id
             OR visa_type_id = :visa_type_id
         )
         ORDER BY sort_order'
    );
    $stmt->execute(['country_id' => $countryId, 'visa_type_id' => $visaTypeId]);
    return $stmt->fetchAll();
}

/**
 * Embassy/consulate/VAC rows for a country. Returns empty arrays if
 * none are published yet — callers render an honest empty state,
 * never invent an address.
 */
function fetch_country_contact_points(int $countryId): array
{
    $embassies = db()->prepare('SELECT * FROM embassies WHERE country_id = :id ORDER BY name');
    $embassies->execute(['id' => $countryId]);

    $consulates = db()->prepare('SELECT * FROM consulates WHERE country_id = :id ORDER BY name');
    $consulates->execute(['id' => $countryId]);

    $vacs = db()->prepare('SELECT * FROM visa_application_centres WHERE country_id = :id ORDER BY name');
    $vacs->execute(['id' => $countryId]);

    return [
        'embassies' => $embassies->fetchAll(),
        'consulates' => $consulates->fetchAll(),
        'vac_centers' => $vacs->fetchAll(),
    ];
}

/** Verified requirement row for a country+visa-type pair, or null if not yet published. */
function fetch_visa_requirement(int $countryId, int $visaTypeId): ?array
{
    $stmt = db()->prepare('SELECT * FROM visa_requirements WHERE country_id = :country_id AND visa_type_id = :visa_type_id LIMIT 1');
    $stmt->execute(['country_id' => $countryId, 'visa_type_id' => $visaTypeId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

/**
 * Continent/region hub pages (/visa/{slug}) and the country-status
 * directories (/visa-status/{slug}) both group the same 208 real
 * countries by a stable membership flag rather than any per-country
 * visa policy fact — see database/schema-visa-portal.sql for why
 * these five flags (GCC/ASEAN/SAARC/Middle East/Caribbean) are safe
 * to hardcode while visa_policy_for_indians is not.
 */
const CONTINENT_HUBS = [
    'asia' => ['label' => 'Asia', 'region_slug' => 'asia'],
    'europe' => ['label' => 'Europe', 'region_slug' => 'europe'],
    'africa' => ['label' => 'Africa', 'region_slug' => 'africa'],
    'north-america' => ['label' => 'North America', 'region_slug' => 'north-america'],
    'south-america' => ['label' => 'South America', 'region_slug' => 'south-america'],
    'oceania' => ['label' => 'Oceania', 'region_slug' => 'oceania'],
    'middle-east' => ['label' => 'Middle East', 'flag_column' => 'is_middle_east'],
    'caribbean' => ['label' => 'Caribbean', 'flag_column' => 'is_caribbean'],
];

/** @return list<array<string,mixed>> */
function countries_by_continent_slug(string $slug): array
{
    if (!isset(CONTINENT_HUBS[$slug])) {
        return [];
    }
    $hub = CONTINENT_HUBS[$slug];

    if (isset($hub['region_slug'])) {
        $stmt = db()->prepare(
            'SELECT c.id, c.name, c.slug, c.iso2, c.iso3, r.name AS region, c.is_popular_destination, c.is_schengen
             FROM countries c JOIN regions r ON r.id = c.region_id
             WHERE c.is_active = 1 AND r.slug = :region_slug
             ORDER BY c.name'
        );
        $stmt->execute(['region_slug' => $hub['region_slug']]);
        return $stmt->fetchAll();
    }

    $column = $hub['flag_column'];
    $stmt = db()->query(
        "SELECT c.id, c.name, c.slug, c.iso2, c.iso3, r.name AS region, c.is_popular_destination, c.is_schengen
         FROM countries c LEFT JOIN regions r ON r.id = c.region_id
         WHERE c.is_active = 1 AND c.$column = 1
         ORDER BY c.name"
    );
    return $stmt->fetchAll();
}

/**
 * Visa-status directories (/visa-status/{slug}) — same "group by a
 * verifiable flag" approach. visa_policy_for_indians-backed slugs
 * only ever return countries a staff member has actually set that
 * field for (see AUDIT.md) — an empty result here means "not yet
 * verified for any country," never a false "none of these exist."
 */
const VISA_STATUS_DIRECTORIES = [
    'visa-free' => ['label' => 'Visa Free for Indians', 'policy_value' => 'visa_free'],
    'visa-on-arrival' => ['label' => 'Visa on Arrival', 'policy_value' => 'visa_on_arrival'],
    'evisa' => ['label' => 'eVisa Countries', 'policy_value' => 'evisa'],
    'schengen' => ['label' => 'Schengen Countries', 'flag_column' => 'is_schengen'],
    'gcc' => ['label' => 'GCC Countries', 'flag_column' => 'is_gcc'],
    'asean' => ['label' => 'ASEAN Countries', 'flag_column' => 'is_asean'],
    'saarc' => ['label' => 'SAARC Countries', 'flag_column' => 'is_saarc'],
];

/** @return list<array<string,mixed>> */
function countries_by_visa_status_slug(string $slug): array
{
    if (!isset(VISA_STATUS_DIRECTORIES[$slug])) {
        return [];
    }
    $dir = VISA_STATUS_DIRECTORIES[$slug];

    if (isset($dir['policy_value'])) {
        $stmt = db()->prepare(
            'SELECT c.id, c.name, c.slug, c.iso2, c.iso3, r.name AS region, c.is_popular_destination
             FROM countries c LEFT JOIN regions r ON r.id = c.region_id
             WHERE c.is_active = 1 AND c.visa_policy_for_indians = :policy
             ORDER BY c.name'
        );
        $stmt->execute(['policy' => $dir['policy_value']]);
        return $stmt->fetchAll();
    }

    $column = $dir['flag_column'];
    return db()->query(
        "SELECT c.id, c.name, c.slug, c.iso2, c.iso3, r.name AS region, c.is_popular_destination
         FROM countries c LEFT JOIN regions r ON r.id = c.region_id
         WHERE c.is_active = 1 AND c.$column = 1
         ORDER BY c.name"
    )->fetchAll();
}

/**
 * Single source of truth for the Country mega-menu — grouped by
 * region plus the popular-destination and Schengen-membership flags.
 */
function country_mega_menu_data(): array
{
    static $data = null;
    if ($data !== null) {
        return $data;
    }

    $byRegion = [];
    $popular = [];
    $schengen = [];
    foreach (countries_all() as $row) {
        $byRegion[$row['region']][] = $row;
        if ($row['is_popular_destination']) {
            $popular[] = $row;
        }
        if ($row['is_schengen']) {
            $schengen[] = $row;
        }
    }

    $data = [
        'by_region' => $byRegion,
        'popular' => $popular,
        'schengen' => $schengen,
        'total' => count(countries_all()),
    ];
    return $data;
}

/**
 * National Location SEO — states/UTs, cities, and location-scoped
 * FAQs. Same shape/caching convention as the country lookups above.
 * `states_all()`/`cities_by_state()` return every active row
 * (indexable or not) so admin previews and "cities we serve" listings
 * work; callers are responsible for checking `is_indexable` before
 * treating a page as safe to index (see visa-consultant/state.php and
 * city.php, which set $noindex accordingly).
 */

/** @return list<array<string,mixed>> */
function states_all(): array
{
    static $states = null;
    if ($states === null) {
        $states = db()->query(
            'SELECT id, name, slug, type, zone, intro_content, meta_title, meta_description,
                    is_indexable, is_active, sort_order
             FROM states WHERE is_active = 1 ORDER BY zone, name'
        )->fetchAll();
        foreach ($states as &$s) {
            $s['is_indexable'] = (bool) $s['is_indexable'];
            $s['is_active'] = (bool) $s['is_active'];
        }
        unset($s);
    }
    return $states;
}

function state_by_slug(string $slug): ?array
{
    foreach (states_all() as $s) {
        if ($s['slug'] === $slug) {
            return $s;
        }
    }
    return null;
}

/** @return list<array<string,mixed>> */
function cities_by_state(int $stateId): array
{
    static $cache = [];
    if (!isset($cache[$stateId])) {
        $stmt = db()->prepare(
            'SELECT id, state_id, name, slug, is_major, intro_content, office_address,
                    meta_title, meta_description, is_indexable, is_active, sort_order
             FROM cities WHERE state_id = :state_id AND is_active = 1
             ORDER BY sort_order, name'
        );
        $stmt->execute(['state_id' => $stateId]);
        $rows = $stmt->fetchAll();
        foreach ($rows as &$c) {
            $c['is_major'] = (bool) $c['is_major'];
            $c['is_indexable'] = (bool) $c['is_indexable'];
            $c['is_active'] = (bool) $c['is_active'];
        }
        unset($c);
        $cache[$stateId] = $rows;
    }
    return $cache[$stateId];
}

function city_by_slug(int $stateId, string $slug): ?array
{
    foreach (cities_by_state($stateId) as $c) {
        if ($c['slug'] === $slug) {
            return $c;
        }
    }
    return null;
}

/** FAQs relevant to a state or city page: general location FAQs plus any tagged to that state or city. */
function location_faqs_for(?int $stateId = null, ?int $cityId = null): array
{
    $stmt = db()->prepare(
        'SELECT question, answer FROM location_faqs
         WHERE is_active = 1 AND (
             (state_id IS NULL AND city_id IS NULL)
             OR state_id = :state_id
             OR city_id = :city_id
         )
         ORDER BY sort_order'
    );
    $stmt->execute(['state_id' => $stateId, 'city_id' => $cityId]);
    return $stmt->fetchAll();
}
