# GxP Review Report Template

This is the markdown skeleton the skill renders to Word via the `docx` skill at `/mnt/skills/public/docx/SKILL.md`. Substitute placeholders in `{curly braces}` with actual content. Remove the leading instruction comments (lines starting with `<!--`) before rendering — they are author guidance only.

---

# GxP Review — {Document ID} {Version}

**Document Title:** {full document title}
**Reviewer:** {Reviewer name, role}
**Review Date:** {YYYY-MM-DD}
**Review Status:** {Early Draft · Final Review · Post-Approval}
**GxP Discipline:** {GMP · GCP · GLP · GDP · GVP · GAMP/Part 11/Annex 11}
**Reviewer Perspective:** {Quality · Technical · Combined}

---

## 1. Document Metadata

| Field | Value |
|---|---|
| Document ID | {e.g., SOP-10} |
| Title | {full title} |
| Version | {V01, Rev. 02, etc.} |
| Effective / Issue Date | {YYYY-MM-DD or N/A if Draft} |
| Originator / Author | {name(s)} |
| Document Owner | {name / role} |
| Status (per Montai document control) | {In Authoring · Issued · Effective · Retired} |
| Source / Location | {Box link, SharePoint URL, or upload path} |

---

## 2. Review Scope

This review was performed by {Reviewer name} acting in the {Quality · Technical · Combined} reviewer role. The document was at the **{Early Draft · Final Review · Post-Approval}** stage at the time of review. The applicable GxP discipline was **{GMP / GCP / GLP / GDP / GVP / GAMP}**, with the regulatory framework anchored to {FDA / EU / both / ICH-only} expectations.

<!-- Add a sentence on what was specifically in scope and out of scope. Example: "In scope: full document content including all attachments. Out of scope: the underlying validation report referenced in §4.2, which has been reviewed separately under {ID}." -->

---

## 3. Severity Definitions

| Severity | Definition |
|---|---|
| **Critical** | A deficiency that produces, or has a high likelihood of producing, harm to a patient, an unreliable record, or a regulatory non-compliance that could trigger enforcement action. Blocks approval. |
| **Major** | A significant deficiency that does not directly endanger safety or release-quality decisions but could lead to non-compliance, reduce result reliability, or be cited at inspection. |
| **Minor** | A departure from procedure, expectation, or best practice that does not significantly affect quality, safety, or compliance. |
| **Observation** | A recommendation, improvement opportunity, or note with no compliance impact. |

---

## 4. Findings Summary

| Severity | Count |
|---|---|
| Critical | {N} |
| Major | {N} |
| Minor | {N} |
| Observation | {N} |
| **Total** | **{N}** |

**Disposition:** {one of the status-appropriate options — see §6}

---

## 5. Detailed Findings

<!-- Group findings: Critical first, then Major, Minor, Observation. Within each severity, order by document section. -->

### 5.1 Critical Findings

<!-- Repeat this block per finding. Omit the section heading entirely if there are no Critical findings. -->

#### F-01 — {one-line title}

| Field | Value |
|---|---|
| **Finding ID** | F-01 |
| **Severity** | Critical |
| **Location** | §{X.Y}, page {N} |
| **Description** | {What is wrong, in enough detail that the author can act without consulting the reviewer. Include the specific value, section, and what the document should say.} |
| **Reference** | {Specific regulatory citation (e.g., 21 CFR 211.165(e); ICH Q2(R2) §5.5) and/or Montai SOP clause (e.g., SOP-04 §6.3)} |

### 5.2 Major Findings

<!-- Same block structure. Omit the heading if no Majors. -->

### 5.3 Minor Findings

<!-- Same block structure. Omit the heading if no Minors. For document review economy, Minor findings can also be presented as a single table with columns: ID / Section / Issue / Reference. Use the table form when there are more than 3-4 Minors and they are simple. -->

### 5.4 Observations

<!-- Same as Minor. -->

---

## 6. Disposition / Recommendation

**{Pick exactly one and use the language verbatim:}**

<!-- Early Draft -->
- Continue authoring with revisions
- Substantive rework required
- Restructure (template / approach mismatch)

<!-- Final Review -->
- Approve as written
- Approve with editorial revisions
- Conditional approval pending Major resolution
- HOLD — do not approve
- Reject

<!-- Post-Approval -->
- No action required
- Initiate change control to address findings
- CAPA required (per SOP-04)
- Supersede / revise document
- Withdraw document

**Rationale:** {one short paragraph linking the disposition to the findings — e.g., "One unresolved Critical (F-01) precludes approval. The document should not be signed until the acceptance criteria in §4.2 are corrected to match the registered specification SPE-XXXXX rev YY."}

---

## 7. Author / Owner Query Table

<!-- Include this section ONLY if there are Major or Critical findings. Each row is a clear, actionable question the author can respond to. -->

| Finding ID | Question for Author / Document Owner |
|---|---|
| F-01 | {Question, e.g., "Please confirm the acceptance limit in §4.2 — it currently states 0.5% NMT but the registered specification SPE-XXXXX rev YY allows 0.15% NMT. Which value applies?"} |
| F-02 | {Question} |

---

## 8. References Cited

### Regulatory

<!-- List every regulatory citation used in the findings, in the order: FDA → EU → ICH → USP → other -->
- 21 CFR 211.165(e) — Testing and release for distribution
- ICH Q2(R2) §5.5 — Accuracy
- {etc.}

### Internal (Montai)

<!-- List every Montai POL/SOP/FRM cited, with Box link -->
- POL-01 Quality Policy V01 — https://montai.app.box.com/file/1991201452779
- SOP-04 CAPA Management V01 §6.3 (Effectiveness Check) — https://montai.app.box.com/file/2043859698123
- {etc.}

### Other

<!-- Any other reference materials cited (vendor SOPs, published methods, etc.) -->

---

## 9. Reviewer Sign-off

| Field | Value |
|---|---|
| Reviewer | {Name} |
| Role | {Quality · Technical · Combined} |
| Signature | _____________________ |
| Date | _____________________ |

<!-- For Final Review of a controlled document where Quality and Technical reviews are required to be independent, the report should also include a separate sign-off line for the second reviewer, OR an explicit note that this combined review does not satisfy the SOP-XX independence requirement. -->

---

## Styling conventions for Word output

Apply these when rendering via the `docx` skill so the report matches Montai corporate style.

**Typography**
- Font: Arial throughout
- Body text: 11pt
- Table text: 10–11pt
- Headings: Arial, bold, Montai navy (`#1F3864`)

**Tables**
- Borders: thin gray (`#999999`)
- Header row: navy fill (`#1F3864`) with white text

**Severity badges** (apply as cell fills wherever a severity appears — summary table, finding mini-tables, etc.)

| Severity | Fill | Text |
|---|---|---|
| Critical | `#FFC7CE` | `#C00000` |
| Major | `#FFF2CC` | `#BF8F00` |
| Minor | `#D9E2F3` | `#1F3864` |
| Observation | `#E2EFDA` | `#385723` |

**Page setup**
- Page size: US Letter
- Margins: 1 inch all sides
- Page numbers: footer, right-aligned, "Page X of Y"
