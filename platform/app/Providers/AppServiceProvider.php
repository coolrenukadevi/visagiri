<?php

declare(strict_types=1);

namespace App\Providers;

use App\Contracts\Audit\AuditLogger;
use App\Contracts\Documents\DocumentAuthorization;
use App\Contracts\Documents\DocumentStorage;
use App\Contracts\Notifications\EmailProvider;
use App\Contracts\Permissions\PermissionRegistry;
use App\Services\Audit\LogChannelAuditLogger;
use App\Services\Documents\LocalDiskDocumentStorage;
use App\Services\Documents\OwnerScopedDocumentAuthorization;
use App\Services\Notifications\LogEmailProvider;
use App\Services\Permissions\LocalArrayPermissionRegistry;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Foundation contract bindings. Every implementation bound here is
     * explicitly LOCAL DEVELOPMENT SCAFFOLDING (see each class's own
     * docblock) because PostgreSQL 18.x is unavailable in this
     * environment (Architecture Wave 0/1). Business code depends on
     * the interfaces on the left, never these concrete classes
     * directly — swapping a binding here is the only change needed
     * once real infrastructure exists.
     */
    public function register(): void
    {
        $this->app->singleton(PermissionRegistry::class, LocalArrayPermissionRegistry::class);
        $this->app->singleton(AuditLogger::class, LogChannelAuditLogger::class);
        $this->app->singleton(DocumentStorage::class, LocalDiskDocumentStorage::class);
        $this->app->singleton(DocumentAuthorization::class, OwnerScopedDocumentAuthorization::class);
        $this->app->singleton(EmailProvider::class, LogEmailProvider::class);
    }

    public function boot(): void
    {
        // API rate-limit foundation (Architecture Phase 4 Section U /
        // Phase 5 Section 23). Keyed by authenticated user id where
        // available, falling back to IP — same "not session-based"
        // resistance-to-bypass principle as the existing app's
        // DB-backed rate_limits table (Wave 0 finding).
        RateLimiter::for('api', function (Request $request) {
            return Limit::perMinute(60)->by($request->user()?->id ?? $request->ip());
        });
    }
}
