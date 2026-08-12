<?php
declare(strict_types=1);

/**
 * Static catalog data — countries, visa types, and FAQs are no longer
 * served from MySQL (see AUDIT.md, "Single-folder no-database
 * rebuild"). The data itself is real: a one-time export of the actual
 * rows that were seeded into the database across Phases 5-90 (208
 * countries with real ISO codes/regions, 9 visa types, 5 general
 * FAQs), not fabricated. data/*.php each `return` a plain array
 * literal; these functions are the only place that reads them, so
 * every consumer (header mega-menu, /countries/, /visa/, /visa-type/,
 * /faq/, sitemap) goes through one cached lookup instead of its own
 * copy of the array.
 */

/** @return list<array{name:string,slug:string,iso2:?string,iso3:?string,region:?string,is_popular_destination:bool,is_schengen:bool,is_active:bool}> */
function countries_all(): array
{
    static $countries = null;
    if ($countries === null) {
        $countries = array_values(array_filter(
            require __DIR__ . '/../data/countries.php',
            static fn(array $c): bool => $c['is_active']
        ));
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

/** @return list<array{name:string,slug:string,description:?string,icon:?string,sort_order:int,is_active:bool}> */
function visa_types_all(): array
{
    static $types = null;
    if ($types === null) {
        $types = require __DIR__ . '/../data/visa-types.php';
        $types = array_values(array_filter($types, static fn(array $t): bool => $t['is_active']));
        usort($types, static fn(array $a, array $b): int => $a['sort_order'] <=> $b['sort_order']);
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

/** General FAQs — none of the real rows were ever tagged to a specific country/visa type, so this is the full active set. */
function faqs_general(): array
{
    static $faqs = null;
    if ($faqs === null) {
        $faqs = require __DIR__ . '/../data/faqs.php';
        $faqs = array_values(array_filter($faqs, static fn(array $f): bool => $f['is_active']));
        usort($faqs, static fn(array $a, array $b): int => $a['sort_order'] <=> $b['sort_order']);
    }
    return $faqs;
}

/**
 * Embassy/consulate/VAC contact points. The embassies/consulates/
 * vac_centers tables were always empty in the database this replaces
 * — no real address was ever entered for any country — so this
 * always returns the honest empty state rather than fabricating a
 * location. Kept as a function (not inlined at call sites) so the
 * three callers (visa overview, visa detail) share one place to wire
 * in real data later if it's ever sourced.
 */
function fetch_country_contact_points(): array
{
    return ['embassies' => [], 'consulates' => [], 'vac_centers' => []];
}

/**
 * Single source of truth for the Country mega-menu — grouped by
 * region plus the popular-destination and Schengen-membership flags.
 * Same shape as the DB-backed version this replaces.
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
