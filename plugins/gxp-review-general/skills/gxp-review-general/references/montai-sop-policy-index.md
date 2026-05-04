# Montai SOP / Policy / Form Index

This is the **on-demand index** of currently published Montai controlled documents in Box folder `330567208254` (the GxP Quality Document Library). When a finding requires checking against a Montai SOP or Policy, fetch the specific document from Box using its file ID — do **not** bulk-fetch all of them at the start of a review.

**Box folder URL**: https://montai.app.box.com/folder/330567208254
**Box folder ID**: `330567208254`

If the user references a Montai POL/SOP/FRM not listed here, search the folder via `Box:list_folder_content_by_folder_id` to confirm whether it exists, and tell the user if it does not — that may itself be a finding (referencing an uncontrolled procedure).

---

## How to fetch on demand

When a finding requires the SOP content:

```
Box:get_file_content(file_id="<id-from-table-below>")
```

For PDFs, prefer `Box:get_file_preview` first to confirm the version, then `get_file_content` for text extraction.

Always cite the specific clause/section, not just the SOP number. Example: "SOP-04 §6.3 (Effectiveness Check)" — not just "SOP-04".

---

## Currently published (as of folder snapshot)

### Policies

| Doc ID | Title | Box file ID | When this applies in a review |
|---|---|---|---|
| **POL-01** | Quality Policy V01 (5Sep2025) | `1991201452779` | Always available as the top-level framing for any Quality finding. Cite when the finding implicates the firm's overarching commitment to quality, regulatory compliance, or patient safety. Use sparingly — POL-01 is principle-level and most findings cite a downstream SOP. |

### SOPs

| Doc ID | Title | Box file ID | When this applies in a review |
|---|---|---|---|
| **SOP-02** | GxP Training V01 (5Sep25) | `1991199907027` | Whenever the document under review describes an activity requiring trained personnel, or introduces a new procedure that needs training. Findings: missing training requirement, missing training-record reference, document instructs an action not in the training matrix. |
| **SOP-03** | GxP Vendor Management V01 (5Sep25) | `1991191372547` | Whenever the document is from, references, or relies on an outsourced vendor (CMO, CRO, contract testing lab, IT vendor with GxP impact). Findings: vendor not qualified per SOP-03, vendor qualification expired or pending, missing pre-audit (FRM-03-01), QTA gap. |
| **SOP-04** | Corrective Action Preventive Action Management V01 (25Nov25) | `2043859698123` | For any document/record where a deviation, OOS, complaint, audit finding, or trend should have triggered CAPA. Use as the disposition reference for Post-Approval reviews where "CAPA required" is the disposition. Cite SOP-04 specific clauses for root cause analysis adequacy, effectiveness check, etc. |
| **SOP-05** | GxP Box System V01 (21Nov25) | `2030505595062` (with signing log: `2043869910687`) | Whenever the record under review is generated, stored, signed, or controlled in Box. Findings: improper folder placement, access controls inadequate, signature workflow not used, retention not configured, audit trail not enabled. This is Montai's primary 21 CFR Part 11 / EU Annex 11 implementation document for Box. |
| **SOP-06** | Batch Release V01 (31Mar26) | `2178270400144` (with signing log: `2178297678156`) | For any document or record involved in batch disposition (CoA, BPR review, release authorization, deviation impact assessment, batch record). Findings: release decision authority unclear, FRM-06-01 not used or not complete, release without resolved deviations. |

### Forms / Templates

| Doc ID | Title | Box file ID | When this applies in a review |
|---|---|---|---|
| **FRM-02-01** | GxP Training Form V01 (5Sep25) | `2007885124720` | Required record for documenting personnel training under SOP-02. Findings: completed training records that don't use FRM-02-01, missing fields on the form. |
| **FRM-02-02** | Record of Signature V01 (5Sep25) | `1983869598036` | The controlled register of personnel signatures and initials. Findings: a record uses a signature/initial not in FRM-02-02. |
| **FRM-03-01** | Pre-audit Questionnaire Template V01 (3Sep25) | `1983855208719` | Required for vendor qualification audits per SOP-03. Findings: a vendor was qualified without an FRM-03-01 on file. |
| **FRM-05-01** | Box User Access Request | `2098085159363` | Required for granting access to GxP folders in Box per SOP-05. Findings: access granted without a completed FRM-05-01; access not periodically reviewed. |
| **FRM-06-01** | Batch Release Authorization V01 (31Mar26) | `2178298242507` | Required output of the SOP-06 batch release process. Findings: a batch released without FRM-06-01; FRM-06-01 incomplete; released-by signature not from an authorized signatory. |

---

## What is NOT in this folder (anticipated gaps)

The folder snapshot includes SOP-02 through SOP-06. Other SOPs that may be cited or referenced (and are either pending publication or live elsewhere):

- **SOP-01** — Document Control / SOP on SOPs (controls how SOPs are authored, reviewed, approved, periodically reviewed, and retired). If a finding requires SOP-01 (e.g., periodic-review interval, document numbering convention), state that the controlling SOP-01 should be consulted and ask the user for its location if needed.
- **SOP-07** — Not in this folder snapshot; ask the user if needed.
- **SOP-08** (Controlled Memos) and **SOP-09** (Medical Writing) — drafted (per project history) but not yet in this folder. If a finding references them, treat as pending publication and note that.
- **FRM-08-01** — drafted alongside SOP-08; same status.

If a review needs an SOP that doesn't exist or isn't current in this folder, the absence itself may be a finding ("Activity X is not currently governed by a controlled SOP at Montai") — typically Major.

---

## Citation style for Montai SOPs in findings

In the findings table:

- **Reference column** entry: `Montai SOP-04 §6.3 (Effectiveness Check)`
- **Combined with regulatory citation**: `ICH Q10 §3.2.2; Montai SOP-04 §6.3` — both, not either/or, when both apply
- **Box link** in the report's References section: `https://montai.app.box.com/file/<file_id>` to make the citation auditable

---

## Re-fetching the folder index

This index reflects the folder state at the time the skill was last updated. Folder contents change (new SOPs published, versions revised). If a review depends on a recent SOP, run a fresh listing:

```
Box:list_folder_content_by_folder_id(folder_id="330567208254", limit=100)
```

and update the citations accordingly.
