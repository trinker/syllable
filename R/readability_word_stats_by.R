#' Readability Word Statistics By Grouping Variable(s)
#'
#' Word statistics commonly used to calculate readability sores by grouping variable(s).
#'
#' @param x A character vector.
#' @param group The grouping variable(s).  Takes a single grouping variable or a
#' list of 1 or more grouping variables.
#' @param group.names A vector of names that corresponds to group.  Generally
#' for internal use.
#' @param \ldots ignored.
#' @return Returns a \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) readability word statistics.
#' @export
#' @importFrom data.table :=
#' @examples
#' dat <- data.frame(
#'    text = c("I like excellent chicken.", "I want eggs Benedict now.", "Really?"),
#'    group = c("A", "B", "A")
#' )
#' readability_word_stats_by(dat$text, dat$group)
#'
#' with(presidential_debates_2012, readability_word_stats_by(dialogue, person))
#' with(presidential_debates_2012, readability_word_stats_by(dialogue, list(role, time)))
#' with(presidential_debates_2012, readability_word_stats_by(dialogue, list(person, time)))
readability_word_stats_by <- function(x, group, group.names, ...){

    n.complex <- text.var <- count <- element_id <- NULL

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

    if(!missing(group.names)) {
        G <- group.names
    }

    element_id <- add_row_id(count_row_length(x))
    long_dat_complex <- text_dat <- long_dat <- stats::setNames(as.data.frame(grouping,
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
        n.sents = sum(sent_count(text.var, ...), na.rm = TRUE)),  keyby = G]

    gunning <- gsub("(?<=[a-z]{3})(ing|es|ed)$", "",
        stringi::stri_trans_tolower(as.character(x)), perl=TRUE)

    long_dat_complex[["n.complex"]] <- tally_poly_vector(sub("(^.+[^aeiou])e[sd]$", "\\1", gsub(proper_noun_regex,
        "", x, perl=TRUE)))

    data.table::setDT(long_dat_complex)

    out3 <- long_dat_complex[, list(n.complexes = sum(n.complex, na.rm = TRUE)),
        keyby = G]

    out <- merge(merge(out1, out2), out3)

    data.table::setcolorder(out, c(G, "n.sents", "n.words", "n.chars", "n.sylls",
        "n.shorts", "n.polys", "n.complexes"))

    attributes(out)[["groups"]] <- G
    out[]
}

proper_noun_regex <- paste(paste0("\\b",
    .common_polysyllabic_proper_nouns, "\\b"), collapse = "|")
