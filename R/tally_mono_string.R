#' String Syllable Tally of Monosyllabic Words
#'
#' Monosyllabic word tallies for the words in a string.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a single integer of the total number of monosyllables in the string.
#' @export
#' @examples
#' tally_mono_string("I like chicken and beans!")
#' tally_mono_string(hamlets_soliloquy)
tally_mono_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `tally_mono_vector` instead")
    }

    sum(syllable_count_long_vector(x) < 2, na.rm = TRUE)
}
