# factor2character.R
#
# Borrowed from package 'hipster' (https://github.com/hkauhanen/hipster).


#' Factor to Character
#'
#' Turns a factor into a plain character vector.
#'
#' @param x Factor to be transformed
#'
#' @return Character vector, i.e. the factor without the levels.
#'
#' @export
factor2character <- function(x) {
  if (is.factor(x)) {
    return(levels(x)[as.numeric(x)])
  } else {
    return(x)
  }
}
