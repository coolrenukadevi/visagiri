<?php
/**
 * Phase 3B -- Transit Visa gap-closure for the final remaining Tier-B cell
 * (Taiwan), resolving the ambiguity that persisted through Phase 3 and Phase
 * 3A via an official, India-named finding: the Travel Authorization
 * Certificate (TAC) transit exemption, kept explicitly distinct from a
 * separately-reported shorter sterile-transit allowance.
 *
 * Loaded from visa_content_db() alongside the other seed files; each entry
 * upgrades the matching bulk-generic page in place via visa_seed_page() /
 * visa_seed_page_upgrade() -- it never overwrites a page that has already
 * moved past 'generic' status.
 */
function visa_seed_pages_def_batch_phase3b_transit(): array
{
    return [
        [
            'page_slug' => 'taiwan-transit-visa',
            'country_slug' => 'taiwan',
            'category_slug' => 'transit-visa',
            'content_status' => 'researched',
            'biometric_status' => 'not_required',
            'interview_status' => 'not_required',
            'official_visa_name' => 'Transit exemption via the online "Travel Authorization Certificate" (TAC), specifically available to Indian citizens for layovers of approximately 7-24 hours',
            'visa_subclass_code' => 'TAC',
            'intro_html' => '<p>Taiwan\'s Bureau of Consular Affairs (boca.gov.tw) and National Immigration Agency confirm that Indian citizens are eligible for a transit exemption when they have applied online in advance for the R.O.C. "Travel Authorization Certificate" (TAC), applicable to layovers of approximately 7 to 24 hours. This TAC-based route is a distinct, India-named mechanism — separate from a shorter sterile-transit allowance reported for same-airline connections staying airside without entering Taiwan (up to roughly 8 hours), which this record does not merge with the TAC route.</p>',
            'typical_stay' => 'Layovers of approximately 7 to 24 hours under the TAC route; a separate, shorter sterile-transit allowance (same airline, airside only, up to roughly 8 hours) has also been reported and is kept distinct here',
            'entry_type' => 'Online application for the Travel Authorization Certificate (TAC), in advance of travel',
            'processing_time_text' => 'Processing time varies; apply online well in advance of travel and confirm current timelines with the National Immigration Agency',
            'validity_text' => 'Covers the specific transit layover window (approximately 7-24 hours) for which it is issued',
            'application_method' => 'Online, via the National Immigration Agency\'s Travel Authorization Certificate application system; the certificate must be printed and presented for both arrival and departure immigration inspection in Taiwan',
            'interview_required' => 'Not required — an online application process',
            'biometric_required' => 'Not required — an online application process',
            'government_fee_text' => 'As researched: confirm the current fee (if any) with the National Immigration Agency or Bureau of Consular Affairs before applying',
            'application_centre' => 'National Immigration Agency\'s online Travel Authorization Certificate system',
            'authority_name' => 'Bureau of Consular Affairs, Taiwan (boca.gov.tw) / National Immigration Agency',
            'authority_url' => 'https://www.boca.gov.tw',
            'eligibility_html' => '<p>Indian citizens transiting through Taiwan with a layover of approximately 7 to 24 hours before their connecting flight can apply online in advance for a Travel Authorization Certificate (TAC). The printed TAC is required for both arrival and departure immigration inspection, and a passport valid for at least six months is required.</p><h4 style=\'margin:20px 0 10px;font-size:16px;\'>A Separate, Shorter Allowance Also Exists</h4><p>Research also identified a shorter sterile-transit allowance for passengers remaining airside on a same-airline connection (reportedly up to around 8 hours) without needing a TAC or visa — this is kept distinct from the TAC route and not merged with it here, since the exact relationship and current eligibility conditions between the two should be confirmed against current Taiwan authority guidance before travel.</p><p>This is general immigration-document guidance, not a guarantee of approval.</p>',
            'indian_applicant_html' => '<h4 style=\'margin:0 0 10px;font-size:16px;\'>Apply for Your TAC Online in Advance</h4><p>This is a genuine, India-specific official transit exemption — confirmed directly by Taiwan\'s own consular and immigration authorities.</p><h4 style=\'margin:20px 0 10px;font-size:16px;\'>Print and Carry Your TAC</h4><p>Required for both arrival and departure immigration inspection in Taiwan.</p><h4 style=\'margin:20px 0 10px;font-size:16px;\'>Confirm Current Eligibility</h4><p>If your layover is very short and strictly same-airline/airside, also check whether the separate sterile-transit allowance applies instead — conditions should be confirmed against current Taiwan authority guidance.</p><p>Our consultants can help you confirm which transit route fits your specific itinerary.</p>',
            'seo_title' => 'Taiwan Transit Visa for Indians | Travel Authorization Certificate (TAC)',
            'meta_description' => 'Transiting through Taiwan? See the India-specific Travel Authorization Certificate (TAC) transit exemption, via VisaAgency.in.',
            'og_title' => 'Taiwan Transit Visa for Indians — Travel Authorization Certificate (TAC)',
            'og_description' => 'Transiting through Taiwan? See the India-specific Travel Authorization Certificate (TAC) transit exemption, via VisaAgency.in.',
            'documents' => [
                ['Basic Documents', 'Passport valid for at least 6 months', 'mandatory'],
                ['Travel Documents', 'Confirmed onward/connecting flight details', 'mandatory'],
                ['Supporting Documents', 'Printed Travel Authorization Certificate (TAC)', 'mandatory'],
            ],
            'steps' => [
                ['Apply for the TAC Online', 'In advance of your travel date.'],
                ['Print Your TAC', 'Required for both arrival and departure immigration inspection.'],
                ['Confirm Your Layover Window', 'Approximately 7-24 hours for the TAC route; check separately if a shorter sterile-transit allowance might apply instead.'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa to transit through Taiwan?', 'Indian citizens can qualify for a transit exemption by applying online in advance for a Travel Authorization Certificate (TAC), for layovers of approximately 7-24 hours.'],
                ['Is this the same as the general sterile-transit allowance?', 'No — a separate, shorter same-airline airside allowance (up to roughly 8 hours) has also been reported; the two are kept distinct, and current eligibility should be confirmed with Taiwan authorities.'],
            ],
            'fees' => [
            ],
            'source' => [
                'authority' => 'Bureau of Consular Affairs, Taiwan (boca.gov.tw) / National Immigration Agency',
                'url' => 'https://www.boca.gov.tw',
                'notes' => 'Phase 3B research: official boca.gov.tw-sourced finding directly names Indian citizens as eligible for the TAC-based transit exemption. This resolves the ambiguity that kept this cell generic through Phase 3 and Phase 3A. The TAC route and a separately-reported shorter sterile-transit allowance are deliberately kept distinct, not merged. Confidence: High.',
            ],
        ],
    ];
}
