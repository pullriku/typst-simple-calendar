#import "/src/lib.typ" as lib: full_area, half_area, single_image, double_image, quadruple_image

#set page(margin: 0pt)
#set text(font: "Noto Sans JP")

#let lake = "/examples/calendar1/images/lake.jpeg"
#let sunset = "/examples/calendar1/images/sunset.jpeg"

#lib.month_calendar(
  2025,
  10,
  half_area(single_image(lake)),
)
#lib.month_calendar(
  2025,
  11,
  full_area(single_image(sunset)),
)

#lib.month_calendar(
  2025, 
  12,
  half_area(double_image(lake, sunset)))
)
