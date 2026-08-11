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

Waiting for your go-ahead to continue to **Phase 3 (Design System)**.
