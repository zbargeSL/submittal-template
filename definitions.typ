#import "@preview/elembic:1.1.1" as e: field, types

#let is_resubmittal = false
#let is_instrument_submittal = false
#let has_spare_parts = true
#let has_heating_calc = false

#let submittal_type = "Submittal"

#if is_resubmittal {
  submittal_type = "Resubmittal"
}

#let project = "project"
#let purpose = [#underline[*purpose #submittal_type*]]
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
)

// Resubmittal comments dictionary in Comment: Sherwood Logan Response format
#let resub_comments = (
)

#let vdc_pws_components = (
  "Modem": "1",
)

#let heat_dissapated = (
  "UPS": "225",
  "DC Power Supplies": "112.5",
  "Digital Input Modules": "139.12",
)

#let component = e.types.declare(
  "component",
  doc: "data for component used in instrument/panel",
  prefix: "@basilbarge/submittal, v1",
  fields: (
    field("manufacturer", str, doc: "Manufacturer Name", required: true, named: true),
    field("catalog", str, doc: "Part catalog number", required: true, named: true),
    field("qty", str, doc: "Part quantity", required: true, named: true),
    field("sheet", int, doc: "Sheet number that cut sheet is on", required: true, named: true),
    field("description", str, doc: "Part description", required: true, named: true),
    field("tags", array, doc: "Tags used for part number", required: true, named: true),
    field("specs", array, doc: "Specifications for part", required: true, named: true),
    field("service", str, doc: "Service for instrument", required: false, named: true),
    field("misc", content, doc: "Additional information to be rendered after specs", required: false, named: true),
  ),
)

#let gen_load_calc_table(pws_tags, pws_current_cap, pws_components) = {
  underline[Power supply load calculations] 
  linebreak()
  linebreak()

  if pws_tags.len() > 1 {
    let desc = ""

    for (i, tag) in pws_tags.enumerate() {
        //second to last tag in array
        if i == 0 {
          desc += tag + ", "
        }  else if i == 1{
          desc += tag
        } else if i == pws_tags.len() -1 {
          desc += " and " + tag
        } else {
         desc += ", " + tag 
        }    
      }
      
    [#desc are redundant]
  }

  let total_current_draw = pws_components.values().reduce((acc, v) => float(v) + float(acc))

  table(
    columns: (75%, 25%),
    align: (left, center),
    stroke: (x,y) => if y == 0 or (x == 1 and y == pws_components.len()) {(bottom: 1pt)} else {none},
    table.header([Description], [Current Draw #linebreak() (Amps)]),
    ..pws_components.pairs().flatten(),
    table.cell(align: right, [Total Current Draw]), [#total_current_draw]
  )

  let perc_use = float(total_current_draw)/float(pws_current_cap) * 100

  list(indent: 1em)[$"Total current capacity" = #total_current_draw/#pws_current_cap", "#perc_use% "used"$] 
}
