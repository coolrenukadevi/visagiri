# Visagiri.com — Phase 1 & 2: Website Audit + Migration/IA Plan

**Date:** 2026-08-11
**Scope:** Full audit of the existing visagiri.com static site (uploaded zip export from the live host `/home/tripgation/public_html/visagiri.com/`), preserved at `legacy-site/` in this repo for reference during rebuild.
**Status:** Audit complete. No rebuild code has been written yet — this document is the deliverable for Phase 1 (Audit) and the first pass of Phase 2 (Information Architecture) per the modernization brief.

---

## 0. What the current site actually is

Contrary to the brief's assumption of a PHP application, the existing site is a **static HTML export of a purchased ThemeForest template** ("**RouteX – Immigration and Visa Consulting HTML5 Template**", built by an agency/freelancer called **RRDevs**), reskinned with Visagiri branding. There is no PHP framework, no database, no authentication, no admin panel, and only two trivial PHP mail scripts. This matters for planning: **Phases 7–16 of the brief (auth, dashboards, admin, document management, tracking) are not present in any form today** — they are 100% new build, not modernization of existing functionality.

The export also contains a **second, unfinished redesign attempt** living at `/new/` (`legacy-site/new/`) — a different, newer template with `index.html` … `index-4.html`, `countries-details.html` … `-6.html`, `coaching-details.html` … `-6.html` (numbered variants, clearly unedited demo pages), plus its own `/new/Doc/` and template documentation folder. It is **currently deployed to production** (reachable at `visagiri.com/new/...`) but not linked from the live site's navigation, and its internal links are broken (see §3). It should be treated as a design reference only, not shipped as-is.

Total legacy footprint: 71 HTML pages, ~4.1MB of markup, ~38MB including fonts/images.

---

## 1. Critical findings (fix priority — real business impact)

These are the four issues I'd fix first in any world, independent of the redesign, because they are actively losing the business money or credibility today:

### 1.1 The contact form on `support.html` sends every enquiry to the template vendor, not Visagiri
`support.html` posts to `mail.php`. That script is still configured with the *template author's* placeholder identity:
```php
$recipient = "support@envato.com";   // ThemeForest support inbox, not Visagiri
$fromName  = "RRDevs";
$fromEmail = "hellow@rrdevs.net";
```
On top of that, the HTML form's field names (`email`, `phone`, `address`, `textarea`) don't match what `mail.php` reads (`$_POST["name"]`, `$_POST["subject"]`). The **production error log** (`legacy-site/error_log`) shows this has been silently throwing `Undefined array key "name"` / `"subject"` warnings on every submission since at least **September 2024**. Net effect: for ~2 years, real customer enquiries through this form have either gone nowhere useful or arrived at a third party's inbox, missing the sender's name and subject. The `address` field is also typed `type="email"`, so browsers will reject a real postal address as invalid input.

### 1.2 A second, more broken mail handler is live at `/new/sendemail.php`
Recipient is a literal unconfigured placeholder (`RECIPIENT_EMAIL = "youremail@mail.com"`), and the `mail()` call itself is malformed — `mail($recipient, $headers, $msgBody)` passes the headers string as the *subject* argument and never sends real headers at all. This form cannot ever have worked. It's reachable in production even though nothing in the live nav links to it.

### 1.3 Unverified/contradictory trust claims live on real, indexed marketing pages
- `offers.html`: *"over 15 years of experience and a 98% approval rate"*
- `partner.html`: *"15+ years of experience and 98% visa approval rate"*
- `about.html`: in the same paragraph — *"over a decade of specialized experience"*, *"a decade-long history"*, and *"over 12+ years"* (three different numbers, one sentence, with a visible copy-paste seam: "...specialized experience.is a seasoned visa consultancy firm...")
- The site's own footer (`support.html`, `dependent.html`, and others) states the real, consistent fact: **"A Unit of Tripgation® ©2014-25"** with **CIN U63030UP2020PTC128661**.

The brief explicitly forbids "98% approval rate" and unverified "X+ years" claims. The footer's "since 2014" is the one number that's consistent site-wide and matches the registered entity — recommend standardizing on that and deleting the rest (see open questions in §7).

