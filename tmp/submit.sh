#!/bin/bash
#$ -N verbalrootsMC

module load R/3.6.3-1
Rscript -e 'source("../R/batch_monte_carlo.R"); batch_monte_carlo(1000)'
