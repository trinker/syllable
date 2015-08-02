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


