# print_violinplots()
#
# Henri Kauhanen 2016-2020
#
# Makes the violinplots for everything.


print_violinplots <- function(results = "../results/filled_counts.RData",
                              family = "Times",
                              outfolder = "../plots",
                              littleboxheight = 1.5,
                              littleboxwidth = 6,
                              bigboxheight = 6,
                              bigboxwidth = 6) {
  load(results) # an object named 'res'

  for (outname in names(res)) {
    for (inname in names(res[[outname]])) {
      filename <- paste(outfolder, "/", "boxplot-", inname, "-", outname, ".pdf", sep="")
      filename <- stringr::str_replace_all(filename, pattern="_", replacement="-")
      pdf(filename, height=littleboxheight, width=littleboxwidth, family=family)
      violinplot_by_root_class(res[[outname]][[inname]])
      dev.off()
      filename <- paste(outfolder, "/", "boxplot-subclass-", inname, "-", outname, ".pdf", sep="")
      filename <- stringr::str_replace_all(filename, pattern="_", replacement="-")
      pdf(filename, height=bigboxheight, width=bigboxwidth, family=family)
      violinplot_by_narrow_root_class(res[[outname]][[inname]])
      dev.off()
    }
  }
}


