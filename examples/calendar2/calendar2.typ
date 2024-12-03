#import "/src/lib.typ" as lib: full_area, half_area, single_image, double_image, quadruple_image

#set page(margin: 0pt)

#let lake = "/examples/calendar2/images/lake.jpeg"
#let sunset = "/examples/calendar2/images/sunset.jpeg"

#lib.year_calendar(
  2025,
  font: "Noto Sans JP",
  images: (
    half_area(single_image(lake)),
    full_area(single_image(sunset)),
    half_area(double_image(lake, sunset)),
    full_area(double_image(lake, sunset)),
    half_area(quadruple_image(lake, sunset, lake, sunset)),
    full_area(quadruple_image(lake, sunset, lake, sunset)),
  ),
)
