#' Vector Syllable Sums By Grouping Variable(s)
#'
#' Syllable sums for the words in the vector(s) of strings for grouping variables.
#'
#' @param x A character vector.
#' @param group The grouping variable(s).  Takes a single grouping variable or a list
#' of 1 or more grouping variables.
#' @param \ldots ignored
#' @return Returns a \code{\link[base]{data.frame}} (\code{\link[data.table]{data.table}}) of
#' syllable sums by grouping variable.
#' @export
#' @importFrom data.table .SD
#' @examples
#' dat <- data.frame(
#'    text = c("I like chicken.", "I want eggs benedict for breakfast.", "Really?"),
#'    group = c("A", "B", "A")
#' )
#' sum_vector_by(dat$text, dat$group)
#'
#' with(presidential_debates_2012, sum_vector_by(dialogue, list(person, time)))
sum_vector_by <- function(x, group, ...){

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
    long_dat[, lapply(.SD, sum, na.rm = TRUE), keyby = G]
}
