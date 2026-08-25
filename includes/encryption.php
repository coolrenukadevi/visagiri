<?php
declare(strict_types=1);

/**
 * Application-level encryption for sensitive fields (currently:
 * passport numbers on customers and visa_applicants). AES-256-GCM
 * with a random IV per value, keyed by ENCRYPTION_KEY (config/site.php
 * — never committed, generated fresh per environment). Values are
 * never stored in plain text; a separate keyed-hash column supports
 * exact-match search without ever decrypting stored rows.
 */

function encrypt_value(?string $plaintext): ?string
{
    if ($plaintext === null || $plaintext === '') {
        return null;
    }

    $key = encryption_key_bytes();
    $iv = random_bytes(12);
    $tag = '';
    $ciphertext = openssl_encrypt($plaintext, 'aes-256-gcm', $key, OPENSSL_RAW_DATA, $iv, $tag);
    if ($ciphertext === false) {
        throw new RuntimeException('Encryption failed.');
    }

    return base64_encode($iv . $tag . $ciphertext);
}

function decrypt_value(?string $encoded): ?string
{
    if ($encoded === null || $encoded === '') {
        return null;
    }

    $raw = base64_decode($encoded, true);
    if ($raw === false || strlen($raw) < 28) {
        return null;
    }

    $key = encryption_key_bytes();
    $iv = substr($raw, 0, 12);
    $tag = substr($raw, 12, 16);
    $ciphertext = substr($raw, 28);

    $plaintext = openssl_decrypt($ciphertext, 'aes-256-gcm', $key, OPENSSL_RAW_DATA, $iv, $tag);
    return $plaintext !== false ? $plaintext : null;
}

/** Keyed hash for exact-match search on an otherwise-encrypted field — never reversible to the plaintext. */
function searchable_hash(?string $plaintext): ?string
{
    if ($plaintext === null || $plaintext === '') {
        return null;
    }
    return hash_hmac('sha256', strtoupper(trim($plaintext)), encryption_key_bytes());
}

function encryption_key_bytes(): string
{
    static $key = null;
    if ($key !== null) {
        return $key;
    }

    $config = require __DIR__ . '/../config/encryption.php';
    $configured = $config['key'] ?? '';
    if ($configured === '' || $configured === 'CHANGE-ME') {
        throw new RuntimeException('ENCRYPTION_KEY is not configured — set encryption_key in config/site.php before storing any encrypted field.');
    }

    // Accept either a raw 32-byte key or a base64-encoded one, so
    // config/site.php can hold a short printable string.
    $decoded = base64_decode($configured, true);
    $key = ($decoded !== false && strlen($decoded) === 32) ? $decoded : hash('sha256', $configured, true);
    return $key;
}
