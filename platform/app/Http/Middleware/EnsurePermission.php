<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use App\Contracts\Audit\AuditLogger;
use App\Contracts\Permissions\PermissionRegistry;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Server-side authorization gate — mirrors includes/rbac.php's
 * require_permission(). This is the ONLY thing that decides whether a
 * request proceeds; a hidden button or an absent nav link is never a
 * substitute (Architecture Phase 5, restated at every phase since).
 *
 * Usage: ->middleware('permission:visa.view')
 */
final class EnsurePermission
{
    public function __construct(
        private readonly PermissionRegistry $permissions,
        private readonly AuditLogger $audit,
    ) {}

    public function handle(Request $request, Closure $next, string $permissionKey): Response
    {
        $roleSlug = $request->attributes->get('role_slug')
            ?? $request->user()?->role_slug
            ?? null;

        if ($roleSlug === null || ! $this->permissions->roleHasPermission($roleSlug, $permissionKey)) {
            // Architecture Wave 0 found this exact gap in the existing
            // app (permission-denials were not audited) and confirmed
            // it empirically. The new foundation does not repeat it.
            $this->audit->log(
                action: 'permission_denied',
                module: 'authorization',
                actorId: $request->user()?->id,
                context: ['permission_key' => $permissionKey, 'role_slug' => $roleSlug],
            );

            abort(403, 'You do not have permission to access this resource.');
        }

        return $next($request);
    }
}
