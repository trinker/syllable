#' Lookup Syllable Counts
#'
#' A dictionary approach to determine syllable counts.  The function searches a
#' hash dictionary for a term and returns syllable counts.  If the term is not
#' found \code{NA} is returned.
#'
#' @param x A character vector of terms.
#' @param dictionary A \pkg{data.table} of terms and counts.
#' @return Returns a vector of syllable counts.
#' @export
#' @examples
#' terms <- c("other", "about", "many", "into", "number", "people", "water",
#'     "over", "only", "little", "very", "after", "sentence", "before",
#'     "any", "follow", "also", "around", "another", "even", "because",
#'     "different", "picture", "again", "away", "animal", "letter",
#'     "mother", "answer", "study", "America")
#'
#' stats::setNames(lookup_syllable_counts(terms), terms)
lookup_syllable_counts <- function(x, dictionary = syllable::syllable_counts_data){
    hash_lookup_helper(tolower(x), dictionary)

}


