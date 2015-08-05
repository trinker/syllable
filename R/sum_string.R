#' String Syllables Sum
#'
#' Syllable sum for the words in a single string.
#'
#' @param x A character string.
#' @param \ldots ignored
#' @return Returns a single integer of the total number of syllables in the string.
#' @export
#' @examples
#' sum_string("I like chicken and eggs for breakfast")
#' sum_string(hamlets_soliloquy)
sum_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `sum_vector` instead")
    }

    sum(syllable_count_long_vector(x), na.rm = TRUE)
}

