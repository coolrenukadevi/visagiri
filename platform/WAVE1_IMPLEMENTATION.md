# Wave 1 Foundation — Implementation Record

Local, isolated development only. No production, staging, or hosting changes. Existing PHP application (`/home/user/visagiri/`, everything outside `platform/`) untouched — `dashboard.php`, `customers.php`, `visa-applications.php`, `sales-crm.php` remain frozen. Rollback point: repository commit `1fc4b6a` (pre-Wave-1 HEAD).

## Environment status

| Component | Locked target | Actual local status |
|---|---|---|
| PHP | 8.5.x | **BLOCKED** — not installable in this sandbox (Launchpad PPA blocked by the environment's outbound network policy, confirmed via `apt-get install php8.5-cli` → `403 Forbidden` from the proxy). **PHP 8.4.19 used as a temporary local execution substitute only** — this is not a change to the locked target. **PHP-RECHECK-01**: the full Foundation test suite must be re-run under PHP 8.5.x before this leaves local development (staging, UAT, production). |
| Composer | — | 2.8.12, working |
| Laravel | 13.x | **Installed** — 13.32.0, via `composer create-project laravel/laravel:^13.0 platform` |
| PostgreSQL | 18.x | **BLOCKED** — not installable in this sandbox (`apt.postgresql.org` blocked by the same proxy policy). No database-dependent work performed; no migrations run; the one migration Laravel's own installer auto-ran against a throwaway SQLite file was reversed immediately (file deleted, `SESSION_DRIVER`/`CACHE_STORE`/`QUEUE_CONNECTION` changed to `file`/`array`/`sync` so the app never requires a database connection). |
| Node/npm | — | v22.22.2 / 10.9.7, already present |
| React | 19.2.x | **Installed** — 19.3.0 (patch-compatible) |
| TypeScript | 5.x | **Installed** — 5.9.3. Note: `npm install typescript` without a version pin initially resolved to 7.0.2 (latest); caught and corrected to the locked 5.x line. |
| Vite | 8.1.x | **Installed** — 8.1.5 (pinned exactly; dependency resolution initially picked 8.3.0, corrected). |
| Tailwind CSS | 4.x | **Installed** — 4.3.3 |
| Inertia.js | — | **Installed** — `inertiajs/inertia-laravel` ^3.3 (server), `@inertiajs/react` 3.7.1 (client) |
| PHPUnit | 12.5 | **Installed** — 12.5.35 (came with the Laravel skeleton) |
| Playwright Test | — | **Installed** — 1.63.0, using the pre-installed sandbox Chromium |

## What was implemented (all verified working, not just written)

- **Application foundation**: Laravel 13 skeleton, environment/config structure, consistent API error envelope (`bootstrap/app.php`), health check (`/api/v1/health`, deliberately does not touch a database).
- **Authentication/Identity**: no database-backed implementation yet (blocked); the 4-way identity-type split from the existing app is documented as the target shape for the Identity foundation, not built against a database in this wave.
- **RBAC**: `App\Contracts\Permissions\PermissionRegistry` + `App\Services\Permissions\LocalArrayPermissionRegistry` — seeds the **real** role/permission inventory verified in Architecture Wave 0 (45 permission keys, 15 roles, from the existing app's actual seed files and a live query), not the earlier illustrative `module.view`/`module.manage` convention. Flat, no inheritance (ADR-004) — unit tested.
- **Server-side authorization**: `App\Http\Middleware\EnsurePermission` — mirrors the existing app's `require_permission()`. No bypass path. Denials are audited (closing the exact gap Wave 0 found empirically in the existing app: permission-denial events were not logged there).
- **Audit**: `App\Contracts\Audit\AuditLogger` + `App\Services\Audit\LogChannelAuditLogger` (local-dev: writes to a dedicated `audit` log channel/file instead of a database table).
- **API foundation**: versioned (`/api/v1/...`), consistent JSON error contract for every exception type, rate-limit foundation (`RateLimiter::for('api', ...)`, keyed by user id or IP).
- **Document foundation**: `DocumentStorage` (local private disk, never public), `DocumentAuthorization` (owner-scoped, mirrors the existing app's verified-correct IDOR-safe pattern).
- **Notification/provider abstractions**: `EmailProvider` (log-based local fake, no real sending), `WhatsAppProvider`, `OcrProvider` interfaces (no implementation — no such integration exists anywhere in the platform today).
- **Frontend foundation**: Inertia + React + TypeScript app shell (`resources/js/Layouts/AppShell.tsx`) — real responsive sidebar (desktop) / slide-over (mobile, not a shrunken desktop copy), accessible (skip link, `aria-label`s, focus-visible states, `role="dialog"`/`role="status"`/`role="alert"`). UI primitives: `Button`, `Card`, `StatusAlert` (never color-only), `LoadingState`, `EmptyState`, `ErrorState`, `PermissionDeniedState`.
- **Testing foundation**: PHPUnit (16 tests, 95 assertions, zero database dependency, all passing) automating the exact P0-01/P0-02 scenarios Wave 0 verified manually against the existing app. Playwright (2 tests, real Chromium browser, passing) verifying the app shell renders and the mobile nav pattern works.

## What was deferred (BLOCKED, not silently skipped)

- All database-backed persistence (users, roles/permissions tables, audit table, document metadata) — PostgreSQL 18.x unavailable.
- Enquiry-domain API/foundation work — blocked on Architecture Phase 3 Decision #1 (`enquiries` vs `visa_enquiries`).
- Finance-adjacent work — blocked on ADR-002.
- Apostille-adjacent work — blocked on ADR-001.
- SLA/Assignment foundation — no schema exists yet (separate future architecture phase required).
- MFA implementation — architecture (ADR-005) is locked, no code written yet (requires the Identity/Authentication database foundation first).

## Files changed outside `platform/`

None. `git status` at the repository root shows only new, untracked content under `platform/`.

## Wave 1 acceptance conditions — closure status

| Condition | Status | Evidence |
|---|---|---|
| PHP-RECHECK-01 (verify under PHP 8.5.x) | **BLOCKED — ENVIRONMENT** | `apt-get install php8.5-cli` fails with `403 Forbidden` from the sandbox's own egress proxy (`ppa.launchpadcontent.net` blocked by organization policy), re-confirmed fresh at acceptance-review time. PHP 8.4.19 remains a temporary execution substitute only, not a redefinition of the target. |
| PostgreSQL 18.x verification | **BLOCKED — ENVIRONMENT** | `apt.postgresql.org` connection rejected (`403`, same proxy policy), re-confirmed fresh at acceptance-review time. No PostgreSQL of any version was substituted; no database connection was ever established. |
| Document-download audit gap | **PASS** | `DocumentDownloadController` now logs both a denied attempt (`document_download_denied`, outcome `denied`) and a successful download (`document_download`, outcome `success`), each with actor id, storage key, and timestamp. Verified by 2 new feature tests (`DocumentDownloadAuditTest`), both passing; full suite re-run afterward with zero regressions (18/18 PHPUnit, 2/2 Playwright). |
