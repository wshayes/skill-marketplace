# DESIGN.md spec — condensed reference

Source of truth: https://github.com/google-labs-code/design.md/blob/main/docs/spec.md (status: alpha).

A `DESIGN.md` file has two layers:

1. **YAML front matter** between exactly `---` fences at the very top — **normative tokens**.
2. **Markdown body** with `##` sections in a defined order — **rationale and application guidance**.

An optional `#` H1 may title the document but is not parsed as a section.

## Front matter schema

```yaml
version: alpha            # optional
name: <System Name>       # always present in real examples
description: <one-line>   # optional
colors:
  <token-name>: <Color>
typography:
  <token-name>: <Typography>
rounded:
  <scale-level>: <Dimension>
spacing:
  <scale-level>: <Dimension | bare number>
components:
  <component-name>:
    <property>: <value | token reference>
```

### Token value types

| Type | Format | Example |
|---|---|---|
| **Color** | `#` + sRGB hex, quoted | `"#1A1C1E"` |
| **Dimension** | number + `px`, `em`, or `rem` | `48px`, `1.5rem`, `-0.02em` |
| **Token Reference** | `{group.token}` | `{colors.primary}` |
| **Typography** | object (see below) | — |
| **bare number** (spacing only) | unitless | `5` |

### Typography object

```yaml
headline-lg:
  fontFamily: Public Sans       # string
  fontSize: 32px                # Dimension
  fontWeight: "600"             # number or quoted string
  lineHeight: 1.2               # unitless multiplier OR Dimension
  letterSpacing: -0.02em        # Dimension (optional)
  fontFeature: "ss01"           # optional, maps to font-feature-settings
  fontVariation: "wght 600"     # optional, maps to font-variation-settings
```

### Token reference rules

- References resolve to **primitive values** only — `{colors.primary}` ✅, `{colors}` ❌.
- **Exception:** inside `components`, composite refs to typography objects are allowed — `{typography.label-md}` ✅.

### Component properties (well-known set)

`backgroundColor`, `textColor`, `typography`, `rounded`, `padding`, `size`, `height`, `width`. Unknown properties (`borderColor`, etc.) are accepted with a warning.

### Component variants

Variants are **separate top-level entries** under `components` with a related key name; only changed properties need to be repeated.

```yaml
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-md}"
    rounded: "{rounded.md}"
    padding: 12px
  button-primary-hover:
    backgroundColor: "{colors.primary-container}"
```

## Body sections — canonical order

Sections may be omitted; **present sections must appear in this order**. Out-of-order = `section-order` warning. Duplicate headings = hard error.

| # | Canonical Heading | Accepted Aliases |
|---|---|---|
| 1 | `## Overview` | `## Brand & Style` |
| 2 | `## Colors` | — |
| 3 | `## Typography` | — |
| 4 | `## Layout` | `## Layout & Spacing` |
| 5 | `## Elevation & Depth` | `## Elevation` |
| 6 | `## Shapes` | — |
| 7 | `## Components` | — |
| 8 | `## Do's and Don'ts` | — |

Per-section guidance:

- **Overview** — Brand personality, target audience, emotional response (playful vs professional, dense vs spacious). Foundation that downstream decisions ladder back to.
- **Colors** — At least `primary` palette must be defined. Describe each color's role with `**Name (#hex):** description` bullets.
- **Typography** — 9–15 typography levels is typical. Describe font choice, hierarchy strategy, special treatments.
- **Layout** — Grid model (fluid, fixed-max-width, etc.), spacing scale base, container strategy.
- **Elevation & Depth** — Shadows vs tonal layers vs borders vs color contrast.
- **Shapes** — Corner radius philosophy (sharp, soft, organic), icon language.
- **Components** — Use `###` subheadings to group (Action Elements, Containers & Surfaces, Inputs & Selection, Typography Application).
- **Do's and Don'ts** — Simple bullet list: `- Do …` and `- Don't …`. Acts as guardrails.

## Color palette defaults (Material-3-style)

Real examples consistently use a Material-3-style palette structure. Default to this unless the user requests otherwise:

```yaml
colors:
  # Brand families
  primary: "#______"
  on-primary: "#______"
  primary-container: "#______"
  on-primary-container: "#______"
  secondary: "#______"
  on-secondary: "#______"
  secondary-container: "#______"
  on-secondary-container: "#______"
  tertiary: "#______"
  on-tertiary: "#______"

  # Surface families
  surface: "#______"
  on-surface: "#______"
  surface-variant: "#______"
  on-surface-variant: "#______"
  surface-container: "#______"
  surface-container-high: "#______"
  surface-container-low: "#______"

  # Utility
  outline: "#______"
  outline-variant: "#______"
  error: "#______"
  on-error: "#______"
```

For simpler projects, the minimum viable palette is `primary`, `on-primary`, `surface`, `on-surface`, `outline`, `error`. The spec only requires `primary`; everything else is convention.

## Default rounded scale

```yaml
rounded:
  none: 0px
  sm: 4px
  md: 8px
  lg: 12px
  xl: 16px
  full: 9999px
  DEFAULT: 8px     # Tailwind-compatible alias used by all 3 examples
```

## Default spacing scale

```yaml
spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 32px
  xl: 64px
```

Spacing also accepts domain-specific keys (`container-padding`, `card-gap`, `gutter`) and bare numbers (for column counts).

## Forward-compatibility rules

| Scenario | Behavior |
|---|---|
| Unknown `##` section heading | Preserve; do not error |
| Unknown color/typography token name | Accept if value is valid |
| Unknown spacing value type | Accept; store as string |
| Unknown component property | Accept with warning |
| Duplicate section heading | **Error — reject the file** |

## Lint rules (from `@google/design.md/linter`)

| Rule | Severity | Trigger |
|---|---|---|
| `broken-ref` | **error** | `{path.to.token}` doesn't resolve |
| `missing-primary` | warning | Colors defined but no `primary` |
| `contrast-ratio` | warning | Component bg/text pair below WCAG AA 4.5:1 |
| `orphaned-tokens` | warning | Color tokens never referenced by any component |
| `missing-typography` | warning | Colors defined but no typography tokens |
| `section-order` | warning | Sections out of canonical order |
| `missing-sections` | info | Optional sections (spacing, rounded) absent |
| `token-summary` | info | Per-section token counts |

## Self-checks (run before writing)

1. `name` is present in front matter.
2. At least one color token exists, and `primary` is among them.
3. Every `{group.token}` reference points to a defined primitive (or a typography composite, inside `components`).
4. Every component with both `backgroundColor` and `textColor` clears WCAG AA 4.5:1.
5. Sections appear in canonical order; no duplicate `##` headings.
6. Dimensions use only `px`, `em`, or `rem`.
7. Color values are quoted hex strings in sRGB.
8. Component variants reuse their base name plus a state suffix (`-hover`, `-active`, `-pressed`, `-focus`, `-disabled`).

## Optional CLI integration

When Node is available, the following commands are useful (offer; don't run without asking):

```bash
npx @google/design.md lint DESIGN.md                          # validate
npx @google/design.md lint --format json DESIGN.md
npx @google/design.md diff DESIGN.md DESIGN-prior.md          # token diff between versions
npx @google/design.md export --format css-tailwind DESIGN.md > theme.css
npx @google/design.md export --format dtcg DESIGN.md > tokens.json
```

On Windows, the binary is aliased `designmd` (the `.md` suffix collides with file association).
