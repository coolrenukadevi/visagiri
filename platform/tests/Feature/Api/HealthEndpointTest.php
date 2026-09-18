<?php

declare(strict_types=1);

namespace Tests\Feature\Api;

use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

final class HealthEndpointTest extends TestCase
{
    #[Test]
    public function it_responds_without_touching_a_database(): void
    {
        // Deliberately does not set up any DB connection for this
        // test — if HealthController ever starts requiring one, this
        // test fails loudly instead of silently depending on
        // PostgreSQL 18.x being reachable.
        $response = $this->getJson('/api/v1/health');

        $response->assertOk()
            ->assertJsonPath('data.status', 'ok')
            ->assertJsonStructure(['data' => ['status', 'app', 'env', 'timestamp']]);
    }
}
