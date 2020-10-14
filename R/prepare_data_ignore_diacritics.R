# prepare_data_ignore_diacritics.R
#
# Henri Kauhanen 2020
#
# Prepare data for the various different analyses and save objects into an RData file,
# ignoring languages with an asterisk or dagger in Table 6.


prepare_data_ignore_diacritics <- function(infile = "../data/verbal_roots_download.tsv",
                                           outfile = "../data/prepared_nodia.RData") {
  file_contents <- read_data(infile)

  file_contents <- ignore_diacritics(file_contents)

  data <- vector("list", 2)
  names(data) <- c("with_hyps", "wo_hyps")
  data$with_hyps <- vector("list", 6)
  names(data$with_hyps) <- c("plain", "morphology_corrected", "markedness_A", "markedness_B", "markedness_C", "markedness_D")
  data$wo_hyps <- vector("list", 6)
  names(data$wo_hyps) <- c("plain", "morphology_corrected", "markedness_A", "markedness_B", "markedness_C", "markedness_D")

  for (h in names(data)) {
    if (h == "with_hyps") {
      df <- rm_classes(file_contents)
    } else if (h == "wo_hyps") {
      df <- rm_hyps(rm_classes(file_contents))
    }
    data[[h]]$plain <- df
    data[[h]]$morphology_corrected <- mutate_result_states(df)
    data[[h]]$markedness_A <- mutate_markedness_A(df)
    data[[h]]$markedness_B <- mutate_markedness_B(df)
    data[[h]]$markedness_C <- mutate_markedness_C(df)
    data[[h]]$markedness_D <- mutate_markedness_D(df)
  }

  save(data, file=outfile)
}
