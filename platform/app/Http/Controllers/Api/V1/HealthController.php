<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;

/**
 * Foundation health check. Deliberately does not touch the database —
 * PostgreSQL 18.x is unavailable in this environment (Architecture
 * Wave 0/1), and a health check that fails only because of that
 * environment gap would be misleading about the *application's* health.
 * A database connectivity check is added to this endpoint once
 * PostgreSQL 18.x is reachable.
 */
final class HealthController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json([
            'data' => [
                'status' => 'ok',
                'app' => config('app.name'),
                'env' => config('app.env'),
                'database_check' => 'skipped — PostgreSQL 18.x unavailable in this environment (see WAVE1_IMPLEMENTATION.md)',
                'timestamp' => now()->toIso8601String(),
            ],
        ]);
    }
}
