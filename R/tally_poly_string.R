#' String Syllable Tally of Polysyllabic Words
#'
#' Polysyllabic word tallies for the words in a string.
#'
#' @param x A character vector.
#' @param \ldots ignored.
#' @return Returns a single integer of the total number of polysyllables in the
#' string.
#' @family syllable functions
#' @export
#' @examples
#' tally_poly_string("I like generalized chicken and tarnishing hotdogs!")
#' tally_poly_string(hamlets_soliloquy)
tally_poly_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `tally_poly_vector` instead")
    }

    sum(syllable_count_long_vector(x) > 2, na.rm = TRUE)
}
