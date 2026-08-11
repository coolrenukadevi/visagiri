<?php
declare(strict_types=1);
render_scaffold_page(
    title: 'Visa Requirements',
    description: 'Country-specific visa requirements, documents, fees, and processing time.',
    canonicalPath: $_SERVER['REQUEST_URI'] ?? '/visa/',
    handlerPath: 'visa/index.php',
    plannedInPhase: 'Phase 8 — Country pages (/visa/{country}/ and /visa/{country}/{type}/)'
);
