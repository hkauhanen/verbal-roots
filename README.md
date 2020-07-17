# verbal-roots

This repository contains R code required to replicate the typological analyses reported in the following publication:

> Beavers, John, Michael Everdell, Kyle Jerro, Henri Kauhanen, Andrew Koontz-Garboden, Elise LeBovidge & Stephen Nichols (s.a.) States and changes-of-state: a cross-linguistic study of the roots of verbal meaning.

The raw data come from <https://verbal-roots.la.utexas.edu/>.


## Repository contents

* `clean.sh`: Shell script used to remove all results (to start from scratch)
* `collect_paperfigs.sh`: Shell script used to collect figures for paper in folder `paperfigs`
* `data`: Data, both raw (a tab-separated file) and in RData format prepared for the analyses
* `paperfigs`: Figures for the paper; a subset of the plots and tables in `plots` and `tables`
* `plots`: Figures
* `R`: Sources of scripts for all analyses
* `README.md`: This file
* `results`: Results of analyses are saved in this folder
* `Rsession`: Default folder to run an R session in
* `stats`: Results of statistical tests
* `tables`: Data tables in TeX format


## Overview of code logic

The overall logic of the scripts is as follows. First, raw data, which exists as a tab-separated file in the `data` folder, is prepared for the various analyses reported in the paper. These prepared data sets are saved as a nested list structure in the file `data/prepared.RData`. The analysis routines operate on the latter object, producing a result object (again a nested list) which contains information about the proportion of simple states and marked paradigms; this object is written into `results/filled_counts.RData`. Monte Carlo runs are written into `results/monte_carlo.RData`. Statistics and plotting routines operate on the latter objects and place their output in `stats`, `plots` and `tables`.


## How to replicate the analyses

### Main analysis

To reproduce the main analysis, navigate to the `Rsession` folder and issue the following commands from R:

``` r
source("../R/batch_main_analysis.R")
batch_main_analysis()
```

This will prepare the data, carry out the analyses (with and without hypothetical forms), and put the results in the `results`, `stats`, `plots` and `tables` folders. Runtime is on the order of 3 minutes on a typical computer, the bulk of which is consumed by preparing the data for the different data conditions.


### Monte Carlo runs

To reproduce the Monte Carlo analyses for synonym selection, type the following in R, again inside the `Rsession` folder:

``` r
source("../R/batch_monte_carlo.R")
batch_monte_carlo(1000)
```

This assumes that `batch_main_analysis()` has been called before, so that the prepared data exists in the `data` folder. The above call will conduct 1000 MC runs with hypotheticals and 1000 MC runs without hypotheticals (adjust value accordingly, if a larger or smaller number of runs is required). Note that this takes *a long time*: runtime for 1000+1000 repetitions is on the order of 6 hours on a typical computer, if not parallelized. Output goes to `results/monte_carlo.RData`, in the form of a list each element of which contains one run.

Given these runtimes, the production of statistics and plots from the Monte Carlo runs is divorced from the analysis batch itself. To produce these, with output going into the `stats` and `plots` folders, issue the following:

``` r
source("../R/batch_monte_carlo.R")
print_monte_carlo()
```

## Acknowledgements

This material is based upon work supported by the National Science Foundation under grant no. BCS-1451765; the Federal Ministry of Education and Research (BMBF) and the Baden-Württemberg Ministry of Science as part of the Excellence Strategy of the German Federal and State Governments; The Ella and Georg Ehrnrooth Foundation; and Emil Aaltonen Foundation.


## License and how to cite

All code in this repository is licensed under [GNU GPL-3](LICENSE). If you use it in your work, please provide a link to <https://github.com/hkauhanen/verbal-roots> and cite the following publication:

> Beavers, John, Michael Everdell, Kyle Jerro, Henri Kauhanen, Andrew Koontz-Garboden, Elise LeBovidge & Stephen Nichols (s.a.) States and changes-of-state: a cross-linguistic study of the roots of verbal meaning.
