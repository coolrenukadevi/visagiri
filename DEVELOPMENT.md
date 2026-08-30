# Convercession platform — developer notes

> **ARCHITECTURE (PHP).** The site is **PHP-backed with clean, extensionless
> URLs**. The static-HTML generator that preceded it has been removed — country
> guides are rendered on request by a single controller, `visa.php`. See "PHP architecture" below. `node tools/export-data.js`
> refreshes the JSON that PHP reads; run it after editing `data/countries.js`,
> `data/all-countries.json` or `data/navigation.js`.

## PHP architecture

```
index.php            Homepage (hand-authored sections + shared chrome)
visa.php             ONE controller for all 216 country guides
countries.php        Region + A–Z index
payments.php         Payment methods
request-info.php     Enquiry fallback
login.php            /login — Google / Facebook / X sign-in
auth.php             /auth/{provider}, /auth/callback/{provider}, /logout
account.php          /account — signed-in dashboard (noindex)
sitemap.php          Sitemap index + /sitemap-pages.xml + /sitemap-countries.xml
.htaccess            Clean URLs, 301s, canonical host, security headers
includes/
  config.php         Company details, canonical origin, env(), url(), canonical(), e()
  head.php           <head> — canonical/OG/schema all derived from ONE path
  header.php         Utility bar + mega-menu header
  footer.php         Currency widget + CTA band + 5-column footer
  currency-widget.php  Live FX strip (included once, site-wide)
  nav.php            Nav data + cv_slug() (byte-identical to the JS slugify)
  partials.php       breadcrumbs, sticky search, enquiry widget
lib-php/
  currency.php       XE API + file cache + stale fallback
  data.php           Reads data/generated/*.json
  auth.php           Sessions, the SQLite user store, CSRF
  oauth.php          OAuth 2.0 + PKCE for Google / Facebook / X
tools/
  export-data.js     JS data  -> JSON (single source of truth for PHP + browser)
  refresh-currency.php  Cron entry point for FX refresh
  router.php         Dev router so `php -S` mirrors .htaccess
  url-audit.php      Automated SEO/URL audit (spec §15)
  auth-tests.php     Sign-in test suite (php tools/auth-tests.php)
```

**URL contract**: public URLs never contain `.php` or `.html`. `canonical()`
in `config.php` is the only place a URL is made absolute, so canonical tags,
OG tags, breadcrumb schema and the sitemap cannot disagree with each other.

**Sign-in**: OAuth 2.0 + PKCE, no passwords stored here. See
"Sign-in (Google / Facebook / X)" below for how to switch it on.

**Currency**: `XE_ACCOUNT_ID` / `XE_API_KEY` come from `.env` (see
`.env.example`), never from client code. Rates are cached in `/cache`; a page
render never blocks on the API (refresh via the cron script). If the API fails
the last good rate keeps showing; if no rate was ever fetched the widget says
so rather than inventing a number.


This is the state of the build: a static-site foundation for the visa
platform, generated from a single data file, with a front-end enquiry form
that is **not yet wired to a backend**. This document is the map for whoever
picks this up next.

## What's actually here

