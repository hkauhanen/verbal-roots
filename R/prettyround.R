# prettyround.R
#
# Henri Kauhanen 2020
#
# Round a figure nicely for printing purposes, retaining all zeroes.


prettyround <- function(x,
                        digits = 2) {
  sprintf("%.2f", round(x, digits))
}
