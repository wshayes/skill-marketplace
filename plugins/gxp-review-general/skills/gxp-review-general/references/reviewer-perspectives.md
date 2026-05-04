# Reviewer Perspectives — Quality, Technical, Combined

This file is loaded after Step 1's intake establishes the reviewer role. It defines what each role is responsible for catching and what each role can de-prioritize. Findings are still graded by severity (C/M/m/O) — the perspective changes which findings the reviewer is **expected to catch**, not how they are graded.

---

## 1. Quality Reviewer (QA / QC / Compliance)

The Quality reviewer asks: **"Is this document compliant, complete, traceable, and inspector-ready?"** They are not the SME — they should not be re-deriving calculations or second-guessing the science. They are the system-conformance and regulatory-alignment checker.

### Quality reviewer focus areas

1. **Document control & metadata**
   - Document number, version, effective/issue date present and consistent with the controlled register
   - Header/footer carries the controlled metadata on every page
   - Revision history populated and traceable to change controls (where applicable)
   - Cover-page approvers match the matrix in the controlling SOP

2. **Approval / signature integrity**
   - All required signatures present (or appropriately absent for the document status)
   - Signature dates not prior to authoring dates
   - Electronic signatures meet 21 CFR 11.50 / EU Annex 11 §14 (printed name, date/time, meaning)
   - No "approved" record contains unresolved tracked changes or open comments

3. **Regulatory alignment**
   - Does the document meet the applicable ICH / FDA / EU / USP / OECD / PIC/S requirement set for the GxP discipline?
   - Are guidance citations current (no superseded versions like ICH Q2(R1) where Q2(R2) now applies)?
   - Where local regulation differs (e.g., FDA vs. EU expectations on QP release), is the document explicit about which regime applies?

4. **Internal SOP / Policy alignment**
   - Does the document comply with Montai's Quality Policy and applicable SOPs?
   - Where the document instructs an action governed by a Montai SOP (training, batch release, vendor management, CAPA, document-control system), does it reference the SOP and follow its requirements?
   - See `montai-sop-policy-index.md` for the active Montai POL/SOP/FRM list

5. **Data integrity (ALCOA+)**
   - Records support Attributable, Legible, Contemporaneous, Original, Accurate, plus Complete, Consistent, Enduring, Available
   - Electronic data: audit trail enabled; user access controlled; periodic review evidence
   - Paper data: pen color, error-correction style, signature/date adjacency, retention plan

6. **Traceability & cross-document linkage**
   - Specifications referenced are the current registered version
   - Cross-references to other controlled documents resolve and point to the right version
   - Where the document is downstream of an IND / IMPD / CMC dossier section, alignment is preserved

7. **Training & qualification linkage**
   - Where the document instructs an activity, are trained personnel evidence requirements clear?
   - For new SOPs, is there a training plan / FRM-02-01 expectation?

8. **Change control & deviation linkage**
   - Was this document issued through a change control? Is the change reference cited?
   - Are known related deviations or CAPAs cross-referenced where they affect the procedure?

9. **Vendor / outsourcing alignment**
   - Where a vendor performs the activity, is the QTA in place and current?
   - Vendor qualification status (per SOP-03) referenced where required

### What the Quality reviewer typically does NOT focus on

