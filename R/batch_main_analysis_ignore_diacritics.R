# batch_main_analysis_ignore_diacritics.R
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
# NB! This version of the routine ignores languages with an asterisk or dagger in
# Table 6. The version which does NOT ignore those languages needs to be run first 
# so that the file '../data/prepared.RData' exists.


batch_main_analysis_ignore_diacritics <- function() {
  # Load routines
  sapply(list.files("../R", pattern=".R$", full.names=TRUE), source, .GlobalEnv)

  # Set RNG seed; this is important for reproducibility as we pick synonyms at random
  set.seed(9382473)

  # Prepare data
  cat("Preparing data...")
  prepare_data_ignore_diacritics()
  cat(" done!\n")

  # Analyse, i.e. get the proportions of languages with simple states and marked paradigms
  cat("Analysing...")
  main_analysis(outfile="../nodia/results/filled_counts.RData", data_objects="../data/prepared_nodia.RData")
  cat(" done!\n")

  # Stats, plots, etc.
  cat("Printing tests and plots...")
  root_counts(datafile="../data/prepared_nodia.RData", outfile="../nodia/stats/root-counts.txt")
  print_tests(results="../nodia/results/filled_counts.RData", outfolder="../nodia/stats")
  print_glmm(data_objects="../data/prepared_nodia.RData", outfolder="../nodia/stats")
  print_violinplots(results="../nodia/results/filled_counts.RData", outfolder="../nodia/plots")
  print_tables(results="../nodia/results/filled_counts.RData", folder="../nodia/tables")
  typology_magic(datafile="../data/prepared_nodia.RData", folder="../nodia/results")
  print_Table6(datafile="../data/prepared_nodia.RData", typofile="../nodia/results/typology_wo_hyps.csv", folder="../nodia/tables") # must be preceded by call to typology_magic()
  print_Table12(typofile="../nodia/results/typology_wo_hyps.csv", folder="../nodia/tables") # must be preceded by call to typology_magic()

  cat(" done!\n")
}