```
index.php                   Homepage — hero visa search (Country / Embassy-VAC city / Visa
                            Type), service console, visa type cards, popular destinations.
page.php                    ONE controller for the 35 content pages in data/pages.php.
visa.php                    ONE controller for all 216 country guides.
visa-type.php               ONE controller for the 10 visa CATEGORY pages (/visa/tourist …).
css/site.css                Shared stylesheet for every page.
data/all-countries.json     THE single list of every country/territory the platform knows
                            about (216 entries, plain names, no ISO codes). Both the
                            browser search dropdown (js/data.js) and the PHP country
                            controller are synced from this one file.
data/pages.php              Definitions for all 35 content pages (title, lede, sections,
                            FAQs, CTAs). Adding a page = adding a data entry, not a file.
data/documents.php          The document checklist model — core, by-purpose,
                            by-nationality (India) and by-applicant layers.
data/country-codes.json     Name -> ISO alpha-2, used only to derive flag emoji
                            and the fallback country-code chip.
data/navigation.js          Header mega-menu + 5-column footer IA. Every entry must resolve
                            to a real page — there are no "#" hrefs and no placeholders.
js/data.js                  Reference data: embassy cities, visa types, plus two blocks
                            auto-synced by tools/export-data.js — COUNTRIES (from
                            all-countries.json) and GENERATED_PAGES (from the merged set).
js/common.js                Shared behaviour: mega-menu + panel overflow guard, smart site
                            search, mobile drawer, sticky search, related links, FAQ
                            accordion, share/print/save, recently-viewed, compare tray,
                            and the visa enquiry form (client-side only).
js/home.js                  Homepage-only behaviour: the 4-tab hero search widget.
data/countries.js           Content for country guides: hand-authored detail for the "rich"
                            countries plus the quickTouristVisa factory for the rest.
```

Run `node tools/export-data.js` after editing `data/countries.js`,
`data/all-countries.json` or `data/navigation.js`. It rewrites
`data/generated/*.json` (what PHP reads) and the `COUNTRIES` +
`GENERATED_PAGES` arrays in `js/data.js` (what the browser reads), keeping the
two halves of the site on one source of truth. Both arrays live between
`/* MARKER:START */ ... /* MARKER:END */` comments — don't hand-edit between
them, they'll just get overwritten on the next run (and hand-edits are exactly
how these lists drifted out of sync earlier in this project).

There is no build step and no static output: pages are rendered by PHP on
request. The old static generator (`build.js`) has been removed — it wrote
217 `.html` files and a `sitemap.xml` that would now shadow the live routes.

### Current coverage: one page per country, all 216 countries/territories

