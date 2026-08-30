# GxP Document Style Guide

Company-agnostic. The header wordmark is a `<Company Name>` placeholder
resolved per project — see SKILL.md.

The authority for how a controlled document looks. `scripts/gxpdoc.py`
implements it and `scripts/check_doc.py` enforces it; rule ids below (`F/7`)
are the ids the linter reports. If code and guide disagree, correct whichever
is wrong — but never hand-format a document to work around either.

---

## A. Identity, numbering and draft handling

Prefixes, per SOP-001 (Document Control) §5.2 and observed practice:

| Prefix | Type | Example |
|---|---|---|
| `QM` | Quality Manual | `QM-001` |
| `POL` | Quality Policy | `POL-001` |
| `SOP` | Standard Operating Procedure | `SOP-003` |
| `WI` | Work Instruction | `WI-001`, `WI-CSA-01` |
| `FRM` | Form / Template | `FRM-005` |
| `LOG` | Log / Register | `LOG-002` |
| `GXP-<TYPE>` | Validation deliverable | `GXP-URS-001`, `GXP-IQ-PROD-001` |
| `SUP-YYYY` | Supplier assessment record | `SUP-2026-001` |
| `CC-YYYY` | Change control record | `CC-2026-014` |
| `TQ` | Tool qualification | `TQ-001` |

Sequence numbers are zero-padded to three digits.

**Version** is `X.Y`: X for a change to process, scope or responsibilities, Y
for editorial correction. The in-document `Version No.` states the version
being sought and **never reads `DRAFT`** (`A/4b`). Writing `DRAFT` there means
somebody must remember to change it just before routing for signature; that
step gets missed. Draft state lives in the filename only (`A/4c`):

```
SOP-014_Deviation_Trending_v1.0_DRAFT1.docx    Version No. cell: 1.0
SOP-014_Deviation_Trending_v1.0_DRAFT2.docx    Version No. cell: 1.0
SOP-014_Deviation_Trending_v1.0.docx           Version No. cell: 1.0
```

Nothing inside the document changes between the last draft and the signature
copy. Register every document on the Document Master List.

---

## B. Page furniture

US Letter, 1" margins, 0.5" header and footer distance (`B/3`).

Header — company wordmark, then a three-column table, both on the section
header so Word repeats them on every page (`B/1`):

```
<Company Name>
╔═══════════════════════════════════════════════════════════════════════════╗
║              STANDARD OPERATING PROCEDURE                                 ║
╠═══════════════╦═══════════════════════════════════════╦═══════════════════╣
║  Document ID  ║        Document Description           ║    Version No.    ║
╠═══════════════╬═══════════════════════════════════════╬═══════════════════╣
║   SOP-014     ║      DEVIATION TRENDING PROCEDURE     ║        1.0        ║
╚═══════════════╩═══════════════════════════════════════╩═══════════════════╝
```

- Widths 1.5" / 4.2" / 1.3". Banner row merged across all three.
- Solid **black** borders, 1.5pt outer and 0.75pt inner. **No shading**; all
  cells white. This is the one table that does not follow component E — the
  header block reads as furniture, not content.
- Every cell centered horizontally and vertically.
- Column labels exactly `Document ID` / `Document Description` /
  `Version No.`
- Banner vocabulary: `QUALITY MANUAL`, `QUALITY POLICY`, `STANDARD OPERATING
  PROCEDURE`, `WORK INSTRUCTION`, `FORM`, `LOG`, `VALIDATION PROTOCOL`,
  `VALIDATION REPORT`.
- Wordmark is 14pt bold text, defaulting to the literal `<Company Name>`
  until `--company` supplies the real one. `GxpDoc(logo_path=...)` swaps in an
  image when one exists.

Footer (`B/2`), 9pt, with **live `PAGE`/`NUMPAGES` fields** — frozen text is
what makes today's documents print `Page  of `:

```
Printed copies are uncontrolled                Page 3 of 12
                                        (centered on the 3.25" tab)
```

