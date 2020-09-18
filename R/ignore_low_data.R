# ignore_low_data.R (forked from print_Table6.R)
#
# Henri Kauhanen 2020
#
# Drop low data languages from the data set. This routine is called from
# 'prepare_data_ignore_low.R'.
#
# Note that the version of the data analysis which does NOT drop these 
# languages will need to have been conducted first ('datafile' argument).


ignore_low_data <- function(dataset,
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

  out <- out[out$no_RR >= 12 & out$no_PC >= 12, ]
  high_data_lges <- out$Language

  dataset <- dataset[dataset$Language %in% high_data_lges, ]
  dataset
}
