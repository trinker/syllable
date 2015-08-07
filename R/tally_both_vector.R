#' Vector Tally of Short-Syllabic and Poly-Syllabic Words
#'
#' Short-syllabic (< 3 syllables) and poly-syllabic (>= 3 syllables) word
#' tallies for the words in a vector of strings.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a two column \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) of integer tallies for the total number of
#' short syllable (short) and poly syllable (poly) words for each string in the vector.
#' @family syllable functions
#' @export
#' @importFrom data.table :=
#' @examples
#' sents <- c("I like excellent chicken.", "I want eggs benedict for Festivus.")
#' tally_both_vector(sents)
#' tally_both_vector(presidential_debates_2012$dialogue)
tally_both_vector <- function(x, ...){

    count <- element_id <- NULL

    long_dat <- data.frame(
        element_id = add_row_id(count_row_length(x)),
        count = syllable_count_long_vector(x)
    )

    data.table::setDT(long_dat)
    data.table::setkey(long_dat, "element_id")
    long_dat[, list(short = sum(count < 3, na.rm = TRUE),
        poly = sum(count > 2, na.rm = TRUE)), by=element_id][,element_id:=NULL]
}
