<?php
declare(strict_types=1);

/** Shorthand for htmlspecialchars() with sane defaults, used in every template. */
function e(?string $value): string
{
    return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}

/**
 * Appends a `?v=<mtime>` cache-buster to a static asset path. Pairs
 * with the year-long `immutable` Cache-Control set in .htaccess
 * (Phase 17) — without this, editing a CSS/JS file after launch would
 * leave returning visitors on a stale cached copy for up to a year,
 * since nothing else in the URL would change.
 *
 * Checks both the local-dev layout (assets/ under a sibling `public/`
 * folder) and the flattened single-folder cPanel deployment (assets/
 * directly beside includes/) — see bin/package-cpanel.sh — so this
 * one function works correctly under either layout with no further
 * changes needed.
 */
function asset_url(string $path): string
{
    $version = null;
    foreach ([__DIR__ . '/../public' . $path, __DIR__ . '/..' . $path] as $candidate) {
        if (is_file($candidate)) {
            $version = filemtime($candidate);
            break;
        }
    }
    return $path . '?v=' . ($version ?? time());
}

function redirect(string $path, int $status = 302): never
{
    header('Location: ' . $path, true, $status);
    exit;
}

function slugify(string $text): string
{
    $text = trim($text);
    $text = strtolower($text);
    $text = preg_replace('/[^a-z0-9]+/', '-', $text) ?? '';
    return trim($text, '-');
}

function flash_set(string $key, string $message): void
{
    $_SESSION['flash'][$key] = $message;
}

function flash_get(string $key): ?string
{
    $message = $_SESSION['flash'][$key] ?? null;
    unset($_SESSION['flash'][$key]);
    return $message;
}

/** Formats a decimal amount with its currency code, e.g. "INR 12,500.00". */
function format_money(float $amount, string $currency = 'INR'): string
{
    return $currency . ' ' . number_format($amount, 2);
}

/** Renders a country's flag as a Unicode emoji from its ISO2 code (no image assets needed). */
function flag_emoji(?string $iso2): string
{
    if ($iso2 === null || strlen($iso2) !== 2) {
        return '🌐';
    }
    $codePoints = array_map(static fn($c) => 0x1F1E6 + (ord($c) - 65), str_split(strtoupper($iso2)));
    return mb_convert_encoding('&#' . $codePoints[0] . ';&#' . $codePoints[1] . ';', 'UTF-8', 'HTML-ENTITIES');
}

/**
 * Real, client-confirmed WhatsApp number (see includes/enquiry-widget.php
 * for sourcing) — the single existing enquiry/quotation channel on the
 * site. Any "Get a Quote"-style CTA should link here with a relevant
 * pre-filled message rather than standing up a duplicate contact form.
 */
function whatsapp_enquiry_href(string $message): string
{
    $number = setting('whatsapp_number', '917065819819');
    return 'https://wa.me/' . $number . '?text=' . rawurlencode($message);
}

/** A distinctive icon per visa type (slug), used on the /visa-type/ hub and detail pages. */
function visa_type_icon(string $slug): string
{
    return match ($slug) {
        'tourist' => '🧳',
        'business' => '💼',
        'student' => '🎓',
        'work' => '🏢',
        'family' => '👨‍👩‍👧‍👦',
        'transit' => '✈️',
        'medical' => '🏥',
        'conference' => '🎤',
        'sports' => '🏅',
        default => '📄',
    };
}

/**
 * Single source of truth for every attestation service — used by
 * includes/header.php's mega-menu, attestation/index.php's hub +
 * detail routing, and includes/footer.php's Attestation column. This
 * exists to avoid a repeat of the stale-hardcoded-nav-array bug fixed
 * three times already for visa types (header, footer, sitemap): one
 * array, three consumers, never three copies. Fixed set of 13
 * industry-standard document-attestation service categories, not
 * fabricated per-service claims — same discipline already applied to
 * Sports Visa.
 */
