# Severity Definitions and Regulatory Framework

This file is **always loaded** by the `gxp-review-general` skill. It provides:
1. The canonical Critical / Major / Minor / Observation severity definitions
2. The regulatory citation menu, organized by GxP discipline and jurisdiction
3. Guidance on choosing the right citation for a finding

---

## 1. Severity definitions

The grading scale is harmonized with the conventions used in regulatory inspections (FDA Form 483 / EIR severity, EMA inspection reports, PIC/S inspection categorizations) and adapted for internal review use.

### Critical

A deficiency that produces, or has a high likelihood of producing, **a product that is harmful to the patient**, **a record that does not faithfully reflect the GxP activity**, or **a regulatory non-compliance that could trigger enforcement action**.

Typical Critical patterns:
- Patient safety risk (e.g., an instruction that would yield a sub-potent or super-potent dose; a missing impurity control)
- Data integrity breach (ALCOA+ violation — e.g., backdated entries, lack of audit trail, shared logins)
- Cross-contamination or sterility risk in manufacturing instructions
- Wrong specification limit applied (e.g., DS limit of 0.5% applied where the registered limit is 0.15%)
- Missing required signature on a record being submitted for release
- An approved document that contradicts the registered IND / IMPD / NDA / MAA dossier
- Use of an uncontrolled / unapproved method or reagent for a release-quality decision
- Stability data extrapolation beyond what ICH Q1E permits
- Clinical: enrollment of an ineligible subject, dose error, missed safety reporting per ICH E2A timeline
- Computerized system: missing or disabled audit trail; unauthorized data modification capability

A single Critical, if unresolved, blocks approval (Final Review status) or triggers immediate change control / quarantine (Post-Approval status).

### Major

A significant deficiency that **does not directly endanger patient safety or release-quality decisions**, but **could lead to non-compliance, reduce the reliability of results, or be cited by an inspector**.

Typical Major patterns:
- Acceptance criteria not justified or not traceable to specifications
- Validation parameter missing (e.g., robustness or specificity not demonstrated for an assay)
- Missing required section that is recoverable (e.g., revision history present but incomplete)
- Permissive limits without scientific or toxicological justification
- Inconsistent values between method body and qualification summary
- Tracked changes / open reviewer comments persisting at Final Review
- Cross-references to documents that do not yet exist (when the dependency is material)
- Quality Agreement clause that does not reflect current regulatory expectation (e.g., missing IND-specific obligations)
- SOP that contradicts a higher-level Policy or another approved SOP
- Computerized system: incomplete user-access matrix, periodic-review overdue
- Clinical: protocol deviation pattern not addressed; informed consent version mismatch

Multiple Majors at Final Review typically yield a "Conditional Approval" or "HOLD" disposition.

### Minor

A departure from procedure, expectation, or best practice that **does not significantly affect quality, safety, or compliance**.

Typical Minor patterns:
- Editorial errors in non-instruction text (spelling, grammar)
- Inconsistent terminology that does not affect meaning
- Formatting departures from the controlled template
- Missing optional / non-required sections
- Outdated reference to a superseded guidance when the relevant content is unchanged
- Tables not numbered consistently

### Observation

A **recommendation, improvement opportunity, or note** with no compliance impact. Observations exist to capture the reviewer's judgment without forcing the author to action.

Typical Observation patterns:
- Suggestion to align language with a forthcoming guidance (e.g., ICH Q2(R2) updates)
- Note that a procedure could be made more efficient
- Cross-reference to a related document the author may want to consider
- Editorial preference (Oxford comma, etc.)

### Severity-grading discipline

Two reviewers applying these definitions to the same finding should land within ±1 severity level of each other. If a finding feels like it could be either Critical or Major, write the finding with the **patient-safety / release-decision lens**: if a downstream user of the document could be harmed or make a wrong release decision because of this gap, it's Critical; otherwise, Major.

---

## 2. Regulatory framework (citation menu)

