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
  margin: (top: 2in, bottom: 2in)
)

#set par(
  justify: true
)

\

#align(center)[
  #upper[*#project*] \
\
  #upper[#purpose] \
\
  #upper[*#spec_section*]
]

#align(center + horizon)[
  #datetime.today().display("[month repr:long] [day], [year]")
]

#align(bottom)[
ENGINEER: #upper[#engineer]

CONTRACTOR: #upper[#contractor]
]

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

#pagebreak()

#align(center)[
  *Parts Index:* <PartsIndex>
]

#let parts_row = ()

#{
 parts_row = components.map((c) => ([#link(label(str(c.sheet)))[#c.sheet]], c.manufacturer, c.catalog, c.description)).flatten()
}

#{
  set text(size: 10pt)

  table(
    columns: (auto, 1fr, 1fr, 1fr),
    align:(center), 
    table.header([*SHT*], [*MANUFACTURER*], [*MODEL*], [*DESCRIPTION*]),
    ..parts_row,
  )
}

#pagebreak()

#align(center)[
  #upper[*#project*]
] <DataSheets>

#let sheet_rows = components.map((c) => ([#c.qty], [Mfg: #c.manufacturer: #c.description \ Model Number: #c.catalog \ \ Tags/Service: \ #c.tags.join(", ") / #service \ \ Specifications: \ #c.specs]))

#let tables_data = ("1": ())

#{
  for (i, component) in components.enumerate() {
    let key = str(component.qty)

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
    table.cell(stroke: (left: none, top: none, right:none))[], table.cell(stroke: (left: none, top: none, right: none))[#align(right)[Data Sheet #sheet#label(sheet)]],
    align(left)[Customer: \ Reference: \ Date: ], [#contractor \ #reference \ #datetime.today().display("[month]/[day]/[year]")],
    [#underline[Qty] \ \ ], [#underline[Description] \ \ ],
    ..details.flatten(),
  ) 

  pagebreak()
}

#align(center)[
  #upper[*#project*]
]
\
*Drawings Index*:<DrawingIndex>

#{
  set text(size: 10pt)

  table(
    columns: (1fr, 3fr),
    table.header([*Drawing Number*], [*Drawing Description*]),
  )
}

#pagebreak()

#align(center)[
  #upper[*#project*]
]

\
Drawings:<Drawings>