function attestation_services(): array
{
    static $services = null;
    if ($services !== null) {
        return $services;
    }

    $services = [
        'mea-apostille' => [
            'menu_label' => 'MEA Apostille',
            'name' => 'MEA Apostille Services',
            'category' => 'Apostille',
            'icon' => '📜',
            'description' => 'Apostille certification via the Ministry of External Affairs for documents used in Hague Apostille Convention member countries.',
            'meta_description' => 'MEA apostille certification for Indian documents used in Hague Apostille Convention countries. Reliable apostille assistance from Visagiri.',
            'overview' => "An apostille is a certification recognized by every member country of the 1961 Hague Apostille Convention, confirming a document is genuine so it can be used abroad without further legalization by that country's embassy. In India, the Ministry of External Affairs (MEA) is the sole authority for issuing apostilles.",
            'when_needed' => 'Required when an Indian document will be used in a Hague Convention member country — commonly for study visas, work visas, business registration, or property matters abroad.',
            'process_steps' => [
                'Document verified by the issuing authority or notarized, as applicable',
                'State/HRD attestation for educational and personal documents, where required',
                'MEA apostille stamp affixed to the document',
            ],
            'typical_documents' => ['Educational certificates', 'Birth/marriage certificates', 'Power of attorney', 'Commercial documents'],
        ],
        'e-apostille' => [
            'menu_label' => 'E-Apostille',
            'name' => 'E-Apostille Services',
            'category' => 'Apostille',
            'icon' => '💻',
            'description' => 'Digital apostille issued electronically by the Ministry of External Affairs for eligible document categories.',
            'meta_description' => 'E-Apostille services for eligible documents — digital apostille issued electronically by the Ministry of External Affairs. Apply with Visagiri.',
            'overview' => "E-Apostille is the Ministry of External Affairs' electronic apostille service — a digitally signed, independently verifiable certificate issued for select document categories, rather than a physical stamp.",
            'when_needed' => 'Useful when the receiving country or institution accepts a digitally verifiable apostille and your document category is eligible for electronic processing.',
            'process_steps' => [
                'Document prepared and submitted for e-apostille processing',
                'Eligibility of the document category confirmed',
                'Digital apostille certificate issued with a verifiable reference number',
            ],
            'typical_documents' => ['Educational certificates (select categories)', 'Commercial documents (select categories)'],
        ],
        'mea-attestation' => [
            'menu_label' => 'MEA Attestation',
            'name' => 'MEA Attestation Services',
            'category' => 'Attestation',
            'icon' => '🏛️',
            'description' => 'Ministry of External Affairs attestation for Indian documents used abroad, for countries outside the Hague Convention.',
            'meta_description' => 'MEA attestation for Indian documents used abroad in non-Hague Convention countries. Trusted document attestation assistance from Visagiri.',
            'overview' => "MEA attestation is the Ministry of External Affairs' certification for documents headed to countries that are not part of the Hague Apostille Convention. It confirms the document is genuine and is typically the prerequisite step before embassy attestation.",
            'when_needed' => 'Required for documents headed to non-Hague countries — most commonly Gulf and Middle East destinations — before the destination country\'s embassy will attest the document.',
            'process_steps' => [
                'State/HRD attestation for educational and personal documents, where required',
                'MEA attestation stamp affixed to the document',
                'Document proceeds to embassy attestation, if required by the destination',
            ],
            'typical_documents' => ['Educational certificates', 'Personal documents', 'Commercial documents'],
        ],
        'embassy-attestation' => [
            'menu_label' => 'Embassy Attestation',
            'name' => 'Embassy Attestation Services',
            'category' => 'Attestation',
            'icon' => '🏢',
            'description' => "Attestation of documents by the destination country's embassy or consulate in India.",
            'meta_description' => "Embassy attestation of your documents by the destination country's embassy or consulate, a required step for many visas. Assistance from Visagiri.",
            'overview' => "Embassy attestation is certification carried out by the destination country's own embassy or consulate in India, confirming the document is accepted for use in that country. It generally follows MEA attestation in the standard attestation chain.",
            'when_needed' => 'Required by many non-Hague destination countries — commonly for employment visas, family/dependent visas, and business setup abroad — after MEA attestation is complete.',
            'process_steps' => [
                'MEA attestation completed on the document',
                'Document submitted to the relevant embassy or consulate',
                'Embassy attestation stamp affixed, completing the chain',
            ],
            'typical_documents' => ['Educational certificates', 'Employment documents', 'Personal documents'],
        ],
        'consulate-attestation' => [
            'menu_label' => 'Consulate Attestation',
            'name' => 'Consulate Attestation Services',
            'category' => 'Attestation',
            'icon' => '🛂',
            'description' => 'Attestation of documents through the relevant consulate for destinations without direct embassy processing.',
            'meta_description' => 'Consulate attestation assistance for documents requiring consular authentication before use abroad. Apply online with Visagiri.',
            'overview' => "Consulate attestation follows the same principle as embassy attestation, but is carried out through a country's consulate rather than its embassy — used where a consulate is the authority that handles document authentication for a given jurisdiction.",
            'when_needed' => "Used when the relevant destination-country authority for document authentication in India is a consulate rather than the embassy.",
            'process_steps' => [
                'MEA attestation completed on the document',
                'Document submitted to the relevant consulate',
                'Consulate attestation stamp affixed, completing the chain',
            ],
            'typical_documents' => ['Educational certificates', 'Personal documents', 'Commercial documents'],
        ],
        'educational-document-attestation' => [
            'menu_label' => 'Educational',
            'name' => 'Educational Document Attestation',
            'category' => 'Documents',
            'icon' => '🎓',
            'description' => 'Attestation of degree certificates, mark sheets, and other educational documents for study or work abroad.',
            'meta_description' => 'Educational document attestation for degree certificates and mark sheets, required for study or work visas abroad. Apply with Visagiri.',
            'overview' => "Educational document attestation authenticates degree certificates, mark sheets, diplomas, and other academic records, confirming they were genuinely issued by the named institution — usually the first stage in the wider attestation chain for study or work documentation.",
            'when_needed' => 'Required for student visas, work visas, and employment or licensing applications abroad that depend on verifying your educational qualifications.',
            'process_steps' => [
                'Verification by the issuing university/board, where required',
                'State/HRD attestation',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Degree certificates', 'Mark sheets', 'Diplomas', 'Transfer certificates'],
        ],
        'commercial-document-attestation' => [
            'menu_label' => 'Commercial',
            'name' => 'Commercial Document Attestation',
            'category' => 'Documents',
            'icon' => '🧾',
            'description' => 'Attestation of commercial documents such as invoices, certificates of origin, and business agreements.',
            'meta_description' => 'Commercial document attestation for invoices, certificates of origin, and business agreements used internationally. Apply with Visagiri.',
            'overview' => 'Commercial document attestation authenticates business paperwork — invoices, certificates of origin, board resolutions, and trade agreements — for use in international trade, business registration, or contract enforcement abroad.',
            'when_needed' => 'Required when doing business abroad — setting up a company, opening a bank account, or fulfilling a trade contract that requires authenticated Indian business documents.',
            'process_steps' => [
                'Chamber of Commerce attestation, for trade-related documents',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Invoices', 'Certificates of origin', 'Board resolutions', 'Trade agreements'],
        ],
        'personal-document-attestation' => [
            'menu_label' => 'Personal',
            'name' => 'Personal Document Attestation',
            'category' => 'Documents',
            'icon' => '🪪',
            'description' => 'Attestation of personal documents such as identity, address, and other individual records for use abroad.',
            'meta_description' => 'Personal document attestation for identity, address, and other individual records required for use abroad. Assistance from Visagiri.',
            'overview' => 'Personal document attestation covers individual records — identity documents, address proof, affidavits, and similar personal paperwork — authenticated for use in matters like residency, banking, or legal proceedings abroad.',
            'when_needed' => 'Required for residency applications, banking/financial matters, and legal or administrative processes abroad that ask for authenticated Indian personal documents.',
            'process_steps' => [
                'Notarization, where required',
                'State attestation, if applicable',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Identity documents', 'Address proof', 'Affidavits', 'Single-status certificates'],
        ],
        'birth-certificate-attestation' => [
            'menu_label' => 'Birth Certificate',
            'name' => 'Birth Certificate Attestation',
            'category' => 'Documents',
            'icon' => '👶',
            'description' => 'Attestation of birth certificates for visa, immigration, and family visa applications abroad.',
            'meta_description' => 'Birth certificate attestation for visa, immigration, and family sponsorship applications abroad. Apply online with Visagiri.',
            'overview' => "Birth certificate attestation authenticates the document for use abroad — most often as supporting evidence in family-related visa categories, where the receiving country needs to verify parentage or date of birth from an Indian-issued record.",
            'when_needed' => "Commonly required for dependent/family visas, a minor's passport applications abroad, school admissions, and inheritance or citizenship matters.",
            'process_steps' => [
                'State/municipal attestation of the birth certificate, where required',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Birth certificate (municipal or hospital-issued, as applicable)'],
        ],
        'marriage-certificate-attestation' => [
            'menu_label' => 'Marriage Certificate',
            'name' => 'Marriage Certificate Attestation',
            'category' => 'Documents',
            'icon' => '💍',
            'description' => 'Attestation of marriage certificates for spouse visa, family visa, and residency applications abroad.',
            'meta_description' => 'Marriage certificate attestation for spouse visa, family visa, and residency applications abroad. Apply online with Visagiri.',
            'overview' => 'Marriage certificate attestation authenticates the document for use abroad, most commonly to support a spouse or dependent visa application, or for name-change and residency formalities that require proof of marital status.',
            'when_needed' => 'Commonly required for spouse visas, family sponsorship, name-change formalities, and residency or citizenship applications abroad.',
            'process_steps' => [
                'State/registrar attestation of the marriage certificate, where required',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Marriage certificate (registrar-issued)'],
        ],
        'document-legalization' => [
            'menu_label' => 'Document Legalization',
            'name' => 'Document Legalization Services',
            'category' => 'Legalization',
            'icon' => '⚖️',
            'description' => 'End-to-end legalization of documents through notarization, government, and embassy stages for use abroad.',
            'meta_description' => 'Document legalization services covering notarization, government, and embassy stages for documents used abroad. Assistance from Visagiri.',
            'overview' => "Document legalization is the umbrella term for the full authentication chain a document goes through — notarization, state or HRD attestation, MEA apostille/attestation, and embassy attestation — so it's legally recognized in the destination country. Not every document needs every stage; which stages apply depends on the document type and destination.",
            'when_needed' => 'Needed whenever an Indian-issued document must be legally recognized abroad and more than one stage of authentication applies.',
            'process_steps' => [
                'Notarization, where required',
                'State/HRD attestation, where required',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Educational, personal, and commercial documents requiring multi-stage authentication'],
        ],
        'chamber-of-commerce-attestation' => [
            'menu_label' => 'Chamber of Commerce',
            'name' => 'Chamber of Commerce Attestation',
            'category' => 'Legalization',
            'icon' => '🤝',
            'description' => 'Attestation of commercial invoices and certificates of origin by the Chamber of Commerce.',
            'meta_description' => 'Chamber of Commerce attestation for commercial invoices and certificates of origin used in international trade. Apply with Visagiri.',
            'overview' => 'Chamber of Commerce attestation authenticates commercial documents — invoices, certificates of origin, and similar trade paperwork — confirming they were issued by a genuine Indian business. It is commonly required before MEA and embassy attestation for trade documents.',
            'when_needed' => 'Required for international trade documentation, particularly certificates of origin and invoices used in cross-border commerce.',
            'process_steps' => [
                'Document reviewed and stamped by the relevant Chamber of Commerce',
                'MEA apostille or attestation',
                'Embassy attestation, if required by the destination country',
            ],
            'typical_documents' => ['Invoices', 'Certificates of origin', 'Trade-related declarations'],
        ],
        'hrd-state-attestation' => [
            'menu_label' => 'HRD / State Attestation',
            'name' => 'HRD / State Attestation Services',
            'category' => 'Legalization',
            'icon' => '📋',
            'description' => 'State Human Resources Department attestation of educational certificates, a prerequisite step before MEA attestation in many states.',
            'meta_description' => 'HRD and State attestation of educational certificates, a required step before MEA attestation in many Indian states. Apply with Visagiri.',
            'overview' => 'HRD (Human Resources Department) or State attestation authenticates educational certificates at the state government level, confirming they were issued by a recognized institution within that state. It is typically required before the MEA will apostille or attest an educational document.',
            'when_needed' => 'Required as a precursor step for most educational document attestation, since the MEA generally requires state-level HRD attestation first.',
            'process_steps' => [
                'Document submitted to the HRD/state education department of the issuing state',
                'Verification against institution records',
                'HRD attestation stamp affixed, before the document proceeds to MEA',
            ],
            'typical_documents' => ['Degree certificates', 'Diplomas', 'Mark sheets'],
        ],
    ];

    return $services;
}

/** Old attestation slugs that must 301-redirect to their current equivalents (renamed for clearer SEO labels). */
function attestation_service_redirects(): array
{
    return [
        'apostille' => 'mea-apostille',
        'commercial-attestation' => 'commercial-document-attestation',
    ];
}

/** Attestation services grouped by category, in menu display order — the single source both the header mega-menu and the hub page render from. */
function attestation_categories(): array
{
    $grouped = ['Apostille' => [], 'Attestation' => [], 'Documents' => [], 'Legalization' => []];
    foreach (attestation_services() as $slug => $service) {
        $grouped[$service['category']][] = ['slug' => $slug] + $service;
    }
    return $grouped;
}

/** A distinctive icon per attestation category, used as the mega-menu column heading icon. */
function attestation_category_icon(string $category): string
{
    return match ($category) {
        'Apostille' => '📜',
        'Attestation' => '🏛️',
        'Documents' => '📄',
        'Legalization' => '⚖️',
        default => '📄',
    };
}

/**
 * Small line-icon set for the Company mega-menu — deliberately not
 * the emoji icons used elsewhere on the site (visa types, attestation
 * services): this menu was asked to read as premium/corporate rather
 * than the site's more playful marketing tone, so it gets its own
 * minimal stroke-SVG treatment instead.
 */
function company_nav_icon(string $key): string
{
    $attrs = 'width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"';
    return match ($key) {
        'about' => "<svg $attrs><circle cx=\"10\" cy=\"10\" r=\"7.5\"/><line x1=\"10\" y1=\"9\" x2=\"10\" y2=\"14\"/><circle cx=\"10\" cy=\"6.3\" r=\"0.9\" fill=\"currentColor\" stroke=\"none\"/></svg>",
        'shield' => "<svg $attrs><path d=\"M10 2.5 16.5 5 16.5 9.5C16.5 13.5 13.7 16.5 10 17.5 6.3 16.5 3.5 13.5 3.5 9.5L3.5 5Z\"/><path d=\"M7 10 9 12 13.5 7.2\"/></svg>",
        'compass' => "<svg $attrs><circle cx=\"10\" cy=\"10\" r=\"7.5\"/><path d=\"M13.2 6.8 10.8 10.8 6.8 13.2 9.2 9.2Z\"/></svg>",
        'star' => "<svg $attrs><path d=\"M10 2.8 12.1 7.4 17 8.1 13.5 11.5 14.4 16.3 10 14 5.6 16.3 6.5 11.5 3 8.1 7.9 7.4Z\"/></svg>",
        'users' => "<svg $attrs><circle cx=\"7.2\" cy=\"7\" r=\"2.4\"/><path d=\"M2.5 16C2.5 12.7 4.6 11 7.2 11 9.8 11 11.9 12.7 11.9 16\"/><circle cx=\"14\" cy=\"7.8\" r=\"2\"/><path d=\"M12.7 11.2C15 11.2 16.9 12.7 17 15.6\"/></svg>",
        'briefcase' => "<svg $attrs><rect x=\"3\" y=\"7.5\" width=\"14\" height=\"9\" rx=\"1.3\"/><path d=\"M7 7.5V5.8C7 5 7.6 4.4 8.4 4.4H11.6C12.4 4.4 13 5 13 5.8V7.5\"/><line x1=\"3\" y1=\"11.5\" x2=\"17\" y2=\"11.5\"/></svg>",
        'link' => "<svg $attrs><path d=\"M8.3 11.7 11.7 8.3\"/><path d=\"M9.2 6 11 4.2C12.4 2.8 14.6 2.8 16 4.2 17.4 5.6 17.4 7.8 16 9.2L14.2 11\"/><path d=\"M10.8 14 9 15.8C7.6 17.2 5.4 17.2 4 15.8 2.6 14.4 2.6 12.2 4 10.8L5.8 9\"/></svg>",
        'award' => "<svg $attrs><circle cx=\"10\" cy=\"7.5\" r=\"4.5\"/><path d=\"M7.2 11.3 6 17.5 10 15.3 14 17.5 12.8 11.3\"/></svg>",
        'mail' => "<svg $attrs><rect x=\"2.5\" y=\"5\" width=\"15\" height=\"10.5\" rx=\"1.5\"/><path d=\"M3.2 6 10 11 16.8 6\"/></svg>",
        default => '',
    };
}

/** Small chevron used next to mega-menu nav triggers, rotated via CSS on open. */
function nav_chevron_icon(): string
{
    return '<svg class="mega-menu__trigger-arrow" width="12" height="12" viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2.5 4.5 6 8 9.5 4.5"/></svg>';
}

/**
 * Subtle abstract globe/passport illustration for the Company
 * mega-menu's featured card — same "original inline SVG, not stock
 * photography" approach already used for the homepage hero (Phase 5).
 */
function company_featured_illustration(): string
{
    return <<<SVG
    <svg width="108" height="86" viewBox="0 0 108 86" fill="none" aria-hidden="true">
        <circle cx="46" cy="40" r="30" stroke="#F4B400" stroke-width="1.6" opacity="0.85"/>
        <ellipse cx="46" cy="40" rx="30" ry="12" stroke="#F4B400" stroke-width="1" opacity="0.5"/>
        <ellipse cx="46" cy="40" rx="12" ry="30" stroke="#F4B400" stroke-width="1" opacity="0.5"/>
        <line x1="16" y1="40" x2="76" y2="40" stroke="#F4B400" stroke-width="1" opacity="0.5"/>
        <rect x="60" y="30" width="34" height="46" rx="4" fill="#082A67" stroke="#FFFFFF" stroke-width="1.6"/>
        <circle cx="77" cy="47" r="7" stroke="#F4B400" stroke-width="1.4"/>
        <path d="M74 47 76 49 80.5 44" stroke="#F4B400" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/>
        <line x1="66" y1="62" x2="88" y2="62" stroke="#FFFFFF" stroke-width="1.2" opacity="0.6"/>
        <line x1="66" y1="67" x2="82" y2="67" stroke="#FFFFFF" stroke-width="1.2" opacity="0.6"/>
    </svg>
    SVG;
}

/**
 * Phase 4+ scaffolding: same purpose as render_scaffold_stub(), but
 * rendered inside the real header/footer chrome instead of as plain
 * text, so header/footer can be verified against every route while
 * each page's actual body content is still pending its own phase.
 * The "content pending" block is deliberately plain/internal-sounding
 * (not marketing copy) so it can never be mistaken for shipped copy.
 */
function render_scaffold_page(
    string $title,
    string $description,
    string $canonicalPath,
    string $handlerPath,
    string $plannedInPhase,
    int $statusCode = 200
): void {
    http_response_code($statusCode);

    $pageTitle = $title . ' - Visagiri';
    $pageDescription = $description;
    $canonicalUrl = APP_URL . $canonicalPath;
    // Never indexable — this is a placeholder, not shipped content, and
    // search engines shouldn't be handed dev-only debug text as a real
    // page (see Phase 15 audit in AUDIT.md for the inventory of what's
    // still a stub at any given time).
    $noindex = true;

    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <section class="container" style="padding-top: var(--space-10); padding-bottom: var(--space-10);">
        <?php if ($flashNotice): ?>
        <div class="alert alert-warning" role="status"><?= e($flashNotice) ?></div>
        <?php endif; ?>
        <div class="alert alert-info" role="status">
            <?php if (APP_DEBUG): ?>
            <div>
                <strong>Content pending.</strong>
                Handler: <code><?= e($handlerPath) ?></code> &middot;
                Scheduled for: <?= e($plannedInPhase) ?>
            </div>
            <?php else: ?>
            <div><strong>This page isn't ready yet.</strong> We're still building it — check back soon.</div>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/footer.php';
}

/** Shared "Why Visagiri" feature list — used on the homepage and the About page. */
function why_visagiri_features(): array
{
    return [
        ['title' => 'Expert Visa Guidance', 'desc' => 'Guidance from a team familiar with country-specific visa requirements.'],
        ['title' => 'Document Attestation', 'desc' => 'Apostille, MEA, and embassy attestation for documents used abroad.'],
        ['title' => 'Transparent Process', 'desc' => 'Clear guidance on eligibility, documents, and fees before you commit.'],
        ['title' => 'Quick Response', 'desc' => 'Reach our team directly by WhatsApp, call, or enquiry form.'],
        ['title' => 'Human Support', 'desc' => 'Speak with a consultant about your specific visa or attestation needs.'],
    ];
}

function is_valid_email(string $value): bool
{
    return filter_var($value, FILTER_VALIDATE_EMAIL) !== false;
}

/** Accepts an optional leading + and 7-15 digits — deliberately loose to cover international formats. */
function is_valid_mobile(string $value): bool
{
    return (bool) preg_match('/^\+?[0-9]{7,15}$/', trim($value));
}

/** Renders a real 404 inside the shared chrome with a specific, honest message. */
function render_not_found(string $message = "The page you're looking for doesn't exist."): never
{
    http_response_code(404);
    $pageTitle = 'Page Not Found - Visagiri';
    $pageDescription = $message;
    $canonicalUrl = APP_URL . ($_SERVER['REQUEST_URI'] ?? '/');
    // The static 404 stub (pages/404.php) already noindexes via
    // render_scaffold_page(); this dynamic one (used for real 404s
    // like an unknown country/visa-type slug) needs the same explicit
    // signal rather than relying solely on the 404 status code.
    $noindex = true;
    require __DIR__ . '/header.php';
    ?>
    <section class="container" style="padding-top: var(--space-10); padding-bottom: var(--space-10); text-align:center;">
        <h1>Page Not Found</h1>
        <p><?= e($message) ?></p>
        <a href="/countries/" class="btn btn-primary">Browse Countries</a>
    </section>
    <?php
    require __DIR__ . '/footer.php';
    exit;
}

/** Generates a unique enquiry reference number, e.g. VIS-2026-000001. */
function generate_enquiry_reference(): string
{
    $year = date('Y');
    $stmt = db()->prepare("SELECT COUNT(*) FROM enquiries WHERE reference_number LIKE :prefix");
    $stmt->execute(['prefix' => "VIS-$year-%"]);
    $count = (int) $stmt->fetchColumn() + 1;
    return sprintf('VIS-%s-%06d', $year, $count);
}
