# mutate_result_states.R
#
# Henri Kauhanen 2020
#
# Reclassify result state terms as simple state terms if they are input to, equipollent to,
# or labile with any other form in the paradigm.


mutate_result_states <- function(data) {
  for (i in 1:nrow(data)) {
    if (data[i,]$Result.State != "") {
      if (grepl(pattern="[iel]", data[i,]$Result.State.Code)) {
        data[i,]$Simple.State <- data[i,]$Result.State
      }
    }
  }
  data
}
