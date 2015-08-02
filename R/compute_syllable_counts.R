#' Compute Syllable Counts
#'
#' A computational approach to determine syllable counts.  The function uses
#' regular expressions and linguistical logic to compute the number of syllables
#' in a term.
#'
#' @param x A character vector of terms.
#' @return Returns a vector of syllable counts.
#' @export
#' @examples
#' terms <- c("other", "about", "many", "into", "number", "people", "water",
#'     "over", "only", "little", "very", "after", "sentence", "before",
#'     "any", "follow", "also", "around", "another", "even", "because",
#'     "different", "picture", "again", "away", "animal", "letter",
#'     "mother", "answer", "study", "America")
#'
#' stats::setNames(compute_syllable_counts(terms), terms)
compute_syllable_counts <- function(x) {

    m <- gsub("[ye]{1,2}ing", "XX", tolower(x))
    m <- gsub("ie(st|r)$", "XX", m)
    m <- gsub("([aeiouy][^td]*?)ed$", "\\1", m)
    m <- gsub("ely$", "ly", m)
    m <- gsub("([aeiouy])le(s??)$", "\\1l", m)
    m <- gsub("([^aeiouy])le(s??)$", "\\1lX", m)
    m <- gsub("([aeiouy].*?)e$", "\\1", m)
    m <- gsub("[aeiouy]+", "X", m)
    m <- gsub("[^X]", "", m)
    nchar(m)
}

