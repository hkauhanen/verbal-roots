# rm_hyps.R
#
# Henri Kauhanen 2020
#
# Remove hypotheticals (forms prefaced with '@'), i.e. set them equal to the empty string.
#
# Note that removing hypotheticals is not enough: we also need to set the relevant occurrence
# in each of the *.Code columns to "n" to signal that the form is now unattested.


rm_hyps <- function(data) {
  relevant_cols <- c("Underlying.Root", "Simple.State", "Inchoative", "Causative", "Result.State")
  for (i in 1:nrow(data)) {
    for (c in relevant_cols) {
      if (grepl(pattern="^@", data[i, ][[c]])) {
        data[i, ][[c]] <- ""
        for (cc in setdiff(relevant_cols, c)) {
          index_here <- match(c, relevant_cols)
          substr(data[i, ][[paste0(cc, ".Code")]], index_here, index_here) <- "n"
        }
        data[i, ][[paste0(c, ".Code")]] <- ""
      }
    }
  }
  data
}
