---
name: gxp-doc
description: >
  Write, review, or restyle a GxP controlled document — SOP,
  Policy, Work Instruction, Form, Log, Quality Manual, or a GXP-* validation
  protocol/report. Use when asked to draft a new SOP or policy, revise a
  controlled document, add a References or Approval section, fix document
  headers or numbering, check a document against the QMS style guide, or
  convert existing QMS paperwork to house style. Do NOT use for product
  documentation, README/CHANGELOG files, or docs/ engineering notes — those
  are not controlled documents.
---

# GxP controlled documents

## Company name — resolve this first

The page header carries a company wordmark. It defaults to the literal
placeholder `<Company Name>`, which `check_doc.py` reports as a warning in a
draft and an **error** in any file without a `_DRAFT<N>` suffix — so it cannot
reach a signature copy unnoticed.

Before generating or restyling anything:

1. Read the company name from memory (a `project` memory naming the QMS
   company for the repository you are working in).
2. If it is not there, **ask the user** — do not guess it from a directory
   name, a git remote, or an existing document.
3. Save the answer to memory so the next session does not ask again.

Then pass it: `--company "Acme Pharma"`. `restyle_doc.py` falls back to the
`Company` row of a legacy document's own metadata block when `--company` is
omitted.

House style lives in [references/style-guide.md](references/style-guide.md);
section order per document type is in
[references/section-skeletons.md](references/section-skeletons.md). Never hand-
format a document: the scripts below are the only sanctioned path, because
they are the only way the page header, live page-number fields, table shading
and clause indents come out identical across every document.

| Task | Command |
|---|---|
| New document | `new_doc.py --type sop --id SOP-014 --title "..." --company "..."` |
| Check one | `check_doc.py <file.docx>` |
| Bring an old one onto house style | `restyle_doc.py <file.docx> -o build/qms-restyled` |
| See a worked example | `example_sop.py --company "..."` |
| Build something custom | `import gxpdoc` and use `GxpDoc` |

All scripts run under `uv run --with python-docx --with openpyxl python
~/.claude/skills/gxp-doc/scripts/<script>` — `python-docx` is deliberately not
installed into any project; this is QMS tooling, not application code.

`restyle_doc.py --master-list` points at the project's Document Master List
xlsx (used to resolve References titles); it defaults to
`docs_qms/Document_Master_List.xlsx` relative to the working directory.

## Rules you will get wrong if you skip the guide

- **No metadata block, no title line.** The repeating page header carries the
  ID, description and version on every page; the body starts with the contents
  field, then `1.` Company, Owner, Approver, Review Cycle, Regulatory Basis,
  Supersedes, Status and Effective Date all live on the Document Master List.
- **No date and no status anywhere in a document.** A document is a draft
  because it is unsigned. Its approved date is the last signature date in the
  Approval table.
- **The version field never reads `DRAFT`** — it carries the next real number
  from the first keystroke. Draft state lives in the filename:
  `SOP-014_Change_Control_v2.0_DRAFT3.docx`. Renaming away `_DRAFT3` must
  require no edit inside the document.
- **Every document identifier in prose is followed by a name.** `SOP-003
  (Change Control)`, never a bare `SOP-003`.
- **References is a table, always, and is titled exactly `References`.** Never
  a comma-delimited paragraph.
- **Revision History is newest-first.**
- **Table-shaped data is a table** — a repeating set of fields is never a
  bullet list.
- Times New Roman throughout, all text black, US Letter, US English,
  ISO 8601 dates.

## Writing one

```
uv run --with python-docx python ~/.claude/skills/gxp-doc/scripts/new_doc.py \
    --type sop --id SOP-014 --title "Deviation Trending Procedure" \
    --company "Acme Pharma" --approver "A. Approver" -o build/
```

That writes a `_DRAFT1` scaffold that already lints clean. Fill in the clauses
with `GxpDoc.clause()` levels or by editing in Word, then re-run `check_doc.py`
before circulating. Register the document on the Document Master List — the scaffold does not do
this for you.

## Reviewing one

`check_doc.py` reports findings keyed to the style-guide components (`F/7` is
component F, rule 7). Errors exit non-zero; warnings are advisory. Run it over
a directory before any approval round:

```
uv run --with python-docx --with openpyxl python \
    ~/.claude/skills/gxp-doc/scripts/check_doc.py docs_qms/*.docx
```

## Restyling existing documents

`restyle_doc.py` re-emits a document's content through `gxpdoc`, so a
retrofitted file and a new one cannot drift apart. It writes candidates to
`--outdir` and a per-file gap report to `--report`.

**It never writes to the source.** Restyling an approved document is a
revision under the QMS's own document-control and change-control procedures:
it needs a version bump, a Revision History row, and re-approval. Promoting
output over the originals is the document owner's decision, never yours.

Watch for QMS directories that are symlinks into a synced Drive folder — the
gxpsign project's `docs_qms/`, `docs_qms_final/`, `docs_validation/` and
`docs_gxp_customer/` all are. Writing there edits the live signed records.
Always send output to a separate `--outdir`.

Inline bold/italic and images are not carried across — the gap report says so
per file, and the output must be read against the original before promotion.
