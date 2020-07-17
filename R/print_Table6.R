# print_Table6.R
#
# Henri Kauhanen 2020
#
# Get numbers of PC and result roots per language, as well as proportion of paradigms
# which are marked according to markedness interpretation A, for each language, and
# compute the index RR/PC, and print these results out as a TeX tabular. 


print_Table6 <- function(datafile = "../data/prepared.RData",
                         typofile = "../results/typology_wo_hyps.csv",
                         folder = "../tables",
                         documentclass = FALSE) {
  load(datafile) # object named 'data'

  df <- data$wo_hyps$markedness_A

  out <- data.frame(Language=unique(df$Language), no_PC=NA, no_RR=NA, marked_PC=NA, prop_marked_PC=NA, marked_RR=NA, prop_marked_RR=NA, RRPC=NA)

  out$Language <- factor2character(out$Language)

  for (i in 1:nrow(out)) {
    dfhere <- df[df$Language==out[i,]$Language, ]

    out[i, ]$no_PC <- nrow(dfhere[dfhere$Root.Class == "property concept", ])
    out[i, ]$marked_PC <- nrow(dfhere[dfhere$Root.Class == "property concept" & dfhere$ParadigmMarked == "marked", ])
    out[i, ]$prop_marked_PC <- out[i,]$marked_PC/out[i,]$no_PC

    out[i, ]$no_RR <- nrow(dfhere[dfhere$Root.Class == "result roots", ])
    out[i, ]$marked_RR <- nrow(dfhere[dfhere$Root.Class == "result roots" & dfhere$ParadigmMarked == "marked", ])
    out[i, ]$prop_marked_RR <- out[i,]$marked_RR/out[i,]$no_RR

    out[i, ]$RRPC <- out[i, ]$prop_marked_RR/out[i, ]$prop_marked_PC
  }

  # fold Inf in with NaN
  out$RRPC <- ifelse(!is.finite(out$RRPC), NaN, out$RRPC)

  # order according to RR/PC index
  out <- out[order(out$RRPC, decreasing=TRUE), ]

  # take care of boldface and italics
  out$OrigLanguage <- out$Language
  out$Language <- factor2character(out$Language)
  for (i in 1:nrow(out)) {
    out[i,]$Language <- ifelse(!is.nan(out[i,]$RRPC) && out[i,]$RRPC > 1.2, paste0("\\textbf{", out[i,]$Language, "}"), out[i,]$Language)
    out[i,]$Language <- ifelse(out[i,]$no_RR < 12 || out[i,]$no_PC < 12, paste0("\\emph{", out[i,]$Language, "}"), out[i,]$Language)
  }

  # add diacritics
  typology <- read.csv(typofile)
  for (i in 1:nrow(out)) {
    lang <- out[i,]$OrigLanguage
    typo <- typology[typology$Language==lang, ]
    if (typo$Und >= 0.6666 || typo$Equi >= 0.6666) {
      out[i,]$Language <- paste0(out[i,]$Language, "*")
    }
    mPC <- out[i,]$prop_marked_PC
    mRR <- out[i,]$prop_marked_RR
    if (!is.nan(mPC) && !is.nan(mRR)) {
      if (mPC <= 0.3333 && out[i,]$prop_marked_RR <= 0.3333) {
        out[i,]$Language <- paste0(out[i,]$Language, "$\\dagger$")
      }
    }
  }

  # latex troubleshooting
  out$Language <- stringr::str_replace_all(out$Language, pattern="m̃", replacement="\\\\~{m}")

  # divide 'out' in two for printing purposes
  out1 <- out[1:44, ]
  out2 <- out[45:88, ]

  # print out
  file <- paste0(folder, "/table-markedness-by-language.tex")
  sink(file)

  if (documentclass) {
    cat("\\documentclass{standalone}\n")
    cat("\\begin{document}\n")
  }

  cat("\\begin{tabular}{cccccccccccc}\n")
  cat(" & \\multicolumn{2}{c}{\\underline{\\textbf{\\# Verb paradigms}}} & \\multicolumn{3}{c}{\\underline{\\textbf{\\% Markedness}}} & & \\multicolumn{2}{c}{\\underline{\\textbf{\\# Verb paradigms}}} & \\multicolumn{3}{c}{\\underline{\\textbf{\\% Markedness}}} \\\\\n")
  tocat <- c("Language", "PC", "RR", "PC", "RR", "RR/PC", "Language", "PC", "RR", "PC", "RR", "RR/PC")
  tocat <- paste0("\\underline{\\textbf{", tocat, "}}")
  tocat <- paste(tocat, collapse=" & ")
  cat(tocat)

  for (r in 1:44) {
    cat(" \\\\\n")
    cat(as.character(out1[r,]$Language))
    cat(" & ")
    cat(out1[r,]$no_PC)
    cat(" & ")
    cat(out1[r,]$no_RR)
    cat(" & ")
    tocat <- ifelse(is.nan(out1[r,]$prop_marked_PC), "---", prettyround(100*out1[r,]$prop_marked_PC))
    cat(tocat)
    cat(" & ")
    tocat <- ifelse(is.nan(out1[r,]$prop_marked_RR), "---", prettyround(100*out1[r,]$prop_marked_RR))
    cat(tocat)
    cat(" & ")
    tocat <- ifelse(is.nan(out1[r,]$RRPC), "---", prettyround(out1[r,]$RRPC))
    cat(tocat)
    cat(" & ")
    cat(as.character(out2[r,]$Language))
    cat(" & ")
    cat(out2[r,]$no_PC)
    cat(" & ")
    cat(out2[r,]$no_RR)
    cat(" & ")
    tocat <- ifelse(is.nan(out2[r,]$prop_marked_PC), "---", prettyround(100*out2[r,]$prop_marked_PC))
    cat(tocat)
    cat(" & ")
    tocat <- ifelse(is.nan(out2[r,]$prop_marked_RR), "---", prettyround(100*out2[r,]$prop_marked_RR))
    cat(tocat)
    cat(" & ")
    tocat <- ifelse(is.nan(out2[r,]$RRPC), "---", prettyround(out2[r,]$RRPC))
    cat(tocat)
  }

  cat("\n\\end{tabular}")

  if (documentclass) {
    cat("\n\\end{document}")
  }

  sink()
}
