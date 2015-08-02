#' @importFrom data.table setDT
hash_lookup_helper <- function(terms, key) {

    terms <- data.frame(word=terms, stringsAsFactors = FALSE)
    setDT(terms)

    key[terms][[2]]
}
