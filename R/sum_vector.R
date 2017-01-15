#' Vector Syllable Sums
#'
#' Syllable sums for the words in a vector of strings.
#'
#' @param x A character vector.
#' @param \ldots ignored.
#' @return Returns a list of vectors of integer counts.
#' @family syllable functions
#' @export
#' @importFrom data.table setDT
#' @examples
#' sents <- c("I like chicken.", "I want eggs Benedict for breakfast.")
#' sum_vector(sents)
#'
#' data.frame(
#'    sents, syllable_count = sum_vector(sents),
#'    stringsAsFactors = FALSE
#' )
#'
#' sum_vector(presidential_debates_2012$dialogue)
sum_vector <- function(x, ...){

    count <- element_id <- NULL

    long_dat <- data.frame(
        element_id = add_row_id(count_row_length(x)),
        count = syllable_count_long_vector(x)
    )

    data.table::setDT(long_dat)
    data.table::setkey(long_dat, "element_id")

    long_dat[, sum(count, na.rm = TRUE), by=element_id][[2]]
}