**URL architecture: one page per country, visa types as tabs — not one URL
per country+visa-type.** Earlier drafts of this generator produced a separate
page per combination (`/visa/kenya-tourist-visa.html`,
`/visa/kenya-business-visa.html`, …); this was deliberately changed to
`/visa/kenya.html` with a Tourist/Business/… tab strip inside it, per an
explicit decision to consolidate. Trade-off worth knowing: separate URLs are
generally better for SEO (each visa type gets its own indexable
title/description targeting that exact search intent — "Kenya Business Visa
requirements" as its own ranking target), while one page per country is
simpler to navigate and maintain. If you want to revisit this, the tab-panel
content in `visa.php` is already broken out per visa type — reverting to one-URL-per-combination is mostly an exercise in giving
each panel its own `<html>` wrapper and canonical URL again, not a rewrite.

Every country in `data/all-countries.json` now has its own page — that's the
"200+ countries worldwide" requirement, literally covered (216 pages). 15
countries have deeper, hand-authored content (Kenya, USA, UK, Australia,
Canada, Germany, India, France, Italy, Japan, South Korea, UAE, Saudi Arabia,
Singapore, Malaysia, Thailand, China — several with more than one visa-type
tab). The other ~200 use a shared content factory (`quickTouristVisa` in
`data/countries.js`) that interpolates the country name into templated
paragraphs — genuinely faster to scale, but the overview/FAQ/eligibility text
reads generically because it is generic. That's fine for proving the system
handles volume; it is **not** fine to publish as-is. Search engines treat
name-swapped boilerplate as thin content and won't rank it — before going
live, replace the generated paragraphs with country-specific detail the same
way the hand-authored entries already have it, country by country.

**The sample-content banner is page-level, not per-tab**: it shows if *any*
visa-type tab on that country's page still has unverified data, even if one
tab (say, Tourist Visa) has been fully verified via the import pipeline.
Splitting it per-tab would need a small JS tweak to move/toggle the banner on
tab switch — not done, since a page mixing verified and unverified tabs
should probably keep the caution visible regardless of which tab is open.

**Flags**: bulk-generated countries deliberately show a generic 🌍 icon
instead of a country flag. Flags were computed from ISO 3166-1 codes in an
earlier draft; that was dropped on request — also sidesteps flag-emoji
disputes for contested territories (Taiwan, Kosovo, Palestine, etc.) which
render differently across platforms and carry political weight some visa
consultancies would rather not wade into by default. Hand-authored countries
keep their specific flag emoji since those were chosen deliberately per entry.

**Two real bugs found and fixed while scaling to all 215 countries** (both
caught by testing every generated URL, not just a handful):
1. `slug("Curaçao")` produced `cura-ao` — the `ç` was silently dropped as a
   separator instead of transliterated, leaving a stray hyphen. Fixed by
   Unicode-normalizing (NFD) and stripping combining marks before slugifying,
   which handles this generically for any future accented name, not just this
   one country.
2. The old generator never cleared `/visa/` before writing, so the broken
   `cura-ao-tourist-visa.html` from bug #1 was still sitting on disk even
   after the fix, silently reachable. Fixed by deleting and recreating the
   output directory on every build.

## Navigation IA (header + footer)

**Removed from the menus on request** (the pages still exist and still return
200 — they were taken out of the header and footer, not deleted):

| Removed | Page | Kept reachable from |
|---|---|---|
| Home | — | The logo, on every page |
| Technology | `/technology` | CTA on `/about` and `/ai-visa-assistant` |
| Work Visa | `/visa/employment` | The "Other categories" strip on every visa category page |

An unlinked page that is still in the sitemap is an orphan, which is why each
one keeps a contextual inbound link rather than none at all. If you want either
page gone entirely, remove it from `data/pages.php` / `VISA_TYPE_PAGES` and
from the sitemap — do not just unlink it.

**Schengen Visa** was added as a real category page (`/visa/schengen`), not a
label: it lists the 29 member states from the country data, states the
main-destination rule, and flags the two everyone gets wrong (Ireland is EU but
not Schengen; Cyprus is EU but not yet Schengen). Membership changes, so treat
`SCHENGEN_MEMBERS` in `visa-type.php` as a list to review.


`data/navigation.js` is the single source of truth for **both** the header
mega-menu and the 5-column footer, so the two can't drift apart. `tools/export-data.js`
renders it into every generated page *and* injects it into `index.html`
between `<!-- HEADER:START -->` / `<!-- FOOTER:START -->` markers — the
homepage is hand-authored everywhere else, but its chrome is generated.

Structure:

| Tab | Answers |
|---|---|
| Visa Services | "What visa can I get?" |
| **Visa Management** (flagship, brand-tinted) | "How do I manage my application?" |
| Countries | "Where am I travelling?" — 7 regions, not 216 flat items |
| Resources | "What do I need to know?" |
| Company | who we are |

Header CTAs are **Track Visa** + **Check Visa** (not a generic "Contact Us"),
plus a search icon that focuses the page's primary search field.

**Honest link policy**: entries marked `todo: true` in `data/navigation.js`
render as muted, non-clickable placeholders (with a `○` prefix in the mega-menu)
rather than `<a href="#">` links to nowhere. A nav that quietly no-ops is worse
than one that shows what isn't built yet. Delete the `todo` flag when the page
ships and it becomes a real link automatically.

**Regions** live in `data/regions.json` — geographic classification only, not
visa data. Every country in `data/all-countries.json` is mapped; the
region index surfaces any stray as "Other Territories". That cross-check is how the
missing **Ivory Coast** was found and added (215 → 216 countries).

## Why server-rendered PHP instead of a client-side template

The spec asks for real SEO: per-page meta titles/descriptions, Open Graph tags,
canonical URLs, and Schema.org (BreadcrumbList, FAQPage). Crawlers and
link-preview bots largely read the HTML that's served, not what JavaScript
renders afterwards. A single `country.html?country=X` page filling itself in
client-side would fail most of those requirements.

This started as a static generator for that reason, and moved to PHP when the
URL contract changed to extensionless paths: one controller per content family
(`visa.php`, `page.php`, `visa-type.php`) emits the same fully-formed HTML the
generator did, but 216 country guides stop being 216 files that can go stale
independently, and a data fix is live immediately instead of after a rebuild
someone forgot to run. The head, canonical, OG tags, breadcrumb schema and
sitemap all derive from one `canonical()` call, so they cannot disagree.

## Adding a country or visa type

**Adding a visa type to a country that's already covered** (e.g. a Student
Visa tab for a country that only has Tourist so far):
1. Open `data/countries.js`, find the country's entry, add a new object to
   its `visaTypes` array (copy an existing one as a starting point) — it
   becomes a new tab on that country's existing page.
