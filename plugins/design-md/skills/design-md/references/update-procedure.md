# Update procedure — Mode C

Use when a UI/UX change has been made (or is being made) and `DESIGN.md` already exists. The goal: keep tokens, prose, and the implementation in sync without drifting.

## The change-class triage

| Change kind | Front matter? | Prose? | New rule in Do's/Don'ts? |
|---|---|---|---|
| Color hex changed | ✅ update token | ✅ search & reconcile descriptive name | rarely |
| New color token added | ✅ add token | ✅ add bullet under `## Colors` | rarely |
| Color removed | ✅ remove token | ✅ remove bullet; grep refs | maybe (if it codifies "we don't use X") |
| Font swap | ✅ update `fontFamily` across typography tokens | ✅ rewrite typography prose | maybe |
| New typography level | ✅ add token | ✅ add to hierarchy description | no |
| Spacing scale extension | ✅ add token | ✅ note in Layout prose | no |
| New component | ✅ add component(s) + variants | ✅ add `###` subsection under `## Components` | maybe |
| Component removed | ✅ remove all variants | ✅ remove subsection | maybe |
| New design rule learned | ❌ | maybe | ✅ Do's and Don'ts |
| Brand refresh (multiple of above) | ✅ regenerate token block | ✅ rewrite Overview | yes, codify the new constraints |

## Step-by-step for any update

1. **Read current `DESIGN.md`** before editing. Don't assume its state.

2. **Identify what changed and where.** Be specific:
   - "Primary changed from `#1A1C1E` to `#0D0D0F`."
   - "New `tertiary-container` color added."
   - "Card component picked up a 1px outline border."

3. **Update front matter.** Edit tokens directly. Maintain alphabetical-by-role grouping (brand families first, surface families next, utility last) when adding new entries.

4. **Reconcile prose.** Search the body for:
   - The old hex value (e.g., `#1A1C1E`) — replace.
   - The descriptive name attached to the changed token (e.g., "Midnight Forest Green") — confirm or rename in conversation with the user.
   - Any rule that becomes false because of the change (e.g., a Do's/Don'ts bullet that referenced the old behavior).

5. **Update token references if a token was renamed.** Renaming `primary` → `brand-primary` requires updating every `{colors.primary}` ref throughout `components`. If you don't, the spec linter flags `broken-ref` as an error. Prefer not renaming once tokens are referenced — change values, not keys.

6. **Maintain canonical section order** when inserting new content. Adding a `## Elevation & Depth` section to a file that didn't have one? It goes after Layout, before Shapes.

7. **Run self-checks** (see `spec-reference.md#self-checks`). At minimum:
   - All `{group.token}` refs resolve.
   - WCAG AA contrast on any new/changed component bg/text pair.
   - No duplicate `##` headings.

8. **Optionally lint** with `npx @google/design.md lint DESIGN.md`. Offer; don't run silently.

9. **Optionally diff** with `npx @google/design.md diff DESIGN-prior.md DESIGN.md` if the user wants a visible token-level changelog. This requires keeping the prior version on disk; if absent, skip.

10. **Surface the change to the user.** One line, specific:
    > Updated `DESIGN.md`: `colors.primary` `#1A1C1E` → `#0D0D0F`. 3 component refs auto-resolved. WCAG AA still passes on `button-primary` (12.1:1).

## Change-class playbooks

### Color hex swap

1. Edit the token value in front matter.
2. Grep prose for the old hex; replace.
3. Grep prose for the descriptive name (e.g., "Midnight Forest Green"); confirm whether to keep the name or rename in conversation.
4. Re-run WCAG check on every component using this color as `backgroundColor` or `textColor`.

### New component added

1. Add the component to `components:` with all relevant properties.
2. Add a hover variant (and disabled/focus if applicable). Variants are partial overrides.
3. Add a `###` subsection under `## Components` describing when to use it and how it relates to existing components.
4. Check the WCAG ratio.

### Component removed

1. Delete all variant entries (`-hover`, `-active`, `-focus`, `-disabled`).
2. Delete the prose subsection.
3. Grep the rest of the project to ensure no other doc references the removed component.

### Typography revision (font swap)

1. Update `fontFamily` on every typography token using the old font. Be exhaustive — partial updates create an inconsistent type system.
2. Update the typography prose to describe the new font and its rationale.
3. Update any `<link>`/`@font-face`/`next/font` import in the implementation. The DESIGN.md update is incomplete if the font isn't actually loaded.

### Brand refresh

When multiple primitives change at once:
1. Treat as "regenerate, don't patch." Keep the current `DESIGN.md` as `DESIGN.previous.md` for reference, then write the new one from scratch.
2. Rewrite the Overview to reflect the new direction.
3. Run the linter and the WCAG checks across all components — brand refreshes often introduce contrast regressions.
4. Use `npx @google/design.md diff DESIGN.previous.md DESIGN.md` to surface the full token-level delta.
5. Delete `DESIGN.previous.md` only after the user confirms the new version is correct.

### New "Do's and Don'ts" rule

1. Append to the bullet list under `## Do's and Don'ts`. Maintain `Do …` then `Don't …` ordering only loosely — by topic is fine.
2. Rules should be specific and testable. `Do use the primary color only for the single most important action per screen` ✅. `Do make it look good` ❌.

## When to push back

A UI change isn't always a `DESIGN.md` change. Decline to update when:

- The change is a one-off experimental tweak the user is exploring (ask whether it's keeping).
- The change contradicts a documented rule and the user hasn't acknowledged the contradiction (surface it).
- The change is in a sandbox/scratch directory unlikely to ship.

When in doubt, ask: "Should this become part of the design system, or is it a one-off?"
