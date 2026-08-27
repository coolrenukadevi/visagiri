<?php
declare(strict_types=1);

/**
 * Shared helpers for the multi-step B2B partner enrollment wizard
 * (partner/pages/register*.php). Fixed allow-lists for the wizard's
 * multi-select/dropdown fields — validated server-side against these
 * on every step, never trusting whatever the client posts — plus the
 * duplicate-prevention check (client spec §27) and the "which step is
 * next" resume helper used after login.
 */

const PARTNER_BUSINESS_TYPES = [
    'travel_agency' => 'Travel Agency',
    'tour_operator' => 'Tour Operator',
    'visa_consultant' => 'Visa Consultant',
    'corporate_travel_desk' => 'Corporate Travel Desk',
    'immigration_consultant' => 'Immigration Consultant',
    'freelancer' => 'Freelancer / Independent Consultant',
    'sub_agent' => 'Sub-Agent',
    'other' => 'Other',
];

const PARTNER_SERVICES_OFFERED = [
    'visa' => 'Visa Services',
    'flight' => 'Flight Booking',
    'hotel' => 'Hotel Booking',
    'holiday_packages' => 'Holiday Packages',
    'corporate_travel' => 'Corporate Travel',
    'forex' => 'Forex',
    'travel_insurance' => 'Travel Insurance',
    'passport_services' => 'Passport Services',
    'apostille_attestation' => 'Apostille / Attestation',
    'immigration' => 'Immigration',
    'other' => 'Other',
];

const PARTNER_VISA_SPECIALIZATION = [
    'schengen' => 'Schengen',
    'usa' => 'USA',
    'uk' => 'UK',
    'canada' => 'Canada',
    'australia' => 'Australia',
    'new_zealand' => 'New Zealand',
    'uae' => 'UAE',
    'singapore' => 'Singapore',
    'thailand' => 'Thailand',
    'japan' => 'Japan',
    'china' => 'China',
    'hong_kong' => 'Hong Kong',
    'other_countries' => 'Other Countries',
];

const PARTNER_MONTHLY_VOLUME = ['1-10', '11-25', '26-50', '51-100', '100+'];

const PARTNER_DOCUMENT_TYPES = [
    'pan_card' => 'PAN Card',
    'gst_certificate' => 'GST Certificate',
    'company_registration' => 'Company Registration Certificate',
    'trade_license' => 'Trade License',
    'iata_certificate' => 'IATA Certificate',
    'tafi_certificate' => 'TAFI Certificate',
    'office_address_proof' => 'Office Address Proof',
    'authorized_signatory_id' => 'Authorized Signatory ID',
    'company_profile' => 'Company Profile',
    'other' => 'Other Supporting Documents',
];

const PARTNER_TERMS_VERSION = '1.0';

/** Filters a posted array of checkbox values down to only the allowed keys, preserving nothing else. */
function partner_filter_allowed_values(array $posted, array $allowList): array
{
    return array_values(array_intersect($posted, array_keys($allowList)));
}

/**
 * Duplicate-prevention check (client spec §27): looks for an existing
 * partner matching any of the given identifiers. Pass only the fields
 * you actually have — step 1 (business info) has company/GST/PAN/IATA
 * but no email/mobile yet; step 2 (contact) has email/mobile but the
 * company/GST/PAN/IATA check already happened in step 1. Returns the
 * client-facing message on the first match found, or null if clear.
 */