2. Run `node tools/export-data.js`.

**Adding a brand-new country the platform doesn't know about at all**:
1. Add its name to `data/all-countries.json` (this makes it searchable and
   gives it an auto-generated page, with a Tourist Visa tab, for free).
2. If you want richer, hand-authored content instead of the generic
   `quickTouristVisa` template, also add a full entry for it in
   `data/countries.js`.
3. Run `node tools/export-data.js`. It refreshes the JSON PHP reads and
   updates both `COUNTRIES` and `GENERATED_PAGES` in `js/data.js` for you —
   no manual sync step needed, and no page files to regenerate.

**Before publishing any generated page**, replace the sample fee/processing
time/document/embassy data with figures confirmed against the destination
country's official source. The recommended path for this is the import
pipeline below, not hand-editing `data/countries.js` entries in place — the
banner-suppression and priority logic are already wired to it.

## Country flags

`data/country-codes.json` maps all 216 names to their ISO 3166-1 alpha-2 code.
`tools/export-data.js` turns each code into a flag emoji — a flag *is* the two
letters written as regional indicator symbols (U+1F1E6 is "A") — and writes
both the flag and the code into `data/generated/countries.json`.

Why derived rather than 216 image files: no assets to ship or keep in sync, no
CDN (the CSP would block one anyway), and a wrong code produces a visibly wrong
flag, which is easy to spot. The code table is authoritative — a hand-written
flag in `data/countries.js` no longer wins, because a stale one there would
silently outrank the real one.

**The catch**: Windows ships no flag glyphs, so the pair renders as two boxed
letters. `js/common.js` feature-detects this once (draw a flag to a canvas,
compare it against the same pair joined by a zero-width non-joiner so it cannot
compose) and sets `.no-flag-emoji` on `<html>`; the CSS then shows the
country-code chip from `data-code`. Render flags through `country_flag()` in
`includes/partials.php` so this stays consistent.

Kosovo is the one permanent exception: XK is a user-assigned code, not an
official ISO one, so no platform has a glyph for it. It always shows the chip.
`export-data.js` prints a warning naming any country in that state.

## The document checklist

`data/documents.php` is the model; `visa.php` and `visa-type.php` render it.

A checklist is assembled from three layers:

1. **Core** — what essentially every visa application asks for: passport,
   photos, form, itinerary, accommodation, funds.
2. **By purpose** — what the category adds. A student application asks for an
   admission letter wherever you are going; a business one asks for a host
   invitation. These are category-defining, not country-specific.
2b. **By nationality** — what an *Indian* passport holder is actually asked
   for. "Proof of income" is close to useless as instruction when the thing
   handed over is an ITR-V and a Form 16, so for Indian applicants the Funds
   section is replaced with the Indian documents (bank statements stamped at
   the branch, ITR-V, Form 16, PAN, Aadhaar) and each category gains an
   "Indian applicants — also expect" block: MEA apostille vs attestation for
   academics, ECR/ECNR status and a PCC from the Regional Passport Office for
   work, GST registration for business, a marriage certificate registered
   under the Hindu Marriage Act or Special Marriage Act for family.

   This is India-*side* and category-level: the documents Indian authorities
   issue and the attestation route Indian documents take. It asserts nothing
   about what a given destination requires. India is the default because the
   business is Indian; "another passport" switches back to the generic set.