### 1.4 The purchased template's own identity is leaking to visitors and Google
- `visa.html`, `pricing.html`, `team-details.html`, and `404.html` all still have `<title>RouteX - Immigration and Visa Consulting HTML5 T...` — the template's own title, unedited, on **live, indexed pages** (including `/visa.html`, one of the more important pages on the site). Same four pages also have an **empty `<meta name="description">`**.
- `team-details.html`, `404.html`, and `pricing.html` render **"© RRDevs 2024 | All Rights Reserved"** in the footer, linking to `rrdevs.net`.
- `/jina/documention/index.html` and `/new/Doc/index.html` are the **template vendor's own documentation pages**, publicly deployed and crawlable, also titled "RouteX - Immigration and Visa Consulting HTML5 Template".

---

## 2. Content audit

### 2.1 Literal placeholder/filler text on live pages
The exact filler paragraph *"Aliquam eros justo, posuere loborti viverra laoreet matti ullamcorper..."* (Lorem-Ipsum-style Latin filler) is the **entire body content** of these pages:

| Page | Intended purpose |
|---|---|
| `student.html` | Student visa category page |
| `work.html` | Work visa category page |
| `crew.html` | Crew/seafarer visa category page |
| `dependent.html` | Dependent visa category page |
| `documentation.html` | Documentation service page |
| `onlineformfiling.html` | Online form filing service page |
| `commercial.html` | Commercial document verification page |
| `educational.html` | Apostille/educational certificate page |
| `non-commercial.html` | Legal document verification page — also headlined **"Coming Soon"** |
| `sample.html` | Headlined **"Coming Soon"**, filler body |

That's **10 pages**, several of them core visa-category pages (student, work, crew, dependent), shipping zero real content. `tourist.html` and `business.html`, by contrast, have real (if generic and template-styled) written copy — but both also have an **empty `<h1></h1>`** and a CTA linking to `https://visagiri.com/apply`, a URL that doesn't correspond to any page in this export.

### 2.2 Template-default filler content not written for Visagiri at all
`new/index-2.html` (in the unfinished redesign) contains: *"Since 1985, Reliable Service has been servicing its clients..."* — a completely unrelated template placeholder sentence, never edited.

### 2.3 SEO metadata
- **Zero pages** (root site or `/new/`) have a `rel="canonical"` tag.
- **Zero pages** have any `application/ld+json` structured data (no Organization, WebSite, FAQPage, or BreadcrumbList schema anywhere).
- No `robots.txt`, no `sitemap.xml` anywhere in the export — only a human-readable `sitemap.html`.
- 4 pages have duplicate/leaked template titles and empty meta descriptions (§1.4).

### 2.4 Country coverage
`country.html` renders **69 country cards**, driven by static per-country image files (`assets/imgs/countrie/*.png`) rather than any structured data source. The list is a strange mix — it includes micro-territories with no realistic visa consultancy demand (Kiribati, Nauru, Tuvalu, Ashmore and Cartier Islands — the last one is an uninhabited Australian nature reserve, not a real visa destination) while **missing several of the brief's named "popular destinations"**: Canada, UK, UAE, Saudi Arabia, Singapore, Hong Kong, and any unified Schengen entry. This reads as an unfiltered auto-generated flag list rather than a curated, business-relevant catalog.

### 2.5 Testimonials / stats
`index.html` uses JS-driven odometor counters (`data-count="200"` for team members, `data-count="10"` for "complete projects," rendered as `0` until JS animates them) — mechanically fine, but the underlying numbers (200 team members, 10K "projects") are unsourced and should be verified, not carried forward as-is. I did not find named, attributable testimonials with verifiable identities on `testimonial.html`; treat existing testimonial content as unverified pending client confirmation.

---

## 3. Structural / navigation audit

### 3.1 Two parallel, inconsistent template navigations, both broken
The root site's own template nav (visible on `404.html`, `pricing.html`, `team-details.html`, `visa.html`, `country-details.html` — the pages that still carry the raw "RouteX" title) links to pages that were **never created in this project**: `about-us.html`, `contact.html`, `gallery.html`, `service.html`, `service-details.html`, `story.html`, `story-details.html`, `blog-grid.html`, `coaching.html`, `coaching-details.html`, `countrie.html`, `countrie-details.html`, `index-2.html`, `index-3.html`, `visa-offers.html`. These are template demo pages whose links were never swapped for the real Visagiri equivalents.

