# column_filled.R
#
# Henri Kauhanen 2020
#
# Figures out the proportion of languages for which a specified column is filled (not equal to the
# empty string ""). For example, to get the proportion of languages for which a simple state exists,
# set col="Simple.State".


column_filled <- function(data,
                          col,
                          save_rownumbers = FALSE,
                          rownumberfile = "../results/wo_hyps_plain_row_numbers.csv") {
  roots <- unique(data$Root)
  out <- data.frame(Root=roots, Root.Class=NA, Narrow.Root.Class=NA, Filled=NA, Total=NA, PropFilled=NA)
  rownumbers <- NULL
  for (root in roots) {
    df <- data[data$Root==root, ]

    # We need to go language by language, in case a language has several synonyms
    # for the root
    languages <- unique(df$Language)
    filled <- 0
    total <- 0
    for (lang in languages) {
      total <- total + 1
      df2 <- df[df$Language==lang, ]

      # Pick a synonym at random
      df2 <- df2[sample(1:nrow(df2), size=1), ]
      if (save_rownumbers) {
        rownumbers <- c(rownumbers, rownames(df2))
      }

      # If filled, increment counter
      if (df2[[col]] != "") {
        filled <- filled + 1
      }
    }

    # Push result to data frame
    out[out$Root==root, ]$Root.Class <- df[1,]$Root.Class
    out[out$Root==root, ]$Narrow.Root.Class <- df[1,]$Narrow.Root.Class
    out[out$Root==root, ]$Filled <- filled
    out[out$Root==root, ]$Total <- total
    out[out$Root==root, ]$PropFilled <- filled/total
  }

  if (save_rownumbers) {
    write.csv(rownumbers, file=rownumberfile, row.names=FALSE)
  }

  out
}