3. **By applicant** — what changes because of who you are: salaried,
   self-employed, student, retired, or a child under 18. Chosen from the
   "Tailor to" selector; hidden until picked, and excluded from the progress
   count while hidden.

### What it deliberately does not claim

It is a *preparation* checklist, and every page that renders it says so. It is
not a per-country legal requirement list, because that is nationality- and
mission-specific: exact photo dimensions, financial thresholds, what must be
original versus certified copy, and which documents need translation or an
apostille can only come from the mission handling that passport.

`checklist_category()` maps the many `visaTypeSlug` values in the content data
onto ten canonical categories, falling back to the tourist set.

### Verified lists override it

A visa type carrying a `documents` key AND `verified: true` — i.e. one loaded
through `data/import/` from a source somebody checked — renders that list
instead, with the source and date shown. Real data always beats the model.

### State

Ticks live in `localStorage` under `cv_docs:{country}:{visaType}`, so the Kenya
tourist list is independent of the Kenya business list. Nothing is uploaded and
the page says so. Every storage access is guarded — private mode and blocked
cookies must degrade to "forgets your ticks", never to a thrown error.

## Why unverified figures are not printed

Fee, processing time, validity and entry type render through `visa_fact()`
(`lib-php/data.php`). Unless the visa type is `verified`, the tile shows an
honest state — "Confirmed for your nationality" — rather than a number, and is
styled as a sentence rather than a headline figure so it cannot be misread as
data.

This replaced a `(sample)` suffix on every generated country. A reader skims
past a parenthetical; they do not skim past a figure, and a fee or a processing
time is exactly what people book non-refundable travel around. The same rule
applies to prose in `data/countries.js`: do not write a specific amount or
duration into an overview, FAQ or note unless it has been verified.

## Real-data import pipeline (`data/import/`)

This is how verified visa data is meant to get into the site — not by
hand-editing `data/countries.js`, and never by asking an LLM to fill in 200+
countries of fees/processing-times/documents from memory. Visa rules are
nationality-specific, change often, and a wrong figure on this site is a real
traveler's rejected application or lost money.

Drop a `.csv` or `.json` file into `data/import/` (schema documented in
`data/import/README.md`, starter templates in `TEMPLATE.csv`/`TEMPLATE.json`)
and run `node tools/export-data.js`. What that gets you:

- **Highest priority** — an imported row always overrides both the
  hand-authored entries in `data/countries.js` and the generic bulk-generated
  pages, matched by country + visa type.
- **The sample-content banner turns off automatically** for any page sourced
  this way (imported rows default to `verified: true`).
- **A country that doesn't exist on the site yet gets added automatically**
  — both the generated page and the homepage search dropdown — no separate
  step to register it in `data/all-countries.json`.
- **Fails loudly on bad data.** A row missing `country` or `visaType` throws
  a build error naming the exact file and row — it does not silently
  generate a broken or half-empty page.

Real sources for this data: an IATA Timatic export, a licensed visa-data API
(Sherpa³, VisaHQ, etc.), or your own team's manually verified spreadsheet.
See `data/import/README.md` for the full field reference and the "where this
should come from" note.

## What's real vs. stubbed right now

