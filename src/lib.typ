#let weekday_names = ([日], [月], [火], [水], [木], [金], [土])

#let read_syukujitsu_csv() = {
  let csv = csv("/syukujitsu.csv")
  let result = (:)
  for row in csv {
    result.insert(row.at(0), row.at(1))
  }
  result
}

#let month_calendar_table(year, month, holiday_data: (:), weekday_names:weekday_names) = {
  let month_date = datetime(
    year: year,
    month: month,
    day: 1,
  )

  let monthly_days = ()

  for day in range(0, 31) {
    let day = month_date + duration(days: day)
    if day.month() != month {
      break
    }
    monthly_days.push(day)
  }

  let monday_padding = calc.rem-euclid(
    int(monthly_days.first().display("[weekday repr:monday]")),
    7
  )

  let cal_grid = grid(
    columns: (1fr,) * 7,
    rows: (3em,) + (5.5em,) * 6,
    inset: 1em,
    // fill: rgb(200, 200, 255),
    // fill: rgb(255, 255, 255, 80%),
    ..weekday_names.map(name => {
      let color = if name == [日] {
          red
      } else if name == [土] {
          blue
      } else {
          black
      }
      let result = place(top + center)[
        #text(name, fill: color, size: 1.5em, weight: "black")
      ]
      grid.cell(result, stroke: (bottom: 1pt))
    }),
    ..range(0, monday_padding).map(_ => []),
    ..monthly_days.map(day => {
      let holiday_name = holiday_data.at(day.display("[year]/[month padding:none]/[day padding:none]"), default: "")
      let holiday_name =  if holiday_name == "" {
        holiday_data.at(day.display("[year]-[month padding:none]-[day padding:none]"), default: "")
      } else {
        holiday_name
      }

      let color = if holiday_name != "" {
        // green
        // rgb("#207ef2c")
        rgb("#00B000")
      } else if day.weekday() == 6 {
        blue
      } else if day.weekday() == 7 {
        red
      }  else {
        black
      }
      let day_num = day.display("[day padding:none]")
      place(top + left)[
        #text(fill: color, size: 1.5em, weight: "bold")[
          #day_num 
        ]
        #linebreak()
        #text(fill: color, size: 0.8em, weight: "bold")[
          #holiday_name
        ]
      ]
    })
  )

  rect(inset: 0.5pt, radius: 10pt, fill: rgb(255, 255, 255, 80%),)[#cal_grid]
}

#let month_calendar(year, month, image, holiday_data: (:), weekday_names: weekday_names) = {
  box(clip: true)[
    // #quadruple_image("/1.jpeg", "/1.jpeg", "/1.jpeg", "/1.jpeg")
    // #double_image("/1.jpeg", "/tate.jpeg")
    // #single_image("/fish.jpeg")
    // #half_area(single_image("/fish.jpeg"))
    // #image("/1.jpeg", width: 50%, height: 50%, fit: "cover")
    // #images.at(month - 1, default: half_area(single_image("/1.jpeg")))
    #image
  ]

  v(1fr)
  place(bottom)[
    #box(height: 50%, width: 100%)[
    #place(top + left)[
    #pad(1em)[
      #month_calendar_table(year, month, holiday_data: holiday_data, weekday_names: weekday_names)
    ]
  ]
  ]
  ]
  v(1fr)

  place(horizon + right, dy: -7.3%, dx: -1.5em)[
    #text(size: 7em, weight: "black", fill: white)[#month 月]
  ]

  place(bottom + center, dy: -2em)[
    #text()[
      #year 年カレンダー
    ]
  ]
}

#let quadruple_image(path1, path2, path3, path4) = {
  grid(
    columns: (1fr, 1fr),
    rows: (1fr, 1fr),
    image(path1, width: 100%, height: 100%, fit: "cover"),
    image(path2, width: 100%, height: 100%, fit: "cover"),
    image(path3, width: 100%, height: 100%, fit: "cover"),
    image(path4, width: 100%, height: 100%, fit: "cover"),
  )
}

#let double_image(path1, path2) = {
  grid(
    columns: (1fr, 1fr),
    image(path1, width: 100%, height: 100%, fit: "cover"),
    image(path2, width: 100%, height: 100%, fit: "cover"),
  )
}
#let single_image(path) = {
    image(path, width: 100%, height: 100%, fit: "cover")
}

#let vstack(content) = {
  stack(
    dir: ttb,
    spacing: none,
    content,
  )
}

#let half_area(grid) = {
  box(height: 50%)[
    #grid
  ]
}

#let full_area(grid) = {
  box(height: 100%)[
    #grid
  ]
}

#let year_calendar(
  year, 
  months: range(1, 12 + 1),
  font: "",
  images: (),
  weekday_names: weekday_names,
  holiday_data: read_syukujitsu_csv(),
) = [
  #set text(font: font)
  #set page(margin: 0pt)
  #show box: it => align(it, center)

  #for month in months [
    #month_calendar(year, month, images.at(month - 1, default: half_area(single_image("/1.jpeg"))), holiday_data: holiday_data, weekday_names: weekday_names)

    #pagebreak(weak: true)
  ]

]
