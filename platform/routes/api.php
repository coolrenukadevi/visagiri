<?php

declare(strict_types=1);

use App\Http\Controllers\Api\V1\HealthController;
use Illuminate\Support\Facades\Route;

/**
 * API foundation (Architecture Phase 4 Stage 1). Versioned from day
 * one so future contract changes don't break existing callers. Only
 * generic, non-domain-specific endpoints exist here in Wave 1 —
 * Enquiry/Visa/Finance/Apostille domain APIs are explicitly deferred
 * (blocked on Phase 3 Decision #1 and ADR-001/002).
 */
Route::prefix('v1')->name('api.v1.')->group(function () {
    Route::get('/health', [HealthController::class, 'index'])
        ->name('health');

    // Example of the authorization pattern every future domain
    // endpoint follows: rate-limited, then permission-checked
    // server-side — never a client-side-only gate.
    Route::middleware(['throttle:api', 'permission:content.view'])
        ->get('/foundation/ping', fn () => response()->json(['data' => ['message' => 'pong']]))
        ->name('foundation.ping');
});
