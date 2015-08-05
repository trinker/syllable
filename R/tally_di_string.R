#' String Syllable Tally of Disyllabic Words
#'
#' Disyllabic word tallies for the words in a string.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a single integer of the total number of disyllables in the
#' string.
#' @export
#' @examples
#' tally_di_string("I like chicken and hotdogs!")
#' tally_di_string(hamlets_soliloquy)
tally_di_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `tally_di_vector` instead")
    }

    sum(syllable_count_long_vector(x) == 2, na.rm = TRUE)
}
