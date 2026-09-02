#let gen_ups_load_table(ups_components, ups_va_cap, ups_runtime) = {
  underline[UPS sizing calculations]
  linebreak()
  linebreak()

  let total_power_draw = ups_components.values().reduce((acc, v) => float(v) + float(acc))

  table(
    columns: (75%, 25%),
    align: (left, center),
    stroke: (x, y) => if y == 0 or (x == 1 and y == ups_components.len()) { (bottom: 1pt) } else { none },
    table.header([Description], [Power Draw #linebreak() (VA)]),
    ..ups_components.pairs().flatten(),
    table.cell(align: right, [Total Power Draw (VA)]), [#total_power_draw],
  )

  list(
    indent: 1em,
  )[$"Total Power Usage" = #total_power_draw$VA. According to the run time chart at #total_power_draw VA, the UPS will run for #ups_runtime minutes.]
}
