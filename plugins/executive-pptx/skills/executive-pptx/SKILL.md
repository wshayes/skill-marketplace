---
name: executive-pptx
description: "Create or critique executive PowerPoint presentations using a decision-driven structure: conclusion-titles, one-idea-per-slide, and the hardest objection answered on-slide. Draws on the Pyramid Principle, BLUF, SCQA, action-title horizontal logic, the 'so what?' test, Rule of 3, MECE, and pre-mortem objection handling. Use whenever the user is preparing or reviewing slides for a CEO, board, leadership team, steering committee, governance review, or investor update — even for a single slide. Triggers: 'executive deck', 'board slides', 'leadership presentation', 'review my deck', 'tighten this presentation', 'make this more executive', 'CEO-ready slides', 'steering committee', 'pre-read', 'action titles', 'Pyramid Principle', 'critique my deck', and any case where slide content reads as an information dump rather than a recommendation. Use BEFORE branding skills like montai-pptx — structure first, skin second. Use INSTEAD of the generic pptx skill when the audience is senior and the deck must drive a decision."
license: Proprietary
metadata:
  scope: organization
  version: 1.0.0
  composes_with:
    - pptx
    - montai-pptx
---

# Executive PPTX Skill

Build executive presentations the way senior audiences actually consume them: by reading titles, scanning for the ask, and forming an opinion in 30 seconds. This skill encodes a decision-driven discipline — not a design system. The look-and-feel layer is handled separately by `pptx` (mechanics) and `montai-pptx` (branding).

## Operating principle

A slide that explains everything decides nothing. Executive slides exist to drive a decision, not to display work. Information density is not a virtue — selectivity is.

Every slide produced or reviewed by this skill must pass three tests. They are not stylistic preferences; they are pass/fail gates.

### The three tests (apply to every slide)

**Test 1 — Title is a conclusion, not a label.**
The title is the only thing half the audience will read. It must tell them what to think.

- Label (wrong): `Q3 Performance Overview`
- Conclusion (right): `Q3 is 12% below target — we need a budget decision`
- Label (wrong): `Partnership Options`
- Conclusion (right): `Option B is the lowest-risk path to launch`

If you can swap a slide's title onto a different slide without it feeling out of place, the title is a label. Rewrite it.

**Test 2 — One idea, not one topic.**
The slide lands a single sentence. Five data points are allowed only if they all prove the *same* sentence. If you cannot write the sentence in a single line, the slide is two slides.

Ask: *what is the one thing the audience should take away?* Write it down. If you cannot, split or cut.

**Test 3 — The hardest objection is answered on the slide.**
Before any slide carrying a recommendation ships, name the most likely pushback in writing. Then answer it on the slide — not in the appendix, not in your speaker notes, not "I'll cover that if it comes up." On the slide.

Senior audiences will raise the objection regardless. Answering it pre-emptively is what builds credibility; withholding it reads as either avoidance or weak preparation.

## When to use this skill vs. its siblings

| Situation | Skill |
|---|---|
| Audience is senior; a decision is required or a recommendation is being made | **executive-pptx** (this skill) |
| Audience is technical/peer; deck is informational, training, or reference | `pptx` |
| Deck content is already structured and just needs Montai branding | `montai-pptx` |
| Full workflow: raw content → exec structure → Montai look | `executive-pptx` → `montai-pptx` |

When in doubt, use this skill. The three tests do no harm to non-executive decks; they only make them sharper.

## Workflow

### Mode A — Author a new deck

1. **Capture the ask, not the topic.** Before touching slides, write one sentence: *"At the end of this meeting, the audience will [decide / approve / commit to / understand] _____."* If the user has not stated this, ask. Without it, no storyline is possible.
2. **Build the storyline first, slides second.** Draft the deck as an outline of action titles only — no body content, no design. This outline is the deck's *horizontal logic*: read top to bottom, the titles alone must tell the story. See `references/storyline.md` for the Pyramid Principle / SCQA construction.
3. **Stress-test the storyline.** Read the titles aloud in order. Does it form a recommendation supported by reasons? If a title cannot be defended in a sentence, it is a placeholder, not a slide.
4. **Apply the three tests to each planned slide.** Reject any slide that fails.
5. **Decide the slide archetype** for each surviving title. See `references/slide-archetypes.md`. Common archetypes: Recommendation, Evidence, Options Comparison, Trade-off, Risk & Mitigation, Asks & Decisions.
6. **Pre-mortem objections.** For each recommendation-bearing slide, write the strongest objection and the on-slide answer before composing the slide body. See `references/objection-handling.md`.
7. **Compose slides.** Use the `pptx` skill for mechanics. Keep slides visually disciplined — one idea expressed with one chart, one table, or one short text block plus the objection-answer treatment.
8. **Self-critique with `references/critique-mode.md`** before delivering. Then, optionally, re-skin with `montai-pptx`.

### Mode B — Critique an existing deck

1. **Extract titles only.** Use `extract-text` from the `pptx` skill, but read *titles in order* first. Ask: do the titles alone tell the story?
2. **Score every slide against the three tests.** Use the rubric in `references/critique-mode.md`.
3. **Produce a critique report.** Use `assets/critique-report-template.md`. Output is a Markdown or Word document with slide-by-slide findings, severity, and rewrite suggestions for titles and objection-handling.
4. **Offer to redraft.** Convert any failing slide into a passing one if the user asks. Do not silently rewrite — surface the issue first, propose the fix, then act on confirmation.

