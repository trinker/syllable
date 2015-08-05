#' String Syllable Tally of Non-Polysyllabic and Polysyllabic Words
#'
#' Non-polysyllabic and polysyllabic word tallies for the words in a string.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a two integer vector of the total number of non-polysyllables
#' (non) and polysyllables (poly) in the string.
#' @export
#' @examples
#' tally_both_string("I like excellent chicken and mediocre hotdogs!")
#' tally_both_string(hamlets_soliloquy)
tally_both_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `tally_both_vector` instead")
    }

    poly <- syllable_count_long_vector(x) > 2
    c(non = sum(!poly, na.rm = TRUE), poly = sum(poly, na.rm = TRUE))
}

