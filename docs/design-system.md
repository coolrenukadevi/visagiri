# Visagiri 2.0 — Design System (Phase 3)

Source of truth: `public/assets/css/tokens.css`, `base.css`, `components.css`, combined via `public/assets/css/main.css`. Every later phase (header/footer, homepage, dashboard, admin) must consume these tokens/classes rather than hardcoding colors or reinventing components — that's the entire point of doing this phase before any page markup.

Visual preview: `docs/design-system-preview.html` (open directly, or see the screenshots shared alongside this phase).

## Palette

Derived directly from the Visagiri logo — navy, gold, white — refined into a full token set:

| Token | Value | Use |
|---|---|---|
| `--visa-blue` | `#123F91` | Primary brand color: header, primary buttons, links (dark contexts) |
| `--visa-blue-dark` | `#082A67` | Hover/active states, dark sections |
| `--visa-blue-secondary` | `#1557B8` | Body links, info state |
| `--visa-blue-light` | `#EAF2FF` | Tinted backgrounds, hover fills |
| `--visa-gold` | `#F4B400` | Accent / primary CTA |
| `--visa-gold-dark` | `#C98F00` | Gold button hover |
| `--visa-gold-light` | `#FFF5D6` | Tinted accent backgrounds |
| `--text-dark` | `#172033` | Body/heading text |
| `--text-muted` | `#667085` | Secondary text |
| `--background` | `#F7F9FC` | Page background |
| `--surface` | `#FFFFFF` | Card/panel background |
| `--border` | `#E5EAF2` | Hairline borders |
| `--success` / `--success-bg` | `#12805C` / `#E6F6EF` | Approved, completed |
| `--warning` / `--warning-bg` | `#B98900` / `#FFF7E0` | Pending, under review |
| `--danger` / `--danger-bg` | `#C4342F` / `#FCEAEA` | Rejected, failed payment |
| `--info` / `--info-bg` | `#1557B8` / `#EAF2FF` | Informational states |

No legacy template colors (the old site's dark green, RRDevs-era palette) survive anywhere in this token set.

## Typography

System font stack (`-apple-system, "Segoe UI", Roboto, ...`) — zero webfont network requests by default, matching the brief's performance/no-unnecessary-libraries stance. A brand webfont can be swapped in later (Phase 17) by changing one variable (`--font-sans`) without touching component code.

Scale: `--font-size-xs` (12px) through `--font-size-5xl` (48px, desktop H1 only). Weights: regular/medium/semibold/bold — no light weights (matches the "premium, not delicate" fintech direction).

## Spacing, radius, elevation, motion

- 4px-based spacing scale (`--space-1` … `--space-12`) — every component margin/padding uses these, nothing hardcoded.
- Radius is intentionally modest (`--radius-sm` 6px, `--radius-md` 10px, `--radius-lg` 16px) — not the "pill-shaped everything" travel-agency look the brief explicitly warned against.
- Shadows are subtle (`--shadow-sm/md/lg`) — used sparingly for card elevation, not decoration.
- Transitions are fast (120–200ms) — no showy animation, matches "avoid excessive animations."

## Components shipped this phase

`.btn` (primary / gold / outline / ghost, sm/lg sizes), `.card` + `.card-grid`, `.badge` (success/warning/danger/info/neutral — this is what application/document status pills will use from Phase 10 onward), `.form-group`/`.form-input`/`.form-select`/`.form-textarea` with focus and invalid states, `.alert` (for flash messages), `.breadcrumb`, `.accordion-item` (native `<details>`/`<summary>` — the FAQ accordion works with zero JavaScript), `.table`/`.table-wrap` (admin/dashboard listings), `.status-timeline` (the application status timeline from the brief's tracking spec), `.sidebar-nav` (dashboard/admin sidebar), `.pagination`.

Accessibility baked in at this layer: a `.skip-link`, visible `:focus-visible` rings everywhere (never removed without a replacement), `.visually-hidden` for screen-reader-only text.

## What's deliberately not in this phase

No header/footer markup (Phase 4), no page layouts (Phase 5+). This phase is tokens and reusable building blocks only, verified in isolation via the preview page — not yet wired into the route stubs from Phase 2.
