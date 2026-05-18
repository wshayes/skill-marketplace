## Design system

This project uses a `DESIGN.md` file at the project root as the single source of truth for visual design — brand personality, color tokens, typography, spacing, components, and rules. It follows the Google [design.md](https://github.com/google-labs-code/design.md) spec: YAML front matter defines normative tokens; the Markdown body explains rationale and application.

**For any design decision** — picking a color, adding a component, choosing typography, spacing a layout — read `DESIGN.md` first and use its tokens. Do not invent new values; extend the token system instead.

**On any UI/UX change** — adding/removing a component, swapping a color, refining typography, refreshing the brand — update `DESIGN.md` to match. Use the `design-md` skill to keep the file synced and validated against the spec. The skill handles change-class playbooks (color swap, new component, typography revision, brand refresh) and runs the required self-checks (token-reference resolution, WCAG AA contrast, canonical section order).

**Conflicts:** if a recently-edited component disagrees with `DESIGN.md`, surface the conflict and ask which is canonical before silently reconciling.
