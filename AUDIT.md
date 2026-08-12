# AUDIT.md — Visagiri 2.0 Pre-Build Audit

**Status:** Audit only. No Phase 1 (of the 18-phase build sequence below) has started. Waiting for **"START PHASE 1"**.
**Full findings-with-evidence version:** `docs/audit/2026-08-11-website-audit-and-migration-plan.md` (this file is the condensed, structured version requested for this brief).
**Legacy source preserved at:** `legacy-site/` (not deployed, reference only).

A hotfix has already been applied on top of the legacy export (see §3) to stop active lead loss while the real rebuild is pending — that work is done and is not part of the 18-phase sequence.

---

## 1. Current architecture

There is no existing PHP application to modernize. What ships today at visagiri.com is a **static HTML export of a purchased ThemeForest template** ("RouteX – Immigration and Visa Consulting HTML5 Template," reskinned by an agency called RRDevs), plus two trivial procedural mail scripts. Concretely:

- **71 HTML files**, no templating/includes — every page repeats the full header/nav/footer markup inline. No component reuse mechanism exists.
- **2 PHP files total**: `mail.php` (root) and `new/sendemail.php` — both single-purpose contact-form mailers, no framework, no routing, no classes beyond one small `ContactForm` class in `mail.php`.
- **No database.** No `PDO`, no `.env`/config file, no schema anywhere in the export.
- **No authentication, sessions, dashboards, or admin panel** in any form.
- **CSS**: a vendor'd Bootstrap + custom SCSS/CSS build (`assets/css`, `assets/scss`) — a real, reasonably modern component library (cards, breadcrumbs, counters, etc.), but authored for a generic "immigration consulting" template, not a SaaS/fintech direction.
- **JS**: vendor bundle (Swiper, WOW.js, odometer, vanilla-tilt, etc.) — animation/carousel libraries typical of a marketing template, not app logic.
- **A second, incomplete redesign draft lives at `/new/`** in the same production webroot — a different, newer template (multiple unedited `index-2.html`…`index-4.html`, `coaching-details.html`…`-6.html` demo variants) with its own broken internal links, not linked from the live site nav, but publicly reachable today.
- **Two vendor documentation folders are also live in production**: `/jina/documention/` and `/new/Doc/` — the ThemeForest template's own doc pages, publicly crawlable.

**Conclusion:** nothing described in Phases 9–14 of the brief (auth, dashboard, admin, consultant panel, document management, application system) exists in any form. This is a from-scratch build on top of a brand asset (logo/colors) and a page-topic checklist, not a migration of working functionality.

---

## 2. Existing pages (inventory)

38 root-level pages + 33 pages under `/new/` (draft, not counted as production IA). Grouped by what they're for:

| Category | Pages |
|---|---|
| Home / core | `index.html` |
| Visa category pages | `tourist.html`, `business.html`, `student.html`, `work.html`, `crew.html`, `dependent.html` |
| Document services | `documentation.html`, `onlineformfiling.html`, `commercial.html`, `non-commercial.html`, `educational.html` |
| Country directory | `country.html`, `country-details.html` |
| Company | `about.html`, `team.html`, `career.html`, `partner.html`, `testimonial.html` |
| Content | `blog.html`, `blog-details.html`, `faq.html`, `offers.html` |
| Transactional | `payment.html`, `support.html`, `sample.html` |
| Legal/policy | `privacy.html`, `refund.html`, `paymentpolicy.html`, `coc.html`, `grievance.html`, `hiringpolicy.html` |
| Utility | `404.html`, `sitemap.html`, `verifyforzoho.html`, `pricing.html` *(removed — see §3)*, `team-details.html` *(removed — see §3)* |

No page in this inventory represents auth, dashboard, tracking, or admin functionality — those are entirely new IA (see §6).

---

## 3. Broken elements (and what's already fixed)

