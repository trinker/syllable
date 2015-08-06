#' Readability Word Statistics
#'
#' Word statistics commonly used to calculate readability sores.
#'
#' @param x A character vector.
#' @param \ldots ignored
#' @return Returns a \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) readability word statistics.
#' @export
#' @examples
#' x <- c("I like excellent chicken.", "I want eggs benedict now.", "Really?",
#'     "I thought that was good.  Well a bit weird.", "I know right!")
#' readability_word_stats(x)
#'
#' readability_word_stats(presidential_debates_2012$dialogue)
readability_word_stats <- function(x, ...){

    text.var <- count <- element_id <- NULL

    long_dat <- data.frame(
        element_id = add_row_id(count_row_length(x)),
        count = syllable_count_long_vector(x)
    )

    data.table::setDT(long_dat)
    data.table::setkey(long_dat, "element_id")

    out1 <- long_dat[, list(n.words = length(stats::na.omit(count)),
        n.sylls = sum(count, na.rm = TRUE),
        n.shorts = sum(count < 3, na.rm = TRUE),
        n.polys = sum(count > 2, na.rm = TRUE)),  keyby = "element_id"]

    text_dat <- data.frame(element_id = out1[["element_id"]], text.var = as.character(x))
    data.table::setDT(text_dat)
    data.table::setkey(text_dat, "element_id")

    out2 <- text_dat[, list(n.chars = sum(char_count(text.var), na.rm = TRUE),
        n.sents = sum(stringi::stri_count_boundaries(text.var, type="sentence"),
            na.rm = TRUE)),  keyby = "element_id"]
    out <- merge(out1, out2)[, element_id:=NULL]
    data.table::setcolorder(out, c("n.sents", "n.words", "n.chars", "n.sylls", "n.shorts", "n.polys"))
    out
}
