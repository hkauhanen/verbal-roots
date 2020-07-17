# print_tests.R
#
# Henri Kauhanen 2016-2020
#
# Print the results of statistical tests.


print_tests <- function(results = "../results/filled_counts.RData",
                        outfolder = "../stats",
                        pvalue = 0.001) {
  load(results) # an object named 'res'

  # loop through with_hyps and no_hyps
  for (outname in names(res)) {
    # loop through all different data mutations
    for (inname in names(res[[outname]])) {
      thisdat <- res[[outname]][[inname]]
      thisdat$filled_prop <- thisdat$PropFilled
      PCs <- thisdat[thisdat$Root.Class == "property concept", ]
      rrs <- thisdat[thisdat$Root.Class == "result roots", ]
      n1 <- nrow(PCs)
      n2 <- nrow(rrs)
      filename <- paste(outfolder, "/", "stats-", inname, "-", outname, ".txt", sep="")
      filename <- stringr::str_replace_all(filename, pattern="_", replacement="-")
      con <- file(filename, "w")

      # Medians and means
      writeLines("Medians", con)
      writeLines("-------\n", con)
      writeLines(paste("PC roots:\t", median(PCs$filled_prop), " (", round(100*median(PCs$filled_prop), 2), "%)", sep=""), con)
      writeLines(paste("result roots:\t", median(rrs$filled_prop), " (", round(100*median(rrs$filled_prop), 2), "%)", sep=""), con)
      writeLines("\n", con)
      writeLines("Means", con)
      writeLines("-----\n", con)
      writeLines(paste("PC roots:\t", mean(PCs$filled_prop), sep=""), con)
      writeLines(paste("result roots:\t", mean(rrs$filled_prop), sep=""), con)
      writeLines("\n", con)

      # two-tailed test
      testres <- mann_whitney_U(res[[outname]][[inname]], alternative="two.sided")
      writeLines("Mann-Whitney U-test (two-tailed)", con)
      writeLines("-------------------------------\n", con)
      writeLines("Null hypothesis: The distribution of PC roots is not different from the distribution of result roots\n", con)
      writeLines(paste("U = ", testres$statistic, sep=""), con)
      writeLines(paste("n1 = ", n1, sep=""), con)
      writeLines(paste("n2 = ", n2, sep=""), con)
      writeLines(paste("p = ", testres$p.value, sep=""), con)
      if (testres$p.value < pvalue) {
        decision <- "Reject"
      } else {
        decision <- "Do not reject"
      }
      writeLines(paste("Decision (at the p < ", pvalue, " level): ", decision, " null hypothesis", sep=""), con)
      writeLines("\n", con)

      # one-tailed test, "greater"
      testres <- mann_whitney_U(res[[outname]][[inname]], alternative="greater")
      writeLines("Mann-Whitney U-test (one-tailed in the expected direction)", con)
      writeLines("----------------------------------------------------------\n", con)
      writeLines("Null hypothesis: The distribution of PC roots is not higher than (not shifted towards 1 relative to) the distribution of result roots\n", con)
      writeLines(paste("U = ", testres$statistic, sep=""), con)
      writeLines(paste("n1 = ", n1, sep=""), con)
      writeLines(paste("n2 = ", n2, sep=""), con)
      writeLines(paste("p = ", testres$p.value, sep=""), con)
      if (testres$p.value < pvalue) {
        decision <- "Reject"
      } else {
        decision <- "Do not reject"
      }
      writeLines(paste("Decision (at the p < ", pvalue, " level): ", decision, " null hypothesis", sep=""), con)
      writeLines("\n", con)

      # one-tailed test, "less"
      testres <- mann_whitney_U(res[[outname]][[inname]], alternative="less")
      writeLines("Mann-Whitney U-test (one-tailed in the unexpected direction)", con)
      writeLines("------------------------------------------------------------\n", con)
      writeLines("Null hypothesis: The distribution of PC roots is not lower than (not shifted towards 0 relative to) the distribution of result roots\n", con)
      writeLines(paste("U = ", testres$statistic, sep=""), con)
      writeLines(paste("n1 = ", n1, sep=""), con)
      writeLines(paste("n2 = ", n2, sep=""), con)
      writeLines(paste("p = ", testres$p.value, sep=""), con)
      if (testres$p.value < pvalue) {
        decision <- "Reject"
      } else {
        decision <- "Do not reject"
      }
      writeLines(paste("Decision (at the p < ", pvalue, " level): ", decision, " null hypothesis", sep=""), con)
      writeLines("\n", con)

      close(con)
    }
  }
}


