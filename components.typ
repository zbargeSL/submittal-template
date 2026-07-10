#import "@local/submittal:0.1.0": *
#import "./definitions.typ": *

#let components = (
  DS42S_120_G: (sheet: 1, manufacturer: "Citel", qty: 2, tags: ("TVSS",)),
  ALFSWD: (sheet: 1, manufacturer: "Hoffman", qty: 4, tags: ("RECP1", "RECP2", "RECP3", "RECP4")),
)

#let spare_parts = components.pairs().filter(v => v.at(0) == "DS42S_120_G")

#let spare_parts_qty = (
  "DS42S_120_G": "1",
)
