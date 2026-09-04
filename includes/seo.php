<?php
declare(strict_types=1);

function organization_schema(): array
{
    return [
        '@context' => 'https://schema.org',
        '@type' => 'Organization',
        'name' => 'Videshia',
        'alternateName' => 'Videshia - a unit of Tripgation',
        'url' => SITE_URL . '/',
        'logo' => SITE_URL . '/assets/images/favicon.svg',
        'sameAs' => [],
        'contactPoint' => [
            '@type' => 'ContactPoint',
            'telephone' => '+91-78448-19819',
            'contactType' => 'customer service',
            'email' => 'info@tripgation.com',
        ],
    ];
}

function breadcrumb_schema(array $items): array
{
    $list = [];
    foreach ($items as $i => [$label, $itemUrl]) {
        $entry = ['@type' => 'ListItem', 'position' => $i + 1, 'name' => $label];
        if ($itemUrl) {
            $entry['item'] = $itemUrl;
        }
        $list[] = $entry;
    }
    return ['@context' => 'https://schema.org', '@type' => 'BreadcrumbList', 'itemListElement' => $list];
}

function faq_schema(array $faqs): array
{
    $entities = array_map(static fn($f) => [
        '@type' => 'Question',
        'name' => $f['question'],
        'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['answer']],
    ], $faqs);

    return ['@context' => 'https://schema.org', '@type' => 'FAQPage', 'mainEntity' => $entities];
}

function service_schema(string $name, string $description, string $itemUrl): array
{
    return [
        '@context' => 'https://schema.org',
        '@type' => 'Service',
        'name' => $name,
        'description' => $description,
        'url' => $itemUrl,
        'provider' => ['@type' => 'Organization', 'name' => 'Videshia'],
        'areaServed' => 'IN',
    ];
}

function render_breadcrumbs(array $items): string
{
    $html = '<nav class="breadcrumbs" aria-label="Breadcrumb"><ol>';
    $last = count($items) - 1;
    foreach ($items as $i => [$label, $itemUrl]) {
        if ($itemUrl && $i !== $last) {
            $html .= '<li><a href="' . e($itemUrl) . '">' . e($label) . '</a></li>';
        } else {
            $html .= '<li aria-current="page">' . e($label) . '</li>';
        }
    }
    return $html . '</ol></nav>';
}
