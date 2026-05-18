---
name: design-md
description: "Author, extract, and maintain a project's DESIGN.md following the Google design.md spec (https://github.com/google-labs-code/design.md). Use whenever the user is (a) starting a new application or feature and wants to capture the design, style, or brand guide; (b) working in a project that already has UIs but no DESIGN.md — extract the existing visual language into one; or (c) making UI/UX changes that should be reflected in DESIGN.md. Triggers: 'create a design system', 'save the design', 'style guide', 'brand guide', 'design.md', 'DESIGN.md', 'design tokens', 'extract the styles', 'document the UI'. Also fires whenever a UI change is made — propose updating DESIGN.md. After creating or updating DESIGN.md, always ensure the project's CLAUDE.md contains a reference instructing future agents to use DESIGN.md for design decisions."
license: Proprietary
metadata:
  scope: organization
  version: 1.0.0
  spec_source: https://github.com/google-labs-code/design.md/blob/main/docs/spec.md
---

# design-md Skill

DESIGN.md is the project's single source of truth for visual design — brand personality, color tokens, typography, spacing, components, and the rules that bind them. This skill owns that file: creating it, extracting it from existing UIs, keeping it current as the UI evolves, and ensuring CLAUDE.md points at it.

The file format is the Google `design.md` spec: YAML front matter for normative tokens + Markdown body for rationale and application guidance.

## Operating principle

The front matter is normative (agents copy values verbatim). The prose is descriptive (it explains *why* and *how to apply*). They must stay in sync. If a token changes, find prose references and reconcile.

## When to act

Run this skill in one of three modes:

| Trigger | Mode |
|---|---|
| User wants to start/save a design or brand guide for an app being built | **Mode A — Author from scratch** |
| Project already has UI code/styles but no `DESIGN.md` exists | **Mode B — Extract from existing UI** |
| A UI/UX change has just been made (or is being planned) | **Mode C — Update on change** |

If a project has any of: a `tailwind.config.*`, `theme.{ts,js,json}`, CSS custom properties, a `globals.css` with `:root` tokens, styled-components themes, MUI/Chakra theme files, Figma exports — and no `DESIGN.md` — surface this to the user and offer Mode B. Don't silently produce a `DESIGN.md`; confirm scope first.

## Mode A — Author from scratch

Use when the user is building a new application and wants to capture the design, style, or brand guide upfront.

1. **Capture the brand context.** Before writing any tokens, ask (or infer from conversation):
   - Product name and one-line description
   - Target audience and core emotional response (playful, professional, calm, energetic, premium, utilitarian, etc.)
   - Reference inspirations or anti-references the user has named
   - Domain constraints (accessibility floors, dark mode required, specific platforms)

   If the user has not stated brand direction, do not invent one — ask one focused question and proceed once answered.

2. **Draft the Overview section first.** This is the load-bearing prose that downstream decisions ladder back to. See `references/spec-reference.md#overview`.

3. **Propose a token skeleton.** Use `assets/DESIGN-template.md` as the starting point. Populate `colors`, `typography`, `rounded`, `spacing`, and a minimum component set (`button-primary`, `button-secondary`, plus their hover variants, and one input or surface component). Default to a Material-3-style palette unless the user pushes back — see `references/spec-reference.md#color-palette-defaults`.

4. **Run the self-checks** in `references/spec-reference.md#self-checks` before writing the file:
   - `primary` color exists.
   - Every `{group.token}` reference resolves.
   - WCAG AA contrast (4.5:1) on every component `backgroundColor`/`textColor` pair.
   - Section order matches canonical order.
   - No duplicate section headings (this is a hard reject).

5. **Write `DESIGN.md` at the project root.** Always at the root unless the user specifies a subfolder for a monorepo.

6. **Wire CLAUDE.md.** See `## Wiring CLAUDE.md` below — this is non-optional; every Mode A run ends with this step.

7. **Offer lint validation.** If Node is available, propose running `npx @google/design.md lint DESIGN.md`. Don't run it without asking — it's a network call.

## Mode B — Extract from existing UI

Use when the project already has visual design implemented in code but no `DESIGN.md` to reference.

1. **Inventory first, write second.** Scan the codebase for:
   - **Color sources:** `tailwind.config.*`, `theme.{ts,js,json}`, `:root` CSS variables, styled-components/emotion theme objects, MUI/Chakra theme overrides, design-token JSON, SCSS `$variables`, Figma exports (`tokens.json`, `*.design-tokens.json`).
   - **Typography sources:** font imports (`@font-face`, Next.js `next/font`, `<link>` tags to Google Fonts), `font-family`/`font-size`/`font-weight` declarations across components, type scales in theme files.
   - **Spacing & layout:** spacing scales in theme files, recurring padding/margin values in components, container max-widths, breakpoints.
   - **Rounded/elevation:** border-radius values, box-shadow rules.
   - **Components:** the primary action button, secondary buttons, links, inputs, cards/surfaces, modals/dialogs, nav. Capture both base and hover/active states.

   For codebases over a few files, dispatch a subagent (`Explore`) to enumerate sources rather than reading everything yourself. See `references/extraction-procedure.md` for a query checklist.

2. **Resolve conflicts before drafting.** If you find three different "primary" blues, name the conflict and ask the user which to canonize. Don't pick silently.

3. **Reverse-engineer the Overview prose.** From the patterns observed (corner radii, contrast level, density, font choices), infer the brand personality the design currently expresses. Write the Overview as a description of what *is*, not what should be. Flag any aspect that feels accidental rather than intentional and ask the user to confirm.

