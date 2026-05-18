---
version: alpha
name: <Product Name>
description: <one-line summary of what this product is>
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

typography:
  headline-lg:
    fontFamily: <Font Name>
    fontSize: 32px
    fontWeight: "600"
    lineHeight: 1.2
    letterSpacing: -0.02em
  headline-md:
    fontFamily: <Font Name>
    fontSize: 24px
    fontWeight: "600"
    lineHeight: 1.3
  body-lg:
    fontFamily: <Font Name>
    fontSize: 18px
    fontWeight: "400"
    lineHeight: 1.6
  body-md:
    fontFamily: <Font Name>
    fontSize: 16px
    fontWeight: "400"
    lineHeight: 1.6
  body-sm:
    fontFamily: <Font Name>
    fontSize: 14px
    fontWeight: "400"
    lineHeight: 1.5
  label-md:
    fontFamily: <Font Name>
    fontSize: 14px
    fontWeight: "500"
    lineHeight: 1.4
    letterSpacing: 0.01em
  label-sm:
    fontFamily: <Font Name>
    fontSize: 12px
    fontWeight: "500"
    lineHeight: 1.3
    letterSpacing: 0.04em

rounded:
  none: 0px
  sm: 4px
  md: 8px
  lg: 12px
  xl: 16px
  full: 9999px
  DEFAULT: 8px

spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 32px
  xl: 64px

components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-md}"
    rounded: "{rounded.md}"
    padding: 12px
  button-primary-hover:
    backgroundColor: "{colors.primary-container}"
  button-primary-disabled:
    backgroundColor: "{colors.surface-variant}"
    textColor: "{colors.on-surface-variant}"

  button-secondary:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label-md}"
    rounded: "{rounded.md}"
    padding: 12px
  button-secondary-hover:
    backgroundColor: "{colors.surface-container-high}"

  input-text:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-md}"
    rounded: "{rounded.md}"
    padding: 12px

  card:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.lg}"
    padding: 16px
---

# <Product Name>

## Overview

<3–5 sentences describing brand personality, target audience, and the emotional response the UI should evoke. Examples of dimensions to address:>
- *Tone:* playful / professional / authoritative / approachable / premium / utilitarian
- *Density:* spacious / compact / hybrid
- *Personality cues:* what should make this feel distinct from competitors?
- *Audience:* who uses this, and what state of mind are they in?

This Overview is the foundation downstream sections ladder back to. When a token value or component decision needs justification, it should reduce to a sentence here.

## Colors

<Prose describing the role of each color family. Use **Name (#hex):** description bullets.>

- **Primary (#______):** <e.g., "the brand hue, used for the single most important action per screen.">
- **On-primary (#______):** <readable text/icon color on top of `primary`.>
- **Primary container (#______):** <a tinted variant of primary for grouped UI areas; used for hover/active states of primary actions.>
- **Secondary (#______):** <supportive brand hue, used for filter chips, alternate emphasis.>
- **Surface (#______):** <the dominant background color of the canvas.>
- **On-surface (#______):** <default body text color on `surface`.>
- **Outline (#______):** <borders and divider lines.>
- **Error (#______):** <destructive and error-state color.>

## Typography

<Describe font choice, type system philosophy, and any special treatments.>

The type system uses <font name> across all levels. <Rationale for the font choice — readability, brand personality, technical constraints.>

Hierarchy strategy:
- **Display & headlines** use <weight> at the larger sizes with negative letter-spacing for optical density.
- **Body** uses <weight> at 16px default with 1.6 line height for comfortable reading.
- **Labels** are slightly smaller with positive letter-spacing — they identify UI elements rather than convey content.

<Note any uppercase-only labels, monospaced fallbacks, or technical/data treatments.>

## Layout

<Describe the layout model and spacing rhythm.>

- **Grid:** <Fluid 12-column / fixed max-width / hybrid. Specify breakpoints and container max-widths.>
- **Spacing scale:** 4px base unit. The scale (xs=4, sm=8, md=16, lg=32, xl=64) doubles at each step beyond `sm`, creating clear visual rhythm.
- **Container strategy:** <e.g., "Content max-width 1200px. Side margins collapse from 64px on desktop to 16px on mobile.">
- **Breakpoints:** <list the breakpoints in use, e.g., sm: 640px, md: 768px, lg: 1024px, xl: 1280px.>

## Elevation & Depth

<Describe how layering is communicated.>

Elevation is communicated primarily through <choose one of: tonal layers (`surface-container-low` → `surface-container` → `surface-container-high`) / shadows / 1px outlines / a hybrid approach>.

<If shadows: specify the exact shadow values for each elevation tier.>
<If tonal: specify which surface tokens map to which elevation.>

## Shapes

<Describe corner-radius philosophy and any other shape-language decisions.>

The shape language is <soft / sharp / mixed-intentionally>. Default `rounded.md` (8px) applies to most surfaces — cards, buttons, inputs. `rounded.lg` (12px) is reserved for primary surfaces like cards. `rounded.full` (9999px) is reserved for chips, avatars, and pill-shaped tags.

<Note any anti-pattern, e.g., "Don't mix radii within a single component.">

## Components

### Action elements

- **`button-primary`** — Used for the single most important action on a screen. One per view. Hover transitions to `primary-container`. Disabled state uses surface tones.
- **`button-secondary`** — Used for secondary actions alongside or instead of primary. Subtler surface treatment.

### Containers & surfaces

- **`card`** — A grouped content surface. Uses `rounded.lg` and `surface-container` background to lift it from the page.

### Inputs & selection

- **`input-text`** — Default text input. Padding matches button height for visual harmony in forms.

### Typography application

- **Page titles** use `headline-lg`.
- **Section headings** use `headline-md`.
- **Body content** uses `body-md` for paragraphs, `body-sm` for metadata.
- **Form labels and button text** use `label-md`. Label spacing (`+0.01em`) distinguishes them from body content even at the same size.

## Do's and Don'ts

- Do use the `primary` color only for the single most important action on each screen.
- Don't apply primary to multiple competing CTAs — it dilutes hierarchy.
- Do maintain WCAG AA contrast (4.5:1) on every text/background pair. The token system is designed so on-* pairs satisfy this by default.
- Don't mix `rounded.sm` and `rounded.lg` within the same component family.
- Do use `surface-container-*` tonal layers to communicate elevation rather than dropping shadows.
- Don't introduce new color values inline — extend the token block instead.
- Do use `label-md` (not `body-md`) inside buttons and form controls.
- Don't use more than two font weights on a single screen.
