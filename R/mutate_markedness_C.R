# mutate_markedness_C.R
#
# Henri Kauhanen 2020
#
# Like mutate_markedness_A, but assume that all missing verb forms are unmarked.


mutate_markedness_C <- function(data) {
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

    if (data[i,]$Inchoative == "") {
      data[i,]$Inchoative <- "DUMMY" # to make it not empty
      inchoative_marked <- FALSE
    }
    if (data[i,]$Causative == "") {
      data[i,]$Causative <- "DUMMY" # to make it not empty
      causative_marked <- FALSE
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
