# monte_carlo.R
#
# Henri Kauhanen 2020
#
# Conduct the Monte Carlo synonyms analyses.


monte_carlo <- function(outfile = "../results/monte_carlo.RData",
                        data_objects = "../data/prepared.RData",
                        reps) {
  # Load data objects
  load("../data/prepared.RData")

  # Prepare list for results over MC runs
  res_MC <- vector("list", reps)
  names(res_MC) <- paste0("rep_", 1:reps)

  # Set progress bar
  pb <- txtProgressBar(style=3, min=0, max=reps)

  # Loop
  for (i in 1:reps) {
    # Prepare results list
    res <- vector("list", 2)
    names(res) <- c("with_hyps", "wo_hyps")
    res$with_hyps <- vector("list", 6)
    names(res$with_hyps) <- c("plain", "morphology_corrected", "markedness_A", "markedness_B", "markedness_C", "markedness_D")
    res$wo_hyps <- vector("list", 6)
    names(res$wo_hyps) <- c("plain", "morphology_corrected", "markedness_A", "markedness_B", "markedness_C", "markedness_D")

    for (h in names(res)) {
      # Simple states analysis
      res[[h]]$plain <- column_filled(data[[h]]$plain, col="Simple.State")

      # Result states as simple states analysis
      res[[h]]$morphology_corrected <- column_filled(data[[h]]$morphology_corrected, col="Simple.State")

      # Markedness analyses
      res[[h]]$markedness_A <- column_filled(data[[h]]$markedness_A, col="ParadigmMarked")
      res[[h]]$markedness_B <- column_filled(data[[h]]$markedness_B, col="ParadigmMarked")
      res[[h]]$markedness_C <- column_filled(data[[h]]$markedness_C, col="ParadigmMarked")
      res[[h]]$markedness_D <- column_filled(data[[h]]$markedness_D, col="ParadigmMarked")
    }

    # Update progress bar
    setTxtProgressBar(pb, i)

    # Push to meta list
    res_MC[[i]] <- res
  }

  # Close progress bar
  close(pb)

  # Save
  save(res_MC, file=outfile)
}