4. **Populate tokens from observed values.** Every color hex, font size, weight, spacing value, and radius that recurs should become a token. Idiosyncratic one-offs stay as prose notes, not tokens.

5. **Identify gaps.** What's missing — a documented elevation system, an error palette, a consistent type scale? List these in a "Gaps observed" note to the user *before* writing the file. Don't silently invent values to fill them.

6. **Write `DESIGN.md`, run self-checks, wire CLAUDE.md.** Same as Mode A steps 5–7.

See `references/extraction-procedure.md` for the full extraction playbook.

## Mode C — Update on UI/UX change

Use after (or while making) any change that affects the visual language: a new component, a color swap, a typography revision, a spacing change, a brand refresh.

1. **Diff the change against `DESIGN.md`.**
   - **Token-level changes** (a color hex changed, a new size added): update the front matter token. Search prose for descriptive references to that token and reconcile descriptions.
   - **New component**: add the component(s) to the `components` front matter block AND under `## Components` in prose.
   - **Removed component**: remove from front matter and prose. Search the rest of the project for component refs that no longer resolve.
   - **New design rule learned** (e.g., "we decided buttons never use the tertiary color"): add to `## Do's and Don'ts`.

2. **Preserve section order.** When inserting new content, keep the canonical section order (Overview → Colors → Typography → Layout → Elevation & Depth → Shapes → Components → Do's and Don'ts).

3. **Re-run self-checks.** Same checks as Mode A step 4. A token rename that breaks a `{ref}` is a hard error — fix before committing.

4. **Note the change visibly.** Don't bury an update inside a much larger commit. Surface to the user: "DESIGN.md updated: `colors.primary` `#1A1C1E` → `#0D0D0F`, three component refs unchanged." Brief, specific.

See `references/update-procedure.md` for change-class playbooks.

## Wiring CLAUDE.md

Every successful run of this skill ends by ensuring the project's `CLAUDE.md` contains a reference to `DESIGN.md`. This is what makes future agents (and future-you) actually use the design system instead of redesigning ad-hoc.

1. **Locate** `CLAUDE.md` at the project root. If absent, create it.
2. **Check for an existing DESIGN.md reference.** Search for the literal string `DESIGN.md`. If a reference exists, leave it alone — don't duplicate.
3. **If absent, append** the snippet from `assets/claude-md-snippet.md` near the top of `CLAUDE.md`, under a `## Design system` heading. The snippet instructs future agents to consult `DESIGN.md` for any design decision and to invoke this skill on UI/UX changes.

If the user has multi-level CLAUDE.md files (root + per-package in a monorepo) and the `DESIGN.md` is at the root, wire the root CLAUDE.md only. If they have package-specific DESIGN.md files, wire each package's CLAUDE.md to its local DESIGN.md.

## File location conventions

- `DESIGN.md` lives at the **project root** by default.
- In a monorepo, if multiple distinct UIs exist, propose **one `DESIGN.md` per UI package** (e.g., `apps/web/DESIGN.md`, `apps/admin/DESIGN.md`) and wire each package's `CLAUDE.md` accordingly. Ask before assuming one-vs-many.
- Filename is exactly `DESIGN.md` — uppercase, no variants. Other agents and the `@google/design.md` CLI expect this name.

## Anti-patterns (refuse silently producing these)

- **Inventing brand direction.** If the user hasn't articulated a brand personality and there are no UI artifacts to extract from, ask. Don't make one up.
- **Token names that are descriptive instead of systematic.** `midnight-forest-green: "#1A2A1C"` is wrong in tokens; `primary: "#1A2A1C"` with prose noting "Midnight Forest Green" is right. Token keys are roles; prose carries the evocative names.
- **Group references in token values.** `{colors}` is invalid. Only primitive paths like `{colors.primary}` (or composite typography refs inside `components`).
- **Duplicate section headings.** Two `## Colors` blocks reject the file. Catch this before writing.
- **Defining colors without typography.** Triggers the spec's `missing-typography` warning. Either define both or neither.
- **Silently overwriting an existing `DESIGN.md`.** Read it first; diff; ask before destructive overwrite.
- **Forgetting CLAUDE.md.** A `DESIGN.md` that future agents don't know to read is dead weight. Wiring CLAUDE.md is part of the deliverable, not a nice-to-have.
- **Skipping the WCAG AA check.** Every `backgroundColor`/`textColor` component pair must clear 4.5:1. Flag any failures and propose fixes before writing.

## Reference files

- `references/spec-reference.md` — Condensed Google design.md spec: front matter schema, body sections, token reference syntax, color palette defaults, self-checks, lint rule meanings.
- `references/extraction-procedure.md` — Mode B playbook: where to look for tokens in existing codebases, how to resolve conflicts, when to dispatch a subagent.
- `references/update-procedure.md` — Mode C playbook: change-class playbooks (color change, new component, typography revision, brand refresh).

## Assets

- `assets/DESIGN-template.md` — Blank scaffold with all canonical sections and a reasonable starter token set. Always copy this and edit; never write `DESIGN.md` from a blank file.
- `assets/claude-md-snippet.md` — The exact snippet to inject into the project's `CLAUDE.md`.

## Composition with other skills

- Pair with **`impeccable` / `frontend-design`** when authoring new UI: those skills generate the visual code; this skill captures the resulting language in `DESIGN.md`.
- Pair with **`audit`** to verify accessibility/contrast claims in `DESIGN.md` against the actual implementation.
- Pair with **`critique`** when reviewing a UI: critique findings often surface decisions that belong in `## Do's and Don'ts`.

This skill is content + structure; it does not generate the UI itself. It records and preserves the decisions made elsewhere.
