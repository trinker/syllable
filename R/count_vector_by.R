#' Vector Syllable Counts By Grouping Variable(s)
#'
#' Syllable counts for the words in a vector of strings by grouping variables.
#'
#' @param x A character vector.
#' @param group The grouping variable(s).  Takes a single grouping variable or a list
#' of 1 or more grouping variables.
#' @param \ldots ignored
#' @return Returns a named list of vectors of integer counts for each grouping variable.
#' @family syllable functions
#' @export
#' @examples
#' dat <- data.frame(
#'    text = c("I like chicken.", "I want eggs benidict for breakfast.", "Really?"),
#'    group = c("A", "B", "A")
#' )
#' count_vector_by(dat$text, dat$group)
#'
#' with(presidential_debates_2012, count_vector_by(dialogue, list(person, time)))
count_vector_by <- function(x, group, ...){

    if (is.list(group) & length(group)>1) {
        grouping <- group
    } else {
        grouping <- unlist(group)
    }

    lens <- count_row_length(x)
    out <- relist_vector(syllable_count_long_vector(x), lens)
    out <- lapply(split(out, grouping), unlist)
    out[!unlist(lapply(out, is.null))]
}


