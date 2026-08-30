# Redirect map (301, permanent)

Every legacy URL from the previous static build maps to exactly one clean URL.
Implemented in `.htaccess` (steps 3–6) and mirrored in `tools/router.php` for
local testing. Verified by `php tools/url-audit.php` — zero redirect chains,
zero loops.

## Rule-based (covers all 216 country pages)

| Old URL | 301 → | New URL |
|---|---|---|
| `/visa/{slug}.html` | → | `/visa/{slug}` |
| `/{page}.php` | → | `/{page}` |
| `/index.php`, `/index.html`, `/index` | → | `/` |
| `/{page}/` (trailing slash) | → | `/{page}` |
| `http://…`, `https://convercession.com/…` | → | `https://www.convercession.com/…` |

## Explicit page map

| Old | 301 → | New |
|---|---|---|
| `/index.html` | → | `/` |
| `/countries.html` | → | `/countries` |
| `/payments.html` | → | `/payments` |
| `/visa/request-info.html` | → | `/visa/request-info` |
| `/visa/kenya.html` | → | `/visa/kenya` |
| …(all 216 country pages, by rule) | → | `/visa/{slug}` |

## Notes

- Host + scheme canonicalisation happens in **one** redirect, not two chained
  ones — a `http://convercession.com/x` request lands on
  `https://www.convercession.com/x` in a single hop.
- The `.php`-stripping rule matches on `THE_REQUEST` (the literal request line),
  not `REQUEST_URI`. This is what stops the internal rewrite in step 6 from
  re-triggering the external redirect in step 3 — the classic infinite loop in
  extensionless-PHP setups.
- Old static `.html` files were **deleted**, not left in place. Leaving them
  would have served two indexable copies of every page regardless of redirects.
