# debug_classes.R
#
# Henri Kauhanen 2020
#
# Find instances of paradigms where (narrow) root class has been incorrectly coded. Prints the
# numbers of rows where something is likely to be fishy.


debug_classes <- function(data) {
  for (root in unique(data$Root)) {
    rc <- unique(data[data$Root==root, ]$Root.Class)
    nrc <- unique(data[data$Root==root, ]$Narrow.Root.Class)

    if (length(rc) > 1) {
      rc_tokens <- rep(NA, length(rc))
      for (i in 1:length(rc)) {
        rc_tokens[i] <- nrow(data[data$Root==root & data$Root.Class==rc[i], ])
      }
      print(rownames(data[data$Root==root & data$Root.Class==rc[which.min(rc_tokens)], ]))
    }

    if (length(nrc) > 1) {
      nrc_tokens <- rep(NA, length(nrc))
      for (i in 1:length(nrc)) {
        nrc_tokens[i] <- nrow(data[data$Root==root & data$Narrow.Root.Class==nrc[i], ])
      }
      print(rownames(data[data$Root==root & data$Narrow.Root.Class==nrc[which.min(nrc_tokens)], ]))
    }
  }
}
