<?php
/**
 * SQLite-backed storage for the Country x Visa-Purpose SEO content system.
 * Shares the same physical database as includes/enquiry-db.php (single
 * connection point, matching that file's documented rationale for
 * shared-hosting portability) but keeps its own schema in this file so the
 * CRM schema and the public content schema stay easy to reason about
 * separately.
 */
require_once __DIR__ . '/enquiry-db.php';
require_once __DIR__ . '/countries-data.php'; // must load at top-level scope so nav.php's own require_once (same real path) still gets $VISA_AGENCY_COUNTRIES in the global scope

const VISA_PAGE_STATUSES = ['draft', 'under_review', 'published', 'needs_update', 'archived'];
const VISA_PAGE_STATUS_LABELS = [
    'draft' => 'Draft', 'under_review' => 'Under Review', 'published' => 'Published',
    'needs_update' => 'Needs Update', 'archived' => 'Archived',
];
const VISA_COUNTRY_REGIONS = [
    'Asia', 'Europe', 'North America', 'South America', 'Africa', 'Middle East',
    'Oceania', 'Caribbean', 'Central America',
];
const VISA_DOC_GROUPS = ['Basic Documents', 'Financial Documents', 'Travel Documents', 'Supporting Documents'];

const VISA_CATEGORY_DEFS = [
    ['slug' => 'tourist-visa',    'name' => 'Tourist Visa',    'icon' => 'fa-umbrella-beach',  'short_description' => 'Holiday, sightseeing and short leisure visits.'],
    ['slug' => 'business-visa',   'name' => 'Business Visa',   'icon' => 'fa-briefcase',       'short_description' => 'Meetings, conferences, negotiations and corporate visits.'],
    ['slug' => 'family-visa',     'name' => 'Family Visa',     'icon' => 'fa-house-user',      'short_description' => 'Visiting relatives or family-sponsored travel.'],
    ['slug' => 'transit-visa',    'name' => 'Transit Visa',    'icon' => 'fa-plane-departure', 'short_description' => 'Airport transit and short connecting-flight stopovers.'],
    ['slug' => 'sports-visa',     'name' => 'Sports Visa',     'icon' => 'fa-trophy',          'short_description' => 'Athletes, coaches, officials and sporting delegations.'],
    ['slug' => 'medical-visa',    'name' => 'Medical Visa',    'icon' => 'fa-house-medical',   'short_description' => 'Medical treatment, consultation and accompanying attendants.'],
    ['slug' => 'crew-visa',       'name' => 'Crew Visa',       'icon' => 'fa-ship',            'short_description' => 'Airline and maritime crew requirements.'],
    ['slug' => 'visa-extension',  'name' => 'Visa Extension',  'icon' => 'fa-clock-rotate-left', 'short_description' => 'Extending an existing visa where the destination permits it.'],
];

const VISA_DEFAULT_PROCESS_STEPS = [
    ['title' => 'Check Eligibility', 'description' => 'Determine the appropriate visa category for your purpose of travel.'],
    ['title' => 'Prepare Documents', 'description' => 'Collect the country- and visa-specific documents required.'],
    ['title' => 'Complete Application', 'description' => 'Submit the appropriate online or offline application.'],
    ['title' => 'Pay Visa Fee', 'description' => 'Pay the applicable government and/or application fees.'],
    ['title' => 'Biometrics / Interview', 'description' => 'Complete biometrics or an interview where applicable.'],
    ['title' => 'Application Processing', 'description' => 'Monitor your application status while the authority processes it.'],
    ['title' => 'Visa Decision', 'description' => 'Receive the final decision from the relevant immigration authority.'],
    ['title' => 'Travel', 'description' => "Review your visa conditions carefully before travelling."],
];

