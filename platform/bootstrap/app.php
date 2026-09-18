<?php

use App\Http\Middleware\EnsurePermission;
use App\Http\Middleware\HandleInertiaRequests;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->web(append: [
            HandleInertiaRequests::class,
        ]);

        // API foundation: every "api/*" request gets a consistent JSON
        // error contract (Section 7 — response/error conventions),
        // never an HTML error page.
        $middleware->api(prepend: []);

        $middleware->alias([
            'permission' => EnsurePermission::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(
            fn (Request $request) => $request->is('api/*') || $request->expectsJson(),
        );

        // Single, consistent API error envelope: { "error": { "code",
        // "message" } }. Debug detail (exception class, file/line) is
        // only ever attached when APP_DEBUG is true, never in an
        // environment configured for anything else.
        $exceptions->render(function (\Throwable $e, Request $request) {
            if (! ($request->is('api/*') || $request->expectsJson())) {
                return null;
            }

            $status = method_exists($e, 'getStatusCode') ? $e->getStatusCode() : 500;
            $code = match (true) {
                $status === 401 => 'UNAUTHENTICATED',
                $status === 403 => 'FORBIDDEN',
                $status === 404 => 'NOT_FOUND',
                $status === 422 => 'VALIDATION_ERROR',
                $status === 429 => 'RATE_LIMITED',
                $status >= 500 => 'INTERNAL_ERROR',
                default => 'ERROR',
            };

            $body = [
                'error' => [
                    'code' => $code,
                    'message' => $status >= 500 && ! config('app.debug')
                        ? 'An unexpected error occurred.'
                        : $e->getMessage(),
                ],
            ];

            if (config('app.debug')) {
                $body['error']['exception'] = $e::class;
                $body['error']['file'] = $e->getFile();
                $body['error']['line'] = $e->getLine();
            }

            return response()->json($body, $status ?: Response::HTTP_INTERNAL_SERVER_ERROR);
        });
    })->create();
