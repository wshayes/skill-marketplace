# Section skeletons per document type

Level-1 sections, in order. Rendered ALL CAPS (component J). Enforced as
`D/5`. Machine-readable equivalents live in `scripts/skeletons.py`.

## SOP and Policy

```
1.  PURPOSE
2.  SCOPE
3.  DEFINITIONS              Term | Definition
4.  RESPONSIBILITIES         Role | Responsibilities
5.  PROCEDURE                (Policy: POLICY STATEMENTS)
6.  RECORDS AND RETENTION    Record | Retention Period | Owner
7.  REFERENCES               Document ID | Title
8.  REVISION HISTORY         Version | Date | Author | Description of Change | Change Control Ref
9.  APPROVAL                 Role | Name | Title | Signature | Date
```

Topic-specific sections insert **after** Procedure and renumber the tail —
SOP-005 (Deviations and CAPA) adds "Trending and Review" and "Forms and Logs";
SOP-012 (BCP, Backup and Restore) adds "Restore Procedure" and "Testing".
Purpose through Procedure and the References/Revision History/Approval tail
never move.

References sits late rather than at §2 deliberately: it appends to the
existing thirteen SOPs without renumbering §5.x, so citations other documents
already make stay valid.

## Work Instruction

```
1.  PURPOSE
2.  SCOPE
3.  PREREQUISITES
4.  STEPS
5.  RECORDS
6.  REFERENCES
7.  REVISION HISTORY
8.  APPROVAL
```

## Form

```
1.  INSTRUCTIONS       italic standing line; what to complete and where to route
2.  IDENTIFICATION     Field | Entry, fillable
3.  ASSESSMENT         Criterion | Finding | Evidence
…   (further numbered sections as the form needs)
n.  APPROVAL
    APPENDIX A — SOURCES REVIEWED   (optional)
```

Numbered `1.`, never `Section 1 —`. FRM-001 through FRM-004 and FRM-008 use
the old form today; FRM-007 already uses the correct one.

## Log / Register

```
1.  INSTRUCTIONS
2.  LOG               Ref | Date | Description | Owner | Status
3.  KEY               Code | Meaning
4.  SUMMARY METRICS   (optional, updated at each Periodic Review)
```

## Validation document (`GXP-*`)

```
    REVISION HISTORY
    APPROVAL
1.  PURPOSE
2.  REFERENCES
3.  SCOPE
4.  PREREQUISITES
…
n.  ACCEPTANCE CRITERIA
```

Revision History and Approval stay **front-loaded** here, and References sits
at §2. This is deliberate and is the one skeleton that departs from the SOP
order: a protocol is signed before it is executed, so the signature block
belongs where a reader meets it first. The linter checks presence but not
order for these.

## Record instance of a form

A completed instance of a form — `SUP-2026-001` is an instance of FRM-007
(Supplier Assessment Form) — follows the form's own section order, with two
differences:

- The page header carries the **form's** ID and version; the control block
  Title carries the **record's** ID and subject.
- The control block adds `Form used` and `Parent procedure` rows.

## Quality Manual

```
1.  PURPOSE AND SCOPE
2.  COMPANY OVERVIEW
3.  QUALITY POLICY
4.  REGULATORY FRAMEWORK
5.  QMS STRUCTURE
6.  ORGANISATIONAL RESPONSIBILITIES
7.  KEY QMS PROCESSES
8.  MANAGEMENT REVIEW
9.  CONTINUOUS IMPROVEMENT
10. REFERENCES
11. REVISION HISTORY
12. APPROVAL
```
