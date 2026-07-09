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
#let resubmittal_number = ""


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