## Frameworks this skill draws on

The three tests are non-negotiable. Everything below is scaffolding that *helps* a slide pass them.

| Framework | What it gives you | Where it lives |
|---|---|---|
| **Pyramid Principle (Minto)** | Top-down structure: answer first, then key reasons, then evidence | `references/storyline.md` |
| **SCQA (Situation–Complication–Question–Answer)** | Opening narrative arc | `references/storyline.md` |
| **BLUF (Bottom Line Up Front)** | The first slide states the ask | `references/storyline.md` |
| **Action titles / horizontal logic** | Titles read as a coherent storyline alone | `references/action-titles.md` |
| **"So what?" test** | Every fact ladders to a recommendation | `references/storyline.md` |
| **Rule of 3** | Three options, three reasons, three risks — human working memory | `references/slide-archetypes.md` |
| **MECE** | Options/categories don't overlap and cover the space | `references/slide-archetypes.md` |
| **Pre-mortem** | Surface the hardest objection in writing before slide composition | `references/objection-handling.md` |
| **Tufte / data-ink** | Charts carry signal, not decoration | `references/slide-archetypes.md` |
| **Decision-required tagging** | Each slide labelled DECISION / DISCUSSION / FYI | `references/slide-archetypes.md` |
| **Appendix discipline** | Detail moves to appendix; main deck only carries decision-driving slides | `references/storyline.md` |

## Output formats

**Author mode** produces:
- A storyline outline (Markdown) — always created first; this is the deliverable the user reviews before any slides are built.
- A `.pptx` file — built via the `pptx` skill once the storyline is approved.
- Optionally, a Montai-branded `.pptx` — produced by running `montai-pptx` on the output.

**Critique mode** produces:
- A `.docx` or `.md` critique report following `assets/critique-report-template.md`. Includes per-slide findings, severity (Critical / Major / Minor), and rewrite proposals. Default to `.docx` if the user is going to share the critique; default to `.md` if it's for their own use.

## Defaults the user can override

- **Length.** Default ceiling for an executive deck is **10 slides in the main body** plus an appendix. If the storyline cannot fit in 10, the storyline is wrong, not the budget. Override only on explicit request.
- **One recommendation per deck.** If the user has multiple unrelated decisions to drive, propose splitting into separate decks. A deck that drives two decisions usually drives neither.
- **Decision-required tag visible on every main-body slide.** Top-right corner: `DECISION`, `DISCUSSION`, or `FYI`. This forces honesty about why the slide exists.

## Anti-patterns (catch and refuse)

Surface these to the user and propose the fix. Do not silently produce them.

- **Title-as-label.** "Background", "Overview", "Next Steps", "Risks" — these are section headers in a textbook, not titles on an executive slide.
- **The kitchen-sink slide.** Multiple charts, three callouts, two text blocks. Split it.
- **The "we just wanted to share this" FYI slide.** If it doesn't change a decision, it belongs in the appendix or in an email.
- **Buried recommendation.** Recommendation appears for the first time on slide 8. Move it to slide 1.
- **Objections only in speaker notes.** Pull them onto the slide.
- **Symmetric option tables that hide the recommendation.** When showing options, the recommended option is visually emphasized and called out by name. A neutral comparison table without a recommendation is an abdication.
- **Cliffhanger titles.** "Our path forward" leaves the audience to guess. "Path forward: license, don't build" tells them.
- **Recycled "Executive Summary" slide that summarises everything except the ask.** The exec summary IS the ask.

## Interaction style

- The user is usually senior and time-constrained. Lead every response with the answer or the proposed storyline — practise what the skill preaches.
- If the user provides slide content that fails the three tests, do not produce the failing slide. Surface the failure, propose the fix, and wait for confirmation. Producing the failing slide silently is a disservice.
- When proposing title rewrites, always show *label → conclusion* side by side. The contrast is the lesson.
- When in critique mode, lead with the **deck-level read-through** before slide-by-slide findings. A deck whose titles don't tell the story has problems no slide-level edit can fix.

## Reference files

Read on demand:

- `references/storyline.md` — Pyramid Principle, SCQA, BLUF, "So what?" laddering, appendix discipline, opener/closer construction.
- `references/action-titles.md` — How to write conclusion-titles. Patterns, anti-patterns, length guidance, before/after examples for common slide types.
- `references/objection-handling.md` — Pre-mortem method, objection-on-slide patterns, when a footnote is enough vs. a full counter-argument.
- `references/slide-archetypes.md` — The eight slide types this skill produces, with composition rules for each. Includes Rule of 3, MECE for options, decision-required tagging, data-ink guidance.
- `references/critique-mode.md` — Step-by-step critique procedure, severity rubric, deck-level vs. slide-level findings.

## Templates

- `assets/storyline-template.md` — Blank storyline outline. Always produce one of these first in author mode.
- `assets/critique-report-template.md` — Markdown structure for the critique deliverable.

## Composition with other skills

This skill is content-discipline. It expects:

- **`pptx`** to do file mechanics (creating the `.pptx`, embedding charts, running visual QA via subagent).
- **`montai-pptx`** to apply Montai branding *after* the storyline is locked.

Do not pre-apply branding before the storyline is approved. Re-skinning a deck whose storyline still has gaps wastes effort.
