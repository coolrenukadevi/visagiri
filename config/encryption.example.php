<?php
declare(strict_types=1);

/**
 * Template for config/encryption.php — copy this to
 * config/encryption.php and generate a real key with:
 *   php -r "echo bin2hex(random_bytes(32));"
 * config/encryption.php itself is gitignored — a real key should
 * never be committed. See that file's docblock for details.
 */

return [
    'key' => 'CHANGE-ME',
];
