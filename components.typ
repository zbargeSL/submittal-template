#import "@local/submittal:0.1.0": *
#import "./definitions.typ": *

#let components = (
  DS42S_120_G: (sheet: 1, manufacturer: "Citel", qty: 2, tags: ("TVSS",)),
  ALFSWD: (sheet: 1, manufacturer: "Hoffman", qty: 4, tags: ("RECP1", "RECP2", "RECP3", "RECP4")),
  GFRST15W: (sheet: 2, manufacturer: "Hubbel", qty: 1, tags: ("RECP10",)),
  MD_120_24A_1C: (sheet: 3, manufacturer: "Micron", qty: 1, tags: ("PWS1",)),
  MDP_PDMA_C: (sheet: 3, manufacturer: "Micron", qty: 1, tags: ("PWSRED",)),
)

#let spare_parts = components.pairs().filter(v => v.at(0) == "DS42S_120_G")

#let spare_parts_qty = (
  "DS42S_120_G": "1",
)
