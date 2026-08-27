<?php
/**
 * Single source of truth for the "Get Assistance" Quick Enquiry widget's
 * services, their step-2 purpose/requirement options and extra fields.
 * Used by the modal renderer (quick-enquiry-modal.php), the JS that
 * drives step switching (quick-enquiry-modal.js, via json_encode of this
 * same array), and the backend validator (quick-enquiry-handler.php) —
 * so a new option only ever needs to be added here once.
 *
 * 'category_map' (visa only): maps the chosen purpose to the exact
 * existing CRM_VISA_CATEGORIES value, so Quick Enquiry submissions land
 * in the same staff-facing categories as every other enquiry channel —
 * no parallel taxonomy. 'service_required' (other services): the fixed
 * CRM_VISA_CATEGORIES value for that whole service, since the purpose
 * chosen there is a sub-detail, not a distinct top-level category.
 */

const QUICK_ENQUIRY_SERVICES = [
    'visa' => [
        'key' => 'visa',
        'label' => 'Visa Assistance',
        'icon' => '🛂',
        'subtitle' => 'Tourist • Business • Student • Work • Family • Transit • Medical & more',
        'step2_question' => 'What is the purpose of your visa?',
        'step2_options' => ['Tourist', 'Business', 'Student', 'Work', 'Family Visit', 'Dependent', 'Transit', 'Medical', 'Conference', 'Sports', 'Other'],
        'category_map' => [
            'Tourist' => 'Tourist Visa', 'Business' => 'Business Visa', 'Student' => 'Student Visa',
            'Work' => 'Work Visa', 'Family Visit' => 'Family Visa', 'Dependent' => 'Dependent Visa',
            'Transit' => 'Transit Visa', 'Medical' => 'Medical Visa', 'Conference' => 'Conference Visa',
            'Sports' => 'Sports Visa', 'Other' => 'Other',
        ],
        'extra_fields' => [
            ['key' => 'country', 'label' => 'Destination Country', 'type' => 'country', 'required' => true],
            ['key' => 'travel_date', 'label' => 'Expected Travel Date', 'type' => 'date', 'required' => true],
        ],
    ],
    'apostille' => [
        'key' => 'apostille',
        'label' => 'Apostille & Attestation',
        'icon' => '📜',
        'subtitle' => 'Apostille • Embassy Attestation • Document Legalization',
        'step2_question' => 'What do you need help with?',
        'step2_options' => ['Apostille', 'Embassy Attestation', 'Consulate Attestation', 'Document Legalization', 'Certificate Authentication', 'Notary', 'Not Sure'],
        'service_required' => 'Apostille & Attestation',
        'extra_fields' => [
            ['key' => 'country', 'label' => 'Destination Country', 'type' => 'country', 'required' => true],
            ['key' => 'document_type', 'label' => 'Document Type', 'type' => 'text', 'placeholder' => 'e.g. Educational certificate, birth certificate', 'required' => true],
        ],
    ],
    'forex' => [
        'key' => 'forex',
        'label' => 'Forex',
        'icon' => '💱',
        'subtitle' => 'Foreign Currency • Travel Forex Assistance',
        'step2_question' => 'What do you need Forex assistance for?',
        'step2_options' => ['Foreign Currency', 'Travel Forex', 'Currency Exchange', 'Forex Card', 'Other'],
        'service_required' => 'Forex Assistance',
        'extra_fields' => [
            ['key' => 'country', 'label' => 'Destination Country', 'type' => 'country', 'required' => true],
            ['key' => 'currency', 'label' => 'Currency Required', 'type' => 'text', 'placeholder' => 'e.g. USD, EUR, GBP', 'required' => true],
            ['key' => 'amount', 'label' => 'Approximate Amount', 'type' => 'text', 'placeholder' => 'e.g. 2000', 'required' => false],
            ['key' => 'travel_date', 'label' => 'Travel Date', 'type' => 'date', 'required' => true],
        ],
    ],
    'travel' => [
        'key' => 'travel',
        'label' => 'Travel Services',
        'icon' => '✈️',
        'subtitle' => 'Flights • Hotels • Tours • Travel Assistance',
        'step2_question' => 'What do you need help with?',
        'step2_options' => ['Flight', 'Hotel', 'Tour Package', 'Travel Insurance', 'Airport Assistance', 'Other'],
        'service_required_map' => ['Travel Insurance' => 'Travel Insurance'],
        'service_required' => 'Flight & Hotel Assistance',
        'extra_fields' => [
            ['key' => 'country', 'label' => 'Destination', 'type' => 'country', 'required' => true],
            ['key' => 'travel_date', 'label' => 'Travel Date', 'type' => 'date', 'required' => true],
        ],
    ],
    'general' => [
        'key' => 'general',
        'label' => 'General Enquiry',
        'icon' => '💬',
        'subtitle' => 'Have another question? Talk to our team.',
        'is_freeform' => true,
        'service_required' => 'General Enquiry',
    ],
];
