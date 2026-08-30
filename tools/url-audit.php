<?php
/**
 * Automated URL / SEO audit — spec §15.
 *
 * Crawls every URL in the sitemap plus everything linked from the pages it
 * visits, and fails (exit 1) on anything that would hurt SEO in production:
 *
 *   - public-facing ".php" links in HTML
 *   - broken internal links (non-200)
 *   - redirect chains (>1 hop) and loops
 *   - canonical missing, or not matching the fetched URL
 *   - canonical / OG / schema / sitemap URLs containing ".php"
 *   - http:// (non-https) canonical or OG URLs
 *   - duplicate <title> across pages
 *
 * Usage:  php tools/url-audit.php [baseUrl]
 * Default base is the local dev server.
 */
declare(strict_types=1);

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8702', '/');
$problems = [];
$titles   = [];
$visited  = [];
$queue    = ['/'];

function fetch(string $url): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_TIMEOUT        => 10,
        CURLOPT_HEADER         => true,
    ]);
    $raw    = (string) curl_exec($ch);
    $status = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    $hlen   = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    curl_close($ch);
    $headers = substr($raw, 0, $hlen);
    $body    = substr($raw, $hlen);
    $loc = null;
    if (preg_match('/^Location:\s*(.+)$/mi', $headers, $m)) {
        $loc = trim($m[1]);
    }
    return ['status' => $status, 'body' => $body, 'location' => $loc];
}

// ---- 1. Sitemap must be clean -----------------------------------------
$sitemapUrls = [];
foreach (['/sitemap.xml', '/sitemap-pages.xml', '/sitemap-countries.xml'] as $sm) {
    $r = fetch($base . $sm);
    if ($r['status'] !== 200) {
        $problems[] = "sitemap $sm returned {$r['status']}";
        continue;
    }
    preg_match_all('#<loc>(.*?)</loc>#', $r['body'], $m);
    foreach ($m[1] as $loc) {
        $loc = html_entity_decode($loc);
        if (str_contains($loc, '.php')) {
            $problems[] = "sitemap contains .php URL: $loc";
        }
        if (str_starts_with($loc, 'http://')) {
            $problems[] = "sitemap contains non-HTTPS URL: $loc";
        }
        if (str_ends_with($sm, 'countries.xml') || str_ends_with($sm, 'pages.xml')) {
            $sitemapUrls[] = $loc;
        }
    }
}

// Map canonical sitemap URLs onto the local base so they are fetchable.
foreach ($sitemapUrls as $loc) {
    $path = parse_url($loc, PHP_URL_PATH) ?: '/';
    $queue[] = $path;
}

// ---- 2. Crawl ----------------------------------------------------------
while ($queue) {
    $path = array_shift($queue);
    if (isset($visited[$path])) {
        continue;
    }
    $visited[$path] = true;

    $r = fetch($base . $path);

    // redirect chain / loop detection
    $hops = 0;
    $cur  = $path;
    while ($r['status'] >= 300 && $r['status'] < 400 && $r['location']) {
        $hops++;
        $next = parse_url($r['location'], PHP_URL_PATH) ?: '/';
        if ($next === $cur) {
            $problems[] = "redirect loop at $cur";
            break;
        }
        if ($hops > 1) {
            $problems[] = "redirect chain (>1 hop) starting at $path";
            break;
        }
        $cur = $next;
        $r = fetch($base . $next);
    }

    if ($r['status'] !== 200) {
        $problems[] = "non-200 ($r[status]) for $path";
        continue;
    }
    // After following a redirect, all page-level checks below must run against
    // the FINAL url ($cur), not the originally-requested one — otherwise every
    // legitimate 301 reports a bogus "canonical mismatch".
    $effective = $cur;
    if ($effective !== $path) {
        if (isset($visited[$effective])) {
            continue; // destination already audited on its own
        }
        $visited[$effective] = true;
    }
    if (!str_contains((string) $r['body'], '<html')) {
        continue; // xml/text resource
    }

    $body = $r['body'];

    // canonical present, https, no .php, self-referencing
    if (!preg_match('#<link rel="canonical" href="([^"]+)"#', $body, $cm)) {
        $problems[] = "missing canonical on $path";
    } else {
        $canon = $cm[1];
        if (str_contains($canon, '.php'))       $problems[] = "canonical contains .php on $path ($canon)";
        if (str_starts_with($canon, 'http://')) $problems[] = "canonical not HTTPS on $path ($canon)";
        $canonPath = parse_url($canon, PHP_URL_PATH) ?: '/';
        if ($canonPath !== $effective) {
            $problems[] = "canonical mismatch on $effective -> $canonPath";
        }
    }

    // OG + schema URLs
    if (preg_match('#<meta property="og:url" content="([^"]+)"#', $body, $om)) {
        if (str_contains($om[1], '.php'))       $problems[] = "og:url contains .php on $path";
        if (str_starts_with($om[1], 'http://')) $problems[] = "og:url not HTTPS on $path";
    }
    if (preg_match_all('#"(?:item|url|@id)"\s*:\s*"([^"]+)"#', $body, $sm2)) {
        foreach ($sm2[1] as $u) {
            if (str_contains($u, '.php')) { $problems[] = "schema URL contains .php on $path ($u)"; break; }
        }
    }

    // duplicate titles
    if (preg_match('#<title>(.*?)</title>#s', $body, $tm)) {
        $t = trim($tm[1]);
        if (isset($titles[$t])) {
            $problems[] = "duplicate <title> on $effective and {$titles[$t]}";
        } else {
            $titles[$t] = $effective;
        }
    }

    // internal links: collect + flag .php
    // Delimiter is ~ not # — the character class contains a literal '#',
    // which silently terminated the pattern when # was the delimiter.
    preg_match_all('~href="(/[^"#?]*)~', $body, $lm);
    foreach (array_unique($lm[1]) as $href) {
        if (str_contains($href, '.php')) {
            $problems[] = "public .php link on $path -> $href";
        }
        // Only follow site pages, not assets
        if (!preg_match('#^/(css|js|assets|images)/#', $href) && !isset($visited[$href])) {
            $queue[] = $href;
        }
    }
}

// ---- 3. Report ---------------------------------------------------------
$problems = array_values(array_unique($problems));
printf("Crawled %d URLs against %s\n", count($visited), $base);
if (!$problems) {
    echo "PASS — no .php links, no broken links, no redirect chains, canonicals clean.\n";
    exit(0);
}
echo "FAIL — " . count($problems) . " problem(s):\n";
foreach ($problems as $p) {
    echo "  - $p\n";
}
exit(1);
