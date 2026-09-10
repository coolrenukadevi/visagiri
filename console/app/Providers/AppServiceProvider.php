<?php

namespace App\Providers;

use App\Models\Customer;
use App\Services\EnquiryScope;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Relation::morphMap([
            'customer' => Customer::class,
        ]);

        // Route-level gate for "holds any enquiries.view.* tier" — the fine-grained
        // own/team/all filtering itself happens in EnquiryScope::visibleTo().
        Gate::define('enquiries.access', fn ($user) => EnquiryScope::hasAnyViewPermission($user));
    }
}
