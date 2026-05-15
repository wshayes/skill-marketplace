# Critique Mode

Read this when reviewing an existing deck rather than authoring one. The procedure is deliberately top-down: deck-level read-through first, slide-level second. Slide-level fixes on a broken storyline are wasted effort.

## When to use critique mode

- "Review my deck before I send it to the SteerCo."
- "Is this CEO-ready?"
- "Tighten this for me."
- "What's wrong with this?"
- Any case where the user already has a `.pptx` and is asking for an opinion before they ship.

## Procedure

### Step 1 — Extract titles only

Read the titles in order, with nothing else visible. The `pptx` skill's `extract-text` tool gives you this directly.

Ask:
- Do the titles, read in order, form a complete argument?
- Is there a recommendation? Does it appear in the first one to three slides?
- Can a stranger reading only the titles summarise the deck's ask in one sentence?

If the answer to any of these is no, that is the **headline finding**. Lead the critique report with it. No slide-level edit fixes a deck whose titles don't tell the story.

### Step 2 — Score each slide against the three tests

For every slide, mark:

| Test | Pass / Fail | Note |
|---|---|---|
| Title is a conclusion, not a label | | |
| Slide lands one idea, not one topic | | |
| Hardest objection is answered on-slide (if recommendation-bearing) | | |

A slide passes only if all three apply. (Objection test is N/A for evidence slides that don't carry recommendations.)

### Step 3 — Assign severity

- **Critical** — Slide actively undermines the deck. Examples: recommendation buried past slide 5; option-comparison table with no recommendation; data slide that disproves the title above it; missing the ask; no decision-required tagging on a DECISION deck.
- **Major** — Slide fails one or more tests in a way the audience will notice. Examples: label-style title on a high-stakes slide; objection ignored; two ideas on one slide; "so-what" missing from an evidence slide.
- **Minor** — Slide passes the tests but could be sharper. Examples: title is conclusion but wordy; chart is correct but cluttered; trade-off implicit not explicit.
- **Observation** — Style or polish notes that don't change the decision-quality of the deck.

Use the same Critical / Major / Minor / Observation scale the user already uses in GxP reviews — the vocabulary travels.

### Step 4 — Write the critique report

Use `assets/critique-report-template.md`. The structure is:

1. **Headline finding** — one sentence on the deck-level read-through.
2. **Deck-level recommendation** — keep, sharpen, restructure, or rebuild.
3. **Per-slide findings** — table with slide number, severity, finding, proposed fix.
4. **Proposed rewrites** — for the top 3–5 slides that need title or objection work, show *current → proposed* side by side.
5. **Storyline gap analysis** — if the horizontal logic is broken, sketch the storyline as it should be (action-title outline).

### Step 5 — Offer to redraft, don't redraft silently

End the critique with an offer: "Want me to redraft the top three slides?" or "Want me to reorder the storyline?" The user decides what to fix; the critique does not pre-empt that decision.

## Deck-level diagnostic patterns

Common failure modes and how to name them in the critique:

### Pattern A — Inverted pyramid

Symptom: Background and analysis slides 1–5; recommendation appears on slide 6 or later.
Diagnosis: Inverted pyramid. The audience disengages before the recommendation.
Fix: Move the recommendation to slide 1. Re-cast the analysis as evidence supporting it.

### Pattern B — Two competing recommendations

Symptom: Slide 1 recommends X. Slide 7 recommends Y. The deck never reconciles them.
Diagnosis: Deck is two decks fighting for the same meeting.
Fix: Pick one recommendation. Make the other a fallback option *inside* the first, or split into two decks.

### Pattern C — Decoration density

Symptom: Every slide has multiple charts, layered callouts, dense bullets. No single takeaway per slide.
Diagnosis: Information-dump deck. One-idea-per-slide test fails on >50% of slides.
Fix: Split slides aggressively. Move detail to appendix. Each main-body slide carries one chart or one table, not three.

### Pattern D — Missing ask

Symptom: Deck ends with "Thank you" or "Next Steps" with no specific decision requested.
Diagnosis: The author has not committed to what they're asking for.
Fix: Add an Asks & Decisions slide. State who approves what by when.

### Pattern E — Objection-free zone

Symptom: Every slide is upside. No counter-arguments, trade-offs, or pre-empted objections anywhere.
Diagnosis: The author has not pre-mortemed the deck. Audience will surface objections at the worst possible moment.
Fix: For each recommendation-bearing slide, name the top objection and add an on-slide treatment per `objection-handling.md`.

### Pattern F — Symmetric options table

Symptom: Options comparison slide with a neutral pros/cons table and no recommendation.
Diagnosis: The author is deferring the decision to the audience. This reads as either preparation gap or political avoidance.
Fix: Name a recommendation. Emphasise the recommended option visually. Add a one-line "We recommend X because Y" below the table.

### Pattern G — RAG fog

Symptom: Status slide with traffic-light cells, no annotation, everything green.
Diagnosis: Performative status reporting. Audience cannot tell what actually needs attention.
Fix: Sort by status. Surface the one item that needs leadership help. Drop the green-on-green-on-green cells or make them passive.

## How to deliver hard findings

The critique itself is an executive communication. Apply the same discipline:

- **Lead with the finding, not the methodology.** "The recommendation is buried — move it to slide 1" comes first. The three-test rubric explanation comes second, if at all.
- **Quantify where possible.** "12 of 18 slides have label-style titles" beats "many slides have weak titles."
- **Show, don't tell, on rewrites.** A proposed title rewrite next to the original teaches more than three paragraphs of theory.
- **End with the smallest fix that produces the biggest gain.** Often this is rewriting slides 1, 2, and the closer. Say so.

Authors who get critique well-delivered take it. Authors who get critique buried in process notes shrug it off. The form matters.
