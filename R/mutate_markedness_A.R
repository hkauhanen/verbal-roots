# mutate_markedness_A.R
#
# Henri Kauhanen 2020
#
# A verb form (causative/inchoative) is considered marked iff it is overtly derived from or
# equipollent to something else in its paradigm. A paradigm is considered marked if both
# verb forms exist and both forms are marked. A paradigm is considered unmarked if at least one
# verb form is unmarked. If only one form exists, we ignore the paradigm. If neither verb exists,
# we ignore the paradigm.


mutate_markedness_A <- function(data) {
  data$ParadigmMarked <- NA
  ignores <- NULL

  for (i in 1:nrow(data)) {
    # Markedness of verb forms
    inchoative_marked <- FALSE
    causative_marked <- FALSE
    if (grepl(pattern="[de]", data[i,]$Inchoative.Code)) {
      inchoative_marked <- TRUE
    }
    if (grepl(pattern="[de]", data[i,]$Causative.Code)) {
      causative_marked <- TRUE
    }

    # Paradigm markedness
    paradigm_marked <- FALSE
    if (data[i,]$Inchoative != "" && data[i,]$Causative != "") {
      if (inchoative_marked && causative_marked) {
        paradigm_marked <- TRUE
      }
    } else if (data[i,]$Inchoative == "" && data[i,]$Causative != "") {
      if (causative_marked) {
        ignores <- c(ignores, i)
      }
    } else if (data[i,]$Inchoative != "" && data[i,]$Causative == "") {
      if (inchoative_marked) {
        ignores <- c(ignores, i)
      }
    } else if (data[i,]$Inchoative == "" && data[i,]$Causative == "") {
      ignores <- c(ignores, i)
    }

    if (paradigm_marked) {
      data[i,]$ParadigmMarked <- "marked"
    } else {
      data[i,]$ParadigmMarked <- ""
    }
  }

  if (!is.null(ignores)) {
    data <- data[-ignores, ]
  }
  data
}
