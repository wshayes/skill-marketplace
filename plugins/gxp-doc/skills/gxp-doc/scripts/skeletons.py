"""Canonical section order per document type.

Each entry is a list of (level-1 section name, [starter clauses]). A starter
clause of None means the section opens with a table rather than prose; the
table headers are given in TABLES.
"""

SOP = [
    ("Purpose", ["To <state what this procedure achieves, in one sentence>."]),
    ("Scope", ["Applies to <who and what>, across <Company Name>."]),
    ("Definitions", None),
    ("Responsibilities", None),
    ("Procedure", ["<First step. One requirement per clause.>"]),
    ("Records and Retention", None),
]

POLICY = [
    ("Purpose", ["To <state the intent of this policy>."]),
    ("Scope", ["Applies to <who and what>, across <Company Name>."]),
    ("Definitions", None),
    ("Responsibilities", None),
    ("Policy Statements", ["<Company Name> shall <requirement>."]),
    ("Records and Retention", None),
]

WI = [
    ("Purpose", ["To <state what this work instruction achieves>."]),
    ("Scope", ["Applies to <who and what>."]),
    ("Prerequisites", ["<What must be true before starting.>"]),
    ("Steps", ["<First step.>"]),
    ("Records", None),
]

FORM = [
    ("Instructions", ["Complete every unshaded entry and route for approval."]),
    ("Identification", None),
    ("Assessment", None),
    ("Decision", None),
]

LOG = [
    ("Instructions", ["One row per entry. Do not delete rows; close them."]),
    ("Log", None),
    ("Key", None),
]

PROTOCOL = [
    ("Purpose", ["To <state what this protocol qualifies>."]),
    ("References", None),
    ("Scope", ["<What is in and out of qualification scope.>"]),
    ("Prerequisites", ["<What must be signed or in place before execution.>"]),
    ("Test Cases", None),
    ("Acceptance Criteria", ["<How pass and fail are decided.>"]),
]

#: Tables a section opens with: section name -> (headers, placeholder rows)
TABLES = {
    "Definitions": (["Term", "Definition"], [("<Term>", "<Definition>")]),
    "Responsibilities": (
        ["Role", "Responsibilities"],
        [("<Role>", "<What this role is accountable for>")],
    ),
    "Records and Retention": (
        ["Record", "Retention Period", "Owner"],
        [("<Record>", "<Period, or 'per SOP-001 (Document Control) §6'>",
          "<Owner>")],
    ),
    "Records": (
        ["Record", "Retention Period", "Owner"],
        [("<Record>", "<Period>", "<Owner>")],
    ),
    "Identification": (["Field", "Entry"], [("<Field>", "")]),
    "Assessment": (
        ["Criterion", "Finding", "Evidence"],
        [("<Criterion>", "", "")],
    ),
    "Decision": (["Decision", "Rationale", "Date"], [("", "", "")]),
    "Log": (["Ref", "Date", "Description", "Owner", "Status"], [("", "", "", "", "")]),
    "Key": (["Code", "Meaning"], [("<Code>", "<Meaning>")]),
    "Test Cases": (
        ["Test ID", "Requirement", "Method", "Expected Result"],
        [("<TC-01>", "<URS ref>", "<How it is exercised>", "<What passing looks like>")],
    ),
}

SKELETONS = {
    "sop": SOP,
    "policy": POLICY,
    "wi": WI,
    "form": FORM,
    "log": LOG,
    "protocol": PROTOCOL,
    "report": PROTOCOL,
    "qm": POLICY,
}
