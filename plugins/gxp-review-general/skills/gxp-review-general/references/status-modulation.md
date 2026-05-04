# Document Status Modulation

How the review changes when a document is in **Early Draft**, **Final Review** (pre-approval / pre-signature), or **Post-Approval** (retrospective / audit-style).

The severity rubric (C/M/m/O) does not change. What changes is:
- Which findings are in scope
- How aggressively to flag formatting and editorial issues
- How the disposition is phrased
- What follow-up actions are appropriate

---

## 1. Early Draft

The author is still working on the document. The reviewer's job is to **help the document get to Final Review with the right shape and content** — not to nitpick.

### Scope at Early Draft

✅ In scope:
- Structural completeness — required sections present
- Conformance to the controlled template (if one exists)
- Scientific / regulatory framing — is the document approaching its purpose correctly?
- Major content gaps
- Critical scientific or compliance flaws (these always matter)
- Cross-reference coherence (do referenced documents exist or are they correctly anticipated?)
- Risk and feasibility of the approach

❌ De-prioritized:
- Editorial polish (typos, grammar, formatting consistency) — these should be flagged broadly ("editorial pass needed before Final Review") rather than catalogued
- Signature blocks, version control metadata, effective dates (the document isn't trying to be controlled yet)
- Tracked changes (drafts are expected to have them)

### Severity bias at Early Draft

- **Critical** — reserve for fundamental flaws: wrong scientific approach, regulatory non-starter, patient-safety problem in the proposed design
- **Major** — bulk of substantive findings land here: missing required sections, methodology concerns, gap with regulation
- **Minor** — content-level departures from expectation; editorial issues are typically rolled up into a single "editorial pass" Observation
- **Observation** — recommendations and improvement ideas; the author has latitude to accept or reject

### Disposition options at Early Draft

| Disposition | When to use |
|---|---|
| **Continue authoring with revisions** | Minor / Observation only; or a small number of Majors that are easy to address |
| **Substantive rework required** | Multiple Majors or one Critical; the document needs another round before Final Review is realistic |
| **Restructure (template / approach mismatch)** | The document is not using the right template, or the chosen approach won't get it to compliance |

### Tone at Early Draft

Constructive and forward-looking. Findings can include "Suggested revision:" snippets where helpful. The author is still your collaborator at this stage; the document will improve faster if the review is specific about what's needed.

---

## 2. Final Review (pre-approval / pre-signature)

The document is intended for approval. The reviewer's job is to **decide whether it can be signed** and, if not, what specifically must change.

### Scope at Final Review

Everything in the standard Step 5 review applies, with these emphasis points:

✅ In scope:
- All approval / signature integrity checks
- All tracked changes and reviewer comments resolved
- Full regulatory conformance check
- Full Montai SOP / Policy alignment check
- Internal consistency at the value level (numbers match across sections)
- Specification traceability to current registered specs
- Data integrity / ALCOA+ for any record-capturing capability
- Editorial quality (typos / formatting are now in scope; they shouldn't survive into a controlled document)

### Severity bias at Final Review

The full C/M/m/O range applies. Be deliberate and precise — **the disposition follows automatically from the findings**.

### Disposition options at Final Review

| Disposition | Triggering condition |
|---|---|
| **Approve as written** | No findings worse than Observation |
| **Approve with editorial revisions** | Only Minor / Observation; author/owner accepts a "fix-and-issue" pathway |
| **Conditional approval pending Major resolution** | One or more Major findings with a clear, agreed remediation path; appropriate when the underlying decisions are sound but discrete fixes are needed |
| **HOLD — do not approve** | Any unresolved Critical, OR multiple unresolved Majors, OR a Major that affects the scientific or regulatory premise of the document |
| **Reject** | Fundamental methodology / approach failure; the document needs to be re-authored, not revised |

### Tone at Final Review

Direct, neutral, regulatory. This review may be cited in an inspection — write it accordingly. No advocacy, no hedging. Findings state facts; the disposition states the decision.

### Author / Owner query table

When Final Review yields Major or Critical findings, include an Author/Owner query table at the back of the report. Each row is a clear question the author can respond to without re-reading the full review. This dramatically shortens the back-and-forth cycle.

---

## 3. Post-Approval (retrospective / audit-style)

The document is already in effect. The reviewer's job is to **identify gaps that may require change control, CAPA, or document revision** — and to do so with the awareness that any finding here may have inspection consequences.

### Scope at Post-Approval

✅ In scope:
- Currency: does the document still reflect current science, current regulation, current Montai practice?
- Operational evidence: are records generated under this document consistent with what the document instructs? (When records are available for cross-checking, do.)
- Regulatory drift: have ICH / FDA / EU requirements changed since the document was approved?
- Data integrity: are records generated under this document ALCOA+ compliant?
- Deviation / CAPA history: are recurring deviations against this document indicating a procedural gap?
- Cross-reference integrity: do all referenced documents still exist at their cited versions?
- Periodic-review status (per Montai's document-control SOP): is this document overdue?

### Severity bias at Post-Approval

Critical findings here are weightier than at Final Review — they typically trigger **immediate change control / quarantine / batch-disposition review**. Write them with that in mind:

- **Critical** — the document is unfit for use right now; suspend / supersede / quarantine as appropriate
- **Major** — change control needed to address; document remains in use pending revision
- **Minor** — incorporate at next periodic review
- **Observation** — note for awareness; no required action

### Disposition options at Post-Approval

| Disposition | When to use |
|---|---|
| **No action required** | No findings worse than Observation; document still fit for use; periodic-review-style sign-off |
| **Initiate change control to address findings** | Major findings that need a controlled revision; the document remains usable in the interim |
| **CAPA required (per SOP-04)** | Findings indicate a systemic gap that produced or could produce repeated deviations; CAPA initiation is the correct vehicle |
| **Supersede / revise document** | Multiple Majors or a Critical; the right vehicle is a new revision, not a CAPA-driven patch |
| **Withdraw document** | The document is fundamentally unsuitable; it should be retired and replaced by a fresh authoring cycle |

### Tone at Post-Approval

Audit-style. Past tense for what was reviewed; present tense for current state. Avoid implying blame on the original approvers — the reviewer's job is to identify the gap and the fix, not to assign fault. If a finding has inspection-readiness implications, say so explicitly: "This gap is likely to be cited in an inspection of the {process / lab / clinical site}."

### Linkage to Montai's quality systems at Post-Approval

- For findings that warrant CAPA → reference SOP-04 explicitly in the disposition and offer a CAPA initiation memo as a follow-up deliverable
- For findings that warrant change control → reference the controlling change-control SOP and offer a change-control initiation memo
- For findings that affect a vendor's controlled document → reference SOP-03 (Vendor Management); the vendor's QA is the action owner, not Montai's

---

## 4. Cross-status principles

- The same finding does not always carry the same severity across statuses. A blank signature block is Critical at Final Review, irrelevant at Early Draft, and Major at Post-Approval (the document was approved unsigned, which is a control breakdown).
- A reviewer should always state the status in the report's Review Scope so a downstream reader knows which lens was applied.
- If the document arrives mid-status (e.g., "Final Review — but I'm planning to push back on the author") and the reviewer believes the document should not even be at Final Review, that's a finding in itself: "The document is being put forward for Final Review prematurely; recommend returning to Early Draft."
