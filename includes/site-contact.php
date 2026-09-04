<?php
/**
 * Single source of truth for contact details and social links used
 * across header, footer and any page that needs them. Edit here once
 * instead of hunting through every template.
 */
$site_phone_e164   = '+917844819819';
$site_phone_display = '+91 78448 19819';
$site_whatsapp_url  = 'https://wa.me/917844819819';
$site_email         = 'info@visaagency.in';
$site_city          = 'Patna, Bihar';
$site_address       = '#302, Sharda Mansion Apartment, Kailash Puri, Hanuman Nagar, Patna, Bihar 800020';
$site_hours         = 'Monday &ndash; Friday, 9:00 AM &ndash; 5:00 PM';

$site_social = [
    'linkedin'  => 'https://www.linkedin.com/company/visaagency/',
    'twitter'   => 'https://x.com/TheVisaAgency',
    'instagram' => 'https://www.instagram.com/visaagencyofficial/',
    'youtube'   => '#',
    'facebook'  => 'https://www.facebook.com/visaagencyofficial',
];

$site_logo_black = 'assets/img/logo/visaagency-logo-light.png';
$site_logo_white = 'assets/img/logo/visaagency-logo-dark.png';

/**
 * Bank transfer / UPI details shown on the public "Make a Payment" page
 * (payment.php). Left blank on purpose — these are real financial
 * identifiers and must never be fabricated. Fill in your actual account
 * details here once available; until then, the payment page shows a
 * "contact us to arrange payment" fallback instead of blank/fake fields.
 */
$site_bank_account_name   = '';
$site_bank_account_number = '';
$site_bank_ifsc           = '';
$site_bank_name           = '';
$site_bank_branch         = '';
$site_upi_id              = '';
