<?php
/** Reusable page fragments shared across controllers. */
declare(strict_types=1);
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/nav.php';
require_once __DIR__ . '/../lib-php/data.php';

/** @param array<int,array{label:string,href?:string}> $items */
function breadcrumbs(array $items): string
{
    $out = '';
    $last = count($items) - 1;
    foreach ($items as $i => $it) {
        $out .= $i === $last
            ? '<li aria-current="page">' . e($it['label']) . '</li>'
            : '<li><a href="' . e($it['href']) . '">' . e($it['label']) . '</a></li>';
    }
    return '<nav class="breadcrumbs" aria-label="Breadcrumb"><div class="container"><ol>' . $out . '</ol></div></nav>';
}

/** Breadcrumb JSON-LD built from the same items, using clean canonical URLs. */
function breadcrumb_schema(array $items): array
{
    $list = [];
    foreach ($items as $i => $it) {
        $list[] = [
            '@type'    => 'ListItem',
            'position' => $i + 1,
            'name'     => $it['label'],
            'item'     => canonical($it['href'] ?? '/'),
        ];
    }
    return ['@context' => 'https://schema.org', '@type' => 'BreadcrumbList', 'itemListElement' => $list];
}

function sticky_search(): string
{
    return <<<HTML
<div class="sticky-search" id="stickySearch">
  <div class="container sticky-search-inner">
    <span class="sticky-search-label"><svg viewBox="0 0 24 24" width="16" height="16"><path fill="currentColor" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z"/></svg>Find a visa</span>
    <form class="sticky-search-form" id="stickySearchForm">
      <div class="autocomplete-field">
        <input type="text" id="stickyCountryInput" class="autocomplete-input" placeholder="Country" autocomplete="off" role="combobox" aria-expanded="false" aria-autocomplete="list" aria-controls="stickyCountryList">
        <input type="hidden" id="stickyCountry">
        <ul class="autocomplete-list" id="stickyCountryList" role="listbox" hidden></ul>
      </div>
      <select id="stickyCity"></select>
      <div class="autocomplete-field sticky-field-visatype">
        <input type="text" id="stickyVisaTypeInput" class="autocomplete-input" placeholder="Visa type" autocomplete="off" role="combobox" aria-expanded="false" aria-autocomplete="list" aria-controls="stickyVisaTypeList">
        <input type="hidden" id="stickyVisaType">
        <ul class="autocomplete-list" id="stickyVisaTypeList" role="listbox" hidden></ul>
      </div>
      <button type="submit" class="btn btn-primary btn-sm">Search</button>
    </form>
  </div>
</div>
HTML;
}

