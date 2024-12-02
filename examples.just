import "./dirs.just"

all-examples: calendar1 calendar2

# examples compilation
calendar1: examples
    typst compile {{typst_flags}} examples/calendar1/calendar1.typ dist/examples/calendar1.pdf

calendar2: examples
    typst compile {{typst_flags}} examples/calendar2/calendar2.typ dist/examples/calendar2.pdf
