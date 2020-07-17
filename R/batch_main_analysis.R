# batch_main_analysis.R
#
# Henri Kauhanen 2020
#
# Batch for main analysis. Run this to carry out the analyses reported in the paper
# (including hypotheticals runs for the appendix, but not the Monte Carlo synonym runs).
# Runtime is on the order of 3 minutes on an ordinary computer.
#
# Requires write access to the '../data', '../results', '../stats', '../plots' and
# '../tables' folders.


batch_main_analysis <- function() {
  # Load routines
  sapply(list.files("../R", pattern=".R$", full.names=TRUE), source, .GlobalEnv)

  # Set RNG seed; this is important for reproducibility as we pick synonyms at random
  set.seed(9382473)

  # Prepare data
  cat("Preparing data...")
  prepare_data()
  cat(" done!\n")

  # Analyse, i.e. get the proportions of languages with simple states and marked paradigms
  cat("Analysing...")
  main_analysis()
  cat(" done!\n")

  # Stats, plots, etc.
  cat("Printing tests and plots...")
  root_counts()
  print_tests()
  print_violinplots()
  print_tables()
  typology_magic()
  print_Table6() # must be preceded by call to typology_magic()
  print_Table12() # must be preceded by call to typology_magic()

  cat(" done!\n")
}
