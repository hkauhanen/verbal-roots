# main_analysis.R
#
# Henri Kauhanen 2020
#
# Conduct the main analyses, both without and with hypotheticals (but not the Monte Carlo runs).


main_analysis <- function(outfile = "../results/filled_counts.RData",
                          data_objects = "../data/prepared.RData") {
  # Load data objects
  load("../data/prepared.RData")

  # Prepare results list
  res <- vector("list", 2)
  names(res) <- c("with_hyps", "wo_hyps")
  res$with_hyps <- vector("list", 6)
  names(res$with_hyps) <- c("plain", "morphology_corrected", "markedness_A", "markedness_B", "markedness_C", "markedness_D")
  res$wo_hyps <- vector("list", 6)
  names(res$wo_hyps) <- c("plain", "morphology_corrected", "markedness_A", "markedness_B", "markedness_C", "markedness_D")

  for (h in names(res)) {
    # Simple states analysis
    res[[h]]$plain <- column_filled(data[[h]]$plain, col="Simple.State", save_rownumbers=TRUE)

    # Result states as simple states analysis
    res[[h]]$morphology_corrected <- column_filled(data[[h]]$morphology_corrected, col="Simple.State")

    # Markedness analyses
    res[[h]]$markedness_A <- column_filled(data[[h]]$markedness_A, col="ParadigmMarked")
    res[[h]]$markedness_B <- column_filled(data[[h]]$markedness_B, col="ParadigmMarked")
    res[[h]]$markedness_C <- column_filled(data[[h]]$markedness_C, col="ParadigmMarked")
    res[[h]]$markedness_D <- column_filled(data[[h]]$markedness_D, col="ParadigmMarked")
  }

  # Save
  save(res, file=outfile)
}
