#' Vector Syllable Counts
#'
#' Syllable counts for the words in a vector of strings.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a list of vectors of integer counts.
#' @export
#' @examples
#' sents <- c("I like chicken.", "I want eggs benidict for breakfast.")
#' count_vector(sents)
#'
#' Map(function(x, y) setNames(x, y),
#'    count_vector(sents),
#'    strsplit(gsub("[^a-z ]", "", tolower(sents)), "\\s+")
#' )
#'
#' count_vector(presidential_debates_2012$dialogue)
count_vector <- function(x, ...){
    lens <- count_row_length(x)
    stats::setNames(relist_vector(syllable_count_long_vector(x), lens), seq_along(lens))
}
