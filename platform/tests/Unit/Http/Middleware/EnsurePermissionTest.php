<?php

declare(strict_types=1);

namespace Tests\Unit\Http\Middleware;

use App\Contracts\Audit\AuditLogger;
use App\Contracts\Permissions\PermissionRegistry;
use App\Http\Middleware\EnsurePermission;
use Illuminate\Http\Request;
use PHPUnit\Framework\Attributes\Test;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Tests\TestCase;

/**
 * Verifies the exact property Architecture Wave 0 tested manually
 * against the existing app (P0-02): no bypass, denial is audited, a
 * correctly-permitted request proceeds. Automating this is the
 * concrete first step of turning that one-off manual test into a
 * repeatable regression check (Architecture Phase 7 Section 14).
 */
final class EnsurePermissionTest extends TestCase
{
    #[Test]
    public function it_denies_and_audits_when_the_role_lacks_the_permission(): void
    {
        $registry = $this->createMock(PermissionRegistry::class);
        $registry->method('roleHasPermission')->willReturn(false);

        $audit = $this->createMock(AuditLogger::class);
        $audit->expects($this->once())
            ->method('log')
            ->with('permission_denied', 'authorization', null, null, $this->arrayHasKey('permission_key'));

        $middleware = new EnsurePermission($registry, $audit);
        $request = Request::create('/api/v1/foundation/ping');

        $this->expectException(HttpException::class);

        try {
            $middleware->handle($request, fn () => response()->json(['data' => 'unreachable']), 'content.view');
        } catch (HttpException $e) {
            $this->assertSame(403, $e->getStatusCode());

            throw $e;
        }
    }

    #[Test]
    public function it_allows_the_request_through_when_the_role_holds_the_permission(): void
    {
        $registry = $this->createMock(PermissionRegistry::class);
        $registry->method('roleHasPermission')->willReturn(true);

        $audit = $this->createMock(AuditLogger::class);
        $audit->expects($this->never())->method('log');

        $middleware = new EnsurePermission($registry, $audit);
        $request = Request::create('/api/v1/foundation/ping');
        $request->attributes->set('role_slug', 'super-admin');

        $response = $middleware->handle($request, fn () => response()->json(['data' => 'ok']), 'content.view');

        $this->assertSame(200, $response->getStatusCode());
    }

    #[Test]
    public function it_denies_when_no_role_is_present_at_all(): void
    {
        // Directly exercises the P0-02 concern: an unauthenticated
        // caller with no role must never be treated as implicitly
        // authorized, regardless of which permission is requested.
        $registry = $this->createMock(PermissionRegistry::class);
        $registry->expects($this->never())->method('roleHasPermission');

        $audit = $this->createMock(AuditLogger::class);
        $audit->expects($this->once())->method('log');

        $middleware = new EnsurePermission($registry, $audit);
        $request = Request::create('/api/v1/foundation/ping');

        $this->expectException(HttpException::class);
        $middleware->handle($request, fn () => response()->json(['data' => 'unreachable']), 'content.view');
    }
}
