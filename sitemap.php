<?php
/**
 * XML sitemap generator.
 *
 *   /sitemap.xml            -> sitemap index
 *   /sitemap-pages.xml      -> static pages
 *   /sitemap-countries.xml  -> the 216 country guides
 *
 * Every URL emitted here is the canonical clean URL built by canonical():
 * absolute, HTTPS, preferred host, no ".php", no query string, no trailing
 * slash. There is no separate list to keep in sync — the country set comes
 * from the same data the pages render from, so the sitemap cannot drift.
 */
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/data.php';
require_once __DIR__ . '/data/pages.php';

header('Content-Type: application/xml; charset=UTF-8');

$set = (string) ($_GET['set'] ?? '');

/** @return array<int,array{loc:string,changefreq:string,priority:string}> */
function visa_type_slugs(): array
{
    require_once __DIR__ . '/visa-type-slugs.php';
    return VISA_TYPE_SLUG_LIST;
}

function pages_urls(): array
{
    $urls = [
        ['loc' => canonical('/'),                  'changefreq' => 'weekly',  'priority' => '1.0'],
        ['loc' => canonical('/countries'),         'changefreq' => 'weekly',  'priority' => '0.9'],
        ['loc' => canonical('/visa-finder'),       'changefreq' => 'weekly',  'priority' => '0.9'],
        ['loc' => canonical('/payments'),          'changefreq' => 'monthly', 'priority' => '0.5'],
        ['loc' => canonical('/visa/request-info'), 'changefreq' => 'monthly', 'priority' => '0.5'],
        // /login is a real, stable page worth indexing. /account, /auth/* and
        // /logout are deliberately absent — per-user or single-use, and
        // robots.txt disallows them.
        ['loc' => canonical('/login'),             'changefreq' => 'yearly',  'priority' => '0.3'],
    ];
    // Visa category pages
    foreach (array_keys(visa_type_slugs()) as $t) {
        $urls[] = ['loc' => canonical('/visa/' . $t), 'changefreq' => 'monthly', 'priority' => '0.8'];
    }
    // Every content page defined in data/pages.php, minus the ones already above.
    $seen = array_column($urls, 'loc');
    foreach (array_keys(page_definitions()) as $slug) {
        $loc = canonical('/' . $slug);
        if (in_array($loc, $seen, true)) continue;
        // Legal pages are indexable but low priority; everything else mid.
        $urls[] = ['loc' => $loc, 'changefreq' => 'monthly', 'priority' => '0.6'];
    }
    return $urls;
}

function countries_urls(): array
{
    $out = [];
    foreach (all_countries() as $c) {
        $out[] = ['loc' => canonical('/visa/' . $c['slug']), 'changefreq' => 'weekly', 'priority' => '0.8'];
    }
    return $out;
}

function emit_urlset(array $urls): void
{
    echo '<?xml version="1.0" encoding="UTF-8"?>', "\n";
    echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">', "\n";
    foreach ($urls as $u) {
        printf(
            "  <url><loc>%s</loc><changefreq>%s</changefreq><priority>%s</priority></url>\n",
            htmlspecialchars($u['loc'], ENT_XML1 | ENT_QUOTES, 'UTF-8'),
            $u['changefreq'],
            $u['priority']
        );
    }
    echo '</urlset>', "\n";
}

switch ($set) {
    case 'pages':
        emit_urlset(pages_urls());
        break;

    case 'countries':
        emit_urlset(countries_urls());
        break;

    case '':
        // Sitemap index. Only two children today; the split is here because a
        // 216-country set will keep growing and this avoids a later migration.
        $lastmod = gmdate('Y-m-d');
        echo '<?xml version="1.0" encoding="UTF-8"?>', "\n";
        echo '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">', "\n";
        foreach (['pages', 'countries'] as $child) {
            printf(
                "  <sitemap><loc>%s</loc><lastmod>%s</lastmod></sitemap>\n",
                htmlspecialchars(canonical("/sitemap-{$child}.xml"), ENT_XML1 | ENT_QUOTES, 'UTF-8'),
                $lastmod
            );
        }
        echo '</sitemapindex>', "\n";
        break;

    default:
        http_response_code(404);
        echo '<?xml version="1.0" encoding="UTF-8"?><error>Unknown sitemap set</error>';
}
