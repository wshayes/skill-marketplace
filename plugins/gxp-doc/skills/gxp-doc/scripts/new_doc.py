"""Scaffold a new controlled document in house style.

    uv run --with python-docx python .claude/skills/gxp-doc/scripts/new_doc.py \
        --type sop --id SOP-014 --title "Deviation Trending Procedure" \
        --approver "Head of Quality" -o build/

The scaffold is always written as _DRAFT1: a new document is a draft because
it is unsigned, and its Version No. already carries the number being sought.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from gxpdoc import BANNER, COMPANY_PLACEHOLDER, GxpDoc  # noqa: E402
from skeletons import SKELETONS, TABLES  # noqa: E402


def slug(title):
    return re.sub(r"[^A-Za-z0-9]+", "_", title).strip("_")


def build(doc_id, title, doc_type, version, approver, company):
    doc = GxpDoc(doc_id=doc_id, title=title, doc_type=doc_type,
                 version=version, company=company)
    doc.toc()
    for name, clauses in SKELETONS[doc_type]:
        doc.h1(name)
        for clause in clauses or []:
            doc.clause(2, clause)
        if name in TABLES:
            headers, rows = TABLES[name]
            doc.table(headers, rows, fillable=doc_type in ("form", "log"))

    doc.references({"References": []})
    doc.revision_history([(version, "", "<Author>", "Initial release", "")])
    doc.approval([
        ("Author", "<Name>", "<Title>"),
        ("Reviewer", "<Name>", "<Title>"),
        ("Approver", approver, "Head of Quality"),
    ])
    return doc


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--type", required=True, choices=sorted(BANNER))
    parser.add_argument("--id", required=True, dest="doc_id")
    parser.add_argument("--title", required=True)
    parser.add_argument("--version", default="1.0")
    parser.add_argument("--approver", default="<Approver>")
    parser.add_argument("--company", default=COMPANY_PLACEHOLDER,
                        help="appears as the header wordmark")
    parser.add_argument("--draft", type=int, default=1)
    parser.add_argument("-o", "--outdir", type=Path, default=Path("build"))
    args = parser.parse_args()

    doc = build(args.doc_id, args.title, args.type, args.version,
                args.approver, args.company)
    name = (f"{args.doc_id}_{slug(args.title)}_v{args.version}"
            f"_DRAFT{args.draft}.docx")
    path = doc.save(args.outdir / name)
    print(f"wrote {path}")
    if args.company == COMPANY_PLACEHOLDER:
        print(f"WARNING: company is still {COMPANY_PLACEHOLDER} — pass --company")
    print("Register it on the Document Master List before circulating.")


if __name__ == "__main__":
    main()
