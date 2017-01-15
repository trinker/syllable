#' Vector Syllable Sums By Grouping Variable(s)
#'
#' Syllable sums for the words in the vectors of strings by grouping variables.
#'
#' @param x A character vector.
#' @param group The grouping variable(s).  Takes a single grouping variable or a list
#' of 1 or more grouping variables.
#' @param as.tibble logical.  If \code{TRUE} the output class will be set to a
#' \pkg{tibble}, otherwise a \code{\link[data.table]{data.table}}.  Default
#' checks \code{getOption("tibble.out")} as a logical.  If this is \code{NULL}
#' the default \code{\link[textshape]{tibble_output}} will set \code{as.tibble}
#' to \code{TRUE} if \pkg{dplyr} is loaded.  Otherwise, the output will be a
#' \code{\link[data.table]{data.table}}.
#' @param \ldots ignored.
#' @return Returns a \code{\link[base]{data.frame}} (\code{\link[data.table]{data.table}}) of
#' syllable sums (count) by grouping variable.
#' @family syllable functions
#' @export
#' @importFrom data.table .SD
#' @examples
#' dat <- data.frame(
#'    text = c("I like chicken.", "I want eggs Benedict for breakfast.", "Really?"),
#'    group = c("A", "B", "A")
#' )
#' sum_vector_by(dat$text, dat$group)
#'
#' with(presidential_debates_2012, sum_vector_by(dialogue, list(person, time)))
sum_vector_by <- function(x, group, as.tibble = tibble_output(), ...){

    count <- NULL

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

    if_tibble(long_dat[, list(n.words = length(stats::na.omit(count)),
        count = sum(count, na.rm = TRUE)), keyby = G], as.tibble = as.tibble)
}
