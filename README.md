# Videshia — Travel, Visa, Forex & CRM Platform

Public website + internal CRM for videshia.com, built in plain PHP (no framework, no build step)
with an embedded SQLite database. Runs anywhere PHP + PDO SQLite is available — no server setup.

## Structure

```
index.php, about.php, contact.php, travel-services.php, legal.php   Public pages
visa.php                                                             /visa/ hub, country, category & type views
login.php, signup.php, forgot-password.php, dashboard.php           Customer-facing demo account flow
enquiry-submit.php, thank-you.php                                   Hero widget → enquiry pipeline
sitemap.php, sitemap-pages.php, sitemap-visa.php, robots.txt        SEO
404.php                                                              Custom not-found page

crm/                          Internal CRM (noindex, separate auth & RBAC from the public site)
  login.php, logout.php
  dashboard.php               KPIs + charts, scoped by role
  enquiries.php, enquiry.php  List + detail with status workflow, notes, follow-ups
  customers.php, followups.php
  users.php, audit-log.php    Admin only (Super Admin / Admin)
  includes/layout-top.php, layout-bottom.php

includes/                     config, functions (incl. brand mark), db, auth, crm-auth, enquiry engine, seo helpers
database/
  schema.sql                  Full normalized schema (roles, users, customers, enquiries + 7
                               per-service detail tables, countries, visa_categories,
                               country_visa_categories, faqs, documents, followups, audit_logs)
  seed.php, countries-data.php, visa-content.php   Auto-seeds on first run
assets/css/style.css, auth.css   Design tokens (navy/teal, from the brand mark) & all layout CSS
assets/js/main.js                Nav, tabs, password visibility, form UX
router.php                       Dev-only: `php -S localhost:8000 router.php` mirrors .htaccess
                                  clean-URL rules so /visa/... works under the built-in server
```

## Running locally

```bash
php -S localhost:8000 router.php
```

Then open `http://localhost:8000`. The SQLite database at `data/videshia.sqlite` is created and
seeded automatically on first request (schema + ~195 countries + deep content for 20 flagship
destinations + demo accounts). Delete `data/` to reset and reseed.

## Demo accounts

**Public site** (`login.php`) — in-memory demo, not DB-backed yet:
`demo@videshia.com` / `Videshia@123`

**CRM** (`crm/login.php`) — real DB-backed accounts:
- `admin@videshia.com` / `Videshia@123` (Super Admin — full access)
- `visa.consultant@videshia.com` / `Videshia@123` (Visa Consultant — scoped to visa enquiries only)

## Visa content policy

Only 20 flagship countries (US, UK, Canada, Australia, Schengen states, UAE, etc.) carry deep,
reviewed content and are marked `indexable = 1`. The other ~175 countries have real pages with
factual metadata but are marked `indexable = 0` (noindex, excluded from the sitemap) until real
content is added — this avoids thin/duplicate SEO pages. Extend flagship coverage in
`database/visa-content.php` (`flagship_country_facts()`).

## What's not built yet

This is a working Phase 1, not the full 53-section spec. Deliberately deferred:
- Dedicated CRM screens per vertical (hotel/forex/insurance consoles) — the DB tables exist,
  `crm/enquiry.php` renders their fields generically, but there's no bulk/specialized UI yet.
- Document upload (schema exists in `documents` table; no upload UI/storage wired up).
- Real email/SMS/WhatsApp notifications on enquiry creation (architecture is ready — swap in
  provider credentials via environment variables, never hard-coded).
- Google Analytics / Search Console wiring.
- A production DB migration (MySQL/Postgres) — swap the PDO DSN in `includes/db.php` and port
  `database/schema.sql`.
- Full accessibility and performance audit pass.

## Brand

Colors and the logo mark in `includes/functions.php` (`videshia_logo()`) are sourced directly
from the Videshia brand mark: deep navy (`#0A1B3D`) to bright teal (`#17C3C9`).
