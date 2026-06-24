---
name: html-app
description: Suite of tools for creating elaborate, multi-component single-file HTML app artifacts for claude.ai using modern frontend web technologies (React, TypeScript, Tailwind CSS v4, shadcn/ui). Use for complex artifacts requiring state management, routing, or shadcn/ui components — not for simple single-file HTML/JSX artifacts.
license: Complete terms in LICENSE.txt
---

# HTML App (Single-File Artifact Builder)

> **Origin & attribution.** This skill is adapted from Anthropic's
> [`web-artifacts-builder`](https://github.com/anthropics/skills) skill (Apache 2.0 — see `LICENSE.txt`).
> It has been modernized: **Node 20+**, **Tailwind CSS v4** (CSS-first, OKLCH tokens),
> React 19, the unified `radix-ui` package, and a regenerated set of **56 native-v4
> shadcn/ui components**. Changes by William Hayes.

Build a powerful React app and ship it as ONE self-contained HTML file that runs as a claude.ai artifact.

**Workflow:**
1. Initialize the project with `scripts/init-artifact.sh`
2. Develop the artifact by editing the generated code
3. Bundle everything into a single HTML file with `scripts/bundle-artifact.sh`
4. Share `bundle.html` with the user as an artifact
5. (Optional) Test the artifact

**Stack:** React 19 + TypeScript + Vite (dev) + Parcel (bundling) + Tailwind CSS **v4** + shadcn/ui. Requires **Node 20+**.

## The one hard rule: self-containment

claude.ai artifacts run under a **strict CSP that blocks every external network request** — no CDN scripts, no external stylesheets, no remote fonts, no remote images, no `fetch`/XHR to other hosts. The output MUST be a single HTML file with all JS, CSS, and assets inlined.

- Embed images/fonts as `data:` URIs, not URLs.
- Don't add `<link>` to Google Fonts or any CDN. Use system font stacks or `data:`-embedded fonts.
- Don't call external APIs at runtime. Bake data in or accept it as props/state.
- `bundle-artifact.sh` warns if any `http(s)://` reference survives into the bundle — treat that warning as a build failure to fix.

## Design & style guidelines

VERY IMPORTANT — avoid the "AI slop" look: no excessive centered layouts, no purple gradients, no uniformly rounded corners, no default Inter everywhere. Aim for an intentional, distinctive visual identity. If the `frontend-design` skill is available, use it for design direction; it pairs well with this build pipeline.

## Quick start

### Step 1: Initialize project

```bash
bash scripts/init-artifact.sh <project-name>
cd <project-name>
```

This creates a fully configured project with:
- ✅ React + TypeScript (via Vite)
- ✅ Tailwind CSS **v4** (CSS-first config — no `tailwind.config.js`)
- ✅ OKLCH design tokens + class-based dark mode, wired to shadcn
- ✅ Path aliases (`@/`)
- ✅ 56 native-v4 shadcn/ui components (new-york style) pre-installed
- ✅ `radix-ui` + `@base-ui/react` + `recharts` + `tw-animate-css`
- ✅ Node 20+ checked at startup

### Step 2: Develop your artifact

Edit the generated files (start with `src/App.tsx`). See **Common Development Tasks** below.

### Step 3: Bundle to a single HTML file

```bash
bash scripts/bundle-artifact.sh
```

Produces `bundle.html` — a self-contained artifact with all JavaScript, CSS, and assets inlined. **Requires an `index.html` in the project root** (Vite creates one).

What it does: installs Parcel + `html-inline`, builds with Parcel (Tailwind v4 compiles via the shared `postcss.config.js`, no source maps), inlines all assets, then checks the result for stray external references.

### Step 4: Share artifact with user

Share `bundle.html` in the conversation so the user can view it as an artifact.

### Step 5: Testing / visualizing (optional)

Optional — only if needed or requested. Open `bundle.html` in a browser, or use Playwright/Puppeteer. Avoid testing upfront (it adds latency before the user sees the result); test afterward if issues arise.

## Tailwind v4 notes (read before editing styles)

Tailwind v4 is **CSS-first** — there is no `tailwind.config.js`. Everything lives in `src/index.css`:

- `@import "tailwindcss";` replaces the old `@tailwind base/components/utilities` directives.
- `@import "tw-animate-css";` provides the enter/exit utilities shadcn uses (`animate-in`, `fade-in-0`, `zoom-in-95`, `slide-in-from-*`). This is the v4 successor to `tailwindcss-animate`.
- `@custom-variant dark (&:is(.dark *));` enables class-based dark mode.
- `@theme inline { ... }` maps shadcn semantic tokens (`--color-primary`, etc.) to Tailwind color utilities. **`inline` is required** so utilities reference `var(--token)` at use-site and the `.dark` overrides flip at runtime.
- Design tokens are **OKLCH** values defined in `:root` and `.dark`.

**To change the color scheme:** edit the `oklch(...)` values in the `:root` / `.dark` blocks of `src/index.css`. To add a new token (e.g. a brand color), add `--brand: oklch(...)` in `:root`, map `--color-brand: var(--brand)` inside `@theme inline`, then use `bg-brand`, `text-brand`, etc.

## Common development tasks

- **Use components:** `import { Button } from '@/components/ui/button'`. Components live in `src/components/ui/`.
- **Dark mode:** wrap the tree with a `.dark` class (or use `next-themes`, already installed) — the token overrides handle the rest.
- **Add an icon:** `lucide-react` is installed: `import { Check } from 'lucide-react'`.
- **Forms:** `react-hook-form` + `zod` + `@hookform/resolvers` are installed; use the `form` component.
- **Toasts:** use `sonner` (`import { Toaster, toast } from '@/components/ui/sonner'`). The old Radix `toast`/`use-toast` was removed in v4 — sonner is the replacement.
- **Charts:** `chart` wraps `recharts` 3. The theme ships 5 chart series tokens — reference them in the chart `config` as `color: "var(--chart-1)"` … `var(--chart-5)`. They're neutral grays by default; edit the `--chart-*` values in `src/index.css` (or use any color) for a distinct palette.
- **Add a component not in the set:** `pnpm dlx shadcn@latest add <name>` pulls the current Tailwind-v4 source into `src/components/ui/`.

## Bundled components (56, native Tailwind v4 / new-york)

accordion, alert, alert-dialog, aspect-ratio, avatar, badge, breadcrumb, button, button-group, calendar, card, carousel, chart, checkbox, collapsible, combobox, command, context-menu, dialog, direction, drawer, dropdown-menu, empty, field, form, hover-card, input, input-group, input-otp, item, kbd, label, menubar, native-select, navigation-menu, pagination, popover, progress, radio-group, resizable, scroll-area, select, separator, sheet, sidebar, skeleton, slider, sonner, spinner, switch, table, tabs, textarea, toggle, toggle-group, tooltip.

## Known limitations

- Components import from the unified `radix-ui` package and `@base-ui/react`, matching the current shadcn registry. `react-day-picker` (calendar), `react-resizable-panels` (resizable), and `recharts` (chart) are pinned to the major versions those components target; if you add a newer component version, update the matching dependency.

## Reference

- shadcn/ui components: https://ui.shadcn.com/docs/components
- Tailwind v4: https://tailwindcss.com/docs
