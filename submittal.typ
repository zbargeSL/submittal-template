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

#set par(
  justify: true
)

#{
  set page(
    margin: (top: 2in, bottom: 2in)
  )

  align(center)[
    #upper[*#project*] \
  \
    #upper[#purpose] \
  \
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
\
#link(<Comments>)[*Comments*] \
\
#link(<PartsIndex>)[*Parts Index*] \ 
\
#link(<DataSheets>)[*Data Sheets*] \
\
#link(<DrawingIndex>)[*Drawing Index*] \
\
#link(<Drawings>)[*Drawings*] \

#pagebreak()

#align(center)[
  #upper[*#project*]
]
\
\
General Comments: <Comments>

#for comment in comments{
  [+ #comment \ \ ]
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

  table(
    columns: (auto, 1fr, 1fr, 1fr),
    align:(center + horizon), 
    table.header([*SHT*], [*MANUFACTURER*], [*MODEL*], [*DESCRIPTION*]),
    ..parts_row.flatten(),
    [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [UT 2,5], [Terminal Block],
    [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [UT 2,5-PE], [Grounding Terminal Block],
    [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [D-UT 2,5-10], [Terminal End Barrier],
    [#link(label(str(last_sheet)))[#last_sheet]], [Phoenix Contact], [E/NS 35 N], [Terminal Anchor],
  )
}

#pagebreak()

#align(center)[
  #upper[*#project*]
] <DataSheets>

#let sheet_rows = components.map((c) => ([#c.qty], [Mfg: #c.manufacturer: #c.description \ Model Number: #c.catalog \ \ Tags/Service: \ #c.tags.join(", ") / #service \ \ Specifications: \ #list(indent: 1em, ..c.specs) \ ] ))

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
    align(left)[Customer: \ Reference: \ Date: ], [#contractor \ #reference \ #datetime.today().display("[month]/[day]/[year]")],
    [#underline[Qty] \ \ ], [#underline[Description] \ \ ],
    ..details.flatten(),
  ) 

  pagebreak()
}

#table(
  columns: (auto, 1fr),
  align: (center, left),
  table.cell(stroke: (left: none, top: none, right: none))[], table.cell(stroke: (left: none, top: none, right: none))[#align(right)[*Data Sheet #last_sheet#label(str(last_sheet))*]],
  align(left)[Customer: \ Reference: \ Date: ], [#contractor \ #reference \ #datetime.today().display("[month]/[day]/[year]")],
  [#underline[Qty] \ \ ], [#underline[Description] \ \ ],
  [A/R \ \ \ A/R \ \ \ A/R \ \ \ A/R], [Mfg: Phoenix Contact: Terminal Block \ Model Number: UT 2,5 \
  \
  Mfg: Phoenix Contact: Grounding Terminal Block \ Model Number: UT 2,5-PE \ 
  \
  Mfg: Phoenix Contact: Terminal End Barrier \ Model Number: D-UT 2,5-10 \
  \
  Mfg: Phoenix Contact: Terminal Anchor \ Model Number: E/NS 35 N \
  \
  Tags / Service: \ #term_blocks / #service \
  \
  Specifications: \
  #list(
    indent: 1em,
     [Feed through and grounding terminals],
     [Screw clamps], 
     [End plates and anchors],
     [DIN rail mount],
   ) \
  ], 
)

#pagebreak()

#align(center)[
  #upper[*#project*]
]
\
*Drawings Index*:<DrawingIndex>

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

\
Drawings:<Drawings>

