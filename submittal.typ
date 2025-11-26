#let project = "project"
#let purpose = [*purpose*]
#let spec_section = "spec section"
#let engineer = "engineer"
#let contractor = "contractor"

#set text(
  size: 14pt,
  font: "Times New Roman"
)

#set page(
  header: [
    #image("./images/SL_Header.png", width: 100%)
  ],
  footer: [
    #image("./images/SL_Footer.png", width: 100%)
  ],
  paper: "us-letter",
  margin: (top: 2in, bottom: 2in)
)

#set par(
  justify: true
)

\

#align(center)[
  #upper[#project] \

  #upper[#purpose] \

  #upper[#spec_section]
]

#align(center + horizon)[
  #datetime.today().display("[month repr:long] [day], [year]")
]

#align(bottom)[
ENGINEER: #upper[#engineer]

CONTRACTOR: #upper[#contractor]
]
