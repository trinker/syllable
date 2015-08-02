#' @importFrom data.table setDT
hash_lookup_helper <- function(terms, key) {

    terms <- data.frame(word=terms, stringsAsFactors = FALSE)
    setDT(terms)

    key[terms][[2]]
}


make_words <- function(x){
    x <- gsub("^\\s+|\\s+$|[^\\p{L}' -]+", "", tolower(x), perl = TRUE)
    x <- paste(x, collapse = " & ")
    stringi::stri_split_regex(x, "\\s+")
}
