# rm_classes.R
#
# Henri Kauhanen 2020
#
# Remove root classes we don't want to include in the analyses.


rm_classes <- function(data) {
  data[!(data$Narrow.Root.Class %in% c("human propensity")), ]
}
