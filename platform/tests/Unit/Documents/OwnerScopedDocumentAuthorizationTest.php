<?php

declare(strict_types=1);

namespace Tests\Unit\Documents;

use App\Services\Documents\OwnerScopedDocumentAuthorization;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

/**
 * Automates the exact scenario Architecture Wave 0 verified by hand
 * against the existing app (P0-01): a document belonging to one
 * customer must never be retrievable by another, via direct key/ID
 * manipulation.
 */
final class OwnerScopedDocumentAuthorizationTest extends TestCase
{
    #[Test]
    public function the_owner_can_view_and_download_their_own_document(): void
    {
        $auth = new OwnerScopedDocumentAuthorization;
        $key = 'documents/customer/4/01ABC-passport.pdf';

        $this->assertTrue($auth->canView(4, $key));
        $this->assertTrue($auth->canDownload(4, $key));
    }

    #[Test]
    public function a_different_actor_cannot_view_or_download_it(): void
    {
        // Directly mirrors the Wave 0 P0-01 live test: "Bob" (id 5)
        // attempting to reach "Alice's" (id 4) document by manipulating
        // the identifier.
        $auth = new OwnerScopedDocumentAuthorization;
        $key = 'documents/customer/4/01ABC-passport.pdf';

        $this->assertFalse($auth->canView(5, $key));
        $this->assertFalse($auth->canDownload(5, $key));
    }

    #[Test]
    public function a_prefix_match_is_not_sufficient_id_10_does_not_match_id_1(): void
    {
        // Guards against a naive substring-match bug that would treat
        // actor 1 as authorized for actor 10's documents.
        $auth = new OwnerScopedDocumentAuthorization;
        $key = 'documents/customer/10/file.pdf';

        $this->assertFalse($auth->canView(1, $key));
        $this->assertTrue($auth->canView(10, $key));
    }
}