No status, no effective date, no generation date in either. All three go
stale the moment the file is copied and then contradict the register.

---

## C. No metadata block

A document carries **no control block, no metadata table, and no title line**.
The repeating page header already states the ID, the description and the
version on every page; restating them in the body means two places to keep in
step, and they will not stay in step (`C/4`).

Everything else that used to sit in that block belongs on
the Document Master List, which is the register and the system of
record: Company, Document Type, Review Cycle, Owner, Approver, Regulatory
Basis, Supersedes, Status, Effective Date.

Owner and Approver are not lost — they are the Approval table (component H),
where they are signed for rather than merely asserted.

The body begins with the contents field, then `1.`

Legacy documents typically open with a `Field | Details` table; several also carry
`Status` and `Date` rows inside it (`C/4a`). `restyle_doc.py` strips the block
and reports any values that need to reach the register.

---

## D. Section skeletons

See [section-skeletons.md](section-skeletons.md). Enforced as `D/5`.

---

## E. Tables

Body tables (`E/6`): header row bold on `#F2F2F2`, `w:tblHeader` set so it
repeats across page breaks; borders 0.75pt outer / 0.5pt inner in `#D9D9D9`;
no body-cell shading; 0.08" cell margins; text left-aligned and top-anchored;
rows set not to split across pages; fillable cells blank at 0.30" minimum
height, signature cells 0.40".

**Anything table-shaped is a table** (`E/6a`). Not a preference — it is what
makes a document reviewable and diff-able. Applies to Responsibilities
(`Role | Responsibilities`), Definitions (`Term | Definition`), Records and
Retention (`Record | Retention Period | Owner`), References, Revision History,
Approval, forms-and-logs lists, numbering conventions
(`Prefix | Type | Example`), risk scoring matrices, and any responsibility
grid. Three or more consecutive `Label: value` paragraphs is a finding.

---

## F. Cross-references

Never a bare identifier (`F/7`). Every mention, every time:

```
per SOP-003 (Change Control)
GXP-RA-001 (System Risk Assessment) §6
FRM-003 (Deviation and CAPA Form)
21 CFR Part 11 (Electronic Records; Electronic Signatures)
```

One form — no first-use/subsequent-use bookkeeping to get wrong. References
to a clause of the current document stay `§5.2 of this procedure`.

---

## G. References

Titled exactly `References` (`G/8`). Always a table. Never a comma-delimited
paragraph:

| Document ID | Title |
|---|---|
| SOP-003 | Change Control Procedure |
| GXP-RA-001 | GxPSign System Risk Assessment |
| 21 CFR Part 11 | Electronic Records; Electronic Signatures |

Past roughly eight rows, split into numbered sub-clauses: *QMS Documents* /
*Validation Documents* / *External Standards and Regulations*. A third
`Applies to` column is allowed where it earns its place.

Bidirectional (`G/9`): every identifier cited in the body appears here, and
every row here is cited somewhere.

---

## H. Approval

Columns exactly `Role | Name | Title | Signature | Date` (`H/10`), rows
ordered Author → Reviewer(s) → Approver, preceded by the standing sentence
about GxPSign qualified electronic signatures.

`Date` is **blank** in the source file. This table is the only place a date
appears in an unsigned document, and the latest date in it is the document's
approved date — nothing else restates it.

---

## I. Revision History

Columns exactly `Version | Date | Author | Description of Change | Change
Control Ref` (`I/11`), **newest first** — the current revision is the one a
reader wants. `1.0` "Initial release" sits at the bottom. The top row's date
is filled at signature, not at drafting.

---

## J. Typography, heading levels and numbering

**Times New Roman throughout. All text black** (`J/6b`). Controlled documents
get printed, scanned and photocopied; gray body text and teal headings survive
none of that. The GxPSign brand palette governs the product UI, not QMS paper.
The only non-white fill in a document is the `#F2F2F2` body-table header row.