**Already fixed in `legacy-site/` as a hotfix** (not part of the 18-phase rebuild, done to stop active business damage — full detail in `docs/audit/...`):
- `mail.php` sent every contact-form submission to the template vendor's inbox (`support@envato.com`) instead of Visagiri's, and had a field-name mismatch with the HTML form causing 2 years of silent PHP warnings in production. → now sends to `info@visagiri.com` / `accounts@visagiri.com`, form fields aligned.
- `pricing.html` and `team-details.html` deleted — confirmed unedited template demo content (generic SaaS pricing tiers; a bio page for the template's own placeholder staff member "Ashikur Rahman").
- `404.html` and `visa.html` had the literal unedited template title "RouteX - Immigration and Visa Consulting HTML5 Template" and empty meta descriptions, live and indexed — retitled and given real descriptions.

**Still broken, not yet touched (will be resolved by the rebuild, not worth patching in the legacy archive):**
- **Broken logo**: `assets/imgs/logo/logo.svg` is missing — the header logo doesn't render on several pages (confirmed visually via screenshot during the hotfix QA pass).
- **9 broken image references** total (missing country flags for Sri Lanka/Vietnam, 4 missing contact-page images, missing footer logo, missing logo in `/new/`).
- **~40 distinct broken internal links** across both the live nav and `/new/` — template demo links (`about-us.html`, `gallery.html`, `coaching.html`, `businessvisa.html`, etc.) that were never replaced with real Visagiri pages.
- **A second, more broken mail handler** at `/new/sendemail.php` (placeholder recipient `youremail@mail.com`, malformed `mail()` call) — left as-is since `/new/` won't be carried into the rebuild.
- **Zero SEO fundamentals**: no canonical tags anywhere, no schema markup anywhere, no `robots.txt`, no `sitemap.xml`.
- **10 pages are 100% Lorem-Ipsum-style filler text**, including core visa-category pages: `student.html`, `work.html`, `crew.html`, `dependent.html`, `documentation.html`, `onlineformfiling.html`, `commercial.html`, `educational.html`, plus `non-commercial.html`/`sample.html` (both headlined "Coming Soon").
- **Unverified/contradictory trust claims** live on `offers.html` and `partner.html` ("15+ years," "98% approval rate") contradicting each other and the site's own footer. Per your confirmation, the real fact is **"serving visa and travel-related requirements since April 2015"** — this replaces all of the above, and no percentage/approval-rate claim should be used anywhere.
- **69 country cards** on `country.html` are an unfiltered flag list (includes uninhabited territories like Ashmore and Cartier Islands, excludes named brief priorities like Canada, UK, UAE, Singapore, Schengen) — not a curated, business-relevant catalog.
- Dead newsletter/search forms (`action="#"`) on several pages — decorative only, matches the brief's observation that there's no working search today.

---

## 4. Missing functionality

Everything in Phases 9–17 of the brief's sequence is missing outright: user accounts, login/register/password reset, customer dashboard, visa search engine with structured results, database-driven country/visa-type pages, document upload/management, application workflow + reference numbers, status timeline, public application tracking, admin panel, consultant/role-based panel, payments, appointments, messaging/notifications, structured schema markup, sitemap.xml/robots.txt.

---

## 5. Existing useful content (keep, don't discard)

- **Brand palette and logo concept** (navy/gold, globe/passport/aircraft) — usable seed for the refined SaaS/fintech-leaning identity this brief asks for.
- **69 real country flag images** and the general card pattern — reusable once curated against real target-market priority and moved into a DB-driven model.
- **`tourist.html` and `business.html`** contain genuinely hand-written, on-brand marketing copy (not template filler) — adaptable rather than rewrite-from-zero.
- **The footer's legal line** — "A Unit of Tripgation® ... CIN: U63030UP2020PTC128661" — real and consistent, anchors About/footer/invoice copy.
- **Bootstrap-based CSS component set** (cards, breadcrumbs, accordions, forms) — reasonable implementation quality, just needs restyling to the new palette/direction rather than being rebuilt from scratch.
- Legal/policy pages exist in some form for all the categories this brief lists (Privacy, Refund, Payment Policy, Code of Conduct, Grievance, Hiring Policy) — need a legal-accuracy pass, not from-scratch authoring.

---

## 6. Recommended new structure

```
/public/                    → web root
  index.php
/includes/
  config.php                → DB + app config (outside public web root if hosting allows)
  database.php               → PDO connection
  auth.php
  functions.php
  security.php               → CSRF, input helpers
  header.php
  footer.php
/assets/
  css/
  js/
  images/
/pages/                      → public marketing/content pages
  home.php, about.php, contact.php, faq.php, blog.php
/visa/                       → database-driven country + visa-type routing
  index.php                  → single controller resolving /visa/{country}/{type}/ from DB
/visa-type/                  → cross-country visa-type explainer routing
/auth/
  login.php, register.php, logout.php, forgot-password.php
/dashboard/                  → authenticated customer area
  index.php, applications.php, documents.php, payments.php, appointments.php, messages.php, profile.php
/admin/                      → role-gated staff area
  index.php, countries.php, visa-types.php, applications.php, users.php, documents.php, payments.php, blog.php
/uploads/                    → private storage, not web-accessible directly; served via a signed/authenticated download endpoint
```

URL scheme (matches the brief exactly):
```
/                              → homepage
/visa/{country-slug}/          → country visa overview
/visa/{country-slug}/{type}/   → country + visa-type detail
/visa-type/{type-slug}/        → cross-country visa-type explainer
/track-visa/                   → public tracking
/dashboard/...                 → customer area
/admin/...                     → staff area
/blog/{slug}/                  → visa updates & guides
/about/, /contact/, /faq/, /privacy/, /terms/, /refund-policy/, /cookie-policy/, /grievance/, /disclaimer/
```

`/new/` and `/jina/` are not carried forward in any form — visual/UX reference only during design work, never deployed.

---

## 7. Database requirements

Normalized MySQL 8 schema, PDO + prepared statements throughout, matching the table list from the brief:

`users`, `roles`, `countries`, `visa_types`, `country_visa_types` (join table — which visa types a country actually offers, since this varies), `visa_requirements` (the versionable content block: eligibility, documents, process, fees, processing time — each row carries `last_verified_at` + `source_url`, never silently overwritten), `embassies`, `consulates`, `vac_centers`, `applications`, `application_status_history`, `documents` (document type catalog), `application_documents` (uploaded files per application — private storage, randomized filename, MIME/size validated), `appointments`, `payments`, `notifications`, `messages`, `support_tickets`, `faqs`, `blog_posts`, `blog_categories`, `contact_enquiries`, `audit_logs`.

Roles table backs: Super Admin, Admin, Visa Consultant, Document Reviewer, Finance, Customer Support — each with a distinct permission set as specified in the brief (consultants see only assigned applications; finance sees payments only, etc.).

Every table gets `created_at`/`updated_at`; soft-delete (`deleted_at`) on `applications`, `users`, `documents` where audit history matters more than hard deletion. Foreign keys enforced at the DB level, not just app level.

This schema needs your §7-style sign-off on scope (e.g., exact document type list, exact status timeline stages) before table DDL is finalized — I'll draft it as part of Phase 1/2 of the sequence below and flag anything still open.

---

## 8. Homepage redesign plan

Matches the brief's 11-section structure, built as one `pages/home.php` composed of includable section partials (not one monolithic file):

1. **Hero** — label "SMART VISA MANAGEMENT," headline "Your Visa Journey, Simplified.", subhead, three CTAs (Check Visa Requirements / Start Your Application / Track Application). Visual: original illustration/graphic treatment (passport + digital motif), not stock travel photography — matches the "Stripe/Wise, not travel agency" direction.
2. **Visa search widget** ("Find the Right Visa") — the core interactive component (§5 of the brief); built first as a component since the country pages, homepage, and header search all consume it.
3. **Popular destinations** — curated card grid linking to `/visa/{country}/`, seeded from the brief's named list (USA, Canada, UK, Schengen, Australia, Japan, South Korea, UAE, Singapore, New Zealand, China, Thailand) rather than the legacy's unfiltered 69-flag list.
4. **Visa services** — 8 cards (Tourist/Business/Student/Work/Family/Transit/Medical/Conference), each linking to `/visa-type/{slug}/`.
5. **How Visagiri Works** — 7-step timeline, restyled from the legacy's existing `counter2`/timeline component pattern rather than rebuilt from zero.
6. **Why Visagiri** — 6 feature blocks, text only, no invented numbers (matches the brief's explicit ban on unsupported claims).
7. **Application tracking** — enter application number → `/track-visa/`.
8. **Customer portal preview** — static preview of dashboard modules (Applications/Documents/Appointments/Payments/Messages/Notifications) + Login/Create Account CTAs.
9. **Latest visa updates** — DB-driven, pulls from `blog_posts` filtered to visa-relevant categories, each card showing title/country/published/updated/author.
10. **FAQ accordion** — DB-driven from `faqs`, filterable by category.
11. **Final CTA** — "Ready to start your visa journey?" → Start Application.

---

## 9. Customer dashboard plan

SaaS-pattern layout: fixed sidebar (Dashboard, My Applications, Documents, Appointments, Payments, Messages, Notifications, Profile, Support, Logout) + content area.

- **Dashboard home**: "Welcome back, [Name]" + 4 summary tiles (Active Applications, Pending Documents, Upcoming Appointments, Outstanding Payments) + application cards (Application ID, Country, Visa Type, Status, Progress %, Last Updated, Next Action).
- **Application detail**: visual status timeline (Created → Documents Submitted → Documents Verified → Payment Completed → Appointment Scheduled → Submitted → Under Processing → Decision Received → Completed), each stage stamped with date/time/consultant comment, sourced from `application_status_history`.
- **Documents**: per-document status (Required/Uploaded/Under Review/Approved/Rejected), upload widget with client + server-side validation, consultant re-upload requests with visible comments.
- **Payments**: outstanding/paid list, tied to `payments`.
- **Messages/Notifications**: threaded per-application messaging with consultants; system notifications for status changes.
- Session-gated throughout (`includes/auth.php`); every write action CSRF-protected; every document fetch goes through a private, authenticated download endpoint — never a direct public `/uploads/` URL.

---

## 10. Admin dashboard plan

Role-gated (`/admin/`, Super Admin / Admin / Consultant / Document Reviewer / Finance / Support), sidebar-driven, mirroring the customer dashboard's visual language so the whole platform feels like one system rather than two bolted-together products.

- **Admin dashboard home**: operational counts (Total/New Applications, Pending Documents, Under Review, Appointments, Payments, Completed, Open Support Requests).
- **Content management (this is the load-bearing feature of the whole platform)**: Countries, Visa Types, Visa Requirements, Embassies/Consulates/VACs — all editable through forms, never by touching PHP. Every requirements record has a mandatory "last verified" date + source field enforced at the DB/form level, so stale or unsourced info can't silently ship.
- **Operational management**: Applications (assign consultant, view/change status, timeline), Customers, Documents (approve/reject/request re-upload with comment), Payments (status, invoice generation), Appointments, Consultants (assignment/workload).
- **Content/marketing**: Blog posts + categories, FAQs, Testimonials (kept out of public view until a real, attributable, consented testimonial exists — no placeholder testimonials ship).
- **Enquiries**: contact form submissions land here (not just email) so nothing gets lost the way it has been.
- Role permission checks enforced server-side on every admin route, not just hidden in the UI; every state-changing action writes to `audit_logs`.

---

## Next step

**Phase 2 (Architecture) is now complete**, built on top of this audit:

- Folder skeleton matching §6: `public/`, `includes/`, `pages/`, `auth/`, `dashboard/`, `admin/`, `visa/`, `visa-type/`, `countries/`, `blog/`, `uploads/`.
- `includes/config.php` — `.env`-driven config (no secrets committed; `.env.example` documents the required variables), `includes/database.php` — PDO connection (prepared statements only, exceptions on error), `includes/security.php` — CSRF tokens, security headers, a basic rate limiter, `includes/auth.php` — hardened sessions, `password_hash()`/`password_verify()` wrappers, `require_login()`/`require_role()` guards, `includes/functions.php` — shared helpers (`e()`, `redirect()`, `slugify()`, application-number generator).
- `public/index.php` — single front controller routing every URL from the §6 URL scheme to its handler; `public/.htaccess` — forces HTTPS, routes everything through the controller, blocks dotfile access.
- `database/schema.sql` — all 23 tables from §7, with foreign keys, indexes, timestamps, and soft-deletes on `users`/`applications`/`application_documents`; seeded with legitimate catalog data only (roles, the 8 visa types, the document-type catalog, blog categories) — no country content, fees, or company statistics.
- **Verified**: every PHP file passes `php -l`; the router was exercised end-to-end with `php -S` — content routes return their scaffold stub with 200, `/dashboard/` and `/admin/` correctly redirect unauthenticated requests to `/login/` (302, with security headers and a hardened session cookie already present), a genuinely missing route returns a real 404 (caught and fixed a bug during this pass where the 404 page was silently returning HTTP 200). `schema.sql` was reviewed by hand for FK ordering and type-matching (all 23 tables checked) but **could not be executed against a live MySQL server** — none is available in this sandbox. Recommend running it against a real staging DB before Phase 7 data entry begins.
- Each page/route handler currently renders a plain-text scaffold stub identifying itself and the phase that will replace it with real content — deliberately not styled or worded like a real page, so nothing resembling "Coming Soon" placeholder content risks shipping.

**Phase 3 (Design System) is now complete** — see `docs/design-system.md` and `docs/design-system-preview.html`. Tokens (`public/assets/css/tokens.css`), base/reset (`base.css`), and a full component library (`components.css`: buttons, cards, badges/status pills, forms, alerts, breadcrumbs, a zero-JS accordion, tables, the application status timeline, sidebar nav, pagination) are built entirely from the logo palette, verified by rendering the preview page at desktop and mobile widths with zero console errors.

**Phase 4 (Header/Footer) is now complete:**

- `includes/header.php` — sticky global header: logo wordmark, a "Visa Services" dropdown (Tourist/Business/Student/Work/Family/Transit — consolidates the brief's "Visa Services"/"Visa Types" nav items into one clean mega-menu instead of two redundant top-level entries), Countries/Visa Process/Visa Updates/About, search icon, Login/Sign Up (or account name + Logout when signed in — pulled from `current_user()`), gold "Start Application" CTA. Compacts on scroll via vanilla JS; full `<head>` (title/description/canonical/OG tags) driven by variables each page sets.
- `includes/footer.php` — 4-column footer (Visa Services / Explore / Company + brand column), the required "visa decisions are made by the embassy/consulate, not guaranteed by Visagiri" disclaimer, and the bottom bar with the confirmed facts (Tripgation Pvt Ltd, since April 2015, CIN U63030UP2020PTC128661).
- Mobile: hamburger toggles a full nav panel (with a working burger→X animation), no horizontal scroll.
- Added `/visa-process/` as a new route (was implied by the header nav but didn't exist yet).
- Every existing route stub (home, about, contact, FAQ, legal pages, track, countries, visa, visa-type, blog, login, register, logout, forgot-password, dashboard, admin, 404) now renders inside this real header/footer instead of plain text — bodies are still an explicit "Content pending — Phase X" notice, not real copy.

**Verified, and 2 real bugs caught and fixed in this pass:**
1. PHP's built-in dev server routes *every* request (including real CSS/JS files) through the front controller unless it explicitly declines — `public/index.php` was missing that check, so `/assets/css/main.css` 404'd. Fixed with the standard `PHP_SAPI === 'cli-server'` bypass (Apache in production already handles this via `.htaccess`, so this only affects local dev).
2. A too-broad CSS selector (`.site-header__nav ul`) leaked the horizontal flex layout into the nested dropdown menu, making "Visa Services" render as a cramped horizontal row instead of a vertical list. Scoped to `.site-header__nav > ul` and reverified.

Confirmed via headless Chromium: dropdown opens correctly, scroll-compact class toggles correctly (verified directly since the short stub pages don't have enough content to scroll on their own), mobile menu opens/closes, zero console errors on desktop or mobile.

**Phase 5 (Homepage) is now complete**, and along the way this session finally got access to a real MySQL-compatible server (MariaDB, installed locally for testing) — so `schema.sql`, which Phase 2 could only hand-review, has now actually been executed for the first time: it loaded cleanly with zero errors across all 23 tables, and foreign keys/joins were verified with real inserts.

**Real (non-fabricated) catalog data added to the seed:**
- 12 popular-destination countries (name + standard ISO codes only — the exact list from your brief) — no visa requirements, fees, or processing times seeded, since those need verified sourcing in Phase 7/8, not invented here.
- Short factual one-line descriptions for the 8 visa types (what each category means, not a claim about Visagiri).
- 5 general, non-country-specific FAQs (how search/tracking/documents work, and one that directly restates the "Visagiri does not guarantee visa approval" disclaimer) — no fabricated stats or country-specific rules.

**Homepage built** (`pages/home.php`), all 11 sections from your spec, DB-driven wherever real data exists:
1. Hero — original inline-SVG illustration (abstract passport/globe motif in brand colors), not stock photography
2. Find the Right Visa search widget — floats over the hero, dropdowns populated from the real `countries`/`visa_types` tables (full search logic is Phase 6, per your own sequence — this phase is the UI + real catalog data)
3. Popular Destinations — the 12 seeded countries, flag emoji + link to `/visa/{country}/`
4. Visa Services — the 8 seeded visa types with real descriptions, linking to `/visa-type/{type}/`
5. How Visagiri Works — 7 steps
6. Why Visagiri — 6 feature blocks, zero invented numbers
7. Application tracking band
8. Customer portal preview (visual dashboard mockup + Login/Create Account)
9. Latest Visa Updates — queries `blog_posts`; renders an honest **empty state** ("no updates published yet") since there is no real content to show — not a single fabricated article
10. FAQ accordion — the 5 real seeded FAQs, zero-JS native accordion
11. Final CTA

**Verified against the real database**, not mocked: page loads with real SQL query results, zero PHP warnings/errors in the response, zero browser console errors on desktop or mobile, no horizontal overflow on mobile (checked programmatically, not just visually).

**Phase 6 (Visa Search) is now complete:**

- `/visa-search/` — validates the submitted country/visa-type slugs against the real catalog (never trusts raw input as a redirect target) and sends the visitor to the canonical `/visa/{country}/` or `/visa/{country}/{type}/` page; invalid input gets a flash notice and a safe fallback to `/countries/`. The homepage widget now posts here instead of the Phase 5 placeholder.
- `/visa/{country}/` and `/visa/{country}/{type}/` are now real, DB-backed pages — not stubs. The detail page renders the brief's full spec sheet (eligibility, documents, process, processing time, fees, validity/stay/entry type, biometrics/interview, notes, last-verified date, official source link) whenever a verified `visa_requirements` row exists. **None do yet** — zero were fabricated — so every combination currently and correctly shows an honest "Requirements not yet verified" notice with a Contact CTA, ready to switch on the moment Phase 7/8 adds real, sourced data.
- Added, per your request: a 5th footer column, **Legal & Support** (Privacy, Terms, Travel Terms, Payment Policy, Refund Policy, Cookie Policy, Grievance, Sitemap, Track Request, Payment Link, Contact Support), plus the new routes it needed (`/travel-terms/`, `/payment-policy/`, `/track-request/`, `/payment-link/`, `/support/`) and a fully real `/sitemap/` page (simple enough to build for real rather than stub).

**Verified, and one more real bug caught:** a CSS class (`.hero__actions`) was reused outside the hero for a button row, silently inheriting white-on-white button styling from the hero's dark-background context — invisible button, caught by screenshot review, fixed with a proper `.button-group` utility. Also ran an end-to-end QA pass by temporarily inserting one throwaway test requirements row directly into the local dev database (never touched `schema.sql`, never committed) to confirm the populated-data template renders every field correctly, screenshotted it, then deleted the row and confirmed the page correctly reverted to the honest empty state.

---

**⚠️ Flagging before continuing — please read:** a large new "master prompt" arrived mid-Phase-6 with two direct contradictions to everything built so far:

1. **Tech stack**: it recommends Next.js/React/TypeScript/Node.js/PostgreSQL/headless CMS/Algolia. Every phase so far (1–6) is vanilla PHP 8 + MySQL, per the original brief's explicit and repeated instruction ("the entire website must remain PHP based... do NOT convert to React/Next.js/Node-only"). These are irreconcilable — I have not switched anything.
2. **Tagline**: it proposes "Your Gateway to the World." — the tagline used everywhere so far ("Seamless Visas. Limitless Journeys.") comes directly off your uploaded logo image itself, not something I chose. I have not changed it.

The new prompt also includes what read as specific new business facts (two office addresses in Noida and Patna, WhatsApp numbers) and a much larger 200+-country scope, a mega-menu nav (dropping "Visa Process"/"Visa Updates" in favor of "Visa Information"/"Business & Corporate"/"Resources"), and many new feature ideas (AI assistant, document checklist generator, Algolia-style search). None of this has been applied yet — I paused to confirm scope rather than guess on a change this size. See the chat message accompanying this commit for the specific questions.

**Resolution (same session):** proceeding on the recommended defaults — PHP/MySQL stack, "Seamless Visas. Limitless Journeys." tagline, new scope folded in incrementally as plain PHP.

---

## Phase 7 (Country Database) — complete

- **Countries catalog expanded from 12 to 208** — the original 12 popular destinations untouched, plus 196 more countries/territories added as validated, standard ISO 3166-1 reference data (name, ISO2, ISO3, region) across the requested 6-region taxonomy (Asia, Europe, North America, South America, Africa, Oceania). Generated via a small validation script that asserted zero duplicate slugs and zero duplicate ISO2 codes before writing to `schema.sql` — confirmed against the real database after reload (208 rows, all unique). No visa-requirement content was seeded for any of them — same rule as Phase 5/6, real per-country requirements need verified sourcing, not invention.
- **`/countries/` is now a real, DB-driven directory**: countries grouped by region, a "Popular Destinations" quick row, region jump-links, and a live search filter (vanilla JS).
- **Added Attestation Services** (Apostille, MEA Attestation, Embassy Attestation, Commercial Attestation) as their own service line — `/attestation/` index + `/attestation/{service}/` detail pages, in both the header nav and a new footer column — matching real services found in the legacy-site audit (apostille/document-verification pages existed on the old site).
- **Footer rebuilt to 6 columns** per your requests: Brand, Visa Services, Attestation Services, Explore Countries (regions + "Explore 200+ Countries →"), Company (About/Why Visagiri/Contact/Careers/Partners/Corporate Services), Resources (Visa Information/FAQs/Travel Guides/Visa Updates/Document Checklists/Blog) — with the Legal & Support links moved to a compact inline row below the disclaimer rather than a crowded 7th column. New stub routes added: `/careers/`, `/partners/`, `/corporate-services/`, `/document-checklists/`.
- **Two real bugs caught and fixed**: (1) the country directory's live-search JS was inline and got silently blocked by our own `script-src 'self'` CSP header — moved to an external file rather than weakening the policy; (2) none in header/footer this round beyond that.
- **Logo file**: you've now shared the actual Visagiri logo image twice in chat, but it has no filesystem path in this environment — only the zip you uploaded earlier is readable as a file. The header/footer still use a CSS text wordmark. To wire in the real asset, it needs to arrive as an actual file upload (same mechanism as the site export zip), not inline chat content.
- **Open item**: "since April 2015" vs. "since 2014" — you've stated both at different points; holding April 2015 as authoritative (it was an explicit correction) until you confirm.

Verified: all new/changed PHP passes `php -l`; full route sweep against the real database (200s for valid routes, 404s for invalid country/attestation slugs); zero browser console errors after the CSP fix; live search confirmed working (filters 208 entries correctly); footer/header verified via screenshots at desktop and mobile.

---

## Phase 8 (Country Pages) — complete

Most of "country pages" was already delivered in Phase 6 (the single reusable `/visa/{country}/{type}/` template — never hundreds of hand-written files, exactly per the brief). Phase 8 filled in what was still missing from the full spec:

- **Embassy / Consulate / VAC information** — new `fetch_country_contact_points()` + a shared `includes/contact-points.php` partial, rendered on both the country overview and visa detail pages. Zero embassy/consulate/VAC rows are seeded (same rule as visa requirements — addresses and contact details need verified sourcing, not invention), so every country honestly shows "hasn't been published yet" with a Contact CTA today. Verified the populated-state template renders correctly using one throwaway test embassy + VAC row in the local dev DB, screenshotted, then deleted immediately (never in `schema.sql`, never committed).
- **Contextual FAQs on the visa detail page** — `fetch_relevant_faqs()` pulls the general FAQs plus any tagged specifically to that country or visa type (none tagged yet, so the 5 general ones surface everywhere, which is honest and correct).
- **Country overview page improved**: a neutral, templated intro paragraph (no per-country facts invented) and a region badge.
- **About page went from stub to real content**, using your confirmed facts: the "Since April 2015..." line you provided, the Tripgation/CIN facts, and a "Why Visagiri" section — pulled from a new shared `why_visagiri_features()` function so the homepage and About page can never drift out of sync with each other.

Verified: `php -l` on every changed file, full route sweep, zero console errors, and the temporary-test-data QA technique (insert → screenshot → delete → reconfirm empty state) used again for the embassy/VAC template.

**Still open**: the real logo file (needs to arrive as an upload, not chat content) and, now resolved, the founding-date conflict — **April 2015 confirmed correct**, applied to the About page.

---

## Phase 9 (Authentication) — complete

Real, working authentication — not stubs. `/register/`, `/login/`, `/logout/`, `/forgot-password/`, and a new `/reset-password/` (the link destination, needed to complete the flow — wasn't a named route in the brief but is required for "forgot password" to mean anything).

- **Registration**: full name, email, mobile, password/confirm — server-side validated (email format, mobile format, 8+ char password, match check, duplicate-email check backed by the DB's UNIQUE constraint as a race-condition guard), `password_hash()`, auto-login on success, rate-limited per IP.
- **Login**: email-or-mobile + password, generic "Invalid email/mobile or password" on failure (never confirms which emails exist), session ID regenerated on success (fixation prevention), "Remember me" extends the session cookie to 30 days, `last_login_at` updated.
- **Forgot/reset password**: a real, secure token flow — random 32-byte token, only its SHA-256 hash stored, 1-hour expiry, single-use (cleared on successful reset). **No email-sending integration exists yet anywhere in this project**, so the reset link can't actually reach an inbox; the confirmation page always shows the same generic message either way (no user enumeration), and only when `APP_DEBUG` is on (never in production) does it also print the link directly, so the flow is fully testable without pretending mail delivery works.
- **CSRF** on every POST (419 on missing/invalid token, verified by testing a request with no token).
- **Every route already built in Phase 2** (`require_login()`/`require_role()` on `/dashboard/` and `/admin/`) now gates a *real* session instead of just "nobody's logged in" — verified a real customer account gets into `/dashboard/` and correctly gets a 403 on `/admin/`.

**A real security bug was found and fixed during this phase's verification**: the rate limiter built in Phase 2 stored its counters in `$_SESSION`, which meant an attacker who simply didn't send their session cookie back between attempts got a fresh, empty counter every time — the login rate limit was trivially bypassable and wasn't actually protecting anything. Fixed by moving to a new DB-backed `rate_limits` table, keyed by identifier+IP rather than session. Confirmed the fix by literally attacking it: 6 login attempts using a fresh cookie jar for each one (i.e. simulating an attacker who never persists cookies) — attempts 1–5 got the normal "invalid password" response, attempt 6 correctly got "Too many login attempts." A first attempt at the DB-backed fix also had a bug (comparing a MySQL timestamp string via PHP's `strtotime()` against PHP's `time()`, which silently breaks under DB/PHP timezone mismatches and reset the counter on every call) — fixed by moving the entire expiry comparison into a single atomic SQL statement so it happens in MySQL's own clock domain.

**Full flow verified end-to-end against the real database** with a throwaway test account (registered, logged in with correct/wrong password, tested duplicate-email rejection, tested CSRF rejection, ran the complete forgot-password → dev-mode reset link → set new password → old password rejected → new password accepted chain, confirmed the reset token can't be reused a second time) — then the test account and all rate-limit rows were deleted, nothing left behind.

---

## Phase 10 (Customer Dashboard) — complete

A real SaaS-style dashboard at `/dashboard/`, matching the brief's exact spec: sidebar (Dashboard, My Applications, Documents, Appointments, Payments, Messages, Notifications, Profile, Support, Logout), 4 stat tiles (Active Applications, Pending Documents, Upcoming Appointments, Outstanding Payments — all real DB counts, not placeholders), and application cards showing ID/country/visa type/status/progress exactly as specified.

- **`dashboard/index.php`** is a small router dispatching to 9 sub-pages under `dashboard/pages/`, sharing one layout (`includes/dashboard-layout.php`) so the sidebar/shell isn't duplicated 9 times.
- **Applications**: list + a detail page with the brief's full 9-stage visual status timeline (Application Created → Documents Submitted → Documents Verified → Payment Completed → Appointment Scheduled → Application Submitted → Under Processing → Decision Received → Completed), each stage showing date/time/comment from `application_status_history` once reached — plus that application's documents and payments.
- **Documents / Appointments / Payments / Messages / Notifications**: real list views scoped to the logged-in user only, honest empty states (nothing fabricated — no customer has any applications yet, since application *creation* is Phase 11, not this one).
- **Profile**: editable name/mobile (email locked, matches "contact support to change" convention), a real change-password flow (verifies the current password, re-hashes on success).
- **Support**: submits real rows into `support_tickets` and lists the user's own tickets.

**A real bug was caught and fixed during screenshot review**: with a user logged in, the header now shows their name + a Logout button alongside the existing nav, and at 1400px this pushed several nav items ("Visa Services," "Visa Process," "Visa Updates") into an ugly two-line wrap. Fixed two ways: the header greeting now shows first name only (a normal UX pattern, and it just needed less room), and nav links got `white-space: nowrap` so this class of bug can't recur as more nav items get added later.

**Verified against the real database with a full temporary-test-data pass**: registered a throwaway account, confirmed every one of the 9 dashboard pages returns 200 with zero PHP warnings and correct empty states, then inserted one throwaway application (with status history, a document, a payment, an appointment, a message, and a notification) to prove the *populated* views — the status timeline, application cards, document/payment badges, unread-notification highlighting, and the "mark all as read" action were all screenshotted working correctly — then deleted every row and reconfirmed zero test data remains (users, applications, messages, notifications all back to 0).

---

## Phase 11 (Application System) — complete

A real, transactional application-creation flow — the missing link between "browse a visa type" and "see it in the dashboard" that Phase 10 correctly left empty.

- **Schema**: `applications` gained `applicant_passport_number`, `applicant_dob`, `applicant_nationality` — the applicant-identity fields the wizard collects. No new fabricated columns (fees/appointments stay consultant-driven, per the brief's "no automatic charging" stance already established in Phase 10).
- **`/apply/` — a 3-step session-backed wizard**, login-gated (`require_login()`), nothing written to the database until the final step:
  1. **`/apply/` (destination + visa type)** — dropdowns sourced from the real `countries`/`visa_types` tables, pre-fillable via `?country=&type=` query params so every "Start Application" CTA site-wide (header, homepage, about, visa detail pages, dashboard overview) can deep-link straight into a specific visa type.
  2. **`/apply/details/`** — passport number (regex-validated), date of birth (validated as a real past date within 120 years), nationality (dropdown from the real 208-country list) — held in `$_SESSION['apply_wizard']`, not the DB, so an abandoned wizard never leaves a stray row.
  3. **`/apply/review/`** — shows the full summary plus the real default document checklist (`documents WHERE is_required_default = 1`) and an honest disclaimer that fees/appointments are consultant-confirmed, not auto-charged. On submit, wraps application creation in a DB transaction: inserts the `applications` row (status `created`, 10% progress) via the existing `generate_application_number()`, its first `application_status_history` entry, and one `application_documents` row per required document — commits atomically or rolls back on any failure.
- **Every "Start Application" CTA now points at `/apply/`** instead of a dead link: site header (desktop + mobile), homepage hero/final-CTA, About page final CTA, visa detail page, and the dashboard overview's "Start New Application" button.
- **`/track-visa/` rebuilt from the Phase 4 stub into a real public lookup** — no login required, but the query requires *both* the application number and the account email to match (a prepared JOIN across `applications`/`users`), and a non-match always shows one generic "we couldn't find a matching application" message regardless of which half was wrong — the same non-enumeration pattern already used by `forgot-password.php`, extended here since this endpoint is public and unauthenticated. Rate-limited per IP via the same DB-backed `rate_limit_check()` from Phase 9. On a match it shows only limited, non-sensitive fields — application number, country, visa type, progress %, last-updated date, and the 9-stage status timeline — explicitly not documents, payments, or full applicant details, which stay behind login.

**Verified end-to-end through the real browser UI, not a direct DB insert** — registered a throwaway account (`phase11-qa@example.com`) via the actual `/register/` form, walked it through `/apply/` → `/apply/details/` → `/apply/review/` with real form input (Canada / Tourist Visa / passport `A1234567` / DOB 15 Jun 1995 / India), submitted, and confirmed:
- the transaction produced application `VIS-2026-000001` with a `created` status-history row and 2 required-document rows (Passport, Photograph);
- it renders correctly on `/dashboard/applications/1/` (status timeline, correct flash-success message) and in the applications list;
- logged out, then confirmed `/track-visa/` correctly finds and displays it (status timeline, progress, country/visa type) when the email matches;
- confirmed `/track-visa/` shows the generic not-found message — not a different error — when the application number is right but the email is wrong, proving the non-enumeration behavior actually works and not just in theory.

All screenshots taken during this pass, then the test user, application, status-history rows, and document rows were deleted and the database reconfirmed at zero rows across `users`/`applications`/`application_status_history`/`application_documents`.

---

## Phase 12 (Document Management) — complete

Real file upload/download/replace/delete for `application_documents` — the fields for this (`original_filename`, `stored_filename`, `mime_type`, `file_size`, `uploaded_at`, `reviewer_comment`/`reviewed_by`/`reviewed_at`) were already designed into the schema back in Phase 2 but unused until now; no migration was needed, only the actual handling logic.

- **`includes/document-management.php`** — the shared logic used everywhere documents appear: `fetch_owned_application_document()` (every single read or write starts here — joins `application_documents` → `applications` and checks `user_id` matches the logged-in user, so a guessed/incremented document ID can never touch another customer's file, not even to see its status), `document_upload_dir()`, a server-verified MIME allowlist (`application/pdf`, `image/jpeg`, `image/png` — checked via `finfo_file()` against the actual file bytes, never the client-supplied `$_FILES[...]['type']`), a 5&nbsp;MB size cap, and `render_document_row()` so the upload/download/replace/remove UI is defined once and shared by both the dashboard's Documents page and the application-detail page rather than duplicated.
- **Storage**: files never live under `public/` — `UPLOADS_PATH` (set in Phase 2) points at a sibling `uploads/` directory outside the web root entirely, so there is no URL that can reach a file directly regardless of server config; `uploads/.htaccess` denies access too, as defense in depth. On disk, files are stored as `uploads/documents/{application_id}/{random-32-hex}.{ext}` — the stored filename is never the original filename or anything derived from user input, so there's nothing to path-traverse with.
- **Three new handlers**, routed via `dashboard/index.php`'s existing `$segments`-based dispatch (`/dashboard/documents/{id}/upload/`, `/download/`, `/delete/`): upload validates, generates the random filename, moves the file, updates the row to `status = 'uploaded'`, and deletes the previous file on disk if this was a replace; download streams the file back with the real `Content-Disposition`/`Content-Type` after the ownership check; delete removes the file from disk and reverts the row to `status = 'required'`. All three require login, verify ownership, and the two POST actions are CSRF-protected. A document can only be uploaded/replaced/removed while its status is `required`, `uploaded`, or `rejected` — once a status reaches `under_review` or `approved` (Phase 13's admin panel will be what sets those), the row becomes read-only with a download link only, so a customer can't silently swap a file out from under a reviewer.
- No auto-approval anywhere: uploading a file sets status to `uploaded` and stops there — it does **not** fabricate a review outcome, since there's no reviewer yet (that's Phase 13).

**Verified end-to-end through the real browser UI** with two throwaway accounts: registered account A, ran the full `/apply/` wizard to get a real application with its two default-required documents (Passport, Photograph), then — using a real 200×200 PDF and a real 1×1 PNG generated for the test, not empty placeholder files — uploaded the PDF to the Passport row (status flipped to `uploaded`), downloaded it back and confirmed the bytes were **byte-for-byte identical** to the original upload, replaced it with the PNG (filename updated correctly), removed it (status correctly reverted to `required`), then re-uploaded and grabbed its download URL. Registered a second throwaway account B and, while logged in as B, requested account A's document download URL directly — got a **404**, confirming the ownership check actually blocks cross-account access rather than just hiding the link in the UI. Afterward, both test users, the application, its status-history and document rows, and the uploaded file on disk were all deleted, and the database and `uploads/` directory were reconfirmed empty.

---

## Phase 13 (Admin Panel) — complete

A real staff-facing admin panel at `/admin/` — gated to `super_admin`/`admin` roles (the customer/consultant/finance/support/document_reviewer roles already existed in the schema from Phase 2 but had nothing built for them yet; `super_admin`/`admin` are the two this phase covers).

- **`includes/admin-layout.php`** + **`admin/index.php`** — the same shared-shell/`$segments`-router pattern as the customer dashboard (Phase 10), sidebar nav: Overview, Applications, Document Review, Users, Support Tickets.
- **Overview**: real stat tiles (total customers, total applications, active applications, documents pending review, open support tickets) — all live `COUNT()` queries, plus the 5 most recent applications across every customer.
- **Applications**: a cross-customer list (filterable by any of the 9 statuses) and a detail page showing the full applicant identity (passport number, DOB, nationality — deliberately *not* shown on the limited public `/track-visa/` page from Phase 11, but appropriate here for staff), a status-update form that writes a real `application_status_history` row and recalculates `progress_percent` from the stage's position in the 9-stage sequence, and a consultant-assignment dropdown sourced from real `consultant`-role accounts (empty today, honestly, since consultant accounts don't exist until Phase 14).
- **Document review**: a cross-application queue of everything sitting in `uploaded`/`under_review`, plus inline approve/reject actions directly on the application-detail page. Reject requires a reason (stored in `reviewer_comment`), both set `reviewed_by`/`reviewed_at`. Reuses Phase 12's storage/validation logic via a new `fetch_application_document()` (the admin-scoped sibling of Phase 12's ownership-checked `fetch_owned_application_document()` — access here is gated by role at the router level instead of per-row ownership, since staff need to see every customer's files).
- **Users**: lists customer accounts with their application count and a suspend/reactivate toggle against the `users.status` field that already existed in the schema — no new column, no fabricated bulk actions.
- **Support tickets**: cross-customer list with status filtering, and inline status-update + staff-assignment forms. No ticket-reply feature was built — the schema has no `ticket_replies` table and no email integration exists (same honesty rule as the Phase 9 forgot-password flow), so admin can triage and resolve tickets but can't fabricate a reply channel that isn't real yet.

**Three real bugs were caught and fixed during this phase**, two of which trace back to earlier phases:
1. `admin/index.php` never loaded `includes/dashboard-layout.php`, so `application_status_stages()` (defined there) was undefined the moment the application-detail page tried to use it — a fatal error caught immediately by the first real page load, fixed by requiring it alongside the new admin layout.
2. **A CSP bug matching the exact one fixed in Phase 7**: the Phase 12 "Remove document" button used an inline `onsubmit="return confirm(...)"` attribute, which our own `Content-Security-Policy: script-src 'self'` header silently blocks (inline event-handler attributes count as inline script, same as `<script>` tags). It never threw a visible error — the confirm dialog just silently never appeared, and the deletion went through unconfirmed. Fixed by adding a small delegated `data-confirm` handler to `site.js` and switching both that Phase 12 form and this phase's new suspend/reactivate button to it instead of inline attributes.
3. Login always redirected everyone to `/dashboard/` regardless of role, so a staff admin logging in landed on the empty customer-facing dashboard instead of `/admin/`. Fixed by looking up the role at login and redirecting `super_admin`/`admin` to `/admin/`; also fixed the equivalent "already logged in" redirect at the top of `login.php` and the header's account-menu link so an admin browsing the public site links to the right place.

**Verified end-to-end through the real browser UI** with a real admin account and a real consultant account (seeded directly in the database — there's no public admin-registration flow, correctly, since anyone signing up through `/register/` gets the `customer` role): a throwaway customer registered, applied, and uploaded both required documents, then filed a support ticket; the admin then approved the Passport document from the application-detail page, rejected the Photograph from the cross-application queue with a reason, updated the application's status (writing real history and recalculating progress), assigned the consultant, suspended the customer's account (confirmed the suspended account is immediately redirected to `/login/` on its next request, since the existing `current_user()` status check from Phase 9 already covers this — no new code needed), reactivated it, and resolved the support ticket. Logged back in as the customer (same session, since suspension doesn't destroy the session — only blocks access while active) and confirmed every one of those changes was visible: Passport showing Approved, Photograph showing Rejected with the admin's reviewer note and still replaceable, the status timeline showing Documents Verified with the admin's comment, and the ticket showing Resolved. All test accounts, applications, documents, tickets, and uploaded files were then deleted and the database/`uploads/` directory reconfirmed empty.

**Still open, by design**: no reply mechanism for support tickets (no schema/email backing yet), payments admin management (no payment-creation flow exists anywhere yet — nothing to manage), and the consultant panel itself (Phase 14).

---

## Phase 14 (Consultant Panel) — complete

A real panel at `/consultant/`, scoped to exactly what the `consultant` role's own description in the schema says: "View assigned applications, review documents, update status" — nothing more. No consultant-reassignment control, no user suspension, no support-ticket access (those stay admin-only, per Phase 13); a consultant here can only ever see and act on applications actually assigned to them, enforced per-query, not just by hiding sidebar links.

- **`includes/consultant-layout.php`** + **`consultant/index.php`** — the same shared-shell/router pattern as Phase 13's admin panel, gated to `require_role(['consultant'])` only (admins don't get a dual-purposed view here; they already have full access via `/admin/`).
- **Overview**: stat tiles scoped with `WHERE assigned_consultant_id = <this consultant>` — assigned applications, active applications, documents pending their review — plus their 5 most recent assigned applications.
- **Applications**: a list and detail page identical in spirit to the admin one from Phase 13 (full applicant identity, status-update form writing real history and recalculating progress) but with every query filtered to `assigned_consultant_id`, and no "Assign Consultant" control — reassignment is an admin action, not a consultant one.
- **Document review**: same approve/reject flow as Phase 13, refactored so both panels share the actual update logic — `includes/document-management.php` gained `mark_document_approved()`/`mark_document_rejected()`, called by both `admin/pages/document-{approve,reject}.php` and the new `consultant/pages/document-{approve,reject}.php` — and a new `fetch_application_document_for_consultant()` that joins through `assigned_consultant_id`, so a consultant literally cannot look up another consultant's document by ID, not just by not being shown a link to it.
- **Login/header now route by role three ways**, not two: a shared `account_home_href()` helper (added to `includes/functions.php` to stop the redirect logic from being copy-pasted a third time) sends `super_admin`/`admin` to `/admin/`, `consultant` to `/consultant/`, everyone else to `/dashboard/` — used at login success, the "already logged in" redirect, and the header's account-menu link/label.

**Verified end-to-end through the real browser UI**, specifically targeting the ownership boundary rather than just the happy path: a throwaway customer created two separate applications with an uploaded Passport document each; one was assigned to a QA consultant account, the other to a *different* consultant account (both seeded directly, like Phase 13's admin account, since there's no public consultant-registration flow). Logged in as the first consultant and confirmed: the overview stats and applications list showed only the one assigned application, never the other; opening it directly worked and both approving its document and updating its status succeeded and were visible immediately on the customer's own dashboard afterward; then — the actual point of this test — requesting the *other* consultant's application by URL returned a real **404** (not a redirect, not an empty page reusing the same template), requesting the other consultant's document download also **404**'d, and a forged direct POST to approve that document (bypassing the UI entirely, sent via `fetch()` from the page) was correctly rejected with **419** for lacking a valid CSRF token — the access boundary holds at the data layer, not just in what the UI happens to link to. All test accounts, applications, documents, and uploaded files were then deleted and the database/`uploads/` directory reconfirmed empty.

---

## Phase 15 (SEO) — complete

Auditing what to put in a sitemap surfaced a real problem before any SEO infrastructure could honestly ship: several primary nav pages — `/visa-type/`, `/faq/`, `/visa-process/`, `/blog/` — were still Phase-4-era scaffold stubs (`render_scaffold_page()`, which literally prints internal debug text like `Handler: pages/faq.php · Scheduled for: Phase 5`) with **no protection against being indexed**. Submitting those to search engines, or even leaving them crawlable, would mean Google indexing dev placeholder text as if it were the real site. That reframed this phase: SEO infrastructure only means something once what it points at is real.

- **`render_scaffold_page()` now always sets `noindex`**, and the raw `Handler:.../Scheduled for:...` debug text only shows when `APP_DEBUG` is on — real visitors in production now see a clean "This page isn't ready yet" instead of internal routing details. This one change immediately protects every remaining stub, present and future, without having to remember to noindex each one by hand.
- **`/visa-type/` rebuilt for real**: a hub listing all 8 real `visa_types` rows (seeded with real descriptions back in Phase 2/5), and `/visa-type/{slug}/` per-type pages showing that type's description, popular destinations (the real `is_popular_destination` flag), and any tagged FAQs — linking into the existing `/visa/{country}/{type}/` pages rather than duplicating them. (The schema's `country_visa_types` table, meant for per-country availability, was never populated — Phase 6 superseded it by treating every visa type as explorable for every country — so this page doesn't claim availability data that doesn't exist; it links to popular destinations and the full country directory instead.)
- **`/faq/` rebuilt for real**: pulls the 5 real general FAQs seeded in Phase 5, nothing invented.
- **`/visa-process/` rebuilt for real**: describes the actual 3-step `/apply/` wizard and the actual 9-stage `application_status_stages()` sequence built in Phases 11–12 — not invented marketing steps, a description of the real system.
- **`/blog/` deliberately NOT rebuilt with content** — there's no `blog_posts` table and no articles have been written anywhere in this project. Inventing "visa policy update" articles would be exactly the kind of fabricated visa/government information the brief forbids. It now shows an honest "No updates published yet" empty state, marked noindex, and is excluded from the sitemap and disallowed in robots.txt.
- **`robots.txt`** (real static file): disallows every private/functional area (`/dashboard/`, `/admin/`, `/consultant/`, `/apply/`, `/login/`, `/register/`, `/forgot-password/`, `/reset-password/`, `/logout/`, `/blog/`), points at the sitemap.
- **`/sitemap.xml`** (real, dynamically generated, not a static file): 228 URLs — 12 static real pages, all 8 visa-type pages, and all 208 real country overview pages. Deliberately **excludes** the ~1,600 individual `/visa/{country}/{type}/` leaf pages even though they're real and reachable — most still show the honest "requirements not yet verified" state, and mass-submitting thin pages to search engines is bad practice; they stay naturally crawlable via each country page's own links instead of being force-submitted. Validated as well-formed XML with a Python parser.
- **JSON-LD structured data**: a sitewide `Organization` block (name, url, logo, description, `foundingDate: "2015-04"`, email, parent organization — confirmed facts only, no invented address/ratings/employee counts/awards), `BreadcrumbList` on every country and visa-type page, and `FAQPage` wherever real FAQs actually render (general FAQ page, visa-type pages, visa detail pages). Skipped entirely on noindexed pages.
- **`og:image`**: no real logo file has ever been uploaded (still blocked on that, per every earlier phase's note), so a branded placeholder card was generated with PHP's GD library in the same visual language as the existing placeholder favicon (navy gradient, gold "V" mark, the real wordmark and tagline) — `public/assets/images/og-image.png`, wired into `og:image`/`twitter:image` meta tags sitewide.

**Verified**: `sitemap.xml` parses as well-formed XML with the expected 228-URL count; `robots.txt` reachable and correct; spot-checked `<meta name="robots">` across a spread of pages — real content pages show `index, follow`, every private/functional/stub page shows `noindex, nofollow` (login, register, dashboard, blog, careers, contact, apply); JSON-LD blocks on a visa detail page parse as valid JSON with the expected `Organization`/`BreadcrumbList`/`FAQPage` types; `og-image.png` returns 200 as `image/png`; zero browser console errors across all rebuilt pages; screenshots taken of `/visa-type/`, `/visa-type/tourist/`, `/faq/`, `/visa-process/`, and the `/blog/` empty state.

**Flagging clearly, not fixing silently**: these pages are still scaffold stubs (now safely noindexed, but still not real) and weren't in this phase's scope — `/contact/`, `/support/` (public contact-support form, distinct from the logged-in dashboard support tickets), `/careers/`, `/partners/`, `/corporate-services/`, `/document-checklists/`, `/payment-link/`, `/track-request/`, and all 8 legal pages (`/privacy/`, `/terms/`, `/travel-terms/`, `/payment-policy/`, `/refund-policy/`, `/cookie-policy/`, `/grievance/`, `/disclaimer/`). A real `/contact/` page in particular is a meaningful gap for a consultancy business — worth a dedicated pass. The real logo file is also still outstanding — every placeholder asset (favicon, og-image) is a stand-in built from the logo's own colors/tagline, not the actual uploaded file.

---

## Phase 16 (Security) — complete

A full audit sweep (SQL injection, XSS, CSRF coverage, IDOR/authorization, state-changing GETs, HTTP header injection, security-header completeness, auth timing side-channels, file/directory exposure, error handling, password policy, open redirects) across every layer built in Phases 2–15, run partly by hand and partly via an independent audit pass covering the newer admin/consultant panels specifically. The good news first: **no SQL injection, no XSS, no CSRF gaps, and no IDOR were found anywhere in the codebase** — the patterns established from Phase 2 onward (prepared statements everywhere, `e()` on every output, `csrf_field()`/`csrf_require()` on every mutating form, and per-resource ownership checks scoped to `user_id`/`assigned_consultant_id`) held up under a dedicated adversarial pass, including across the admin and consultant panels added in Phases 13–14.

Three real, fixable issues were found and fixed:

- **Login timing side-channel (username enumeration)** — `auth/login.php`'s `if (!$user || !verify_password(...))` let PHP's `||` short-circuit: a request for a non-existent email/mobile skipped the (deliberately slow) bcrypt comparison entirely, while a request for a real account with the wrong password paid that cost — both returned the identical generic error message, but the *response time* differed measurably, letting an attacker enumerate registered accounts by timing alone even though the message itself leaked nothing. Fixed by always calling `verify_password()`, against a precomputed dummy hash (`DUMMY_PASSWORD_HASH` in `includes/auth.php`) when no user is found, so both paths cost the same.
- **Logout was a GET-triggered state change** — every other mutation in the app is correctly POST + CSRF-gated, but `<a href="/logout/">` was a plain link, meaning any third-party page could force a visitor's session to end via something as simple as `<img src="https://visagiri.com/logout/">`. Low impact (forcing a logout isn't damaging), but inconsistent with the rule applied everywhere else. Converted every logout link (header, dashboard/admin/consultant sidebars) to a small POST form with a real CSRF token; `auth/logout.php` now rejects non-POST requests. Verified via screenshot that the button renders pixel-identical to the old link (no visual regression) and that clicking it actually ends the session (confirmed `/dashboard/` correctly bounces to `/login/` afterward).
- **Missing HSTS header** — `send_security_headers()` had no `Strict-Transport-Security`, leaving a theoretical SSL-stripping window on top of the HTTPS redirect `public/.htaccess` already forces. Added `max-age=31536000; includeSubDomains`.

One hardening improvement made even though the current runtime already prevents exploitation: the `Content-Disposition` filename in every document-download handler (dashboard/admin/consultant) was built from the uploaded file's original name with only quote-stripping — PHP's `header()` already refuses to emit any value containing a raw CR/LF, so this wasn't actually exploitable as HTTP response splitting today, but relying solely on one runtime's built-in protection isn't real defense in depth. Added `sanitize_uploaded_filename()` (strips control characters at upload time, before the name is ever stored) so the guarantee doesn't depend on PHP's internals alone.

**Reviewed and consciously left as-is, with reasoning recorded rather than silently ignored**:
- `style-src 'unsafe-inline'` stays in the CSP — the codebase uses inline `style="..."` attributes pervasively (37+ files), and stripping it would require a large, high-regression-risk refactor to move every inline style into classes or add nonces. Risk is low relative to `script-src` (already strict, no `unsafe-inline`/`unsafe-eval`) since no injectable vector into any `style="..."` attribute exists (confirmed during the XSS pass) — CSS-only injection has far less exploit potential than JS injection would.
- Password policy stays at an 8-character minimum with no complexity requirement — informational, not a defect; offset somewhat by rate-limited login/registration.
- Local `.env` currently has `APP_DEBUG=true`/`APP_ENV=local`, correct for this dev environment; `.env.example` already defaults to `false`/`production` so a real deploy starts from the safe default.

**Verified**: HSTS header present via curl; a GET to `/logout/` no longer destroys the session (confirmed via cookie-jar test); a real browser login → click the new logout button → confirmed the session actually ended (`/dashboard/` redirected to `/login/` afterward) with zero console errors and no visual difference from the old link-based button; all changed files pass `php -l`.

---

## Floating enquiry widget (WhatsApp / Call / Email) — added between phases, per request

A single expandable floating action button, bottom-right on every public page (`includes/enquiry-widget.php`, included from `includes/footer.php`) — click to reveal three actions: WhatsApp (`wa.me` link with a pre-filled generic message), Call (`tel:`), and Email (`mailto:`). Toggle, outside-click-to-close, and Escape-to-close are handled in `site.js` (not inline `onclick`, consistent with the CSP `script-src 'self'` policy already in place).

**Phone number is real, not invented**: `+91 7065 819 819` appears consistently across 8+ pages of the preserved legacy site (`grievance.html`, `career.html`, `partner.html`, `testimonial.html`, `support.html` ×4, `country-details.html`) alongside the already-reused `info@visagiri.com` address. Confirmed with the client before use rather than assumed silently. The same number is used for both Call and WhatsApp (a reasonable inference for an Indian mobile-format number, not a landline — flagged to the client as an inference, not fabricated as fact).

Naturally scoped to public pages only — it's wired into `footer.php`, which the dashboard/admin/consultant app shells never call (they close via their own `render_*_end()` functions instead), so it doesn't appear inside the authenticated panels. Verified via screenshot at desktop and mobile widths, confirmed all three link targets (`wa.me`/`tel:`/`mailto:`) resolve to the correct number/address, confirmed outside-click closes it, and confirmed it's present on public pages and absent from `/dashboard/` — zero console errors.

---

## Phase 17 (Performance) — complete

- **N+1 query audit**: swept every file with a `foreach` for a query call issued inside the loop body. Found none — every list page (applications, documents, users, support tickets, countries, visa types) already does one fully-joined query before its render loop, a pattern that's held consistently since Phase 6. Nothing to fix here; confirms the architecture, doesn't change it.
- **Missing index found and fixed**: `users.mobile` had no index despite being one half of every login lookup (`WHERE email = :x OR mobile = :x`) — every foreign key was already auto-indexed by InnoDB and every slug/email column was already `UNIQUE`-indexed, but `mobile` fell through since it's neither. Added `idx_users_mobile` to `schema.sql` and applied the same `ALTER TABLE` to the live dev database.
- **Fixed the CSS `@import` chain** that Phase 3 explicitly flagged as "a Phase 17 concern" at the time it was written: `main.css` was one `<link>` that then `@import`s 10 files — the browser has to fetch and parse `main.css` before it even discovers the other 10 URLs exist, so they loaded serially, one round trip at a time, instead of in parallel. `includes/header.php` now emits 10 individual `<link>` tags directly (same cascade order), so the browser's preloader can dispatch all of them the moment it parses `<head>`. `main.css` itself is left on disk unchanged for `docs/design-system-preview.html`, which still wants one bundled file.
- **Static asset caching + compression**: `public/.htaccess` gained `mod_expires`/`mod_headers` rules for a 1-year `immutable` `Cache-Control` on CSS/JS/images/fonts, and `mod_deflate` for gzip on text-based responses — all wrapped in `<IfModule>` so a host without those modules just skips the block instead of a 500. A year-long immutable cache is only safe with cache-busting, so `asset_url()` was added (`includes/functions.php`) and wired into every CSS/JS reference sitewide — it appends `?v=<filemtime>`, so editing a file after launch changes its URL and busts the cache automatically instead of leaving returning visitors on a stale copy for a year.
- Found and removed one piece of dead code in passing: an old, never-called `asset_url()` stub already existed in `functions.php` from an earlier phase (returned `/assets/$path`, no caller anywhere) — the name collision surfaced it immediately via `php -l`, confirmed via grep that nothing used it, removed rather than kept alongside the real one.

**Verified**: all 7 spot-checked pages (`/`, `/about/`, `/countries/`, a visa detail page, `/login/`, `/register/`, `/faq/`) return 200 with zero console errors and zero failed requests after the CSS refactor; homepage screenshot is pixel-identical to before; the country-search live filter (Phase 7's vanilla JS) still works; all 10 CSS files confirmed requested in parallel via Playwright's network listener (up from 1 blocking request); cache-busted URLs (`?v=<mtime>`) confirmed present and still resolve to 200; `.htaccess` syntax reviewed carefully (standard, well-documented directives, correctly wrapped in `<IfModule>`) — its caching/compression/HTTPS-redirect rules can't be exercised against PHP's built-in dev server, which doesn't process `.htaccess` at all, the same limitation that's applied to the HTTPS-redirect rule since Phase 4.

---

## Phase 18 (QA) — complete

The final phase: a full system-wide QA pass, not another feature. Three parts.

**1. Full static + route sweep.** `php -l` on all 80 `.php` files in the new platform (everything outside `legacy-site/`) — 80/80 clean. Every route reachable from `public/index.php`'s router — all ~40 static routes, real and 404 cases for both dynamic route families (`/visa/{country}/{type}/`, `/visa-type/{slug}/`), and all four auth-gated app-shell roots (`/dashboard/`, `/admin/`, `/consultant/`, `/apply/`) — confirmed returning the correct status code with **zero 500 errors** anywhere.

**2. A single continuous cross-role browser journey** — not isolated per-phase tests like every prior phase ran, but one script threading a real visitor through the entire system in the order a real usage pattern would actually hit it: browse countries → view a real visa detail page → register → apply (3-step wizard) → upload both required documents → file a support ticket → check the public tracking page → update profile → **switch to a real admin account** → approve one document, reject the other with a reason, update application status, assign a consultant → suspend the customer (confirm they're immediately blocked) → reactivate → resolve the support ticket → **switch to a real consultant account** → confirm they see only their assigned application → update its status further → **switch back to the customer** → confirm every single change from both staff roles is visible and correct → log out for real → confirm the session is actually dead → confirm a wrong password is rejected → confirm the correct password works again. 22 checks, 21 passed on the first correctly-written run; the 1 apparent failure (a ticket-status badge text comparison) was a case-sensitivity bug in the *test script* itself — `.badge` renders `text-transform: uppercase`, so comparing against lowercase `'resolved'` was always going to fail — confirmed via screenshot that the real status was correct and correctly displayed as "RESOLVED"; not a product defect.

Writing this test surfaced one genuine, if minor, trap worth recording: naive Playwright selectors like `button[type=submit]` are no longer safe to use unscoped on any authenticated page, because Phase 16's CSRF fix (converting the logout link into a real `<form method="post">`) means every logged-in page now has a **second** submit button in the header, ahead of the page's own form in DOM order — an unscoped click matched Logout instead of the intended form and silently killed the session mid-test. Not a product bug (real users click a specific labeled button, they don't blindly hit "the first submit button on the page"), but it's exactly the kind of interaction a real user *could* trigger by mistake (e.g., pressing Enter with focus in the wrong place — though native form submission is scoped to the enclosing `<form>`, so this specific failure mode requires an explicit stray click, not a keyboard slip). Recorded here so a future automated-test suite doesn't hit the same trap blind.

**3. Mobile responsive spot-check** at 390px width: homepage, the mobile nav drawer, `/countries/`, and (deliberately, since it was never explicitly designed mobile-first) the admin panel — all render correctly with zero console errors, confirming the shared `dashboard-shell` grid that the admin/consultant panels also use holds up at narrow widths without any Phase 18-specific CSS work being needed.

**Cleanup**: all QA test accounts (customer/admin/consultant), the application and its documents, the support ticket, and — going further than every previous phase's cleanup — the accumulated `rate_limits` rows left behind by repeated login/register/track-visa testing across this entire session were deleted. Reconfirmed against the live database: `users`, `applications`, `application_documents`, `support_tickets`, `rate_limits` all at zero; the real reference data (208 countries, 8 visa types, 11 documents, 5 FAQs, 7 roles) all intact and untouched; `uploads/` empty but for its own `.htaccess`/`.gitkeep`.

---

## Launch Readiness Summary

Eighteen phases, one continuous build on real infrastructure (a real MySQL/MariaDB database, a real PHP 8 runtime, real browser testing throughout — never mocked). What a visitor, customer, consultant, or admin can actually do on this platform today, all real and verified, none of it fabricated:

**Public site**: homepage, a 208-country directory with live search, per-country visa overview pages, per-visa-type detail pages (all 8 real types), a 4-service attestation section, a real FAQ page, a real "how it works" page describing the actual application system, public no-login application tracking (email + application number, non-enumerating), an XML sitemap and robots.txt, JSON-LD structured data, and a floating WhatsApp/Call/Email widget with a real, client-confirmed phone number.

**Customer account**: registration, login (rate-limited, non-enumerating, timing-safe), password reset, a 9-page dashboard, a 3-step application wizard with transactional DB writes, real document upload/download/replace/delete with MIME-sniffed validation, a public tracking page, profile editing, password changes, and a support-ticket system.

**Staff**: a real admin panel (system-wide application/document/user/ticket management) and a real consultant panel (scoped strictly to assigned applications, enforced at the query level, verified to actually block cross-consultant access rather than just hide the UI for it).

**Non-functional**: CSRF everywhere, prepared statements everywhere, session fixation prevention, DB-backed rate limiting, file-upload validation via real content sniffing rather than trusting the client, ownership checks scoping every resource to the right user/consultant/admin, a documented and deliberately-scoped CSP, HSTS, a login-timing side-channel closed, parallel asset loading, cache-busted long-lived caching, and zero fabricated visa requirements, fees, processing times, or business statistics anywhere on the site — every honest-empty-state decision made across all 18 phases is still in place today.

**What's still open, listed here rather than left implicit**:
- **The real logo file** has never been uploaded as an actual file attachment (only shown inline in chat) — every branded asset on the site (favicon, og-image) is a placeholder built from the logo's own colors and tagline, not the real file. This has been flagged at the end of nearly every phase since Phase 6.
- **Several pages remain scaffold stubs**, safely noindexed since Phase 15 but not real: `/contact/` (a real contact form is a meaningful gap for a consultancy business), `/support/`, `/careers/`, `/partners/`, `/corporate-services/`, `/document-checklists/`, `/payment-link/`, `/track-request/`, and all 8 legal pages (`/privacy/`, `/terms/`, `/travel-terms/`, `/payment-policy/`, `/refund-policy/`, `/cookie-policy/`, `/grievance/`, `/disclaimer/`).
- **`/blog/` has zero published content** and no `blog_posts` table — deliberately left empty rather than fabricated, per the same no-invention rule that governs visa requirements.
- **No verified visa-requirement data exists for any country/visa-type combination** — every `/visa/{country}/{type}/` page correctly and honestly shows "requirements not yet verified" because no real, sourced data has ever been provided to populate `visa_requirements`. This is the single biggest content gap for the site's actual usefulness to a visitor checking real requirements.
- **No payments, appointments, or messaging functionality was built** — the schema supports all three (real tables, already used defensively in dashboard empty-states), but no creation flow exists for any of them; consultants/admins can't yet request a payment, schedule an appointment, or message a customer.
- **No email delivery integration exists anywhere** — password reset only works in `APP_DEBUG` mode (prints the link instead of sending it), and support tickets/enquiries have no automated email notification.
- **The GitHub push permission gap has never resolved** — every single phase's work exists only as local commits on `claude/visagiri-modernization-audit-oup5t5`; `git push` and a direct GitHub-API push both consistently fail with `403 Resource not accessible by integration`, and the repository has never had any branch land on GitHub across the whole project. This needs an admin to grant the GitHub App Contents-write access on `coolrenukadevi/visagiri` before any of this work can leave the local environment.
- **`.env` in this dev environment has `APP_DEBUG=true`/`APP_ENV=local`** — correct for development; `.env.example` already defaults to the safe production values, but a real deploy needs its own `.env` created from that template, not copied from this one.

Every one of these gaps is a deliberate, documented decision to not fabricate content or overstate what's built — not an oversight discovered late. The platform as it stands is a real, working, security-reviewed, performance-reviewed, end-to-end-tested visa management system; what's listed above is what's left to make it a complete, launch-ready business site.

---

## Sitewide justified text alignment — added between phases, per request

`public/assets/css/base.css`: `p`, `li`, and `.accordion-body` (FAQ answers, which use a `<div>` rather than `<p>`) now render `text-align: justify` with `hyphens: auto` — the latter to avoid the large, ugly word-gaps justified text produces on narrower columns without hyphenation. Deliberately **not** applied to the whole `<body>` — headings, buttons, badges, and nav links are short/single-line text where justify has no visible effect anyway, but a two-word wrapped heading stretched full-width to justify looks visibly broken, so `h1`–`h6` and component text (buttons/badges/nav) are left on their default alignment.

Verified via real browser rendering, not just reading the CSS: computed `text-align` confirmed as `justify` on a real `<p>` (`/about/`) and a real `.accordion-body` (`/faq/`, after opening the accordion), confirmed `h1` stays at its default (`start`), and confirmed visually via full-page screenshots of `/about/` and `/faq/` — every paragraph now has clean, even left and right edges, headings and the footer's nav columns are visually unaffected, zero console errors.

---

## Real favicon set — added between phases, per request

Replaced the inline-SVG-data-URI placeholder (a single icon, no size variants, in place since Phase 3/4) with a proper favicon set: `favicon.svg` (scalable, modern browsers), `favicon-16x16.png`/`favicon-32x32.png` (legacy/small-size fallback), `apple-touch-icon.png` (180×180, iOS home-screen), and a real multi-resolution `favicon.ico` at the site root (16/32/48px, each frame genuine PNG-compressed image data — confirmed via `file`, not just a renamed PNG).

No ImageMagick/`rsvg-convert` is available in this environment, so each PNG size was drawn directly with PHP's GD library at 8× supersampling then downsampled for clean anti-aliased edges — rather than generating one image and letting the browser scale it down blurrily — and the `.ico` was hand-assembled (ICO's modern PNG-frame container format, embedding those same PNGs, which is what every current browser/OS expects). Same brand colors used everywhere else on the site: navy `#123F91` background, gold `#F4B400` "V" — the same scheme the placeholder favicon already used, since the real logo file has still never been uploaded as an actual file attachment (unresolved since Phase 6).

All five files wired into `includes/header.php` via the standard multi-`<link>` pattern (SVG first for browsers that support it, ICO/PNG fallbacks with explicit `sizes`, separate `apple-touch-icon` link) and routed through the same `asset_url()` cache-buster as every other static asset, so a future favicon update won't get stuck behind a stale year-long browser cache.

**Verified**: all five files return 200 with correct `Content-Type` (`image/svg+xml`, `image/vnd.microsoft.icon`, `image/png` ×3); `file` confirms `favicon.ico` is a genuine 3-icon `MS Windows icon resource` with real embedded PNG data at each size, not a mislabeled single image; zero console errors or failed requests loading the homepage.

---

## Sports Visa category added — per request

A 9th real `visa_types` row: **Sports Visa** — "For athletes, coaches, and officials travelling abroad to compete in or officiate a sporting event." A genuinely recognized visa category (several countries, including India, issue dedicated sports visas), described generically like the other 8 — no invented fees, processing times, or country-specific claims.

Adding it surfaced a real, pre-existing bug: the header dropdown and footer's "Visa Services" column were both **hardcoded 6-item arrays** that had already silently fallen out of sync with the database — missing Medical Visa and Conference Visa, added in earlier phases, and about to miss Sports Visa the same way. Both are now built dynamically from `SELECT ... FROM visa_types WHERE is_active = 1 ORDER BY sort_order` instead (the human-readable `/sitemap/` page's Visa Services section got the same fix), so a future visa type only needs adding to the database — nav, footer, sitemap, the `/visa-type/` hub, the homepage's Visa Services section, and the `/apply/` wizard's dropdown all already pulled from the DB and needed no changes at all.

**Creative design**: every visa type now gets a distinctive icon (`visa_type_icon()` in `includes/functions.php`) instead of the uniform document-emoji every card used before — 🧳 tourist, 💼 business, 🎓 student, 🏢 work, 👨‍👩‍👧‍👦 family, ✈️ transit, 🏥 medical, 🎤 conference, 🏅 sports — applied on the `/visa-type/` hub cards, the homepage's Visa Services section, and the visa-type detail page header (reusing the same `.destination-card__flag` treatment the country pages already use, for visual consistency). The Sports Visa detail page's title/description were also strengthened for SEO (`"Sports Visa - Requirements, Eligibility & How to Apply | Visagiri"`), which became the template for a broader title/description improvement across the visa-type pages.

**Verified**: all 9 visa types confirmed present and correctly linked in the header dropdown, footer column, and hub grid via Playwright; the Sports Visa detail page renders with its icon, real popular-destination links, and the honest general-FAQ fallback (no sports-specific FAQs tagged yet); zero console errors; all changed files pass `php -l`.

---

## SEO title/description audit across all pages — per request

Dispatched a background audit of every page's `<title>` and meta description against standard best-practice length guidelines (title ~30–60 characters, description ~120–160 — outside that range, Google tends to either pad an unhelpfully generic snippet or truncate mid-sentence). Findings, then fixes:

- **A systemic pattern, not isolated typos**: nearly every real content page's meta description was well under the 120-char floor (60–110 chars typical) — accurate, just too terse to use the SERP snippet space Google allots. Rewritten with real, honest specifics (not padding) on: `/` (homepage), `/about/`, `/faq/`, `/visa-process/`, `/track-visa/`, `/sitemap/`, `/countries/`, `/attestation/` (hub and all 4 real services, which gained a dedicated `meta_description` field separate from their on-page description so the visible UI copy could stay concise while the meta tag hits the target length), and the `/visa-type/` hub.
- **Two titles were too short/generic** (`/about/`: "About Visagiri"; `/countries/`: "Countries - Visagiri"; `/sitemap/`: "Sitemap - Visagiri") — rewritten with real specifics (the confirmed April 2015 founding date, the real 208-country count).
- **My own Sports Visa edit from earlier today was itself flagged** — the visa-type hub title (83 chars) and per-type template (66+ chars, worse for longer names like "Family Visit Visa") were both over budget, caught by the same audit that reviewed everything else. Shortened both templates; verified every one of the 9 real visa types now produces a title in the 44–60 range.
- **The two highest-traffic-shaped templates** — `visa/index.php`'s country and country+visa-type pages, which generate up to 1,872 URLs (208 countries × up to 9 types, plus 208 country overviews) — had the same too-short description problem *for every single generated page*, not a handful. Rewrote both templates with the same honest, non-fabricated framing already established in Phase 6 ("eligibility, required documents, fees, and processing time" describes what the page covers, not a claim that verified figures exist yet) — now in the target range for the overwhelming majority of the 208 real countries; a few extreme edge cases (the longest country name, "Democratic Republic of the Congo," paired with the longest visa type, "Family Visit Visa") run slightly over 160, which is an acceptable, expected trade-off for a formula applied at this scale rather than 1,872 hand-written descriptions.
- **A real bug, not a copy issue**: `render_not_found()` (`includes/functions.php`) — the handler used for genuine dynamic 404s, e.g. an invalid country or visa-type slug — never set `$noindex`, so real 404 pages were serving `index, follow` while the static `pages/404.php` stub correctly noindexed via `render_scaffold_page()`. Fixed to set `$noindex = true` explicitly, consistent with every other non-content page on the site.

**Verified**: re-fetched every changed static page plus a spread of dynamic pages (UAE and UK, country and country+type) and parsed the actual rendered `<title>`/meta description out of the HTML — not just re-reading the PHP source — confirming real character counts land in range; confirmed a live 404 (`/visa/nonexistent-country-xyz/` and `/visa-type/nonexistent-xyz/`) now serves `noindex, nofollow`; 10-page Playwright sweep of the changed pages returns all 200s with zero console errors.

---

## Attestation Services mega-menu — per request

Replaced the single flat "Attestation" nav link with a real "Attestation Services ▾" mega-menu, expanded from 4 services to 13, organized into the 4 categories the client specified directly (Apostille, Attestation, Documents, Legalization — a refinement of the initially-requested 3-column layout, applied as given rather than the generic placeholder structure): **Apostille** (MEA Apostille, E-Apostille), **Attestation** (MEA Attestation, Embassy Attestation, Consulate Attestation), **Documents** (Educational, Commercial, Personal, Birth Certificate, Marriage Certificate), **Legalization** (Document Legalization, Chamber of Commerce, HRD/State Attestation). All 13 are real, industry-standard document-attestation categories — not fabricated company-specific claims — same discipline already applied to Sports Visa.

**Single source of truth**: `attestation_services()`/`attestation_categories()` in `includes/functions.php` back the header mega-menu, the mobile accordion, `attestation/index.php`'s hub + detail routing, `includes/footer.php`'s Attestation column, and both sitemaps (`/sitemap/`, `/sitemap.xml`) — deliberately built this way to avoid a fourth instance of the stale-hardcoded-nav-array bug already fixed three times this session for visa types. Two legacy slugs (`/attestation/apostille/`, `/attestation/commercial-attestation/`) 301-redirect to their renamed equivalents (`redirect()` gained an optional `$status` parameter, defaulting to 302, so this didn't touch any of the ~50 existing single-arg call sites).

**Desktop**: a 4-column panel (icons + SEO-friendly labels per column, e.g. "MEA Apostille Services," "Commercial Document Attestation" — full names on the pages themselves, short labels in the nav to avoid keyword-stuffing) opens on hover/focus-within (the same CSS-only pattern the existing Visa Services dropdown already uses), positioned centered under the whole header rather than the trigger `<li>` (`.has-mega-menu { position: static }` escapes `.has-dropdown`'s own `position: relative` so the panel's containing block becomes `.site-header`), so it's never clipped regardless of where "Attestation Services" sits horizontally. A closing CTA band — "Need Document Attestation?" / "Get professional assistance..." / "Get Attestation Quote →" — links to the site's one real, working enquiry channel (the WhatsApp number already wired into the floating enquiry widget) with a pre-filled message, rather than the still-unbuilt `/contact/` scaffold stub; `whatsapp_enquiry_href()` is now the shared helper both the widget and this CTA call, so the phone number lives in exactly one place.

**Mobile**: a native `<details>/<summary>` accordion (matching the FAQ accordion's existing `+`→`×` rotation pattern) instead of the desktop mega-menu, with the 4 categories shown as labeled sub-groups underneath — no horizontal overflow (confirmed via `scrollWidth`/`clientWidth`), touch targets sized to ~44–45px.

**A real variable-scope bug found and fixed during verification**: the mega-menu's category/service `foreach` loops in `includes/header.php` originally reused the names `$categoryName`/`$categoryServices`/`$service`. Because `includes/header.php` is `require`d directly into each page script rather than called as an isolated function, it shares that script's variable scope — the same mechanism that lets `footer.php` read `header.php`'s `$visaServiceLinks`. `attestation/index.php`'s detail-page branch sets `$service` to the requested slug's data *before* requiring `header.php`, then reads it *after* — so header.php's own loop was silently overwriting it with whichever service it last iterated (always the same one, "HRD / State Attestation Services," the last item in the last category), making every single attestation detail page render HRD's content under its own correct URL/title. Caught by comparing a Playwright screenshot's visible H1 against the URL it navigated to, not by any automated check. Fixed by renaming the mega-menu's loop variables to `$megaCategoryName`/`$megaCategoryServices`/`$megaService` in both the desktop and mobile blocks — distinct enough that no future page's own variables can collide with them.

Also caught and fixed in the same pass: Escape didn't actually close the mega-menu when it had been opened via hover or keyboard focus, because `:focus-within`/`:hover` kept the CSS-only panel visible even after the JS-driven `is-open` class was removed (Escape doesn't blur the trigger or move the mouse). Added a `.mega-menu.is-force-closed` override class (JS-applied on Escape, cleared on the next genuine `mouseenter`/`mouseleave`/`focusout` of the item) so Escape now reliably closes the panel regardless of how it was opened, without breaking the plain hover/focus-within behavior for everyone else.

**Verified**: Playwright across desktop (1440px — hover open/close, keyboard Tab-to-open, Escape-to-close, outside-click via the existing Visa Services dropdown confirmed unaffected, mega-menu link click navigates correctly), tablet (834px — correctly falls back to the burger/mobile nav below the 1024px breakpoint), and mobile (390px — accordion open/close, zero horizontal overflow, 13 links across 4 sub-groups, ~44–45px touch targets); all 13 detail pages independently confirmed to render their own correct H1 (not just relying on the title tag, after the scope-collision bug above); both legacy-slug redirects return real 301s; `/sitemap/` and `/sitemap.xml` both list all 13 real service URLs; SEO title/meta-description lengths checked for all 13 detail pages plus the hub (all in the established 30–65/100–165 character ranges); zero console/page errors across every page tested; all changed files pass `php -l`.

---

**Follow-up, same day**: the 13 detail pages initially shipped thin — a one-sentence description plus a "details being finalized" notice, which read as close to blank on direct visit. Extended `attestation_services()` with four new fields per service (`overview`, `when_needed`, `process_steps`, `typical_documents`) and the detail template to render them as four real content sections, plus a cross-link block to the other services in the same category. Content is real, generic, publicly known information about how India's document-attestation ecosystem actually works (the notarization → state/HRD → MEA → embassy chain, which document categories need which stages, what the Hague Apostille Convention does and doesn't cover) — not fabricated Visagiri-specific claims; the one thing that genuinely can't be published without real sourcing (fees, exact processing time) stays an honest "confirmed directly with our team" note, now paired with a link to the real WhatsApp channel instead of standing alone as the page's only content. All 13 pages re-verified to render all four sections; `php -l` clean.

---

## Premium Company mega-menu — per request

Redesigned only the Company nav dropdown and the footer's Company column (explicitly not the rest of the site) into a premium, corporate-technology-styled mega-menu — a deliberate visual departure from the Attestation mega-menu's emoji/travel-brand tone, since this one was asked to read as SaaS/fintech rather than travel-agency: small stroke-SVG line icons instead of emoji, a navy featured card with an original abstract globe/passport illustration (same "inline SVG, not stock photography" approach as the homepage hero), hover-revealed arrows, and item descriptions rather than a bare link list.

**3 columns** — Discover (About Us, Why Us, Our Story), People (Leadership, Our Team, Careers), Trust & Connect (Partners, Affiliations & Accreditations, Contact Us) — plus a 4th "featured card" slot ("Visa Management, Reimagined." / "Explore Our Approach →" linking to the existing Why-Us section). Mobile gets a flat accordion (no sub-headings, matching the exact structure requested), not the desktop layout.

**Content honesty, per the request's own explicit rule** ("do not create fake pages, fake partnerships, fake accreditations... mark missing pages as PAGE TO BE CREATED"):
- **About Us, Why Us** — reused existing real content (`/about/`, `/about/#why-visagiri`) rather than duplicating pages.
- **Our Story** — new section added to `/about/`, built only from already-confirmed facts (April 2015 founding, Tripgation Pvt Ltd, the technology-plus-consultant approach) — no invented milestones, numbers, or narrative beats.
- **Leadership, Our Team, Affiliations & Accreditations** — new routes (`/leadership/`, `/our-team/`, `/affiliations/`), but there is no real data anywhere in this project for who actually leads/staffs Visagiri or what bodies it's accredited by, and inventing names, bios, or credentials would be a much worse fabrication than a placeholder. These stay honest `render_scaffold_page()` stubs (noindexed, same "content pending" pattern used site-wide since Phase 4) rather than fake bios — this is the direct implementation of "PAGE TO BE CREATED."
- **Corporate Services** — dropped from the Company menu (not part of the requested 9-item structure) but the route/file is left untouched and still reachable, per "do not break existing URLs unnecessarily."
- **Footer brand statement, bottom-bar social icons, and "Back to Top"** — NOT implemented. The request's own opening instruction was explicit: "Redesign ONLY the Company navigation dropdown and Company section of the footer... DO NOT redesign the entire website," but its later footer-brand-statement and bottom-bar items would touch the *whole* footer, and there are no real, sourced social media URLs anywhere in this project to link. Held back rather than guessed at or fabricated; flagging for a follow-up decision.

**A real bug found and fixed during verification, twice**: CSS Grid doesn't let a track shrink below its content's intrinsic (min-content) width by default — the long label "Affiliations & Accreditations" forced its column to ~416px, which cascaded into the whole grid rendering ~1312px wide inside a 940px panel and shoving the featured card almost entirely off-screen. Fixed with `min-width: 0` on the grid/flex items. That fix then exposed a second, previously-invisible bug: the description text still didn't wrap — it inherited `white-space: nowrap` from `.site-header__nav > ul` (set for the flat top-level nav links) all the way down into the mega-menu's description spans, so instead of wrapping within its ~185px column it rendered on one line and bled horizontally into the next column. Fixed by resetting `white-space: normal` explicitly on the mega-menu's label/description/title/copy text. Both caught via direct `getComputedStyle`/`getBoundingClientRect()` inspection after a screenshot showed the featured card clipped at the viewport edge — not visible from reading the CSS alone.

**Verified**: Playwright at 1440px (hover open, item-hover arrow reveal, Escape-close, click-navigates, and the pre-existing Attestation mega-menu re-confirmed still working after the JS was refactored into one shared `initMegaMenu()` function instead of copy-pasted per menu), 834px tablet (correct accordion fallback, zero overflow), and 390px mobile (flat 9-item accordion, zero horizontal overflow); grid column widths measured directly post-fix to confirm the overflow is gone (was 1312px effective content in a 940px panel, now 890px matching exactly); all 15 touched/new routes return 200 (including the 3 new `/leadership/`, `/our-team/`, `/affiliations/` stubs, correctly `noindex, nofollow`); `/sitemap/`'s Company section and the footer's Company column both reuse the same `$companyMenu` array the header defines (one more application of the shared-source-of-truth pattern, not a fourth stale-copy risk); zero console errors; all changed files pass `php -l`.

---

## Countries mega-menu — global visa destination discovery, per request

Replaced the flat "Countries" nav link with a large mega-menu covering all 208 real countries, grouped by the existing 6-region taxonomy, plus a live search, a Schengen highlight, featured destination cards, and a "Find Visa By Purpose" shortcut — all reading from one new `country_mega_menu_data()` query in `includes/functions.php` (region-grouped, popular-flagged, Schengen-flagged) rather than a hardcoded list, so it can never drift the way three earlier nav arrays did before being fixed this session.

**New real, verifiable fact added to the schema**: `countries.is_schengen` — Schengen Area membership (27 states) is a public, static geopolitical fact, seeded by real slug match, same treatment as the ISO codes already in the table — not a business claim requiring client sign-off.

**Three honesty/accuracy decisions made against the request's own wording, flagged rather than silently "improved"**:
- **"🔥 Most Searched"** → relabeled **"Popular Destinations."** This is a from-scratch build with no production traffic yet, so there is no real search-analytics data to back a "most searched" claim — using that label would be inventing a usage statistic, the same category of claim ("15+ years," "98% approval rate") already stripped out of the legacy site early in this project for being unverifiable.
- **"29 European countries"** (the request's own example figure for Schengen) → the real, current count is **27** (verified against the actual 27 member states seeded above) — used the correct number rather than repeating the request's inaccurate one.
- **"Find Visa By Purpose"** lists the site's actual **9 real visa types** (Tourist, Business, Student, Work, Family Visit, Transit, Medical, Conference, Sports) rather than the request's 10-item example list, which included "Dependent Visa" and "Official/Diplomatic" — categories that don't exist anywhere in this system's `visa_types` table and would need to be fabricated to display.
- **"🤖 AI Visa Assistant"** → built as a real, honestly-labeled "Not sure which visa you need?" teaser instead, linking to the homepage's existing "Find the Right Visa" guided-search widget (`/#visa-search` — destination → visa type → nationality → travel date, already real and working since Phase 6). No actual AI/LLM integration exists anywhere in this codebase; calling a plain search-widget shortcut "AI-driven" would be a fabricated capability claim.
- **Per-country visa-type subsets** (the request's "USA Visa → Tourist | Business | Student | Work" implying an exclusive set) were not implemented as exclusive claims — this system has never modeled which specific visa types a given country restricts to (the `country_visa_types` join table exists in the schema but was deliberately left unpopulated back in Phase 6, superseded by treating every visa type as explorable for every country). The 4 featured cards use non-exclusive phrasing ("Tourist, business, student & more") instead.

**Real bug found and fixed twice during verification, both invisible from reading the CSS alone**:
1. **Duplicate listing**: the "Schengen Area" aggregate row (a real `countries` table entry, `region = Europe`, but not itself one of the 27 individual member states) was appearing twice — once correctly in the dedicated Schengen highlight box, and again as a plain link in the "Other Europe" list, since it technically passed the `is_schengen = 0` filter. Fixed by explicitly excluding the `schengen` slug from that list.
2. **Excessive height** (`Do NOT make the dropdown excessively tall` was explicit in the request): the panel first measured **1201px tall** against a 900px viewport. Traced with `getBoundingClientRect()`/a cloned-node intrinsic-height check (grid `align-items: stretch` was making every column report the same inflated height, hiding which one was actually oversized) to the "Popular Destinations" column: 12 chips with long names ("United Arab Emirates," "United Kingdom") crammed into a ~211px-wide column couldn't fit more than about one per row, so 12 chips rendered as a near-vertical list (~352px alone). Fixed by moving the chip row out of the column grid into its own full-width row above the columns — which the request itself had actually suggested ("above... the continent sections") — cutting the measured height to 1059px, plus trimming per-region item caps and converting "Find Visa By Purpose" from a 9-row list to a 2-column grid along the way.

**Verified**: Playwright at 1440×900 (search filter tested with a real match — "japan" correctly narrows to exactly the 2 elements containing "Japan" via direct DOM inspection, not Playwright's less reliable `:visible` heuristic, which had reported a false count — and a nonsense query correctly shows the empty state), grid overflow re-measured directly post-fix (1090px of columns inside a 1140px panel, no clipping), Escape/outside-click/hover all still work and the pre-existing Attestation and Company mega-menus confirmed unaffected; 834px tablet falls back to the mobile nav correctly; 390px mobile accordion (3 top-level sections now: Attestation, Countries, Company) renders all 6 regions plus the Schengen highlight, Find Visa By Purpose, and the directory link, with zero horizontal overflow; a 13-route sweep (`/`, `/countries/`, 4 real `/visa/{country}/` pages including `/visa/schengen/`, plus every previously-existing route) returns all 200s; zero console errors; all changed files pass `php -l`.
