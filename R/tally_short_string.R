#' String Syllable Tally of Non-Polysyllabic (< 3 syllables) Words
#'
#' Non-polysyllabic word tallies for the words in a string.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a single integer of the total number of non-polysyllables in
#' the string.
#' @family syllable functions
#' @export
#' @examples
#' tally_short_string("I like excellent chicken and blah hotdogs!")
#' tally_short_string(hamlets_soliloquy)
tally_short_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `tally_short_vector` instead")
    }

    sum(syllable_count_long_vector(x) < 3, na.rm = TRUE)
}

