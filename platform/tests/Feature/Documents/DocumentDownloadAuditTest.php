<?php

declare(strict_types=1);

namespace Tests\Feature\Documents;

use App\Contracts\Documents\DocumentStorage;
use App\Models\User;
use Illuminate\Support\Facades\File;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

/**
 * Closes Wave 1 acceptance condition 3: both a denied and a successful
 * document download must produce an audit log entry (actor, action,
 * target, timestamp, outcome), not just permission denials raised by
 * EnsurePermission. No database is used — the "authenticated user" is
 * an unpersisted model instance attached directly to the request via
 * actingAs(), consistent with every other test in this wave.
 */
final class DocumentDownloadAuditTest extends TestCase
{
    private string $auditLogPath;

    protected function setUp(): void
    {
        parent::setUp();
        $this->auditLogPath = storage_path('logs/audit-'.now()->format('Y-m-d').'.log');
        File::ensureDirectoryExists(dirname($this->auditLogPath));
        File::put($this->auditLogPath, '');
    }

    #[Test]
    public function a_denied_download_attempt_is_still_denied_and_is_audited(): void
    {
        $response = $this->get('/documents/documents/customer/4/passport.pdf');

        $response->assertStatus(404);

        $log = $this->auditLogContents();
        $this->assertStringContainsString('document_download_denied', $log);
        $this->assertStringContainsString('"outcome":"denied"', $log);
        $this->assertStringContainsString('documents/customer/4/passport.pdf', $log);
    }

    #[Test]
    public function an_authorized_download_succeeds_and_is_audited(): void
    {
        $storage = $this->app->make(DocumentStorage::class);
        $key = $storage->put('customer', 4, 'passport.pdf', 'synthetic test content', 'text/plain');

        $user = new User;
        $user->id = 4;
        $user->exists = true;

        $response = $this->actingAs($user)->get('/documents/'.$key);

        $response->assertOk();
        $response->assertSee('synthetic test content');

        $log = $this->auditLogContents();
        $this->assertStringContainsString('document_download ', $log);
        $this->assertStringContainsString('"outcome":"success"', $log);
        $this->assertStringContainsString('"actor_id":4', $log);

        $storage->delete($key);
    }

    private function auditLogContents(): string
    {
        clearstatcache(true, $this->auditLogPath);

        return File::exists($this->auditLogPath) ? File::get($this->auditLogPath) : '';
    }
}
