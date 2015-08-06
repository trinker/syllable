#' Readability Word Statistics By Grouping Variable(s)
#'
#' Word statistics commonly used to calculate readability sores by grouping variable(s).
#'
#' @param x A character vector.
#' @param group The grouping variable(s).  Takes a single grouping variable or a
#' list of 1 or more grouping variables.
#' @param \ldots ignored
#' @return Returns a \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) readability word statistics.
#' @export
#' @examples
#' dat <- data.frame(
#'    text = c("I like excellent chicken.", "I want eggs benedict now.", "Really?"),
#'    group = c("A", "B", "A")
#' )
#' readability_word_stats_by(dat$text, dat$group)
#'
#' with(presidential_debates_2012, readability_word_stats_by(dialogue, person))
#' with(presidential_debates_2012, readability_word_stats_by(dialogue, list(role, time)))
#' with(presidential_debates_2012, readability_word_stats_by(dialogue, list(person, time)))
readability_word_stats_by <- function(x, group, ...){

    text.var <- count <- element_id <- NULL

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
    text_dat <- long_dat <- stats::setNames(as.data.frame(grouping,
        stringsAsFactors = FALSE), G)
    long_dat <- long_dat[element_id, , drop = FALSE]
    long_dat[["count"]] <- syllable_count_long_vector(x)

    data.table::setDT(long_dat)

    out1 <- long_dat[, list(n.words = length(stats::na.omit(count)),
        n.sylls = sum(count, na.rm = TRUE),
        n.shorts = sum(count < 3, na.rm = TRUE),
        n.polys = sum(count > 2, na.rm = TRUE)),  keyby = G]

    text_dat[["text.var"]] <- as.character(x)
    data.table::setDT(text_dat)
    out2 <- text_dat[, list(n.chars = sum(char_count(text.var), na.rm = TRUE),
        n.sents = sum(stringi::stri_count_boundaries(text.var, type="sentence"),
            na.rm = TRUE)),  keyby = G]
    out <- merge(out1, out2)
    data.table::setcolorder(out, c(G, "n.sents", "n.words", "n.chars", "n.sylls", "n.shorts", "n.polys"))
    out
}