| Area | Status |
|---|---|
| Homepage visa search (country/city/visa-type, 216 countries) | Real, client-side |
| Country + Visa Type **autocomplete** (type-ahead, keyboard nav, prefix-ranked) | Real — hero search and sticky search both use it |
| Country guides (216 pages, visa types as tabs) | Real, rendered by `visa.php` |
| **Document checklist** (per visa type, per nationality, tailored by applicant, tick + print) | Real |
| **India-specific document layer** (ITR-V, Form 16, PAN, MEA apostille, PCC, ECR/ECNR, GST…) | Real — India is the default; "another passport" switches to the generic set |
| National flags for all 216 countries | Real, derived from ISO codes; chip fallback where the platform has no flag glyphs |
| Country index filter (216 destinations) | Real, progressive enhancement |
| Fee / processing time / validity per country | **Not verified — shown as an honest unknown, not a number.** Load real figures via `data/import/` |
| Overview / eligibility / FAQ prose on ~200 countries | Generic. Truthful, but templated — it will not rank on its own |
| Sign-in with Google / Facebook / X | Real — needs credentials in `.env` |
| Sticky search bar on visa pages | Real (collapses to destination-only on phones) |
| Smart site search (magnifier or `/`) | Real |
| Breadcrumbs, related pages/countries, recently-viewed (localStorage) | Real |
| Share / Print / Save page | Real (Web Share API / clipboard / print / localStorage) |
| FAQ accordion, compare-tray UI | Real |
| SEO meta/OG/Twitter/canonical/JSON-LD/sitemap.xml/robots.txt | Real |
| Enquiry form UI + client-side validation | Real |
| **Enquiry form submission (email, Sheets, Drive)** | **Stub — logs to console only** |
| Admin dashboard | **Not built** |
| reCAPTCHA / server-side spam & rate limiting | **Not built** (client has a honeypot field + 4s duplicate-submit guard only — trivially bypassed, not real protection) |
| Google Analytics / Tag Manager, WhatsApp/SMS notifications, multi-language | **Not built** |

## Wiring the enquiry form to a real backend

`js/common.js`'s `enquiryForm` submit handler currently just logs the payload
and shows the success message. To make it real:

1. Stand up an endpoint (Node/Express, or a serverless function) that accepts
   the form fields + files as `multipart/form-data`.
2. Replace the `console.log(...)` block in `js/common.js` with a `fetch()`
   POST to that endpoint, awaiting the response before showing
   `#enquirySuccess` (so failures can show an error instead of a false
   "success").
3. Server-side, on a valid submission:
   - Generate the reference number server-side (don't trust the client-
     generated one — a duplicate or spoofed value is trivial from the browser).
   - Send the admin notification to `hello@convercession.com` and the
     applicant acknowledgement (see the spec's exact subject lines/body).
   - Append a row to Google Sheets via a service account (Sheets API).
   - Upload files to Google Drive into `Visa Enquiries/{year}/{month}/{ref}/`
     (Drive API), using the same service account.
   - Add real reCAPTCHA verification, rate limiting, and file-type/size
     validation server-side — client-side checks are UX, not security.

### Credentials you'll need to provide

- A Google Cloud service account with Sheets API + Drive API enabled, shared
  access to the target Spreadsheet/Drive folder.
- An email sending method: Gmail SMTP app password (fine at low volume),
  or an API key for SendGrid / Amazon SES / Resend for anything higher-volume
  or more deliverable.
- A reCAPTCHA v3 (or v2) site key + secret key.

None of the above exist in this repo — nothing here can send an email, write
a sheet, or store a file until you provide them and someone wires the backend
described above.

## Sign-in (Google / Facebook / X)

OAuth 2.0 Authorization Code + PKCE, no passwords anywhere on this site.

```
login.php          /login  — provider picker
auth.php           /auth/{provider}, /auth/callback/{provider}, /logout
account.php        /account — signed-in dashboard (noindex)
lib-php/oauth.php  provider registry + the shared flow
lib-php/auth.php   sessions, the user store, CSRF
cache/auth.sqlite  users + linked identities (gitignored; back this up)
```

### Switching it on

1. Create an app with each provider and register the exact redirect URI:

   | Provider | Console | Redirect URI |
   |---|---|---|
   | Google | console.cloud.google.com → Credentials → OAuth client ID (Web) | `https://www.convercession.com/auth/callback/google` |
   | Facebook | developers.facebook.com → Facebook Login → Settings | `https://www.convercession.com/auth/callback/facebook` |
   | X | developer.x.com → User authentication settings (Web App) | `https://www.convercession.com/auth/callback/x` |

2. Put the six values in `.env` (`GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`,
   `FACEBOOK_APP_ID`, `FACEBOOK_APP_SECRET`, `X_CLIENT_ID`, `X_CLIENT_SECRET`).
3. Make sure `cache/` is writable by the web server — the SQLite file lives there.

A provider with no credentials shows as **Not configured** on `/login` instead
of sending people into a broken redirect, so you can switch them on one at a
time. Everything else on the site works signed-out; nothing is gated.

### Design decisions worth knowing

- **The client secret never leaves the server.** The browser only ever sees the
  public client id inside a redirect URL. The code-for-token exchange is a
  server-to-server POST.
- **`state` is bound to the session and single-use.** A callback whose state
  doesn't match is discarded — that is what stops login CSRF (an attacker
  completing *their* sign-in in your browser). Replaying a callback URL finds
  nothing, because the pending record is consumed on first read.
