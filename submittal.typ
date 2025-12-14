#let project = "project"
#let purpose = [#underline[*purpose*]]
#let spec_section = "spec section"
#let engineer = "engineer"
#let contractor = "contractor"

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
  Parts Index: <PartsIndex>
]

#pagebreak()

#align(center)[
  #upper[*#project*]
] <DataSheets>

#pagebreak()

#align(center)[
  #upper[*#project*]
]

\
Drawings Index:<DrawingIndex>

#pagebreak()

#align(center)[
  #upper[*#project*]
]

\
Drawings:<Drawings>

