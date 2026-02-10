#import "definitions.typ": *
#import "components.typ": *

#set text(
  size: 14pt,
  font: "Times New Roman"
)

#set page(
  header: context {
      if here().page() == 1 [
        #image("./images/SL_Header.png", width: 100%)
      ]
  },
  footer: context {
    if here().page() == 1 [
     #image("./images/SL_Footer.png", width: 100%)
   ]
  },
  paper: "us-letter",
)

#set pagebreak(weak: true)

#{
  set page(
    margin: (top: 2in, bottom: 2in)
  )

  align(center)[
    #upper[*#project*] 

    #linebreak()
    #upper[#purpose]

    #linebreak()
    #upper[*#spec_section*]
  ]

  align(center + horizon)[
    *#datetime.today().display("[month repr:long] [day], [year]")*
  ]

  align(bottom)[
  *ENGINEER: #upper[#engineer]*

  *CONTRACTOR: #upper[#contractor]*
  ]
}

#pagebreak()

#align(center)[
  #upper[*#project*]

  Table of Contents
]
#linebreak()
#link(<Comments>)[*Comments*] 

#linebreak()
#link(<PartsIndex>)[*Parts Index*]

#if has_spare_parts [
  #linebreak()
  #link(<SparePartsIndex>)[*Spare Parts Index*]
]

#linebreak()
#link(<DataSheets>)[*Data Sheets*] 

#if has_heating_calc [
  #linebreak()
  #link(<HeatingAndCoolingSizes>)[*Heating and Cooling Sizes*]
]
#if not is_instrument_submittal [
  #linebreak()
  #link(<DrawingIndex>)[*Drawing Index*]

  #linebreak()
  #link(<Drawings>)[*Drawings*]
]

#pagebreak()

#align(center)[
  #upper[*#project*]
]

#linebreak()
#linebreak()
General Comments: <Comments>

#for comment in comments{
  [+ #comment #linebreak()#linebreak()]
}

#pagebreak()

#align(center)[
  *Parts Index:* <PartsIndex>
]

#let parts_row = ()
#let last_sheet

#{
  let comp
  for component in components {
    comp = ([#link(label(str(component.sheet)))[#component.sheet]], component.manufacturer, component.catalog, component.description)
    parts_row.push(comp)
    last_sheet = component.sheet + 1
  }
}

#{
  set text(size: 10pt)

  if not is_instrument_submittal {
    table(
      columns: (auto, 1fr, 1fr, 1fr),
      align:(center + horizon), 
      table.header([*SHT*], [*MANUFACTURER*], [*MODEL*], [*DESCRIPTION*]),
      ..parts_row.flatten(),
      [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [3044076], [Terminal Block],
      [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [3044092], [Grounding Terminal Block],
      [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [3047028], [Terminal End Barrier],
      [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [0800886], [Terminal Anchor],
    )
  } else {
    table(
      columns: (auto, 1fr, 1fr, 1fr),
      align:(center + horizon), 
      table.header([*SHT*], [*MANUFACTURER*], [*MODEL*], [*DESCRIPTION*]),
      ..parts_row.flatten(),
    )
  }
}

#pagebreak()

#if has_spare_parts [
  #let spare_parts_rows = ()

  #for spare_component in spare_parts {
    spare_parts_rows.push(parts_row.filter(comp => comp.contains(spare_component.catalog)))
    spare_parts_rows.last().push(spare_parts_qty.at(spare_component.catalog))
  }

  #align(center)[*#upper(project)*]

  #{
    set text(size: 12pt)
    [*Spare Parts Index:* <SparePartsIndex>]
  }

  #v(.3em, weak: true)
  #{
    set text(size: 10pt)

    table(
      columns: (auto, 1fr, 1fr, 1fr, 1fr),
      align:(center + horizon), 
      table.header([*SHT*], [*MANUFACTURER*], [*MODEL*], [*DESCRIPTION*], [*QTY*]),
      ..spare_parts_rows.flatten(),
    )
  }

  #pagebreak()
]

#align(center)[
  #upper[*#project*]
] <DataSheets>

#let sheet_rows = ()

