#import "@local/submittal:0.1.0": *
#import "./definitions.typ": *

//#let components = (
//  component(
//    manufacturer: "manufacturer 1",
//    catalog: "test",
//    qty: "1",
//    sheet: 1,
//    description: "description 1",
//    tags: ("tag 1", "tag 2"),
//    specs: (
//      [spec 1],
//      [spec 2],
//    ),
//    misc: [
//      #gen_load_calc_table(("PWS1200",), 20, vdc_pws_components)
//    ]
//  ),
//  component(
//    manufacturer: "manufacturer 2",
//    catalog: "testtesttesttesttesttest",
//    qty: "1",
//    sheet: 1,
//    description: "description 2",
//    tags: ("tag 1", "tag 2"),
//    specs: (
//      [spec 1],
//      [spec 2],
//    ),
//  ),
//  component(
//    manufacturer: "manufacturer 3",
//    catalog: "test2",
//    qty: "2",
//    sheet: 2,
//    description: "description 3",
//    tags: ("tag 1", "tag 2"),
//    specs: (
//      [spec 1],
//      [spec 2],
//    ),
//  ),
//)

#let components = (
  DS42S_120_G: (sheet: 1, manufacturer: "Citel", qty: 2, tags: ("TVSS",)),
)

//#let spare_parts = components.filter(comp => comp.catalog == "test2" or comp.catalog == "test")

#let spare_parts_qty = (
  "test": "1",
  "test2": "2"
)
