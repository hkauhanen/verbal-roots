# batch_main_analysis_ignore_low.R
#
# Henri Kauhanen 2020
#
# Batch for main analysis. Run this to carry out the analyses reported in the paper
# (including hypotheticals runs for the appendix, but not the Monte Carlo synonym runs).
# Runtime is on the order of 3 minutes on an ordinary computer.
#
# Requires write access to the '../data', '../results', '../stats', '../plots' and
# '../tables' folders.
#
# NB! This version of the routine ignores low data languages. The version which does
# NOT ignore those languages needs to be run first so that the file '../data/prepared.RData'
# exists.


batch_main_analysis_ignore_low <- function() {
  # Load routines
  sapply(list.files("../R", pattern=".R$", full.names=TRUE), source, .GlobalEnv)

  # Set RNG seed; this is important for reproducibility as we pick synonyms at random
  set.seed(9382473)

  # Prepare data
  cat("Preparing data...")
  prepare_data_ignore_low()
  cat(" done!\n")

  # Analyse, i.e. get the proportions of languages with simple states and marked paradigms
  cat("Analysing...")
  main_analysis(outfile="../nolow/results/filled_counts.RData", data_objects="../data/prepared_nolow.RData")
  cat(" done!\n")

  # Stats, plots, etc.
  cat("Printing tests and plots...")
  root_counts(datafile="../data/prepared_nolow.RData", outfile="../nolow/stats/root-counts.txt")
  print_tests(results="../nolow/results/filled_counts.RData", outfolder="../nolow/stats")
  print_violinplots(results="../nolow/results/filled_counts.RData", outfolder="../nolow/plots")
  print_tables(results="../nolow/results/filled_counts.RData", folder="../nolow/tables")
  typology_magic(datafile="../data/prepared_nolow.RData", folder="../nolow/results")
  print_Table6(datafile="../data/prepared_nolow.RData", typofile="../nolow/results/typology_wo_hyps.csv", folder="../nolow/tables") # must be preceded by call to typology_magic()
  print_Table12(typofile="../nolow/results/typology_wo_hyps.csv", folder="../nolow/tables") # must be preceded by call to typology_magic()

  cat(" done!\n")
}
