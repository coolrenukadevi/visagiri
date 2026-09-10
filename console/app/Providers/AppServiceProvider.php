<?php

namespace App\Providers;

use App\Models\AttestationCase;
use App\Models\Customer;
use App\Services\AttestationScope;
use App\Services\EnquiryScope;
use App\Services\FinanceScope;
use App\Services\HrmsScope;
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
            'attestation_case' => AttestationCase::class,
        ]);

        // Route-level gates for "holds any {module}.view.* tier" — the fine-grained
        // own/team/all filtering itself happens in each Scope::visibleTo().
        Gate::define('enquiries.access', fn ($user) => EnquiryScope::hasAnyViewPermission($user));
        Gate::define('attestation.access', fn ($user) => AttestationScope::hasAnyViewPermission($user));
        Gate::define('finance.access', fn ($user) => FinanceScope::hasAnyViewPermission($user));
        Gate::define('hrms.access', fn ($user) => HrmsScope::hasAnyAccess($user));
    }
}
