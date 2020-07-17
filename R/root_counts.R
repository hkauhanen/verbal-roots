# root_counts.R
#
# Henri Kauhanen 2020
#
# Calculate some basic statistics about the data: how many PC and result roots there are,
# how many cells in paradigms are filled, how many hypothetical forms there are, etc.
# Pipe this information to a text file.


root_counts <- function(datafile = "../data/prepared.RData",
                        outfile = "../stats/root-counts.txt") {
  load(datafile) # object named 'data'

  # basic stuff
  plain <- data$wo_hyps$plain
  no_PC_roots <- nrow(plain[plain$Root.Class == "property concept", ])
  no_result_roots <- nrow(plain[plain$Root.Class == "result roots", ])
  no_paradigms <- nrow(plain)
  no_possible_forms <- 5*no_paradigms

  # recorded non-hypothetical forms
  relevant_cols <- c("Underlying.Root", "Simple.State", "Causative", "Inchoative", "Result.State")
  no_forms <- 0
  for (col in relevant_cols) {
    no_forms <- no_forms + sum(plain[[col]] != "")
  }

  # number of hypothetical forms
  hyps <- data$with_hyps$plain
  no_hypotheticals <- 0
  for (col in relevant_cols) {
    no_hypotheticals <- no_hypotheticals + sum(grepl(pattern="^@", hyps[[col]]))
  }

  # number of PC and result roots when only one synonym is chosen per language
  no_PC_roots_onesyn <- 0
  no_result_roots_onesyn <- 0
  for (root in unique(plain$Root)) {
    for (lang in unique(plain$Language)) {
      df <- plain[plain$Root==root & plain$Language==lang, ]
      if (nrow(df) > 0) {
        if (df[1, ]$Root.Class == "property concept") {
          no_PC_roots_onesyn <- no_PC_roots_onesyn + 1
        } else if (df[1, ]$Root.Class == "result roots") {
          no_result_roots_onesyn <- no_result_roots_onesyn + 1
        }
      }
    }
  }

  # writeout
  con <- file(outfile, "w")
  writeLines(paste("Number of PC roots with data:", no_PC_roots), con)
  writeLines(paste("Number of result roots with data:", no_result_roots), con)
  writeLines(paste("Number of paradigms with data:", no_paradigms), con)
  writeLines(paste("Number of possible forms:", no_possible_forms), con)
  writeLines(paste("Number of attested forms:", no_forms), con)
  writeLines(paste("Number of hypothetical forms:", no_hypotheticals), con)
  writeLines(paste("Number of PC roots, when only one synonym considered per language:", no_PC_roots_onesyn), con)
  writeLines(paste("Number of result roots, when only one synonym considered per language:", no_result_roots_onesyn), con)
  close(con)
}