#if is_instrument_submittal{
  sheet_rows = components.map((c) => ([#c.qty], [Mfg: #c.manufacturer: #c.description #linebreak() Model Number: #c.catalog #linebreak() #linebreak() Tags/Service: #linebreak() #c.tags.join(", ") / #c.service #linebreak() #linebreak() Specifications: #linebreak() #list(indent: 1em, ..c.specs) #linebreak() ] ))
} else {
  sheet_rows = components.map((c) => ([#c.qty], [Mfg: #c.manufacturer: #c.description #linebreak() Model Number: #c.catalog #linebreak() #linebreak() Tags/Service: #linebreak() #c.tags.join(", ") / #service #linebreak() #linebreak() Specifications: #linebreak() #list(indent: 1em, ..c.specs) #linebreak() ] ))
}

#let tables_data = ("1": ())

#{
  for (i, component) in components.enumerate() {
    let key = str(component.sheet)

    if (key in tables_data) {
      tables_data.at(key).push(sheet_rows.at(i))
    } else {
      tables_data.insert(key, sheet_rows.at(i))
    }
  }
}

#for (sheet, details) in tables_data {
  table(
    columns: (auto, 1fr),
    align: (center, left),
    table.cell(stroke: (left: none, top: none, right:none))[], table.cell(stroke: (left: none, top: none, right: none))[#align(right)[*Data Sheet #sheet#label(sheet)*]],
    align(left)[Customer: #linebreak() Reference: #linebreak() Date: ], [#contractor #linebreak() #reference #linebreak() #datetime.today().display("[month]/[day]/[year]")],
    [#underline[Qty] #linebreak()#linebreak()], [#underline[Description] #linebreak()#linebreak()],
    ..details.flatten(),
  ) 

  pagebreak()
}

#if not is_instrument_submittal {
  table(
    columns: (auto, 1fr),
    align: (center, left),
    table.cell(stroke: (left: none, top: none, right: none))[], table.cell(stroke: (left: none, top: none, right: none))[#align(right)[*Data Sheet #last_sheet#label(str(last_sheet))*]],
    align(left)[Customer: #linebreak() Reference: #linebreak() Date: ], [#contractor #linebreak() #reference #linebreak() #datetime.today().display("[month]/[day]/[year]")],
    [#underline[Qty] #linebreak()#linebreak()], [#underline[Description] #linebreak()#linebreak()],
    [A/R #linebreak()#linebreak()#linebreak() A/R #linebreak()#linebreak()#linebreak() A/R #linebreak()#linebreak()#linebreak() A/R], [Mfg: Phoenix Contact: Terminal Block #linebreak() Model Number: 3044076 #linebreak()
    #linebreak()
    Mfg: Phoenix Contact: Grounding Terminal Block #linebreak() Model Number: 3044092 #linebreak()
    #linebreak()
    Mfg: Phoenix Contact: Terminal End Barrier #linebreak() Model Number: 3047028 #linebreak()
    #linebreak()
    Mfg: Phoenix Contact: Terminal Anchor #linebreak() Model Number: 0800886 #linebreak()
    #linebreak()
    Tags / Service: #linebreak() #term_blocks / #service #linebreak()
    #linebreak()
    Specifications: #linebreak()
    #list(
      indent: 1em,
       [Feed through and grounding terminals],
       [Screw clamps], 
       [End plates and anchors],
       [DIN rail mount],
     )
     #linebreak()
    ], 
  )

  pagebreak()
}

#if has_heating_calc [
  #align(center)[
    #upper[*#project*]
  ]

  *Heating and Cooling Sizes:*<HeatingAndCoolingSizes>

  #align(center,
  [
    #table(
      columns: (auto, 40%),
      inset: (x, y) =>
        if x == 0 and y <= heat_dissapated.len() { (right: 2em, left: 0% + 5pt, top: 0% + 5pt, bottom: 0% + 5pt) } else { 0% + 5pt },  
      align: (x, y) =>
        if y < heat_dissapated.len() and x == 0 {left}
        else if x > 0 { center } else { right }
      ,
      stroke: (x, y) => (
        top: if y == 0 or (y == heat_dissapated.len() + 1 and x == 1) { 1pt },
        right: if x == 1 { 1pt },
        left: if x == 0 { 1pt },
        bottom: if y == 0 or y == heat_dissapated.len() + 1 { 1pt }
      ),
      [ Device #linebreak() #linebreak() ], [ HEAT DISSIPATED #linebreak() (BTU/Hr) #linebreak() ],
      ..heat_dissapated.pairs().flatten(),
      [Total], [#heat_dissapated.values().map(val => float(val)).sum()]
    )
  ])

  #pagebreak()

]

#if not is_instrument_submittal [

  #align(center)[
    #upper[*#project*]
  ]
  #linebreak()
  *Drawings Index:*<DrawingIndex>

  #{
    set text(size: 10pt)

    table(
      columns: (1fr, 3fr),
      align: (center, left),
      table.header(align(left)[*Drawing Number*], [*Drawing Description*]),
      ..drawings.pairs().flatten()
    )
  }

  #pagebreak()

  #align(center)[
    #upper[*#project*]
  ]

  #linebreak()
  Drawings:<Drawings>
]