/** Visa enquiry widget — visa-related pages only. */
function enquiry_widget(string $country = '', string $visaType = ''): string
{
    $c = e($country);
    $v = e($visaType);
    return <<<HTML
<section class="enquiry-section" id="enquiry">
  <div class="container">
    <div class="enquiry-card">
      <div class="enquiry-head">
        <h2>Get Your Visa Assistance</h2>
        <p>Complete the form below and our visa experts will contact you within 24 hours.</p>
      </div>
      <form id="enquiryForm" data-country="{$c}" data-visa-type="{$v}">
        <div class="honeypot-field" aria-hidden="true"><label>Company website<input type="text" name="company_website" tabindex="-1" autocomplete="off"></label></div>
        <fieldset class="enquiry-fieldset">
          <legend>Personal Details</legend>
          <div class="enquiry-grid">
            <div class="enquiry-field"><label for="enqName">Full Name *</label><input type="text" id="enqName" name="name" required></div>
            <div class="enquiry-field"><label for="enqMobile">Mobile Number *</label><input type="tel" id="enqMobile" name="mobile" required></div>
            <div class="enquiry-field"><label for="enqEmail">Email Address *</label><input type="email" id="enqEmail" name="email" required></div>
            <div class="enquiry-field"><label for="enqNationality">Nationality *</label><input type="text" id="enqNationality" name="nationality" required></div>
            <div class="enquiry-field full"><label for="enqResidence">Country of Residence *</label><input type="text" id="enqResidence" name="residence" required></div>
          </div>
        </fieldset>
        <fieldset class="enquiry-fieldset">
          <legend>Travel Details</legend>
          <div class="enquiry-grid">
            <div class="enquiry-field"><label for="enqDestination">Destination Country *</label><select id="enqDestination" name="destination" required></select></div>
            <div class="enquiry-field"><label for="enqVisaType">Visa Type *</label><select id="enqVisaType" name="visaType" required></select></div>
            <div class="enquiry-field"><label for="enqTravelDate">Intended Travel Date *</label><input type="date" id="enqTravelDate" name="travelDate" required></div>
            <div class="enquiry-field"><label for="enqDuration">Duration of Stay *</label><input type="text" id="enqDuration" name="duration" placeholder="e.g. 14 days" required></div>
            <div class="enquiry-field full"><label for="enqTravellers">Number of Travellers *</label><input type="number" id="enqTravellers" name="travellers" min="1" value="1" required></div>
          </div>
        </fieldset>
        <fieldset class="enquiry-fieldset">
          <legend>Purpose of Travel</legend>
          <div class="enquiry-field full"><textarea id="enqPurpose" name="purpose" placeholder="e.g. Tourism, Business Meeting, Conference, Family Visit, Employment, Study, Medical Treatment"></textarea></div>
        </fieldset>
        <fieldset class="enquiry-fieldset">
          <legend>Additional Message (optional)</legend>
          <div class="enquiry-field full"><textarea id="enqMessage" name="message"></textarea></div>
        </fieldset>
        <fieldset class="enquiry-fieldset">
          <legend>Upload Documents (optional — PDF, JPG, PNG, DOC, DOCX, max 100 MB each)</legend>
          <div class="enquiry-uploads">
            <div class="enquiry-upload"><label for="upPassport">Passport Copy</label><input type="file" id="upPassport" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"></div>
            <div class="enquiry-upload"><label for="upInvite">Invitation Letter</label><input type="file" id="upInvite" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"></div>
            <div class="enquiry-upload"><label for="upSupport">Supporting Documents</label><input type="file" id="upSupport" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" multiple></div>
          </div>
          <p class="enquiry-hint">This form is a front-end demo — uploads are not sent anywhere yet. See DEVELOPMENT.md for wiring this to email / Google Sheets / Google Drive.</p>
        </fieldset>
        <div class="enquiry-actions">
          <button type="submit" class="btn btn-primary">Submit Enquiry</button>
          <button type="reset" class="btn btn-ghost">Reset</button>
        </div>
      </form>
      <div class="enquiry-success" id="enquirySuccess" hidden>
        <div class="success-icon"><svg viewBox="0 0 24 24" width="28" height="28" fill="white"><path d="M9 16.2 4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4z"/></svg></div>
        <h3>Thank you for contacting Convercession</h3>
        <p>Your visa enquiry has been received successfully. One of our visa specialists will contact you shortly.</p>
        <span class="ref-number">Reference: <span id="enquiryRef"></span></span>
      </div>
    </div>
  </div>
</section>
HTML;
}

/**
 * A country flag.
 *
 * Emoji rather than 216 image files: a flag emoji is just the country's ISO
 * letters as regional indicator symbols, so there are no assets to ship, none
 * to keep in sync, and a wrong code shows a visibly wrong flag.
 *
 * The catch is that Windows ships no flag glyphs at all — the pair renders as
 * two boxed letters. js/common.js feature-detects that once and sets
 * .no-flag-emoji on <html>, and the CSS then shows the country-code chip held
 * in data-code instead of a broken-looking glyph. Kosovo has no emoji flag on
 * any platform, so it always uses the chip.
 */
function country_flag(array $c, string $extraClass = ''): string
{
    $flag = (string) ($c['flag'] ?? '');
    $code = (string) ($c['code'] ?? '');
    $cls  = trim('flag ' . $extraClass);
    if ($flag === '') {
        return '<span class="' . e($cls) . ' flag-chip" aria-hidden="true">' . e($code ?: '??') . '</span>';
    }
    return '<span class="' . e($cls) . '" aria-hidden="true" data-code="' . e($code) . '">' . e($flag) . '</span>';
}