Use specific section numbers in citations. "ICH Q2" alone is insufficient — write "ICH Q2(R2) §5.5 (Accuracy)". Same for CFR ("21 CFR 211.165(e)" not "21 CFR Part 211").

### 2a. FDA — United States

#### Drug GMP (small molecule, biologics finished products)
- **21 CFR Part 210** — cGMP general provisions
- **21 CFR Part 211** — cGMP for finished pharmaceuticals
  - 211.22 — QU responsibilities
  - 211.42 — Design and construction features
  - 211.84 — Testing and approval of components
  - 211.100 — Written procedures; deviations
  - 211.110 — Sampling and testing of in-process materials
  - 211.165 — Testing and release for distribution
  - 211.166 — Stability testing
  - 211.180 — General requirements (records and reports)
  - 211.188 — Batch production and control records
  - 211.192 — Production record review
  - 211.194 — Laboratory records
- **21 CFR Part 600–680** — Biologics
- **FDA Guidance: Process Validation: General Principles and Practices (2011)** — three-stage lifecycle
- **FDA Guidance: Q7A Q&A** — API GMPs

#### Electronic records / data integrity
- **21 CFR Part 11** — Electronic records, electronic signatures
  - 11.10 — Controls for closed systems (audit trail, validation, access)
  - 11.30 — Controls for open systems
  - 11.50 — Signature manifestations
  - 11.70 — Signature/record linking
- **FDA Guidance: Data Integrity and Compliance With Drug CGMP (2018)**

#### Clinical (GCP)
- **21 CFR Part 50** — Protection of human subjects (informed consent)
- **21 CFR Part 54** — Financial disclosure by investigators
- **21 CFR Part 56** — IRBs
- **21 CFR Part 312** — IND application
  - 312.32 — IND safety reporting
  - 312.50 — General responsibilities of sponsors
  - 312.56 — Review of ongoing investigations
  - 312.57 — Recordkeeping and record retention
  - 312.62 — Investigator recordkeeping and record retention

#### Nonclinical (GLP)
- **21 CFR Part 58** — Good Laboratory Practice for Nonclinical Laboratory Studies

#### Pharmacovigilance / Postmarket
- **21 CFR 314.80** — Postmarketing reporting of adverse drug experiences
- **21 CFR 314.81** — Other postmarketing reports
- **FDA Adverse Event Reporting System (FAERS)** procedures

#### Distribution (GDP)
- **21 CFR Part 205** — Guidelines for State licensing of wholesale prescription drug distributors
- **DSCSA (Drug Supply Chain Security Act)** requirements

### 2b. EU / EMA

#### GMP — EudraLex Volume 4
- **Part I** — Basic Requirements for Medicinal Products
  - Chapter 1 — Pharmaceutical Quality System
  - Chapter 2 — Personnel
  - Chapter 3 — Premises and Equipment
  - Chapter 4 — Documentation
  - Chapter 5 — Production
  - Chapter 6 — Quality Control
  - Chapter 7 — Outsourced Activities
  - Chapter 8 — Complaints and Product Recall
  - Chapter 9 — Self Inspection
- **Part II** — Basic Requirements for Active Substances (API)
- **Annexes**:
  - **Annex 1** — Manufacture of Sterile Medicinal Products (revised 2022, fully effective Aug 2023)
  - **Annex 11** — Computerised Systems
  - **Annex 13** — IMPs (Investigational Medicinal Products)
  - **Annex 15** — Qualification and Validation
  - **Annex 16** — Certification by a Qualified Person and Batch Release

#### Clinical (GCP)
- **Regulation (EU) 536/2014 (CTR)** — Clinical Trials Regulation
- **Directive 2001/20/EC** (legacy CTD framework)
- **EMA Reflection Papers** on risk-based GCP

