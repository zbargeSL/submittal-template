#import "definitions.typ": *
#import "components.typ": *


#set text(
  size: 14pt,
  font: "Times New Roman"
)

#set page(
  header: context {
      if here().page() == 1 [
        #image("./common/images/SL_Header.png", width: 100%)
      ]
  },
  footer: context {
    if here().page() == 1 [
     #image("./common/images/SL_Footer.png", width: 100%)
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

#if comments.len() > 0 or is_resubmittal {
  linebreak()
  link(<Comments>)[*Comments*] 
}

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

#if comments.len() > 0 or is_resubmittal {
  linebreak()
  linebreak()
}

#if comments.len() > 0 {
  [*General Comments: <Comments>*]

  for comment in comments {
    [+ #comment #linebreak()#linebreak()]
  }
}

#if is_resubmittal [
  *Resubmittal \##resubmittal_number Comment Confirmations:*

  #for (resub_comment, response) in resub_comments {
    [+ #resub_comment #linebreak()#linebreak() *Sherwood Logan Response:* #linebreak()#linebreak() #response #linebreak()#linebreak()]
  }
]

#pagebreak()

#align(center)[
  *Parts Index:* <PartsIndex>
]

#let parts_row = ()
#let last_sheet


#{
  let comp
  let cat
  let test_cat
  for (part_file, part_data) in components {
    import "./Submittal_Data_Sheets/" + part_data.manufacturer + "/" + part_file + ".typ": comp

    if part_data.sheet == 1 {
      test_cat = comp.catalog
    }
    cat = comp.catalog

    if test_cat.len() > 20 {
      let num_breaks = calc.trunc(test_cat.len()/20)
      let i = 1
      while i <= num_breaks {
        test_cat = test_cat.slice(0, count:i*20) + sym.zws + test_cat.slice(i*20)
        i = i + 1
      }
    }

    comp = ([#link(label(str(part_data.sheet)))[#part_data.sheet]], comp.manufacturer, cat, comp.description)
    parts_row.push(comp)
    last_sheet = part_data.sheet + 1
  }
    let uni
    for char in test_cat {
      uni = char.to-unicode()
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

  #for (part_file, part_data) in spare_parts {
    import "./Submittal_Data_Sheets/" + part_data.manufacturer + "/" + part_file + ".typ": comp as spare

    spare_parts_rows.push(parts_row.filter(comp => comp.contains(spare.catalog)))
    spare_parts_rows.last().push(spare_parts_qty.at(part_file))
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
  for (part_file, part_data) in components {
    import "./Submittal_Data_Sheets/" + part_data.manufacturer + "/" + part_file + ".typ": comp
    sheet_rows.push(([#part_data.qty], [Mfg: #comp.manufacturer: #comp.description #linebreak() Model Number: #comp.catalog #linebreak() #linebreak() Tags/Service: #linebreak() #part_data.tags.join(", ") / #comp.service #linebreak() #linebreak() Specifications: #linebreak() #list(indent: 1em, ..comp.specs) #linebreak() ] ))
  }
} else {
  for (part_file, part_data) in components {
    import "./Submittal_Data_Sheets/" + part_data.manufacturer + "/" + part_file + ".typ": comp
    sheet_rows.push(([#part_data.qty], [Mfg: #comp.manufacturer: #comp.description #linebreak() Model Number: #comp.catalog #linebreak() #linebreak() Tags/Service: #linebreak() #part_data.tags.join(", ") / #service #linebreak() #linebreak() Specifications: #linebreak() #list(indent: 1em, ..comp.specs) #linebreak() #comp.misc #linebreak()] ))
  }
}

#let tables_data = ("1": ())

#{
  let i = 0
  for (part_file, part_data) in components {
    import "./Submittal_Data_Sheets/" + part_data.manufacturer + "/" + part_file + ".typ": comp

    let key = str(part_data.sheet)

    if (key in tables_data) {
      tables_data.at(key).push(sheet_rows.at(i))
    } else {
      tables_data.insert(key, sheet_rows.at(i))
    }
    i = i + 1
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

  let items_on_sheet = components.pairs().filter((v) => v.at(1).at("sheet") == int(sheet))


  for item in items_on_sheet {
    set page(margin: (top: 0in, bottom: 0in, left: 0in, right: 0in)) 

    let pdf_path = "./Submittal_Data_Sheets/" + item.at(1).at("manufacturer") + "/" + item.at(0) + ".pdf"

    image(pdf_path)
  }

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

    {
      set page(margin: (top: 0in, bottom: 0in, left: 0in, right: 0in)) 

      let i = 1

      while i < 10 {
        image("./Submittal_Data_Sheets/Phoenix-Contact/Phoenix Contact Terminal Blocks and Accessories.pdf", page: i)
        i = i + 1
      }
    }
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
