#' Vector Tally of Short-Syllabic and Poly-Syllabic Words
#'
#' Short-syllabic (< 3 syllables) and poly-syllabic (>= 3 syllables) word
#' tallies for the words in a vector of strings.
#'
#' @param x A character vector.
#' @param as.tibble logical.  If \code{TRUE} the output class will be set to a
#' \pkg{tibble}, otherwise a \code{\link[data.table]{data.table}}.  Default
#' checks \code{getOption("tibble.out")} as a logical.  If this is \code{NULL}
#' the default \code{\link[textshape]{tibble_output}} will set \code{as.tibble}
#' to \code{TRUE} if \pkg{dplyr} is loaded.  Otherwise, the output will be a
#' \code{\link[data.table]{data.table}}.
#' @param \ldots ignored.
#' @return Returns a two column \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) of integer tallies for the total number of
#' short syllable (short) and poly syllable (poly) words for each string in the vector.
#' @family syllable functions
#' @export
#' @importFrom data.table :=
#' @examples
#' sents <- c("I like excellent chicken.", "I want eggs Benedict for Festivus.")
#' tally_both_vector(sents)
#' tally_both_vector(presidential_debates_2012$dialogue)
tally_both_vector <- function(x, as.tibble = tibble_output(), ...){

    count <- element_id <- NULL

    long_dat <- data.frame(
        element_id = add_row_id(count_row_length(x)),
        count = syllable_count_long_vector(x)
    )

    data.table::setDT(long_dat)
    data.table::setkey(long_dat, "element_id")
    out <- long_dat[, list(short = sum(count < 3, na.rm = TRUE),
        poly = sum(count > 2, na.rm = TRUE)), by=element_id][,element_id:=NULL]
    if_tibble(out[], as.tibble = as.tibble)
}
