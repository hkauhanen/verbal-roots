# read_data.csv
#
# Henri Kauhanen 2020
#
# Read in data file


read_data <- function(file = "../data/verbal_roots_download.tsv") {
  read.csv(file, skip=1, sep="\t", colClasses="character")
}
