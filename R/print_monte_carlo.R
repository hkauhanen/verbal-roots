# print_monte_carlo.R
#
# Henri Kauhanen 2016-2020
#
# Makes the violinplots for Monte Carlo runs, and spits out minimum and maximum p-values.


print_monte_carlo <- function(results = "../results/monte_carlo.RData",
                              family = "Times",
                              outfolder = "../plots",
                              outfolder_pvalues = "../stats",
                              pngheight = 500,
                              pngwidth = 2000,
                              pngres = 330,
                              littleboxheight = 1.5,
                              littleboxwidth = 6,
                              bigboxheight = 6,
                              bigboxwidth = 6) {
  load(results) # an object named 'res_MC'

  for (outname in names(res_MC[[1]])) {
    for (inname in names(res_MC[[1]][[outname]])) {
      # Monte Carlo distributions
      #filename <- paste(outfolder, "/", "montecarlo-all-", inname, "-", outname, ".pdf", sep="")
      filename <- paste(outfolder, "/", "montecarlo-all-", inname, "-", outname, ".png", sep="")
      filename <- stringr::str_replace_all(filename, pattern="_", replacement="-")
      #pdf(filename, height=littleboxheight, width=littleboxwidth, family=family)
      png(filename, height=pngheight, width=pngwidth, family=family, res=pngres)
      plot_monte_carlo_all(res_MC, hyps=outname, which=inname)
      dev.off()

      # Median distributions
      #filename <- paste(outfolder, "/", "montecarlo-medians-", inname, "-", outname, ".pdf", sep="")
      filename <- paste(outfolder, "/", "montecarlo-medians-", inname, "-", outname, ".png", sep="")
      filename <- stringr::str_replace_all(filename, pattern="_", replacement="-")
      #pdf(filename, height=littleboxheight, width=littleboxwidth, family=family)
      png(filename, height=pngheight, width=pngwidth, family=family, res=pngres)
      medians <- plot_monte_carlo_medians(res_MC, hyps=outname, which=inname)
      dev.off()

      # Min and max p-values
      filename <- paste0(outfolder_pvalues, "/", "montecarlo-pvalues-", inname, "-", outname, ".txt")
      filename <- stringr::str_replace_all(filename, pattern="_", replacement="-")
      con <- file(filename, "w")
      writeLines(paste(inname, outname, sep=", "), con)
      writeLines(paste("Min. p-value:", min(medians$pvalues$pvalue)), con)
      writeLines(paste("Max. p-value:", max(medians$pvalues$pvalue)), con)
      close(con)
    }
  }
}