- **PKCE (S256) on all three.** X requires it; Google and Facebook accept it,
  so there is no reason to run a weaker flow for two of them.
- **`redirect_uri` is built from `SITE_ORIGIN`, never from the Host header.**
  A request header is attacker-controlled, and letting it into an OAuth
  redirect URI is how authorization codes end up on somebody else's domain.
- **No provider token is stored.** Identity is needed once, at sign-in.
  Persisting access tokens we never use would only create something worth
  stealing.
- **Accounts link on a VERIFIED email only.** Sign in with Google and later
  with Facebook on the same verified address and you land in one account. An
  *unverified* address never links, and is never written to the user row —
  it is attacker-supplied, and matching on it would be an account-takeover
  path. `users.email` is UNIQUE, so this also avoids a spurious insert failure.
- **X does not return an email address on this API tier.** An X-only account
  therefore has no email until the person links Google or Facebook. `/login`
  says so plainly rather than fabricating an address.
- **Sign-out is POST + CSRF token.** A plain `<a href="/logout">` can be
  triggered by any page on the internet, or prefetched by a browser.
- **`?next=` is filtered through `auth_safe_next()`.** `//evil.com` and
  `https://evil.com` are both absolute to a browser, so a naive
  `startsWith('/')` check is an open redirect.

### What the account page deliberately does NOT do

`/account` shows your profile, which providers are linked, and real next
actions. The applications and documents panels show an honest empty state.
They will stay that way until there is a case-management backend behind them —
a dashboard that displayed invented application statuses would be worse than
no dashboard at all.

### Tests

- Unit coverage was run against the open redirect guard, the authorize URL
  (the PKCE challenge really is S256 of the session verifier; the secret is
  absent from the URL), every callback rejection path (bad state, wrong
  provider, cancellation, replay, expiry) and the account-linking rules
  including the unverified-email takeover case.
- Browser coverage spans both the unconfigured and configured states, the
  signed-in header, sign-out CSRF, and horizontal overflow from 320-1400px.

## Admin dashboard

Not started. It needs the backend (and its own auth) to exist first — there's
nothing to show a dashboard without a real data store behind the enquiry
form. Recommend building it as a small authenticated app reading from
whatever the enquiry backend writes to (the same Sheet, or a proper database
if volume grows past what Sheets comfortably handles).

## Design system notes

- All new components (info cards, doc-checklist groups, FAQ accordion, sticky
  search, enquiry form) reuse the existing color tokens in `css/site.css`
  (`--brand-blue`, `--brand-navy`, etc.) — no new palette was introduced.
- `[hidden]` is force-hidden site-wide (`[hidden] { display: none !important; }`)
  so future components with their own `display` rule can't silently defeat it
  the way `.section-head` originally did for the recently-viewed block.
- Print styles (`@media print`) hide nav/search/footer chrome so "Print Page" /
  "Download Checklist" produce a clean printout — there's no server-side PDF
  generation, this relies on the browser's print-to-PDF.
