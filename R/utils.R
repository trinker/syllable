#' @importFrom data.table setDT
hash_lookup_helper <- function(terms, key) {

    terms <- data.frame(word=terms, stringsAsFactors = FALSE)
    setDT(terms)

    key[terms][[2]]
}


make_words <- function(x){
    stringi::stri_extract_all_words(gsub("\\d", "", stringi::stri_trans_tolower(x)))
}

count_row_length <- function(x){
    x <- stringi::stri_count_words(gsub("\\d", "", x))
    x[is.na(x) | x == 0] <- 1
    x
}


relist_vector <- function(vector, lens){
    ends <- cumsum(as.numeric(lens))
    starts <- c(1, utils::head(c(ends + 1), -1))
    Map(function(s, e) {vector[s:e]}, starts, ends)
}

add_row_id <- function(lens){
    rep(seq_along(lens), lens)
}

syllable_count_long_df <- function(x){

    # found the number of words per string
    lens <- count_row_length(x)

    # split into bag of words
    y <- unlist(make_words(x))

    # find NAs
    NAs <- which(is.na(y))

    # lookup syllable counts
    counts <- lookup_syllable_counts(y)

    # find words that could not be found
    not_found <- which(is.na(counts))
    not_found <- not_found[!not_found %in% NAs]

    # compute syllable count on not found words
    counts[not_found] <- compute_syllable_counts(y[not_found])

    # make a syllable dataframe long version
    data.frame(
        string_number = add_row_id(lens),
        count = counts,
        stringsAsFactors = FALSE

    )

}


syllable_count_long_vector <- function(x){

    # split into bag of words
    y <- unlist(make_words(x))

    # find NAs
    NAs <- which(is.na(y))

    # lookup syllable counts
    counts <- lookup_syllable_counts(y)

    # find words that could not be found
    not_found <- which(is.na(counts))
    not_found <- not_found[!not_found %in% NAs]

    # compute syllable count on not found words
    counts[not_found] <- compute_syllable_counts(y[not_found])

    counts

}