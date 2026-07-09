#let gen_load_calc_table(pws_tags, pws_current_cap, pws_components) = {
  underline[Power supply load calculations] 
  linebreak()
  linebreak()

  if pws_tags.len() > 1 {
    let desc = ""

    for (i, tag) in pws_tags.enumerate() {
        //second to last tag in array
        if i == 0 {
          desc += tag + ", "
        }  else if i == 1{
          desc += tag
        } else if i == pws_tags.len() -1 {
          desc += " and " + tag
        } else {
         desc += ", " + tag 
        }    
      }
      
    [#desc are redundant]
  }

  let total_current_draw = pws_components.values().reduce((acc, v) => float(v) + float(acc))

  table(
    columns: (75%, 25%),
    align: (left, center),
    stroke: (x,y) => if y == 0 or (x == 1 and y == pws_components.len()) {(bottom: 1pt)} else {none},
    table.header([Description], [Current Draw #linebreak() (Amps)]),
    ..pws_components.pairs().flatten(),
    table.cell(align: right, [Total Current Draw]), [#total_current_draw]
  )

  let perc_use = float(total_current_draw)/float(pws_current_cap) * 100

  list(indent: 1em)[$"Total current capacity" = #total_current_draw/#pws_current_cap", "#perc_use% "used"$] 
}
