#' Vector Tally of Poly-Syllabic Words By Grouping Variable(s)
#'
#' Poly-syllabic (>= 3 syllables) word tallies for the words in a vector of
#' strings by grouping variable(s).
#'
#' @param x A character vector.
#' @param group The grouping variable(s).  Takes a single grouping variable or a
#' list of 1 or more grouping variables.
#' @param \ldots ignored
#' @return Returns a \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) of integer tallies for the total number
#' of poly syllable words for each string in the vector.
#' @family syllable functions
#' @export
#' @examples
#' dat <- data.frame(
#'    text = c("I like excellent chicken.", "I want eggs benedict now.", "Really?"),
#'    group = c("A", "B", "A")
#' )
#' tally_poly_vector_by(dat$text, dat$group)
#'
#' with(presidential_debates_2012, tally_poly_vector_by(dialogue, person))
#' with(presidential_debates_2012, tally_poly_vector_by(dialogue, list(role, time)))
#' with(presidential_debates_2012, tally_poly_vector_by(dialogue, list(person, time)))
tally_poly_vector_by <- function(x, group, ...){

    count <- element_id <- NULL

    if (is.list(group) & length(group)>1) {
        m <- unlist(as.character(substitute(group))[-1])
        G <- sapply(strsplit(m, "$", fixed=TRUE), function(x) {
                x[length(x)]
            }
        )
        grouping <- group
    } else {
        G <- as.character(substitute(group))
        G <- G[length(G)]
        grouping <- unlist(group)
    }

    element_id <- add_row_id(count_row_length(x))
    long_dat <- stats::setNames(as.data.frame(grouping, stringsAsFactors = FALSE),
        G)[element_id, , drop = FALSE]
    long_dat[["count"]] <- syllable_count_long_vector(x)

    data.table::setDT(long_dat)

    long_dat[, list(n.words = length(stats::na.omit(count)),
        poly = sum(count > 2, na.rm = TRUE)),  keyby = G]
}
