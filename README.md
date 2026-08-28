# Paynancial — Platform Rebuild

A ground-up rebuild of the Paynancial marketing site and platform: PHP 8 /
MySQL, no framework, no Node.js build step, shared-hosting/cPanel friendly.
Content and contact details are drawn from Paynancial's existing public
pages (paynancial.in); no business, licensing or certification claims have
been invented — see [Content & claims policy](#content--claims-policy).

## What's in this repo

- **Public marketing site** — home, about, solutions, products, pricing,
  developers, partners, support, contact, careers, security & compliance,
  blog, legal pages. Clean URLs, no `.php` extensions.
- **Left-side login panel** — the header "Login" button opens an off-canvas
  panel (slides from the left) with four tabs: **Customer / Partner /
  Employee / HRMS**. Authenticates via AJAX (`/api/auth/login`), no page
  reload.
- **Role-based dashboards** — `/customer`, `/partner`, `/employee`,
  `/hrms`, `/admin`, `/super-admin`, each with its own layout, sidebar and
  real, database-backed pages (not static mockups).
- **MySQL schema** covering identity/RBAC, payments, HRMS, CMS, support and
  audit logging (`database/schema.sql`, `database/seed.sql`).
- **Security by default** — PDO prepared statements everywhere, CSRF
  tokens on every form/AJAX call, `password_hash()`/`password_verify()`,
  session regeneration on login, idle session timeout, login-attempt
  tracking and lockout, secure cookies, security headers, CSP.

## Architecture

```
config/            config.example.php, config.php (git-ignored)
database/          schema.sql, seed.sql
includes/          bootstrap, db, auth, security, functions, header/footer,
                    login panel, dashboard shell
pages/             public marketing page templates (content only)
customer/          customer portal pages
partner/           partner portal pages
employee/          employee portal pages
hrms/              HRMS pages
admin/             admin panel + CMS
api/                JSON endpoints (auth, contact)
public/            web root: index.php (front controller), .htaccess,
                    assets/ (css/js/images), robots.txt, sitemap.php
```

**Routing.** `public/index.php` is the only PHP file the web server ever
executes directly. `public/.htaccess` rewrites every request to it. It
matches the URL against a small route table and does one of three things:

1. `/api/...` → runs a JSON endpoint in `api/` directly.
2. `/{customer|partner|employee|hrms|admin|super-admin}/{page}` → checks
   the session holds an allowed role (`require_role()`), then renders the
   page inside the dashboard shell (`includes/dashboard-head.php` /
   `dashboard-foot.php`).
3. Everything else → looks up a template in `pages/` and renders it inside
   the marketing shell (`includes/site-head.php`, `header.php`,
   `footer.php`, `site-foot.php`).

Page templates only ever output body content — no `<html>`/`<head>` tags —
so the same template can be wrapped in either shell.

**Adding a new page or dashboard module.** Drop a `.php` file in the right
folder, add its slug to the relevant route table in `public/index.php`
(and the sidebar entry in `includes/dashboard-nav.php` for dashboards). No
other wiring is required — this is what "modular, extendable without a
rebuild" means in practice here.

## Installation (shared hosting / cPanel)

1. **Point the domain's document root at `/public`.** This keeps
   `config/`, `includes/`, `database/`, and every role folder outside the
   web-servable directory — the strongest, simplest protection against
   someone downloading your source or config over HTTP. (A root
   `.htaccess` that denies all requests is included as a second layer of
   defense if your host cannot change the document root.)
2. **Create the MySQL database and import the schema:**
   ```bash
   mysql -u youruser -p your_db < database/schema.sql
   mysql -u youruser -p your_db < database/seed.sql
   ```
3. **Configure the app:**
   ```bash
   cp config/config.example.php config/config.php
   ```
   Edit `config/config.php` — set `DB_*`, `APP_URL`, `APP_SECRET` (a random
   64-char hex string: `php -r "echo bin2hex(random_bytes(32));"`), and
   mail settings. Never commit this file (it's git-ignored).
4. **Set upload storage permissions** (used for CVs, partner/employee
   documents): the app creates `storage/uploads/...` on demand; make sure
   the PHP process can write to the project root, or pre-create
   `storage/uploads` with `0750` permissions.
5. **Enable `mod_rewrite`** (standard on cPanel/Apache) so the `.htaccess`
   files take effect.
6. **First login:** `superadmin@paynancial.com` / `ChangeMe@2026`
   (seeded in `database/seed.sql`). **Change this password immediately**
   via the account's normal password-reset flow — do not leave the seeded
   credential in place.

### Local development

```bash
cp config/config.example.php config/config.php   # point at a local MySQL
php -S 127.0.0.1:8000 -t public
```
Note: PHP's built-in server does not read `.htaccess`, so
`/sitemap.xml` (which relies on the rewrite rule) will only resolve at
`/sitemap.php` locally — it works normally under Apache.

## Security implementation notes

- Passwords: `password_hash()` / `password_verify()` only; never stored or
  logged in plaintext.
- CSRF: every state-changing form and AJAX call carries a per-session
  token, verified with `hash_equals()`.
- Sessions: `HttpOnly`, `SameSite=Lax`, secure flag on in production;
  regenerated on login; idle-timeout enforced server-side
  (`SESSION_LIFETIME_SECONDS`).
- Brute force: attempts are logged to `login_attempts`; an identifier is
  locked out after `LOGIN_MAX_ATTEMPTS` failures for
  `LOGIN_LOCKOUT_MINUTES`. A lightweight session-backed rate limiter also
  throttles the login/contact/forgot-password endpoints per IP.
- All database access goes through PDO prepared statements
  (`includes/database.php`, `ATTR_EMULATE_PREPARES` off).
- Uploads (HRMS CVs) are validated by extension **and** MIME sniffing
  (`finfo`), size-capped, and stored under a random filename outside any
  public/guessable path (`validate_cv_upload()`, `store_upload()`).
- A global exception handler (`includes/bootstrap.php`) prevents stack
  traces or DB errors from ever reaching a visitor in production
  (`APP_DEBUG=false`).
- Role-based access control: every dashboard route is gated by
  `require_role()`; the DB schema additionally supports fine-grained
  `permissions` / `role_permissions` / `user_permissions` for modules that
  need finer control than role alone.

## Content & claims policy

Per the project brief, this build **does not invent** transaction volumes,
customer counts, certifications (PCI DSS, ISO, SOC), regulatory approvals,
or banking/payment-aggregator licenses. Where such information would
normally appear:

- `/security` includes a clearly labeled placeholder section for
  certifications, to be filled in once verified.
- Testimonials on the homepage are explicitly tagged **"Placeholder
  content"** pending real, verifiable quotes.
- Pricing is "Talk to Sales" by default (`settings.pricing_mode`),
  configurable from the codebase without inventing numbers.
- Team/leadership bios are a CMS-ready stub until real, verified profiles
  are supplied.

Verified facts already wired in (from Paynancial's existing site): company
name (Paynancial Technology Pvt. Ltd.), CIN (`U66190BR2024PTC067929`),
support email/phone numbers, and the existing brand mark.

## What's fully built vs. scaffolded

**Fully functional, database-backed:** public marketing site; left-side
login panel and AJAX authentication for all four portals; customer
dashboard/payment history/profile; partner dashboard/transactions/
settlements & commissions; employee dashboard/tasks (support-ticket
queue); HRMS dashboard/employee directory/recruitment (job posting +
applications)/attendance; admin dashboard/user management/transactions/
enquiries/CMS (homepage hero + SEO fields are editable and persisted —
wiring `pages/home.php` to read them instead of its static copy is a
small follow-up noted inline in `admin/cms.php`); contact/enquiry system with
generated `PAY-ENQ-YYYY-NNNNNN` IDs and email notification.

**Scaffolded for the next phase** (table already exists in
`database/schema.sql`, ready for a page to be added following the pattern
above): payouts, payment links, refunds detail views, API key/webhook
management UI, partner document/KYC review UI, HR payroll/performance/
announcements, admin blog/CMS pages beyond the homepage, security audit
log viewer. None of these are faked in the UI — they are simply not yet
built, and the schema/route table are structured so adding them is
additive, not a rewrite.

## Tech stack

HTML5, CSS3 (hand-built design system — no Bootstrap/Tailwind runtime
dependency), vanilla JavaScript (mega menu, login panel, AJAX, animated
counters, scroll reveal, code-copy), PHP 8+, MySQL via PDO, Apache
`mod_rewrite`. No Node.js is required to build or run this in production.