function find_partner_duplicate(
    ?string $email = null,
    ?string $mobile = null,
    ?string $companyName = null,
    ?string $gstin = null,
    ?string $pan = null,
    ?string $iataNumber = null
): ?string {
    $pdo = db();
    $message = 'An account/application already exists. Please contact your Relationship Manager.';

    if ($email !== null && $email !== '') {
        $stmt = $pdo->prepare('SELECT id FROM partners WHERE email = :email AND deleted_at IS NULL');
        $stmt->execute(['email' => $email]);
        if ($stmt->fetch()) {
            return $message;
        }
    }

    if ($mobile !== null && $mobile !== '') {
        $stmt = $pdo->prepare('SELECT id FROM partners WHERE mobile = :mobile AND deleted_at IS NULL');
        $stmt->execute(['mobile' => $mobile]);
        if ($stmt->fetch()) {
            return $message;
        }
    }

    if ($companyName !== null && $companyName !== '') {
        $stmt = $pdo->prepare('SELECT id FROM partners WHERE LOWER(company_name) = LOWER(:name) AND deleted_at IS NULL');
        $stmt->execute(['name' => $companyName]);
        if ($stmt->fetch()) {
            return $message;
        }
    }

    if ($gstin !== null && $gstin !== '') {
        $stmt = $pdo->prepare('SELECT id FROM partner_business_profiles WHERE gstin = :gstin');
        $stmt->execute(['gstin' => $gstin]);
        if ($stmt->fetch()) {
            return $message;
        }
    }

    if ($pan !== null && $pan !== '') {
        $stmt = $pdo->prepare('SELECT id FROM partner_business_profiles WHERE pan = :pan');
        $stmt->execute(['pan' => $pan]);
        if ($stmt->fetch()) {
            return $message;
        }
    }

    if ($iataNumber !== null && $iataNumber !== '') {
        $stmt = $pdo->prepare('SELECT id FROM partner_business_profiles WHERE iata_number = :iata');
        $stmt->execute(['iata' => $iataNumber]);
        if ($stmt->fetch()) {
            return $message;
        }
    }

    return null;
}

/**
 * Where a logged-in-but-not-yet-fully-enrolled partner should land —
 * called from login and from the wizard steps themselves so refreshing
 * or navigating back into an earlier step doesn't lose place. Step 1
 * (business info) and step 2 (contact) happen before an account
 * exists at all (held in $_SESSION until step 2 creates the row), so
 * this only needs to distinguish steps 3-5.
 */
function partner_enrollment_next_route(array $partner, ?array $businessProfile): string
{
    if ($partner['enrollment_completed_at'] !== null) {
        return '/partner/dashboard/';
    }
    if ($businessProfile === null || $businessProfile['services_offered'] === null) {
        return '/partner/register-profile/';
    }
    return '/partner/register-documents/';
}

/** Fetches the current partner's business profile row, or null if step 1 was never completed (shouldn't happen post-login, but defensive). */
function current_partner_business_profile(): ?array
{
    $partnerId = current_partner_id();
    if ($partnerId === null) {
        return null;
    }
    $stmt = db()->prepare('SELECT * FROM partner_business_profiles WHERE partner_id = :id');
    $stmt->execute(['id' => $partnerId]);
    $profile = $stmt->fetch();
    return $profile ?: null;
}

const PARTNER_ENROLLMENT_STEPS = [
    1 => 'Business Info',
    2 => 'Contact & Login',
    3 => 'Business Profile',
    4 => 'Documents',
    5 => 'Terms',
];

/**
 * Renders the "verify your email" banner shown on the partner
 * dashboard until email_verified_at is set — non-blocking (the
 * partner isn't locked out of anything by this), just a reminder,
 * since the real gate is admin/pages/partners.php refusing to
 * Approve an unverified partner (client spec §3).
 */
function render_partner_email_verification_banner(array $partner): void
{
    if ($partner['email_verified_at'] !== null) {
        return;
    }
    ?>
    <div class="alert alert-warning" style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:var(--space-3)">
        <span>Your email address isn't verified yet. Verification is required before your account can be approved.</span>
        <form method="post" action="/partner/dashboard/" style="display:inline">
            <?= csrf_field() ?><input type="hidden" name="action" value="resend_verification">
            <button type="submit" class="btn btn-outline btn-sm">Resend verification email</button>
        </form>
    </div>
    <?php
    $devLink = flash_get('partner_dev_verify_link');
    if ($devLink) {
        ?>
        <div class="alert alert-warning">
            <strong>Development mode only</strong> (no email service is connected yet):<br>
            <a href="<?= e($devLink) ?>"><?= e($devLink) ?></a>
        </div>
        <?php
    }
}

/** Renders the 1-5 step indicator shown at the top of every wizard page. */
function render_partner_enrollment_steps(int $currentStep): void
{
    ?>
    <ol class="enrollment-steps">
        <?php foreach (PARTNER_ENROLLMENT_STEPS as $num => $label): ?>
        <li class="enrollment-steps__item<?= $num === $currentStep ? ' is-current' : ($num < $currentStep ? ' is-done' : '') ?>">
            <span class="enrollment-steps__num"><?= $num < $currentStep ? '&#10003;' : $num ?></span>
            <span class="enrollment-steps__label"><?= e($label) ?></span>
        </li>
        <?php endforeach; ?>
    </ol>
    <?php
}
