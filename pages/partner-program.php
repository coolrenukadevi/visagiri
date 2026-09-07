<?php
declare(strict_types=1);

/**
 * /partner-program/ has been consolidated into /partners/ (the real
 * B2B Partner Onboarding page — see pages/partners.php) so there is
 * one canonical URL for this content instead of two near-duplicate
 * landing pages. Permanent redirect preserves any existing inbound
 * links/SEO equity rather than breaking them.
 */
redirect('/partners/', 301);
