# print_tables.R
#
# Print some tables for the appendix.
#
# Henri Kauhanen 2018-2020


print_tables <- function(results = "../results/filled_counts.RData",
                         folder = "../tables",
                         documentclass = FALSE) {
  require(stringr)
  load(results) # object named 'res'

  for (outername in names(res)) {
    for (innername in names(res[[outername]])) {
      if (innername %in% c("plain", "morphology_corrected")) {
        which <- "simple"
      } else {
        which <- "verbal"
      }

      df <- res[[outername]][[innername]]

      file <- paste0(folder, "/table-", innername, "-", outername, ".tex")
      file <- stringr::str_replace_all(file, pattern="_", replacement="-")

      df$rc <- df$Root.Class
      df$root <- df$Root

      PC <- df[df$rc=="property concept", ]
      RR <- df[df$rc=="result roots", ]
      #PC$root <- str_extract(PC$root, pattern="^[^/]*")
      #RR$root <- str_extract(RR$root, pattern="/[a-z]*")
      #RR$root <- str_extract(RR$root, pattern="[a-z]*$")
      #PC[PC$root=="aged", ]$root <- "old"
      #RR[RR$root=="came", ]$root <- "come"
      #RR[RR$root=="killed", ]$root <- "kill"
      PC <- PC[order(PC$root), ]
      RR <- RR[order(RR$root), ]

      if (nrow(PC) != nrow(RR)) {
        warning("Numbers of PCs and RRs differ")
      }

      sink(file)
      if (documentclass) {
        cat("\\documentclass{standalone}\n")
        cat("\\begin{document}\n")
      }
      cat("\\begin{tabular}{p{3cm}ccccp{3cm}ccc}\n")
      if (which == "simple") {
        cat("\\underline{\\textbf{PC root}} & \\underline{\\textbf{\\#states}} & \\underline{\\textbf{\\#languages}} & \\underline{\\textbf{attested}} & & \\underline{\\textbf{Result root}} & \\underline{\\textbf{\\#states}} & \\underline{\\textbf{\\#languages}} & \\underline{\\textbf{attested}}")
      } else if (which == "verbal") {
        cat("\\underline{\\textbf{PC root}} & \\underline{\\textbf{\\#marked}} & \\underline{\\textbf{\\#languages}} & \\underline{\\textbf{marked}} & & \\underline{\\textbf{Result root}} & \\underline{\\textbf{\\#marked}} & \\underline{\\textbf{\\#languages}} & \\underline{\\textbf{marked}}")
      } else {
        stop("Invalid value of which")
      }
      for (r in 1:max(c(nrow(PC), nrow(RR)))) {
        cat(" \\\\\n")
        cat(as.character(PC[r,]$root))
        cat(" & ")
        cat(PC[r,]$Filled)
        cat(" & ")
        cat(PC[r,]$Total)
        cat(" & ")
        cat(paste0(sprintf("%.2f", round(100*PC[r,]$PropFilled, 2)), "\\%"))
        cat(" & & ")
        cat(as.character(RR[r,]$root))
        cat(" & ")
        cat(RR[r,]$Filled)
        cat(" & ")
        cat(RR[r,]$Total)
        cat(" & ")
        cat(paste0(sprintf("%.2f", round(100*RR[r,]$PropFilled, 2)), "\\%"))
      }
      cat("\n\\end{tabular}")
      if (documentclass) {
        cat("\n\\end{document}")
      }
  sink()
    }
  }
}

