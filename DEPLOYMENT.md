# Deploying to cPanel

## Requirements

- PHP 8.0+ with the **`pdo_sqlite`** extension enabled. This is the one thing to check
  first — most cPanel hosts have it on by default, but if not, enable it in
  **MultiPHP INI Editor** (cPanel) or ask your host. Without it, every page will show a
  fatal error, since the whole site reads from the database.
- Apache with `mod_rewrite`, `mod_alias`, and `mod_headers` (standard on cPanel).

## Upload

1. In cPanel → **File Manager**, open the folder the domain points at (usually
   `public_html/` for the primary domain, or `public_html/yoursubfolder/` for an addon
   domain/subdomain).
2. **Upload** `videshia-deploy.zip`, then select it and click **Extract** — this unpacks
   the files directly into that folder (the zip has no wrapper folder, so there's no need
   to move files afterward).
3. Confirm `index.php`, `.htaccess`, `includes/`, `crm/`, `database/`, and `assets/` are
   now sitting directly in that folder.

## First run

Nothing else to configure. On the very first page load, `includes/db.php` automatically
creates `data/videshia.sqlite`, builds the schema, and seeds it — 199 countries, deep
content for 20 flagship destinations, visa categories, FAQs, CRM roles, and two demo
accounts. If it doesn't happen automatically, confirm the site's user can write to the
site root (cPanel accounts almost always can).

**If you're deploying to a subfolder** (not the domain root), open
`includes/config.php` and change `define('BASE_PATH', '');` to your subfolder, e.g.
`define('BASE_PATH', '/videshia');` — otherwise internal links and asset paths will be
wrong.

## Demo accounts (change or remove before going fully live)

- Public site login (`/login.php`): `demo@videshia.com` / `Videshia@123`
- CRM (`/crm/login.php`): `admin@videshia.com` / `Videshia@123` (Super Admin),
  `visa.consultant@videshia.com` / `Videshia@123` (Visa Consultant, scoped access)

## What ships vs. what doesn't

The zip contains only what's tracked in git — no local test data, no `.git` history, no
dev-only `router.php` (that's only for running `php -S` locally; Apache uses `.htaccess`
instead). The database is not pre-built or included; it's generated fresh on the live
server so you don't inherit any of the test enquiries created during development.
