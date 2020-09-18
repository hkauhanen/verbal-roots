# R

This folder contains R scripts required to replicate the analyses. The main analyses can be run using the batch function in `batch_main_analysis.R`; `batch_monte_carlo.R` wraps this in a loop for the synonym analyses (see `README.md` in the parent folder for more details). Each of these two files calls functions defined in the following files, one function per file in most cases, except for `plotting.R`, which defines several plotting routines.

* `batch_main_analysis.R`: Batch file for main analyses.
* `batch_main_analysis_ignore_low.R`: Batch file for main analyses, ignoring low data languages.
* `batch_monte_carlo.R`: Batch file for Monte Carlo runs.
* `column_filled.R`: Figure out proportion of languages for which a given column is filled.
* `debug_classes.R`: Find typos in the coding of root classes and narrow root classes.
* `factor2character.R`: Turn a factor into a character vector (i.e. forget the levels).
* `ignore_low_data.R`: Drop low-data languages from the data set.
* `main_analysis.R`: Main analysis.
* `mann_whitney_U.R`: Mann-Whitney U test.
* `monte_carlo.R`: Monte Carlo runs.
* `mutate_markedness_A.R`: The markedness calculations of Section 7.1 of the paper.
* `mutate_markedness_B.R`: First markedness variant in Section 7.3.
* `mutate_markedness_C.R`: Second markedness variant in Section 7.3.
* `mutate_markedness_D.R`: Third markedness variant in Section 7.3.
* `mutate_result_states.R`: Result states interpreted as simple states; Section 6.2 of the paper.
* `plotting.R`: Plotting routines (several per file).
* `prepare_data.R`: Prepare data for the various different analyses and save objects into an RData file.
* `prettyround.R`: Pretty-printing of figures.
* `print_monte_carlo.R`: Produce plots of Monte Carlo runs, as well as information about p-values.
* `print_Table12.R`: Print a complex table for the manuscript.
* `print_Table6.R`: Print another complex table for the manuscript.
* `print_tables.R`: Print tables of all kinds.
* `print_tests.R`: Print results of statistical tests into text files.
* `print_violinplots.R`: Print violin plots into PDFs.
* `read_data.R`: Reads the data into a data frame from the master TSV file.
* `README.md`: This file.
* `rm_classes.R`: Remove root classes which we're not interested in (human propensity).
* `rm_hyps.R`: Remove hypothetical forms.
* `root_counts.R`: Print basic root count stats.
* `typology_magic.R`: Typology "magic" on paradigm pairings.