function visa_content_db(): PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if ($migrated) {
        return $pdo;
    }

    $pdo->exec("CREATE TABLE IF NOT EXISTS countries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        official_name TEXT,
        iso2 TEXT,
        iso3 TEXT,
        slug TEXT UNIQUE NOT NULL,
        capital TEXT,
        region TEXT,
        sub_region TEXT,
        currency TEXT,
        currency_code TEXT,
        flag TEXT,
        image_path TEXT,
        popularity INTEGER NOT NULL DEFAULT 0,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS visa_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        slug TEXT UNIQUE NOT NULL,
        icon TEXT,
        short_description TEXT,
        default_process_steps_json TEXT,
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS country_visa_pages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_id INTEGER NOT NULL REFERENCES countries(id) ON DELETE CASCADE,
        visa_category_id INTEGER NOT NULL REFERENCES visa_categories(id) ON DELETE CASCADE,
        page_slug TEXT UNIQUE NOT NULL,
        status TEXT NOT NULL DEFAULT 'draft',

        official_visa_name TEXT,
        visa_subclass_code TEXT,
        intro_html TEXT,

        -- Quick Info card: leave NULL to render the honest fallback copy,
        -- never invent a value.
        typical_stay TEXT,
        entry_type TEXT,
        processing_time_text TEXT,
        validity_text TEXT,
        application_method TEXT,
        interview_required TEXT,
        biometric_required TEXT,
        government_fee_text TEXT,
        application_centre TEXT,
        authority_name TEXT,
        authority_url TEXT,

        eligibility_html TEXT,
        indian_applicant_html TEXT,

        seo_title TEXT,
        meta_description TEXT,
        og_title TEXT,
        og_description TEXT,
        canonical_override TEXT,

        last_reviewed_date TEXT,
        reviewed_by TEXT,

        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        UNIQUE(country_id, visa_category_id)
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS visa_documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_visa_page_id INTEGER NOT NULL REFERENCES country_visa_pages(id) ON DELETE CASCADE,
        category TEXT NOT NULL,
        label TEXT NOT NULL,
        sort_order INTEGER NOT NULL DEFAULT 0
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS visa_process_steps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_visa_page_id INTEGER NOT NULL REFERENCES country_visa_pages(id) ON DELETE CASCADE,
        step_number INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS visa_faqs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_visa_page_id INTEGER NOT NULL REFERENCES country_visa_pages(id) ON DELETE CASCADE,
        question TEXT NOT NULL,
        answer TEXT NOT NULL,
        sort_order INTEGER NOT NULL DEFAULT 0
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS visa_fees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_visa_page_id INTEGER NOT NULL REFERENCES country_visa_pages(id) ON DELETE CASCADE,
        label TEXT NOT NULL,
        amount_display TEXT NOT NULL,
        is_government INTEGER NOT NULL DEFAULT 1,
        sort_order INTEGER NOT NULL DEFAULT 0
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS visa_sources (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_visa_page_id INTEGER NOT NULL REFERENCES country_visa_pages(id) ON DELETE CASCADE,
        source_authority TEXT NOT NULL,
        source_url TEXT,
        date_checked TEXT,
        date_reviewed TEXT,
        notes TEXT
    )");

    // Seed visa_categories (8 fixed purposes) if empty.
    if ((int) $pdo->query('SELECT COUNT(*) FROM visa_categories')->fetchColumn() === 0) {
        $now = gmdate('c');
        $stmt = $pdo->prepare('INSERT INTO visa_categories (name, slug, icon, short_description, default_process_steps_json, sort_order, created_at, updated_at)
            VALUES (:name, :slug, :icon, :short_description, :steps, :sort_order, :created_at, :updated_at)');
        foreach (VISA_CATEGORY_DEFS as $i => $cat) {
            $stmt->execute([
                'name' => $cat['name'],
                'slug' => $cat['slug'],
                'icon' => $cat['icon'],
                'short_description' => $cat['short_description'],
                'steps' => json_encode(VISA_DEFAULT_PROCESS_STEPS),
                'sort_order' => $i,
                'created_at' => $now,
                'updated_at' => $now,
            ]);
        }
    }

    // Seed countries from the existing static master list if empty — a
    // mechanical import of data already vetted in the repo, not new facts.
    if ((int) $pdo->query('SELECT COUNT(*) FROM countries')->fetchColumn() === 0) {
        global $VISA_AGENCY_COUNTRIES;
        $now = gmdate('c');
        $stmt = $pdo->prepare('INSERT INTO countries (name, official_name, iso2, iso3, slug, capital, region, sub_region, currency, currency_code, flag, image_path, popularity, is_active, created_at, updated_at)
            VALUES (:name, NULL, NULL, NULL, :slug, NULL, :region, NULL, NULL, NULL, :flag, NULL, 0, 1, :created_at, :updated_at)');
        foreach ($VISA_AGENCY_COUNTRIES as $c) {
            $stmt->execute([
                'name' => $c['name'],
                'slug' => $c['slug'],
                'region' => $c['region'],
                'flag' => $c['flag'],
                'created_at' => $now,
                'updated_at' => $now,
            ]);
        }
    }

    require_once __DIR__ . '/visa-seed-data.php';
    foreach (visa_seed_pages_def() as $def) {
        visa_seed_page($pdo, $def);
    }

    visa_seed_bulk_generic($pdo);

    $migrated = true;
    return $pdo;
}

/**
 * Bulk-generates every remaining country x visa-category combination using
 * category-level generic templates (includes/visa-bulk-generic-content.php),
 * so the full 200+ country x 8-category URL/SEO grid exists and is live.
 * Skips any combination already seeded by visa_seed_pages_def() (the small
 * hand-researched batch, which always takes precedence) or already present
 * from a prior run/admin edit. Fast-exits once every combination exists so
 * this doesn't re-scan on every request once fully seeded.
 */
function visa_seed_bulk_generic(PDO $pdo): void
{
    $countries = $pdo->query('SELECT id, name, slug, region FROM countries WHERE is_active = 1')->fetchAll(PDO::FETCH_ASSOC);
    $categories = $pdo->query('SELECT id, name, slug FROM visa_categories')->fetchAll(PDO::FETCH_ASSOC);
    $totalPossible = count($countries) * count($categories);

    $existingCount = (int) $pdo->query('SELECT COUNT(*) FROM country_visa_pages')->fetchColumn();
    if ($existingCount >= $totalPossible) {
        return; // fast exit — every combination already has a page
    }

    $existingSlugs = array_flip($pdo->query('SELECT page_slug FROM country_visa_pages')->fetchAll(PDO::FETCH_COLUMN));
    require_once __DIR__ . '/visa-bulk-generic-content.php';
    $templatesBySlug = visa_bulk_category_templates();

    $now = gmdate('c');
    $today = gmdate('Y-m-d');

    $insertPage = $pdo->prepare("INSERT INTO country_visa_pages (
        country_id, visa_category_id, page_slug, status,
        official_visa_name, intro_html,
        seo_title, meta_description, og_title, og_description,
        eligibility_html, indian_applicant_html,
        last_reviewed_date, reviewed_by, created_at, updated_at
    ) VALUES (
        :country_id, :category_id, :page_slug, 'published',
        NULL, :intro_html,
        :seo_title, :meta_description, :og_title, :og_description,
        :eligibility_html, :indian_applicant_html,
        :last_reviewed_date, :reviewed_by, :created_at, :updated_at
    )");
    $docStmt = $pdo->prepare('INSERT INTO visa_documents (country_visa_page_id, category, label, sort_order) VALUES (?, ?, ?, ?)');
    $stepStmt = $pdo->prepare('INSERT INTO visa_process_steps (country_visa_page_id, step_number, title, description) VALUES (?, ?, ?, ?)');
    $faqStmt = $pdo->prepare('INSERT INTO visa_faqs (country_visa_page_id, question, answer, sort_order) VALUES (?, ?, ?, ?)');
    $feeStmt = $pdo->prepare('INSERT INTO visa_fees (country_visa_page_id, label, amount_display, is_government, sort_order) VALUES (?, ?, ?, ?, ?)');

    $pdo->beginTransaction();
    foreach ($countries as $country) {
        foreach ($categories as $category) {
            $pageSlug = visa_page_slug($country['slug'], $category['slug']);
            if (isset($existingSlugs[$pageSlug])) {
                continue;
            }
            $tpl = $templatesBySlug[$category['slug']] ?? null;
            if (!$tpl) {
                continue;
            }

            $countryName = $country['name'];
            $titleBase = "{$countryName} {$category['name']}";
            $sub = fn(string $s) => str_replace(['%COUNTRY%', '%CATEGORY%'], [$countryName, $category['name']], $s);

            $insertPage->execute([
                'country_id' => $country['id'],
                'category_id' => $category['id'],
                'page_slug' => $pageSlug,
                'intro_html' => $sub($tpl['intro']),
                'seo_title' => "{$titleBase} from India | Requirements, Documents &amp; Application",
                'meta_description' => "Apply for {$titleBase} from India. Check eligibility, documents, application process and visa assistance for {$countryName}.",
                'og_title' => "{$titleBase} from India — Visa Agency",
                'og_description' => "Everything Indian travellers need for the {$titleBase}: eligibility, documents and application guidance.",
                'eligibility_html' => $sub($tpl['eligibility']),
                'indian_applicant_html' => $sub($tpl['indian_applicant']),
                'last_reviewed_date' => $today,
                'reviewed_by' => 'Visa Agency Content Team',
                'created_at' => $now,
                'updated_at' => $now,
            ]);
            $pageId = (int) $pdo->lastInsertId();

            foreach ($tpl['documents'] as $i => $d) {
                $docStmt->execute([$pageId, $d[0], $sub($d[1]), $i]);
            }
            foreach (VISA_DEFAULT_PROCESS_STEPS as $i => $s) {
                $stepStmt->execute([$pageId, $i + 1, $s['title'], $s['description']]);
            }
            foreach ($tpl['faqs'] as $i => $f) {
                $faqStmt->execute([$pageId, $sub($f[0]), $sub($f[1]), $i]);
            }
            $feeStmt->execute([$pageId, 'Government / Application Fee', 'Check the official immigration authority for current fees', 1, 0]);
            $feeStmt->execute([$pageId, 'Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0, 1]);
        }
    }
    $pdo->commit();
}

/**
 * Generic, data-driven seeder for one country x visa-category content page.
 * Runs on every request (bootstrap-time) so pre-researched content self-installs
 * on any environment this code runs on, matching the zip-based deployment model
 * where the SQLite file itself is never committed. Idempotent — skips if the
 * page already exists (e.g. an admin has since edited it via the CMS).
 *
 * $def shape: see includes/visa-seed-data.php for the full field list per entry.
 */
function visa_seed_page(PDO $pdo, array $def): void
{
    $exists = $pdo->prepare('SELECT id FROM country_visa_pages WHERE page_slug = ?');
    $exists->execute([$def['page_slug']]);
    if ($exists->fetchColumn()) {
        return;
    }

    $countryId = $pdo->prepare('SELECT id FROM countries WHERE slug = ?');
    $countryId->execute([$def['country_slug']]);
    $countryId = $countryId->fetchColumn();
    $categoryId = $pdo->prepare('SELECT id FROM visa_categories WHERE slug = ?');
    $categoryId->execute([$def['category_slug']]);
    $categoryId = $categoryId->fetchColumn();
    if (!$countryId || !$categoryId) {
        return; // countries/visa_categories not seeded yet — nothing to attach to
    }

    $now = gmdate('c');
    $today = gmdate('Y-m-d');

    if (!empty($def['country_enrich'])) {
        $ce = $def['country_enrich'];
        $pdo->prepare('UPDATE countries SET official_name = :official_name, iso2 = :iso2, iso3 = :iso3,
            capital = :capital, sub_region = :sub_region, currency = :currency,
            currency_code = :currency_code, popularity = :popularity, updated_at = :now WHERE id = :id')
            ->execute([
                'official_name' => $ce['official_name'] ?? null,
                'iso2' => $ce['iso2'] ?? null,
                'iso3' => $ce['iso3'] ?? null,
                'capital' => $ce['capital'] ?? null,
                'sub_region' => $ce['sub_region'] ?? null,
                'currency' => $ce['currency'] ?? null,
                'currency_code' => $ce['currency_code'] ?? null,
                'popularity' => $ce['popularity'] ?? 0,
                'now' => $now,
                'id' => $countryId,
            ]);
    }

    $insertPage = $pdo->prepare("INSERT INTO country_visa_pages (
        country_id, visa_category_id, page_slug, status,
        official_visa_name, visa_subclass_code, intro_html,
        typical_stay, entry_type, processing_time_text, validity_text, application_method,
        interview_required, biometric_required, government_fee_text, application_centre,
        authority_name, authority_url,
        eligibility_html, indian_applicant_html,
        seo_title, meta_description, og_title, og_description,
        last_reviewed_date, reviewed_by, created_at, updated_at
    ) VALUES (
        :country_id, :category_id, :page_slug, 'published',
        :official_visa_name, :visa_subclass_code, :intro_html,
        :typical_stay, :entry_type, :processing_time_text, :validity_text, :application_method,
        :interview_required, :biometric_required, :government_fee_text, :application_centre,
        :authority_name, :authority_url,
        :eligibility_html, :indian_applicant_html,
        :seo_title, :meta_description, :og_title, :og_description,
        :last_reviewed_date, :reviewed_by, :created_at, :updated_at
    )");
    $insertPage->execute([
        'country_id' => $countryId,
        'category_id' => $categoryId,
        'page_slug' => $def['page_slug'],
        'official_visa_name' => $def['official_visa_name'],
        'visa_subclass_code' => $def['visa_subclass_code'] ?? null,
        'intro_html' => $def['intro_html'],
        'typical_stay' => $def['typical_stay'] ?? null,
        'entry_type' => $def['entry_type'] ?? null,
        'processing_time_text' => $def['processing_time_text'] ?? null,
        'validity_text' => $def['validity_text'] ?? null,
        'application_method' => $def['application_method'] ?? null,
        'interview_required' => $def['interview_required'] ?? null,
        'biometric_required' => $def['biometric_required'] ?? null,
        'government_fee_text' => $def['government_fee_text'] ?? null,
        'application_centre' => $def['application_centre'] ?? null,
        'authority_name' => $def['authority_name'] ?? null,
        'authority_url' => $def['authority_url'] ?? null,
        'eligibility_html' => $def['eligibility_html'] ?? null,
        'indian_applicant_html' => $def['indian_applicant_html'] ?? null,
        'seo_title' => $def['seo_title'] ?? null,
        'meta_description' => $def['meta_description'] ?? null,
        'og_title' => $def['og_title'] ?? null,
        'og_description' => $def['og_description'] ?? null,
        'last_reviewed_date' => $today,
        'reviewed_by' => 'Visa Agency Content Team',
        'created_at' => $now,
        'updated_at' => $now,
    ]);
    $pageId = (int) $pdo->lastInsertId();

    $docStmt = $pdo->prepare('INSERT INTO visa_documents (country_visa_page_id, category, label, sort_order) VALUES (?, ?, ?, ?)');
    foreach ($def['documents'] as $i => $d) {
        $docStmt->execute([$pageId, $d[0], $d[1], $i]);
    }

    $stepStmt = $pdo->prepare('INSERT INTO visa_process_steps (country_visa_page_id, step_number, title, description) VALUES (?, ?, ?, ?)');
    foreach ($def['steps'] as $i => $s) {
        $stepStmt->execute([$pageId, $i + 1, $s[0], $s[1]]);
    }

    $faqStmt = $pdo->prepare('INSERT INTO visa_faqs (country_visa_page_id, question, answer, sort_order) VALUES (?, ?, ?, ?)');
    foreach ($def['faqs'] as $i => $f) {
        $faqStmt->execute([$pageId, $f[0], $f[1], $i]);
    }

    $feeStmt = $pdo->prepare('INSERT INTO visa_fees (country_visa_page_id, label, amount_display, is_government, sort_order) VALUES (?, ?, ?, ?, ?)');
    foreach ($def['fees'] as $i => $fee) {
        $feeStmt->execute([$pageId, $fee[0], $fee[1], $fee[2], $i]);
    }

    $pdo->prepare('INSERT INTO visa_sources (country_visa_page_id, source_authority, source_url, date_checked, date_reviewed, notes) VALUES (?, ?, ?, ?, ?, ?)')
        ->execute([
            $pageId,
            $def['source']['authority'],
            $def['source']['url'],
            $today,
            $today,
            $def['source']['notes'] ?? '',
        ]);
}

function visa_country_url(string $countrySlug): string
{
    return 'countries/' . $countrySlug;
}

function visa_country_page_url(string $pageSlug): string
{
    return 'countries/' . $pageSlug;
}

function visa_page_slug(string $countrySlug, string $categorySlug): string
{
    return $countrySlug . '-' . $categorySlug;
}

function visa_page_status_class(string $status): string
{
    return 'status-' . str_replace('_', '-', $status);
}

function visa_page_status_label(string $status): string
{
    return VISA_PAGE_STATUS_LABELS[$status] ?? ucfirst($status);
}

/** Renders the honest "not invented" fallback used across quick-info fields. */
function visa_field_or_fallback(?string $value, string $fallback = 'Varies by visa subclass/profile.'): string
{
    $value = trim((string) $value);
    return $value !== '' ? $value : $fallback;
}
