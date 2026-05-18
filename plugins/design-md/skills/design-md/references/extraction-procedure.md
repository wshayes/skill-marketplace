# Extraction procedure — Mode B

Read this before extracting `DESIGN.md` from an existing codebase. The job is to make implicit design choices explicit, not to invent new ones.

## Step 1 — Inventory sources

Dispatch an `Explore` subagent for codebases over ~20 files. Otherwise grep directly. Look for these file patterns:

### Theme & token files
- `tailwind.config.{js,ts,mjs,cjs}` — `theme.extend.colors`, `fontFamily`, `fontSize`, `spacing`, `borderRadius`, `boxShadow`
- `theme.{ts,js,json}`, `*.theme.{ts,js}` — styled-components / emotion / MUI / Chakra theme objects
- `tokens.{json,js,ts}`, `*.design-tokens.json` — DTCG-style or Style Dictionary token exports
- `globals.css`, `app.css`, `styles.css` — `:root { --color-…: … }` custom property blocks
- `*.scss`, `*.less` — `$primary`, `$spacing-unit` variables
- `figma/`, `design-tokens/` directories

### Typography sources
- `<link rel="stylesheet" href="https://fonts.googleapis.com/…">` in HTML / layout files
- `next/font` calls in Next.js apps
- `@font-face` declarations in CSS
- `font-family` declarations across components — grep for recurring values

### Component sources
- For React: `components/Button.{tsx,jsx}`, `components/ui/button.tsx` (shadcn pattern), `Card.tsx`, `Input.tsx`, etc.
- For Vue: `components/Button.vue`
- For pure HTML/CSS: search for repeated class patterns
- Inspect both **base styles** and **state styles** (`:hover`, `:focus`, `:active`, `aria-disabled`)

### Layout sources
- `app/layout.{tsx,vue}`, `pages/_app.{tsx,vue}` — container widths, max-widths
- Grid utilities in use — Tailwind `max-w-*`, CSS Grid templates
- Breakpoints — `tailwind.config` `screens`, CSS `@media` queries

## Step 2 — Resolve conflicts before drafting

If the inventory turns up:

- **Multiple "primary" colors** (e.g., `#1A1C1E` in theme.ts but `#0D0D0F` in Button.tsx) — ask the user which is canonical. Do not pick silently.
- **Multiple fonts in the same role** (two fonts both used for body text) — flag and ask.
- **Inconsistent spacing values** (4px, 5px, 6px all used for "small padding") — propose a canonical value and a migration note.
- **Components that don't compose** (a card uses one radius, buttons use another, modals use a third) — name the inconsistency in `## Do's and Don'ts` or propose harmonization.

Surface conflicts as a numbered list before writing anything. Wait for the user to resolve before generating `DESIGN.md`.

## Step 3 — Reverse-engineer the Overview

The Overview describes **brand personality, target audience, emotional response**. From the inventory, infer:

| Observation | What it suggests |
|---|---|
| Sharp corners (`rounded: 0`), high-contrast palette | Professional, dense, utilitarian (think Bloomberg, Stripe Dashboard) |
| Soft corners (12–16px), pastel palette | Friendly, consumer (think Duolingo, Notion) |
| Heavy use of `backdrop-filter: blur()`, translucent surfaces | Premium, atmospheric (think Apple, glassmorphism) |
| Large display fonts, generous whitespace | Editorial, marketing-led |
| Tight spacing, small type, dense tables | Productivity, power-user tool |
| Monochromatic + one accent | Minimal, content-first |
| Multiple bright hues used together | Playful, brand-forward |

Draft a 3–5 sentence Overview that captures what the design *is currently doing*. If aspects look accidental (e.g., one rogue purple in a sea of greys), call them out as questions, not declarations.

## Step 4 — Convert observations into tokens

For every recurring value, mint a token. Idiosyncratic one-offs stay as inline prose, not tokens.

### Colors

- Group by role. The repeated brand hue → `primary`. The repeated text color → `on-surface`. The repeated background → `surface`.
- Build `*-container` / `on-*-container` pairs when you see both a tinted background and the readable text on it.
- Hex values must be quoted strings: `primary: "#1A1C1E"`.
- Add `error` if you find a destructive/warning color.

### Typography

- Identify how many distinct sizes are actually used. If five sizes appear repeatedly, mint five tokens.
- Map size+weight combinations to roles: largest weight on largest size → `headline-lg`; default text → `body-md`; uppercase small text → `label-md`.
- Capture letter-spacing only if it's intentional (e.g., negative tracking on display, positive on uppercase labels).

### Rounded

- List the distinct radii in use. Map smallest → `sm`, default → `md`, largest non-pill → `lg`. Include `full: 9999px` only if pills/circles appear.

### Spacing

- Identify the base unit (often 4 or 8px). Map the scale: `xs`, `sm`, `md`, `lg`, `xl`. Add domain-specific keys (`container-padding`, `card-gap`) when those values are stable but don't fit the scale.

### Components

For each of the primary action button, secondary button, input, surface/card, link:
- Capture base styles and at least the hover variant.
- Use `{colors.*}`, `{typography.*}`, `{rounded.*}` token refs rather than literal values.
- Padding becomes a literal `Dimension` (e.g., `padding: 12px`) — there's no token reference for padding in the spec.

## Step 5 — Identify gaps before writing

Before generating `DESIGN.md`, surface a short "Gaps observed" list:

- Missing elevation system?
- No documented dark mode despite dark surfaces in some components?
- No error palette but destructive actions exist?
- No documented focus ring?

For each gap, propose what *could* go in `DESIGN.md` and ask the user whether to:
1. Fill it with a reasonable default (and document the assumption in prose).
2. Leave it out for now (the spec allows omitted sections).
3. Defer to the user to fill in.

Do not silently invent values to plug gaps. The whole point of extraction is fidelity.

## Step 6 — Write, self-check, wire CLAUDE.md

Same as Mode A. Read `assets/DESIGN-template.md`, populate it with the extracted values, run the self-checks from `spec-reference.md#self-checks`, then wire CLAUDE.md.

## Common extraction pitfalls

- **Mistaking implementation details for design intent.** A `box-shadow: 0 1px 2px rgba(0,0,0,0.05)` that's the Tailwind default isn't a design decision — it's a default. Only canonize it if it's used deliberately across multiple components.
- **Over-tokenizing.** If a value appears once, it doesn't need a token. Tokens are for things used in multiple places.
- **Inventing dark mode.** If the codebase doesn't have dark mode, don't add a dark palette to `DESIGN.md`. Note it as a gap if relevant.
- **Translating component code 1:1 into `components` entries.** The spec captures style tokens for components, not their full implementation. Capture `backgroundColor`, `textColor`, `typography`, `rounded`, `padding` — not flex direction, gap, transition timings.
- **Forgetting variants.** A button with no `:hover` style in `DESIGN.md` will look broken when an agent regenerates it. Capture at least hover and disabled.
