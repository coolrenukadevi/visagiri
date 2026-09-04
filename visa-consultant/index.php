<?php
declare(strict_types=1);

/**
 * Handles /visa-consultant/ (hub), /visa-consultant/{state}/
 * (overview), and /visa-consultant/{state}/{city}/ (detail).
 * $segments is provided by public/index.php's dispatch closure
 * ($segments[0] === 'visa-consultant'). Mirrors visa/index.php's
 * dispatch shape exactly.
 */

$stateSlug = $segments[1] ?? null;
$citySlug = $segments[2] ?? null;

if ($stateSlug === null) {
    require __DIR__ . '/hub.php';
    exit;
}

$state = state_by_slug($stateSlug);

if (!$state) {
    render_not_found("We couldn't find that state or union territory.");
}

if ($citySlug !== null) {
    $city = city_by_slug((int) $state['id'], $citySlug);

    if (!$city) {
        render_not_found("We couldn't find that city for {$state['name']}.");
    }

    require __DIR__ . '/city.php';
    exit;
}

require __DIR__ . '/state.php';
