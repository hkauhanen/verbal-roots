# ignore_diacritics.R (forked from print_Table6.R)
#
# Henri Kauhanen 2020
#
# Drop those languages from the data set that have an asterisk or dagger in Table 6
# (i.e. labile and equipollent ones). Called from 'prepare_data_ignore_diacritics.R'.
#
# Note that the version of the data analysis which does NOT drop these
# languages will need to have been conducted first ('datafile' argument).


ignore_diacritics <- function(dataset,
                              datafile = "../data/prepared.RData",
                              typofile = "../results/typology_wo_hyps.csv") {
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

  # add diacritics
  out$asterisk <- FALSE
  out$dagger <- FALSE
  typology <- read.csv(typofile)
  for (i in 1:nrow(out)) {
    lang <- out[i,]$Language
    typo <- typology[typology$Language==lang, ]
    if (typo$Und >= 0.6666 || typo$Equi >= 0.6666) {
      out[i,]$asterisk <- TRUE
    }
    mPC <- out[i,]$prop_marked_PC
    mRR <- out[i,]$prop_marked_RR
    if (!is.nan(mPC) && !is.nan(mRR)) {
      if (mPC <= 0.3333 && out[i,]$prop_marked_RR <= 0.3333) {
        out[i,]$dagger <- TRUE
      }
    }
  }

  no_diacritic_languages <- out[!out$asterisk & !out$dagger, ]$Language
  dataset <- dataset[dataset$Language %in% no_diacritic_languages, ]
  dataset
}
