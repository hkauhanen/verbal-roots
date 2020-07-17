# batch_monte_carlo.R
#
# Henri Kauhanen 2020
#
# Batch for Monte Carlo runs.
#
# Assumes that prepare_data() has already been called so that 'data/prepared.RData' exists,
# e.g. through the use of batch_main_analysis().
#
# Requires write access to the '../data' and '../results' folders.


batch_monte_carlo <- function(reps) {
  # Load routines
  sapply(list.files("../R", pattern=".R$", full.names=TRUE), source, .GlobalEnv)

  # Set RNG seed; this is important for reproducibility as we pick synonyms at random
  set.seed(7433071)

  # Analyse, i.e. get the proportions of languages with simple states and marked paradigms
  cat("Running Monte Carlo analysis...\n")
  monte_carlo(reps=reps)
  cat("Done!\n")
}
