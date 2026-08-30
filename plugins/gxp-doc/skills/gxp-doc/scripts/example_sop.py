"""Emit a fully worked SOP — the reference output for this skill.

    uv run --with python-docx python \
        ~/.claude/skills/gxp-doc/scripts/example_sop.py --company "Acme Pharma"

Unlike new_doc.py, which scaffolds placeholders, this builds a complete
document with real prose, nested clauses, bullets and every table type. Use it
to see what house style looks like when filled in, and to eyeball a rendering
after changing gxpdoc.py.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from gxpdoc import COMPANY_PLACEHOLDER, GxpDoc  # noqa: E402


def build(company):
    d = GxpDoc(doc_id="SOP-014", title="Deviation Trending Procedure",
               doc_type="sop", version="1.0", company=company)
    d.toc()

    d.h1("Purpose")
    d.clause(2, "To define how deviation data is trended so that recurring "
                "problems are detected before they become systemic.")

    d.h1("Scope")
    d.clause(2, "Applies to all deviations recorded under SOP-005 (Deviations "
                f"and CAPA) across {company}.")

    d.h1("Definitions")
    d.table(["Term", "Definition"], [
        ("Deviation", "A departure from an approved procedure, specification, "
                      "or established standard."),
        ("Trend", "A directional pattern in deviation data observed across two "
                  "or more consecutive review periods."),
        ("Adverse trend", "A trend that worsens across two consecutive periods, "
                          "or any root cause category recorded three or more "
                          "times in one period."),
    ])

    d.h1("Responsibilities")
    d.table(["Role", "Responsibilities"], [
        ("Head of Quality & Compliance",
         "Owns the trending process; approves the quarterly trend report; "
         "escalates adverse trends to Management Review."),
        ("Document Control",
         "Maintains LOG-001 (Deviation and CAPA Log) and supplies period "
         "extracts to the trend owner."),
        ("All Staff",
         "Record deviations promptly and completely so that trend data is "
         "usable."),
    ])

    d.h1("Forms and Logs")
    d.table(["Document ID", "Purpose"], [
        ("FRM-003 (Deviation and CAPA Form)", "Records one deviation and its CAPA."),
        ("LOG-001 (Deviation and CAPA Log)", "Register of all deviations."),
    ])

    d.h1("Procedure")
    d.clause(2, f"{company} reviews deviation data quarterly. The review shall "
                "cover every deviation closed in the period together with any "
                "deviation still open beyond its target closure date, and shall "
                "produce a written record of the conclusions reached.")
    d.clause(3, "The Head of Quality & Compliance extracts the period's records "
                "from LOG-001 (Deviation and CAPA Log) and classifies each by "
                "process area, root cause category, and severity. Records that "
                "cannot be classified from the log alone are resolved against "
                "the underlying FRM-003 (Deviation and CAPA Form).")
    d.clause(4, "The trend review shall include the following:")
    d.bullet("Count and rate by process area, compared against the prior two "
             "periods")
    d.bullet("Repeat root causes, defined as the same category recorded three "
             "or more times")
    d.bullet("CAPA effectiveness, measured as recurrence after closure")
    d.clause(3, "An adverse trend is escalated to Management Review within ten "
                "working days of the trend review, together with a proposed "
                "CAPA raised under SOP-005 (Deviations and CAPA).")
    d.clause(2, "Where a trend crosses a validated computerised system, the "
                "trend owner raises a change request under SOP-003 (Change "
                "Control) rather than amending the system directly.")
    d.clause(2, "The trend report is filed as a quality record and retained "
                "per §7 of this procedure.")

    d.h1("Records and Retention")
    d.table(["Record", "Retention Period", "Owner"], [
        ("Quarterly deviation trend report", "10 years",
         "Head of Quality & Compliance"),
        ("Trend review meeting minutes", "10 years",
         "Head of Quality & Compliance"),
    ])

    d.references({
        "QMS Documents": [
            ("SOP-003", "Change Control Procedure"),
            ("SOP-005", "Deviations and CAPA Procedure"),
            ("FRM-003", "Deviation and CAPA Form"),
            ("LOG-001", "Deviation and CAPA Log"),
        ],
        "External Standards and Regulations": [
            ("21 CFR Part 820.100", "Corrective and Preventive Action"),
            ("EU GMP Annex 11 §13", "Computerised Systems — Incident Management"),
            ("ICH Q10 §3.2", "Pharmaceutical Quality System"),
        ],
    })

    d.revision_history([
        ("1.0", "", "Quality Team", "Initial release", "CC-2026-021"),
    ])
    d.approval([
        ("Author", "<Author>", "<Title>"),
        ("Reviewer", "<Reviewer>", "<Title>"),
        ("Approver", "<Approver>", "Head of Quality"),
    ])
    return d


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--company", default=COMPANY_PLACEHOLDER)
    parser.add_argument("-o", "--outdir", type=Path, default=Path("build"))
    args = parser.parse_args()
    path = build(args.company).save(
        args.outdir / "SOP-014_Deviation_Trending_Procedure_v1.0_DRAFT1.docx"
    )
    print(f"wrote {path}")


if __name__ == "__main__":
    main()