The `/new/` redesign has the same problem in the other direction: its pages assume same-directory siblings (`team.html`, `business.html`, `privacy.html`, `commercial.html`, `documentation.html`, `educational.html`, `non-commercial.html`, `onlineformfiling.html`) that only exist at site **root**, not inside `/new/`, so every one of those links 404s from within `/new/`. It also links to visa-type pages that don't exist anywhere in the export at all: `businessvisa.html`, `crewvisa.html`, `studentvisa.html`, `workvisa.html`, `touristvisa.html`, `visitvisa.html`, `familyvisa.html`, `residencevisa.html`, `employment.html`, `face2face.html`, plus template demo scaffolding (`index-onepage.html`, `index-rtl.html`, `testimonials.html`, `termandcondition.html`). `new/index.html` additionally contains a literal malformed link, `href="/.html"`.

### 3.2 Broken social icon mapping
Across most `/new/` pages, the **Facebook icon** in the footer links to `https://square.com/visagiri` (Square, the payments company) instead of Facebook — a copy-paste error in the social link block, repeated on ~26 pages.

### 3.3 Dead forms
Several newsletter "subscribe" forms (`404.html`, `pricing.html`, `team-details.html`, `visa.html`) post to `action="#"` — no backend, decorative only. `index.html`'s header search form (`<form id="form" action="#" method="get" role="search">`) is likewise non-functional — consistent with the brief's observation that there's no real search/filter engine today.

---

## 4. Images & assets

Out of 1,831 scanned image references, 9 are broken on live pages:

| Missing file | Referenced by | Effect |
|---|---|---|
| `assets/imgs/logo/logo.svg` | `404.html`, `country-details.html` | **Header logo doesn't render** |
| `assets/imgs/footer/logo.svg` | `404.html`, `pricing.html` | Footer logo doesn't render |
| `assets/imgs/countrie/srilanka.png` | `country.html` | Sri Lanka card broken |
| `assets/imgs/countrie/vietnam.png` | `country.html` | Vietnam card broken |
| `assets/images/logo1.png` | `new/index.html` | Logo broken in redesign draft |
| `assets/imgs/concact/contact-tap-img{1-4}.png` (×4) | `support.html` | 4 broken images in contact section |

Asset weight: 7.2MB of fonts + 7.2MB of images loaded largely unoptimized (no evidence of WebP/AVIF, no lazy-loading attributes observed in a spot check). `/new/Doc/` and `/jina/` add another ~2.7MB of vendor documentation/demo assets that serve no purpose in production and should not ship.

---

## 5. Security notes (static-site level; full auth/app security applies once Phases 7–16 are built)

