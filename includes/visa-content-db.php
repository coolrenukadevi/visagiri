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

    visa_seed_australia_tourist($pdo);

    $migrated = true;
    return $pdo;
}

/**
 * Seeds the one fully-researched sample page (Australia Tourist Visa) so it
 * renders on any environment this code runs on, not just the session that
 * happened to write to a local, gitignored SQLite file. Idempotent — skips
 * if the page already exists (e.g. an admin has since edited it).
 */
function visa_seed_australia_tourist(PDO $pdo): void
{
    $exists = $pdo->prepare('SELECT id FROM country_visa_pages WHERE page_slug = ?');
    $exists->execute(['australia-tourist-visa']);
    if ($exists->fetchColumn()) {
        return;
    }

    $countryId = $pdo->query("SELECT id FROM countries WHERE slug = 'australia'")->fetchColumn();
    $categoryId = $pdo->query("SELECT id FROM visa_categories WHERE slug = 'tourist-visa'")->fetchColumn();
    if (!$countryId || !$categoryId) {
        return; // countries/visa_categories not seeded yet — nothing to attach to
    }

    $now = gmdate('c');
    $today = gmdate('Y-m-d');

    $pdo->prepare("UPDATE countries SET official_name = 'Commonwealth of Australia', iso2 = 'AU', iso3 = 'AUS',
        capital = 'Canberra', sub_region = 'Australia and New Zealand', currency = 'Australian Dollar',
        currency_code = 'AUD', popularity = 90, updated_at = :now WHERE id = :id")
        ->execute(['now' => $now, 'id' => $countryId]);

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
        :typical_stay, :entry_type, NULL, :validity_text, :application_method,
        :interview_required, :biometric_required, NULL, :application_centre,
        :authority_name, :authority_url,
        :eligibility_html, :indian_applicant_html,
        :seo_title, :meta_description, :og_title, :og_description,
        :last_reviewed_date, :reviewed_by, :created_at, :updated_at
    )");
    $insertPage->execute([
        'country_id' => $countryId,
        'category_id' => $categoryId,
        'page_slug' => 'australia-tourist-visa',
        'official_visa_name' => 'Visitor visa (subclass 600) — Tourist stream',
        'visa_subclass_code' => 'Subclass 600 (Tourist stream)',
        'intro_html' => "The Visitor visa (subclass 600), Tourist stream, is Australia's standard visa category for Indian citizens travelling for a holiday, sightseeing or to visit family and friends. Indian passport holders are not eligible for Australia's ETA or eVisitor visas, so tourist travel requires this online visa application through the Department of Home Affairs. VisaAgency.in helps you prepare a complete, well-documented application.",
        'typical_stay' => 'Typically 3, 6 or 12 months, as specified on your visa grant',
        'entry_type' => 'Single or multiple entry, as granted',
        'validity_text' => 'As specified on your visa grant notice',
        'application_method' => 'Online via ImmiAccount (Department of Home Affairs)',
        'interview_required' => 'Not usually, but may be requested in individual cases',
        'biometric_required' => 'May be required at a Visa Application Centre — check when you apply',
        'application_centre' => 'VFS Global Australia Visa Application Centre (India)',
        'authority_name' => 'Australian Government Department of Home Affairs',
        'authority_url' => 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600',
        'eligibility_html' => '<p>The Visitor visa (subclass 600), Tourist stream, is generally available to Indian passport holders who:</p>
<ul>
<li>Are travelling for genuine tourism &mdash; holidays, sightseeing, or visiting family and friends informally</li>
<li>Can demonstrate they intend to stay temporarily (the Department assesses this as part of the Genuine Temporary Entrant consideration)</li>
<li>Have sufficient funds to support themselves during the visit</li>
<li>Meet health and character requirements</li>
<li>Can show reasonable ties to India (employment, business, family or property) supporting an intention to return</li>
</ul>
<p>This is general guidance, not a guarantee of approval &mdash; every application is individually assessed by the Department of Home Affairs.</p>',
        'indian_applicant_html' => '<p>Indian citizens cannot use the ETA or eVisitor visa (these are limited to specific passport holders) and must apply for the Visitor visa (subclass 600) online through ImmiAccount. Commonly requested supporting evidence for Indian applicants includes:</p>
<ul>
<li>Bank statements and income tax returns showing financial capacity</li>
<li>Salary slips and an employer leave-approval letter (for salaried applicants), or business registration and financial documents (for self-employed applicants)</li>
<li>Evidence of ties to India, such as property, family or ongoing employment/business</li>
<li>Previous international travel history, where available</li>
<li>An invitation or contact details of family/friends in Australia, if visiting them</li>
</ul>
<p>Our consultants review your specific profile and help you present this evidence clearly before submission.</p>',
        'seo_title' => 'Australia Tourist Visa from India | Requirements, Documents &amp; Application',
        'meta_description' => 'Apply for an Australia Tourist Visa from India. Check eligibility, documents, application process, fees, processing information and visa assistance.',
        'og_title' => 'Australia Tourist Visa from India — Visa Agency',
        'og_description' => 'Everything Indian travellers need for the Australia Visitor visa (subclass 600) Tourist stream: eligibility, documents, fees, processing and application steps.',
        'last_reviewed_date' => $today,
        'reviewed_by' => 'Visa Agency Content Team',
        'created_at' => $now,
        'updated_at' => $now,
    ]);
    $pageId = (int) $pdo->lastInsertId();

    $docs = [
        ['Basic Documents', "Valid passport (at least 6 months' validity beyond intended stay)"],
        ['Basic Documents', 'Recent passport-style photograph'],
        ['Basic Documents', 'Completed online application via ImmiAccount'],
        ['Basic Documents', 'Government-issued identity documents (e.g. Aadhaar, PAN)'],
        ['Financial Documents', 'Bank statements (typically last 6 months)'],
        ['Financial Documents', 'Income tax returns (ITR)'],
        ['Financial Documents', 'Salary slips (salaried applicants) or business financial documents (self-employed)'],
        ['Travel Documents', 'Tentative travel itinerary'],
        ['Travel Documents', 'Hotel booking or accommodation details'],
        ['Travel Documents', 'Travel insurance (recommended)'],
        ['Supporting Documents', 'Employment leave-approval letter'],
        ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
        ['Supporting Documents', 'Previous visa or international travel history, if applicable'],
        ['Supporting Documents', 'Invitation or host details, if visiting family or friends'],
    ];
    $docStmt = $pdo->prepare('INSERT INTO visa_documents (country_visa_page_id, category, label, sort_order) VALUES (?, ?, ?, ?)');
    foreach ($docs as $i => $d) {
        $docStmt->execute([$pageId, $d[0], $d[1], $i]);
    }

    $steps = [
        ['Check Eligibility', 'Confirm the Visitor visa (subclass 600) Tourist stream is the right category for your trip.'],
        ['Create an ImmiAccount', "Register on the Department of Home Affairs' online portal to begin your application."],
        ['Prepare Documents', 'Gather your passport, financial evidence, travel itinerary and supporting documents.'],
        ['Lodge Application Online', 'Complete and submit your subclass 600 application with supporting documents through ImmiAccount.'],
        ['Pay the Visa Application Charge', 'Pay the government visa application charge as part of lodgement.'],
        ['Biometrics, If Requested', 'Provide biometrics at a Visa Application Centre if the Department requests it.'],
        ['Application Processing', 'The Department assesses your application — track status through ImmiAccount.'],
        ['Visa Decision &amp; Travel', 'Once granted, review your visa conditions (stay period, entries, work restrictions) before travelling.'],
    ];
    $stepStmt = $pdo->prepare('INSERT INTO visa_process_steps (country_visa_page_id, step_number, title, description) VALUES (?, ?, ?, ?)');
    foreach ($steps as $i => $s) {
        $stepStmt->execute([$pageId, $i + 1, $s[0], $s[1]]);
    }

    $faqs = [
        ['Do Indian citizens need a visa for Australia?', 'Yes. All Indian passport holders need a visa before travelling to Australia for tourism — Indians are not eligible for the ETA or eVisitor visa, which are limited to specific passport holders.'],
        ['Which visa should Indian tourists apply for?', 'The Visitor visa (subclass 600), Tourist stream, is the standard visa category for Indian citizens travelling to Australia for a holiday or to visit family and friends.'],
        ['How do I apply for an Australia Tourist Visa from India?', "Applications are lodged online through the Department of Home Affairs' ImmiAccount portal, with supporting documents uploaded electronically."],
        ['What documents are required?', 'A valid passport, photograph, financial evidence, travel itinerary and supporting documents demonstrating genuine tourism intent and ties to India — see the Documents section above for the full checklist.'],
        ['How long does processing take?', "Processing times vary by application volume and individual circumstances. Check the Department of Home Affairs' current published processing times before planning your travel dates."],
        ['How much does the visa cost?', "The government visa application charge is set by the Department of Home Affairs and may change — check their official fee estimator at the time you apply. VisaAgency's service fee is charged separately from the government fee."],
        ['Is an interview required?', 'An interview is not usually required, though the Department may request one or ask for additional information in individual cases.'],
        ['Are biometrics required?', 'Biometrics may be required depending on your application and location. Check current requirements when you apply, or ask your Visa Agency consultant.'],
        ['How long can I stay in Australia on this visa?', 'Stay duration is specified on your visa grant notice — typically 3, 6 or 12 months, depending on what is granted.'],
        ['Can I travel for business on a tourist visa?', 'No. The Tourist stream is intended for genuine tourism. Business activities such as meetings or conferences fall under the Business Visitor stream of the same subclass 600 visa — see our Australia Business Visa page.'],
        ['Can I extend an Australia Tourist Visa?', 'Extension is not automatic. You would generally need to lodge a new Visitor visa application before your current visa expires, meeting the same eligibility and document requirements again.'],
        ['What happens if my visa is refused?', 'If refused, the Department of Home Affairs will provide the reason. Depending on the circumstances, you may be able to reapply and address the concerns raised. Visa approval is solely at the discretion of the Department.'],
    ];
    $faqStmt = $pdo->prepare('INSERT INTO visa_faqs (country_visa_page_id, question, answer, sort_order) VALUES (?, ?, ?, ?)');
    foreach ($faqs as $i => $f) {
        $faqStmt->execute([$pageId, $f[0], $f[1], $i]);
    }

    $pdo->prepare('INSERT INTO visa_fees (country_visa_page_id, label, amount_display, is_government, sort_order) VALUES (?, ?, ?, ?, ?)')
        ->execute([$pageId, 'Base Application Charge', 'Check the official Visa Pricing Estimator — changes periodically', 1, 0]);
    $pdo->prepare('INSERT INTO visa_fees (country_visa_page_id, label, amount_display, is_government, sort_order) VALUES (?, ?, ?, ?, ?)')
        ->execute([$pageId, 'Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0, 0]);

    $pdo->prepare('INSERT INTO visa_sources (country_visa_page_id, source_authority, source_url, date_checked, date_reviewed, notes) VALUES (?, ?, ?, ?, ?, ?)')
        ->execute([
            $pageId,
            'Australian Government Department of Home Affairs',
            'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600',
            $today,
            $today,
            'Subclass 600 Tourist stream — general visa category, eligibility and process information.',
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
