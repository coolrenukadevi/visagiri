<?php
declare(strict_types=1);

/**
 * Renders just the Visa/Apostille enquiry wizard's form markup (no
 * header/footer chrome) for the sitewide "Enquire Now" modal
 * (includes/enquiry-modal.php) to lazy-load via fetch() the first time
 * a visitor picks the Visa or Apostille tile — keeping every other
 * page load free of the countries/visa-types queries this wizard
 * needs. enquiry-modal.js injects the returned HTML into the modal and
 * calls VisagiriEnquiryWizard.init() (enquiry-wizard.js, already
 * loaded sitewide) against it in ajax-submit mode, so filling in and
 * submitting the form never navigates away from the page the modal
 * was opened on.
 */

require_once __DIR__ . '/../includes/enquiry.php';

$service = ($_GET['service'] ?? '') === 'apostille' ? 'apostille' : 'visa';

$visaTypes = visa_types_all();
$countries = countries_all();
$errors = [];
$values = [
    'name' => '', 'mobile_country_code' => '+91', 'mobile_number' => '', 'email' => '',
    'current_city' => '', 'current_state' => '',
    'service_category' => $service,
    'destination_country' => '', 'visa_type' => '',
    'passport_number' => '', 'passport_issued_from' => '', 'journey_date' => '', 'pax_count' => '1',
    'apostille_service_type' => '', 'apostille_document_type' => '', 'apostille_document_count' => '1',
    'apostille_destination_country' => '', 'apostille_purpose' => '',
    'remarks' => '',
];
$ajaxMode = true;

header('Content-Type: text/html; charset=UTF-8');
require __DIR__ . '/../includes/enquiry-wizard-fields.php';