- Re-deriving scientific calculations (Technical reviewer's job)
- Judging methodology selection (e.g., HPLC vs. UPLC) — only confirms it's qualified and appropriate per regulation
- Suggesting alternative approaches — Quality flags non-compliance, not preference

### Common findings the Quality reviewer catches

| Pattern | Typical severity |
|---|---|
| Missing / blank approval signature on a Final-Review document | Critical |
| Effective date precedes approval date | Critical or Major |
| Unresolved tracked changes at Final Review | Major |
| Reference to superseded ICH guidance | Minor or Observation |
| Spec reference to a non-current SPE version | Major or Critical |
| Audit trail not enabled / not validated for an electronic record | Critical |
| Missing revision history detail | Minor |
| Document does not reference applicable Montai SOP | Major |
| Training requirement not stated for a new procedural document | Major |

---

## 2. Technical Reviewer (SME)

The Technical reviewer asks: **"Is the science / engineering / methodology sound, fit for purpose, and reproducible?"** They go deep on the content of the document. They assume the Quality reviewer is handling control-system conformance.

### Technical reviewer focus areas

1. **Scientific / engineering accuracy**
   - Are the principles, mechanisms, and assumptions correct?
   - Are calculations reproducible from the inputs given?
   - Are units, significant figures, and unit conversions correct?
   - Are equipment specifications appropriate for the stated tolerance?

2. **Methodology fitness for purpose**
   - Does the method / procedure / protocol actually achieve the stated objective?
   - Are the controls (positive / negative / blanks / standards / placebos) adequate?
   - Is the sensitivity / dynamic range / precision suited to the use case?

3. **Validation / qualification design**
   - Are validation parameters (specificity, accuracy, precision, linearity, range, robustness, LOD/LOQ) appropriately defined?
   - Are acceptance criteria scientifically defensible (not arbitrary)?
   - Sample sizes / replicate counts / statistical treatment appropriate?

4. **Risk and failure modes**
   - What could go wrong with this procedure as written? Are mitigations stated?
   - For BPRs / MBRs: are critical process parameters identified with appropriate ranges?
   - For protocols: are the stop / hold / abort conditions defined?

5. **Reagent / material fitness**
   - Reagents at the right grade (analytical, ACS, HPLC, USP)?
   - Reference standards traceable and within their qualification window?
   - Container/closure compatible with the formulation?

6. **Calculations and statistical treatment**
   - Formulas dimensionally consistent
   - Rounding / reporting conventions stated and appropriate
   - Where statistical analysis is used, is the model appropriate (e.g., ANOVA assumptions met)?
   - For estimands (clinical): are estimand attributes defined per ICH E9(R1)?

7. **Cross-document scientific consistency**
   - Method body matches qualification report values
   - Stability protocol matches the registered stability plan
   - BPR matches the registered process

8. **Reproducibility**
   - Could a competent operator at another site execute this from the document alone?
   - Are decision points / branching steps unambiguous?
   - Is operator-facing language clear (especially in translated docs — Pharmaron Tianjin English/Chinese; Aptuit Italian/English)?

### What the Technical reviewer typically does NOT focus on

- Document-control formatting (Quality reviewer's job)
- Whether signatures are present (Quality)
- Adequacy of the QMS framework (Quality)

### Common findings the Technical reviewer catches

| Pattern | Typical severity |
|---|---|
| Calculation produces the wrong answer with the inputs provided | Critical |
| Method does not control for a known interferent | Critical or Major |
| Acceptance criteria not justifiable scientifically | Major |
| Validation experiment design has a confounding variable | Major |
| Reagent grade insufficient for the application | Major |
| Sample size yields inadequate statistical power | Major |
| Operator instruction ambiguous at a branching step | Major |
| Insignificant figures stated (false precision) | Minor or Observation |

---

## 3. Combined Reviewer

A single reviewer playing both roles (common at Montai given lean staffing). When this is the case:

- **Run both checklists in sequence**, not simultaneously — use the Quality lens first, then the Technical lens. Doing both at once tends to under-cover one or the other.
- **Annotate findings with which lens caught them**: in the report, optionally tag findings as `[Q]` or `[T]` to make hand-off to a future reviewer easier.
- **Be explicit in the Review Scope** that one person performed both perspectives — this matters for inspector traceability and for any reviewer-independence requirement.

If the document warrants a separate-eyes Quality + Technical review per a controlling SOP (e.g., release-quality decisions usually require independent QA), say so in the disposition: "This combined review does not satisfy the SOP-XX requirement for independent QA review; an independent QA approval is still required prior to signature."

---

## 4. Cross-cutting principles regardless of role

- Findings should be **actionable**: the author or owner reading them should know what to change without consulting the reviewer.
- Findings should **trace to a source**: regulatory citation, internal SOP clause, or both. "This seems wrong" is not a finding.
- **Don't gate-keep over preference.** Editorial preferences become Observations (or are omitted). Compliance and science become Minor / Major / Critical.
- When unsure if something is a Minor or an Observation, default to Observation. When unsure between Major and Critical, write the finding with the patient-safety / release-decision lens and let the answer fall out.
