#import "@preview/elembic:1.1.1" as e: field, types

#let project = "project"
#let purpose = [#underline[*purpose*]]
#let spec_section = "spec section"
#let engineer = "engineer"
#let contractor = "contractor"
#let service = "service"
#let reference = "reference"

#let term_blocks = [TB-AC]

#let drawings = (
  "D-01": "ENCLOSURE EXT. LAYOUT"
)

#let comments = (
  "test comment 1",
  "test comment 2"
)

#let component = e.types.declare(
  "component",
  doc: "data for component used in instrument/panel",
  prefix: "@basilbarge/submittal, v1",
  fields: (
    field("manufacturer", str, doc: "Manufacturer Name", required: true, named: true),
    field("catalog", str, doc: "Part catalog number", required: true, named: true),
    field("qty", int, doc: "Part quantity", required: true, named: true),
    field("sheet", int, doc: "Sheet number that cut sheet is on", required: true, named: true),
    field("description", str, doc: "Part description", required: true, named: true),
    field("tags", array, doc: "Tags used for part number", required: true, named: true),
    field("specs", array, doc: "Specifications for part", required: true, named: true),
  ),
)