#### Pharmacovigilance — GVP Modules
- **Module I** — PV systems and their quality systems
- **Module II** — Pharmacovigilance system master file
- **Module V** — Risk management systems
- **Module VI** — Collection, management and submission of reports of suspected ADRs
- **Module IX** — Signal management

#### Distribution (GDP)
- **Guidelines on Good Distribution Practice (2013/C 343/01)**

### 2c. ICH (international harmonization)

#### Quality
- **Q1A(R2)** — Stability testing of new drug substances and products
- **Q1B** — Photostability testing
- **Q1D** — Bracketing and matrixing designs for stability
- **Q1E** — Evaluation of stability data
- **Q2(R2)** — Validation of analytical procedures (revised 2023; supersedes Q2(R1))
- **Q3A(R2)** — Impurities in new drug substances
- **Q3B(R2)** — Impurities in new drug products
- **Q3C(R8)** — Residual solvents
- **Q3D(R2)** — Elemental impurities
- **Q5A–E** — Biotechnological/biological products (viral safety, cell substrates, comparability, stability, derivation)
- **Q6A** — Specifications: chemical substances
- **Q6B** — Specifications: biotech products
- **Q7** — GMP for active pharmaceutical ingredients
- **Q8(R2)** — Pharmaceutical development
- **Q9(R1)** — Quality risk management
- **Q10** — Pharmaceutical quality system
- **Q11** — Development and manufacture of drug substances
- **Q12** — Lifecycle management
- **Q14** — Analytical procedure development (companion to Q2(R2))

#### Safety / Efficacy / Multidisciplinary (Clinical)
- **E2A** — Clinical safety data management: definitions and standards for expedited reporting
- **E2B(R3)** — Electronic transmission of individual case safety reports
- **E2D** — Post-approval safety data management
- **E2E** — Pharmacovigilance planning
- **E3** — Structure and content of clinical study reports
- **E6(R3)** — Good Clinical Practice (current revision; supersedes E6(R2))
- **E8(R1)** — General considerations for clinical studies
- **E9(R1)** — Statistical principles for clinical trials (estimands)
- **E17** — Multi-regional clinical trials
- **E18** — Genomic sampling
- **M3(R2)** — Nonclinical safety studies for clinical trials and marketing authorization
- **M4** — Common Technical Document
- **M7(R2)** — Mutagenic impurities (DNA-reactive)
- **M9** — Biopharmaceutics classification system

### 2d. USP (United States Pharmacopeia) — General Chapters

- **<232>** — Elemental Impurities — Limits
- **<233>** — Elemental Impurities — Procedures
- **<467>** — Residual Solvents
- **<621>** — Chromatography
- **<711>** — Dissolution
- **<730>** — Plasma spectrochemistry
- **<788>** — Particulate matter in injections
- **<905>** — Uniformity of dosage units
- **<1058>** — Analytical Instrument Qualification (AIQ)
- **<1224>** — Transfer of analytical procedures
- **<1225>** — Validation of compendial procedures
- **<1226>** — Verification of compendial procedures

### 2e. OECD GLP

- **OECD Series on Principles of GLP and Compliance Monitoring** — Documents 1 through 17+
  - No. 1 — OECD Principles on Good Laboratory Practice
  - No. 13 — The Application of the OECD Principles of GLP to the Organisation and Management of Multi-Site Studies
  - No. 17 — Application of GLP Principles to Computerised Systems
  - No. 22 — Application of GLP Principles to Computerised Systems (revised)

### 2f. PIC/S (Pharmaceutical Inspection Co-operation Scheme)

- **PE 009** — Guide to Good Manufacturing Practice (mirrors EU GMP closely)
- **PI 011** — Computerised Systems
- **PI 041** — Good Practices for Data Management and Integrity in Regulated GMP/GDP Environments
- **PI 053** — Aide-Memoire on Inspection of Medical Devices

### 2g. Computerized systems / data integrity (cross-cutting)

