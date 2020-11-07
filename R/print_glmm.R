require(lme4)
require(stringr)

print_glmm <- function(data_objects = "../data/prepared.RData",
                       outfolder = "../stats") {
  # Load data objects
  load(data_objects)

  for (hypocond in names(data)) {
    for (mutation in names(data[[hypocond]])) {
      hc <- str_replace_all(hypocond, pattern="_", replacement="-")
      mn <- str_replace_all(mutation, pattern="_", replacemen="-")
      sink(paste0(outfolder, "/glmm-", mn, "-", hc, ".txt"))
      df <- data[[hypocond]][[mutation]]
      if (mutation %in% c("plain", "morphology_corrected")) {
        df$DV <- ifelse(df$Simple.State=="", 0, 1)
      } else {
        df$DV <- ifelse(df$ParadigmMarked=="", 0, 1)
      }
      model <- glmer(DV~Root.Class+(1|Language)+(1|Root), df, family=binomial)
      print(summary(model))
      sink()
    }
  }
}

