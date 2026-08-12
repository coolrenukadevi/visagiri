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
