<?php

declare(strict_types=1);

namespace Tests\Feature\Api;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

final class ErrorContractTest extends TestCase
{
    #[Test]
    public function unknown_api_routes_return_the_standard_error_envelope_not_an_html_page(): void
    {
        $response = $this->getJson('/api/v1/does-not-exist');

        $response->assertStatus(404)
            ->assertJsonStructure(['error' => ['code', 'message']])
            ->assertJsonPath('error.code', 'NOT_FOUND');
    }

    #[Test]
    public function a_permission_protected_route_without_any_role_is_forbidden_not_silently_allowed(): void
    {
        $response = $this->getJson('/api/v1/foundation/ping');

        $response->assertStatus(403)
            ->assertJsonPath('error.code', 'FORBIDDEN');
    }
}
