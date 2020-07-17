# print_Table12.R
#
# Henri Kauhanen 2020
#
# Print out the typology magic.


print_Table12 <- function(typofile = "../results/typology_wo_hyps.csv",
                          folder = "../tables",
                          documentclass = FALSE) {
  out <- read.csv(typofile)

  # latex troubleshooting
  out$Language <- factor2character(out$Language)
  out$Language <- stringr::str_replace_all(out$Language, pattern="m̃", replacement="\\\\~{m}")

  # divide 'out' in two for printing purposes
  out1 <- out[1:44, ]
  out2 <- out[45:88, ]

  # print out
  file <- paste0(folder, "/table-typology.tex")
  sink(file)

  if (documentclass) {
    cat("\\documentclass{standalone}\n")
    cat("\\begin{document}\n")
  }

  cat("\\begin{tabular}{cccccccccccc}\n")
  tocat <- c("Language", "\\# Roots", "\\% Und", "\\# Pairs", "\\%Equi", "\\% ND")
  tocat <- c(tocat, tocat)
  tocat <- paste0("\\underline{\\textbf{", tocat, "}}")
  tocat <- paste(tocat, collapse=" & ")
  cat(tocat)

  for (r in 1:44) {
    cat(" \\\\\n")

    cat(as.character(out1[r,]$Language))
    cat(" & ")
    cat(out1[r,]$Roots)
    cat(" & ")
    cat(prettyround(100*out1[r,]$Und))
    cat(" & ")
    cat(out1[r,]$Pairs)
    cat(" & ")
    cat(prettyround(100*out1[r,]$Equi))
    cat(" & ")
    cat(prettyround(100*out1[r,]$ND))
    cat(" & ")

    cat(as.character(out2[r,]$Language))
    cat(" & ")
    cat(out2[r,]$Roots)
    cat(" & ")
    cat(prettyround(100*out2[r,]$Und))
    cat(" & ")
    cat(out2[r,]$Pairs)
    cat(" & ")
    cat(prettyround(100*out2[r,]$Equi))
    cat(" & ")
    cat(prettyround(100*out2[r,]$ND))
  }

  cat("\n\\end{tabular}")

  if (documentclass) {
    cat("\n\\end{document}")
  }

  sink()
}
