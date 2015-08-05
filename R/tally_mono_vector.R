#' Vector Tally of Mono-syllabic Words
#'
#' Mono-syllabic word tallies for the words in a vector of strings.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a vector of integer tallies for the total number of
#' monosyllable words for each string in the vector.
#' @export
#' @examples
#' sents <- c("I like chicken.", "I want eggs benedict for breakfast.")
#' tally_mono_vector(sents)
#' tally_mono_vector(presidential_debates_2012$dialogue)
tally_mono_vector <- function(x, ...){

    count <- element_id <- NULL

    long_dat <- data.frame(
        element_id = add_row_id(count_row_length(x)),
        count = syllable_count_long_vector(x)
    )

    data.table::setDT(long_dat)
    data.table::setkey(long_dat, "element_id")

    long_dat[, sum(count < 2), by=element_id][[2]]
}
