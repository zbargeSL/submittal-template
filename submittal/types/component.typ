#import "@preview/elembic:1.1.1" as e: field, types

#let component = e.types.declare(
  "component",
  doc: "data for component used in instrument/panel",
  prefix: "@basilbarge/submittal, v1",
  fields: (
    field("manufacturer", str, doc: "Manufacturer Name", required: true, named: true),
    field("catalog", str, doc: "Part catalog number", required: true, named: true),
    field("description", str, doc: "Part description", required: true, named: true),
    field("specs", array, doc: "Specifications for part", required: true, named: true),
    field("service", str, doc: "Service for instrument", required: false, named: true),
    field("misc", content, doc: "Additional information to be rendered after specs", required: false, named: true),
    field("pdf_length", int, doc: "Length of associated data sheet pdf", required: true, named: true),
  ),
)
