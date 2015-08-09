#' A Small Collection of Syllable Counting Functions
#'
#' Tools for counting syllables and polysyllables.  The tools rely primarily on
#' a \pkg{data.table} hash table lookup, resulting in fast syllable counting.
#' @docType package
#' @name syllable
#' @aliases syllable package-syllable
NULL


#' A \pkg{data.table} of Words and Syllable Counts
#'
#' A \pkg{data.table} hash table dataset containing words and syllable counts.
#'
#' @details
#' \itemize{
#'   \item word. A character coolumn of lower case words.
#'   \item syllables. The syllable counts per word.
#' }
#'
#' @docType data
#' @keywords datasets
#' @name syllable_counts_data
#' @usage data(syllable_counts_data)
#' @format A data frame with 124603 rows and 2 variables
#' @references Counts scraped from \url{http://www.poetrysoup.com}
NULL




#' Hamlet's Soliloquy
#'
#' A dataset containing a character string of Hamlet's soliloquy.
#'
#' @docType data
#' @keywords datasets
#' @name hamlets_soliloquy
#' @usage data(hamlets_soliloquy)
#' @format A character vector with 1 element
NULL


#' 2012 U.S. Presidential Debates
#'
#' A dataset containing a cleaned version of all three presidential debates for
#' the 2012 election.
#'
#' @details
#' \itemize{
#'   \item person. The speaker
#'   \item tot. Turn of talk
#'   \item dialogue. The words spoken
#'   \item time. Variable indicating which of the three debates the dialogue is from
#' }
#'
#' @docType data
#' @keywords datasets
#' @name presidential_debates_2012
#' @usage data(presidential_debates_2012)
#' @format A data frame with 2912 rows and 4 variables
NULL


#' Common Proper Nouns
#'
#' A dataset containing a character vector of common proper nouns Greater than 2
#' syllables.  This is useful to exclude words for "complex word" detection
#' used in the Gunning fog index.
#'
#' @docType data
#' @keywords datasets
#' @name common_polysyllabic_proper_nouns
#' @usage data(common_polysyllabic_proper_nouns)
#' @format A character vector with 250 elements
NULL
