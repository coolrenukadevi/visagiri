<?php
/**
 * Sign-in test suite. Run from the CLI:  php tools/auth-tests.php
 *
 * Covers the parts of OAuth that are easy to get subtly wrong and impossible
 * to eyeball: the open-redirect guard, the authorize URL (is the PKCE
 * challenge really S256 of the verifier we kept? is the secret absent?),
 * every callback rejection path, and the account-linking rules — including
 * the case where an unverified email must NOT reach an existing account.
 *
 * It uses throwaway credentials and a scratch copy of the SQLite store, so it
 * never touches a real provider or a real user database. Exits non-zero on
 * failure, so CI can gate on it.
 */
declare(strict_types=1);
putenv('GOOGLE_CLIENT_ID=test-google-id');
putenv('GOOGLE_CLIENT_SECRET=test-google-secret');
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../lib-php/auth.php';
require __DIR__ . '/../lib-php/oauth.php';

$fail = 0;
function ok(bool $c, string $m) { global $fail; if (!$c) { $fail++; echo "  FAIL $m\n"; } else echo "  ok   $m\n"; }

// Throwaway store: never run these assertions against real accounts.
foreach (['', '-wal', '-shm'] as $suffix) {
    @unlink(CACHE_PATH . '/' . AUTH_DB_FILE . $suffix);
}
if (file_exists(CACHE_PATH . '/' . AUTH_DB_FILE)) {
    fwrite(STDERR, "refusing to run: could not clear the test database\n");
    exit(2);
}

echo "--- open redirect guard ---\n";
foreach ([
  ['/track-visa', '/track-visa'],
  ['/visa/kenya?visaType=Tourist+Visa', '/visa/kenya?visaType=Tourist+Visa'],
  ['//evil.com', '/account'],
  ['https://evil.com', '/account'],
  ['/\\evil.com', '/account'],
  ['', '/account'],
  ['javascript:alert(1)', '/account'],
  ["/ok\nSet-Cookie: x=1", '/account'],
] as [$in, $want]) {
  ok(auth_safe_next($in) === $want, "next(" . str_replace("\n", "\\n", $in) . ") -> " . auth_safe_next($in));
}

echo "\n--- authorize URL ---\n";
$_SESSION = [];
$p = oauth_provider('google');
ok(oauth_configured($p), 'google reads as configured with env credentials');
$u = oauth_authorize_url('google', $p, '/track-visa');
$q = [];
parse_str(parse_url($u, PHP_URL_QUERY), $q);
ok(str_starts_with($u, 'https://accounts.google.com/'), 'points at Google');
ok($q['client_id'] === 'test-google-id', 'carries the client id');
ok(!str_contains($u, 'test-google-secret'), 'SECRET never appears in the redirect URL');
ok($q['redirect_uri'] === 'https://www.convercession.com/auth/callback/google', 'redirect_uri built from SITE_ORIGIN');
ok($q['response_type'] === 'code', 'authorization code flow');
ok($q['code_challenge_method'] === 'S256', 'PKCE S256');
ok(strlen($q['state']) === 64, 'state is 32 random bytes');
ok(isset($q['nonce']), 'OIDC nonce present for Google');
ok($q['scope'] === 'openid email profile', 'minimum identity scopes');
$verifier = $_SESSION['oauth']['verifier'];
$expected = rtrim(strtr(base64_encode(hash('sha256', $verifier, true)), '+/', '-_'), '=');
ok($q['code_challenge'] === $expected, 'challenge is S256(verifier) held in the session');
ok($_SESSION['oauth']['next'] === '/track-visa', 'return destination remembered server-side');

echo "\n--- callback validation ---\n";
$saved = $_SESSION['oauth'];
[$prof, $err] = oauth_handle_callback('google', $p, ['state' => 'wrong-state', 'code' => 'abc']);
ok($prof === null && $err === 'state', 'mismatched state rejected');
$_SESSION['oauth'] = $saved;
[$prof, $err] = oauth_handle_callback('facebook', $p, ['state' => $saved['state'], 'code' => 'abc']);
ok($prof === null && $err === 'session', 'callback for a different provider rejected');
$_SESSION['oauth'] = $saved;
[$prof, $err] = oauth_handle_callback('google', $p, ['state' => $saved['state'], 'error' => 'access_denied']);
ok($prof === null && $err === 'cancelled', 'user cancellation reported as cancelled');
ok(!isset($_SESSION['oauth']), 'pending state consumed (single use)');
[$prof, $err] = oauth_handle_callback('google', $p, ['state' => $saved['state'], 'code' => 'abc']);
ok($prof === null && $err === 'session', 'replayed callback finds nothing');
$_SESSION['oauth'] = ['provider' => 'google', 'state' => 'st', 'verifier' => 'v', 'next' => '/', 'issued' => time() - 3600];
[$prof, $err] = oauth_handle_callback('google', $p, ['state' => 'st', 'code' => 'abc']);
ok($err === 'expired', 'stale sign-in expires');

echo "\n--- user store ---\n";
[$u1, $o1] = auth_upsert_user(['provider'=>'google','id'=>'g-1','email'=>'Ravi@Example.com','email_verified'=>true,'name'=>'Ravi Kumar','avatar'=>'https://x/i.png']);
ok($o1 === 'created' && $u1['email'] === 'ravi@example.com', 'first sign-in creates the account (email lower-cased)');
[$u2, $o2] = auth_upsert_user(['provider'=>'google','id'=>'g-1','email'=>'ravi@example.com','email_verified'=>true,'name'=>'Ravi Kumar','avatar'=>'']);
ok($o2 === 'signed_in' && (int)$u2['id'] === (int)$u1['id'], 'same identity signs into the same account');
ok($u2['avatar_url'] === 'https://x/i.png', 'existing avatar not blanked by a provider that sent none');
[$u3, $o3] = auth_upsert_user(['provider'=>'facebook','id'=>'f-9','email'=>'ravi@example.com','email_verified'=>true,'name'=>'Ravi K','avatar'=>'']);
ok($o3 === 'linked' && (int)$u3['id'] === (int)$u1['id'], 'second provider, same VERIFIED email -> links to one account');
[$u4, $o4] = auth_upsert_user(['provider'=>'x','id'=>'x-7','email'=>'ravi@example.com','email_verified'=>false,'name'=>'Ravi','avatar'=>'']);
ok($o4 === 'created' && (int)$u4['id'] !== (int)$u1['id'], 'UNVERIFIED email does NOT hijack the existing account');
$ids = auth_user_identities((int)$u1['id']);
ok(count($ids) === 2, 'account shows both linked providers');
[$u5, $o5] = auth_upsert_user(['provider'=>'x','id'=>'x-8','email'=>null,'email_verified'=>false,'name'=>'No Email','avatar'=>'']);
ok($o5 === 'created' && $u5['email'] === null, 'X account with no email is allowed');
[$u6, $o6] = auth_upsert_user(['provider'=>'x','id'=>'x-9','email'=>null,'email_verified'=>false,'name'=>'Also None','avatar'=>'']);
ok($o6 === 'created' && (int)$u6['id'] !== (int)$u5['id'], 'two email-less accounts do not collide on NULL');

echo "\n" . ($fail ? "$fail FAILURES\n" : "all auth checks passed\n");
exit($fail ? 1 : 0);