- **GAMP 5 Second Edition (2022)** — A Risk-Based Approach to Compliant GxP Computerized Systems (ISPE)
- **MHRA "GxP" Data Integrity Guidance and Definitions (2018)**
- **WHO TRS 996, Annex 5** — Good Data and Record Management Practices
- **FDA Guidance: Data Integrity and Compliance With Drug CGMP (2018)**
- **EMA Guideline on Computerised Systems and Electronic Data in Clinical Trials (2023)**

### 2h. WHO

- **WHO TRS series** (technical report series) — relevant Annexes for GMP, GDP, biological products, vaccines

---

## 3. Choosing the right citation

Pick the **most jurisdictionally specific** citation that supports the finding:

- If Montai's audience for this document is U.S. IND filings → cite 21 CFR + ICH
- If for EU CTA / IMPD → cite EudraLex + ICH
- If for both → cite both, with ICH as the harmonization layer
- If the deficiency is purely scientific (e.g., a poorly designed validation experiment) → ICH alone often suffices
- If the deficiency is data integrity → cite the jurisdiction's Part 11 / Annex 11 plus PIC/S PI 041 or MHRA guidance
- If the deficiency violates a Montai internal SOP → cite the SOP clause **in addition to** the regulatory reference, not instead of it

Avoid citation inflation. One precise citation per finding is better than a list of three vaguely related ones.

---

## 4. Document-specific quick-reference

| Document type | Typical primary regulatory anchors |
|---|---|
| Analytical method | ICH Q2(R2), Q14, USP <1225>/<1226>/<1224>, 21 CFR 211.165(e), 211.194 |
| Method validation report | ICH Q2(R2), USP <1225>, 21 CFR 211.165(e) |
| Stability protocol/report | ICH Q1A(R2), Q1B, Q1D, Q1E, 21 CFR 211.166 |
| Specification (DS / DP) | ICH Q6A/Q6B, Q3A/B/C/D, M7(R2), USP general & monograph |
| BPR / MBR | 21 CFR 211.188, 211.192, EudraLex Vol 4 Ch 4, Annex 16 |
| SOP / Policy | EudraLex Vol 4 Ch 4, ICH Q10, 21 CFR 211.22, 211.100 |
| Validation protocol/report (process) | EudraLex Vol 4 Annex 15, FDA Process Validation Guidance, ICH Q8/Q9/Q10 |
| Validation protocol/report (CSV) | EU Annex 11, 21 CFR Part 11, GAMP 5, PI 011/PI 041 |
| Change control | ICH Q10 §3.2.3, EudraLex Vol 4 Ch 1, 21 CFR 211.100 |
| CAPA | ICH Q10 §3.2.2, 21 CFR 211.192, EudraLex Vol 4 Ch 1 |
| Deviation | ICH Q10 §3.2.1, 21 CFR 211.192, EudraLex Vol 4 Ch 1 |
| Quality Agreement (QTA) | FDA Guidance: Contract Manufacturing — Quality Agreements (2016), EudraLex Vol 4 Ch 7 |
| CoA | ICH Q6A/Q6B, 21 CFR 211.165, EudraLex Vol 4 Ch 6 |
| Clinical protocol | ICH E6(R3), E8(R1), E9(R1), 21 CFR Part 312, EU CTR 536/2014 |
| Clinical study report | ICH E3, E6(R3), 21 CFR Part 312 |
| Investigator brochure | ICH E6(R3) §7, 21 CFR 312.55 |
| Site monitoring report | ICH E6(R3) §5.18, 21 CFR 312.56 |
| Pharmacovigilance / safety report | ICH E2A, E2D, 21 CFR 312.32, EU GVP Modules VI / IX |
| GLP study protocol/report | OECD GLP No. 1, 21 CFR Part 58 |
| Computerized-system validation | GAMP 5, EU Annex 11, 21 CFR Part 11, PI 011 |
| Audit trail review | EU Annex 11 §9, 21 CFR 11.10(e), PI 041 §9 |
