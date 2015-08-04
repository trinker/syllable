#' String Syllable Counts
#'
#' Syllable counts for the words in a single string.
#'
#' @param x A character string.
#' @param \ldots ignored
#' @return Returns a vector of integer counts.
#' @export
#' @examples
#' count_string("I like chicken and eggs for breakfast")
#' count_string(hamlets_soliloquy)
#' library(stringi)
#'
#' data.frame(
#'     word = stri_extract_all_words(stri_trans_tolower(hamlets_soliloquy))[[1]],
#'     syllables = count_string(hamlets_soliloquy)
#' )
count_string <- function(x, ...){

    if (length(x) > 1) {
        stop("`count_string` operates on a string.\n",
        "Consider using `count_vector` instead")
    }

    syllable_count_long_vector(x)
}