- **Information disclosure**: template vendor documentation (`/jina/documention/`, `/new/Doc/`) and demo pages publicly deployed reveal the exact commercial template in use — low severity but unnecessary attack-surface/recon information, and it's indexable by search engines (diluting SEO with irrelevant content).
- **`mail.php`** has no CSRF protection, no rate limiting, and no output encoding beyond `strip_tags()`/`FILTER_SANITIZE_EMAIL` — acceptable for a `mail()`-based contact form but not a pattern to carry forward once real user data (documents, payments) enters the picture in later phases.
- **No secrets or API keys were found** in any JS/CSS/HTML in this export — clean on that front.
- `.htaccess` only handles HTTPS redirection; no security headers (CSP, X-Frame-Options, HSTS, etc.) are set at the file level (may be set at the server/hosting-panel level, which this export can't show).

---

## 6. What's genuinely worth keeping

Not everything needs to be thrown away:
- The **brand palette and logo concept** (navy/gold/globe/passport/aircraft) is usable as the seed for the redesigned identity in the brief.
- **69 real country flag images** and the general country-card pattern are a reasonable visual starting point (once curated against real target-market demand and moved into a database-driven model).
- `tourist.html` and `business.html` contain **genuinely hand-written, on-brand marketing copy** (not template filler) that can be adapted rather than rewritten from scratch.
- The footer's legal line — *"A Unit of Tripgation® ©2014-25... CIN: U63030UP2020PTC128661"* — is a real, consistent, usable fact and should anchor the new About/footer copy.
- Legal/policy pages exist in some form for Privacy, Refund, Payment Policy, Code of Conduct, Grievance, Hiring Policy — these need a legal-accuracy review, not a from-scratch rewrite.
- The overall page inventory (34 policy/service/informational page types) is a reasonable checklist of *topics* the new IA should cover, even though the new URL structure and content will be new.

---

## 7. Facts I need from you before writing real copy

Per our earlier agreement, I'm not going to invent these — flagging them now so Phase 2+ isn't blocked later:

1. **Founding year** — is "serving visa/travel-related requirements since 2014" (the site's own footer claim) confirmed and safe to use platform-wide? Should the "12+/15+ years" and "98% approval rate" lines simply be deleted, or is there a real, current figure you want used instead?
2. **CIN / legal entity** — confirm `U63030UP2020PTC128661` under Tripgation Pvt Ltd is current and correct for footer/invoice use.
3. **Real office address(es), phone number(s), business hours, and support email** for the Contact page and LocalBusiness schema (I did not find a verified current address in this export worth reusing as-is).
4. **Actual visa processing times, fees, and service fees per country/visa type** — none of this exists in a trustworthy, structured form today; it needs to come from you or your consultants per country.
5. **Real testimonials** (with consent to publish) — existing ones are unverifiable and should not carry forward silently.
6. **Payment gateway** you want integrated for Phase 10 (application fees/service fees).
7. **Target country/visa-type priority list** for the first data-population pass — the brief's "popular destinations" list is a good default (USA, Canada, UK, Schengen, Australia, NZ, Japan, South Korea, China, Singapore, UAE, Saudi Arabia, Thailand, Indonesia, Vietnam, Malaysia, Hong Kong, Brazil, South Africa, Egypt, Turkey) — confirm or adjust before I model the database around it.

---

## 8. Recommended Information Architecture (target state)

Per the brief's URL rules, moving from today's flat `*.html` structure to:

```
/                                   → homepage
/visa/{country-slug}/               → country visa overview
/visa/{country-slug}/{type-slug}/   → country + visa-type detail (tourist, business, student, work, family, transit, medical, conference, dependent, crew)
/visa-types/{type-slug}/            → cross-country visa-type explainer pages
/countries/                         → country directory/search
/track-visa/                        → public application tracking
/dashboard/...                      → authenticated customer area
/admin/...                          → staff/admin area (role-gated)
/blog/{slug}/                       → visa updates & guides (replaces today's generic travel blog)
/about/, /contact/, /faq/, /privacy/, /terms/, /refund-policy/, /payment-policy/, /cookie-policy/, /grievance/, /code-of-conduct/, /disclaimer/
```

Redirect map from legacy → new URLs (301s) will be needed for the pages that already carry any search equity (`tourist.html`, `business.html`, `student.html`, `work.html`, `about.html`, `faq.html`, `blog.html`, `country.html`, the policy pages) — this becomes a concrete task list once the new routing is built (Phase 12 in the brief).

`/new/` and `/jina/` should **not** be carried into the rebuild in their current form; their only value is as a visual/UX reference during Phase 3 (branding/header/footer redesign), after which they should not be deployed to the new production root.

---

## 9. Phase mapping — what happens next

Mapping the brief's 15 phases onto what this audit unlocks:

| Brief phase | Status after this session |
|---|---|
| 1. Full audit | **Done** (this document) |
| 2. IA + DB architecture | IA drafted above (§8); DB schema design is next — needs your answers from §7 first for realistic scope |
| 3. Brand/logo/header/footer | Not started — logo concept + palette already given in the brief, ready to execute once you confirm scope for this session vs. next |
| 4–15 | Not started — all genuinely new build (no existing PHP app to modernize), sequenced as the brief specifies |

**Recommended immediate next step:** confirm the §7 answers you can provide now (even partial), then I'll move to Phase 2 proper — the normalized MySQL schema (`countries`, `visa_types`, `country_visa_types`, `visa_requirements`, `applications`, etc.) and the PHP folder skeleton from the brief's §23, before any homepage code is written.

---

## Appendix: reference material

- Full legacy export preserved at `legacy-site/` in this repo (not deployed, reference only).
- Raw findings (link graph, image-reference scan, title/meta scan) were generated via scripted crawl of the local export; scripts are not retained, but every specific claim above was verified against the actual file contents at the paths cited.