```
5.   FORMS AND WORK INSTRUCTIONS                13pt BOLD ALL CAPS
     5.1.  FRM-003 (Deviation and CAPA Form)    11pt regular (body font)

6.   PROCEDURE
     6.1.  <Company Name> reviews deviation data quarterly. The review
           shall cover every deviation closed in the period…
           6.1.1.  The Head of Quality extracts the period's records
                   from LOG-001 (Deviation and CAPA Log)…
                   6.1.1.1.  The trend review shall include:
                             •  Count and rate by process area
```

| Level | Number | Number at | Text at | Size | Weight | Case |
|---|---|---|---|---|---|---|
| 1 | `5.` | 0.00" | 0.30" | 13pt | bold | ALL CAPS |
| 2 | `5.1.` | 0.30" | 0.65" | 11pt | regular | Sentence |
| 3 | `5.1.1.` | 0.65" | 1.10" | 11pt | regular | Sentence |
| 4 | `5.1.1.1.` | 1.10" | 1.65" | 11pt | regular | Sentence |
| bullet | `•` | 1.65" | 1.90" | 11pt | regular | Sentence |
| body | — | 0.30" | — | 11pt | regular | — |

Level 1 is the only visually distinct heading. Levels 2–4 sit in the plain
body font, separated by number and indent alone: they are numbered *clauses*,
not headings, and that is what makes `§6.1.1` a precise citation target.

Rules (`J/6c`):

- Every level carries a trailing period.
- Hanging indent at every level; wrapped lines align to the text column, never
  back to the number.
- **Numbers are literal text, never Word auto-numbering.** Auto-numbering
  renumbers silently on insert and would invalidate every `§5.2` citation in
  every other document. Levels are still real paragraph styles (`GxP L1`–
  `GxP L4`) so structure stays machine-readable and the contents field works.
- Level 1 headings are stored in caps. `References`, `Revision History` and
  `Approval` therefore render as `REFERENCES`, `REVISION HISTORY`, `APPROVAL`.
- No standalone title paragraph (`J/6e`).

Other sizes: wordmark 14pt bold, banner 12pt bold caps, header labels 10pt
regular, header values 10pt bold, table header cell 10pt bold, table body cell
10pt regular, footer 9pt. Line spacing 1.15, 6pt after each clause, 12pt
before a level 1. No underline anywhere — it reads as a hyperlink. Italics
only for standing instruction lines.

**Table of contents** (`J/6d`): level-1 headings with page numbers, before the
control block, as a `TOC \o "1-1" \h` field so it refreshes.

---

## K. Language

`shall` = requirement. `should` = recommendation. `may` = permitted. `will` =
statement of fact. Use them strictly and never interchangeably.

US English. ISO 8601 dates, `YYYY-MM-DD` (`K/13`).

Banned as unenforceable: *appropriate, adequate, periodically, as needed, if
necessary, as required, timely, regularly*. Replace each with something
measurable — "quarterly", "within ten working days", "by the Head of Quality".

One requirement per numbered clause, so each is separately citable and
separately auditable. Expand acronyms on first use.

---

## L. Records and Retention

`Record | Retention Period | Owner`. Reference the master retention list in
SOP-001 (Document Control) §6 rather than restating periods per document —
restating them guarantees they diverge.

---

## M. Drafting hygiene

Placeholders in angle brackets, `<like this>`. No unresolved placeholder or
TBD in a file without a `_DRAFT<N>` suffix (`M/14`). No empty headings
(`M/12`). No DRAFT watermark or banner — unsigned *is* draft.

The status vocabulary DRAFT / IN REVIEW / APPROVED / EFFECTIVE / SUPERSEDED /
RETIRED belongs to the Document Master List only, never inside a document.

---

## N. Governance

SOP-001 (Document Control) should mandate this guide and the `gxp-doc` scripts
for new controlled documents. Without that hook the guide is advisory and the
drift it corrects returns.
****