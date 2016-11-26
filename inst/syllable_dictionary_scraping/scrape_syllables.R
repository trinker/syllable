p_load(dplyr, XML, qdapDictionaries, parallel)

#syllable_df <- list2df(as.list.environment(qdap::env.syl), "syllables", "word")[, 2:1]
#no_syllable <- GradyAugmented[!GradyAugmented %in% syllable_df$word]

syllable_scrape <- function(x){
    URL <- sprintf('http://www.poetrysoup.com/syllables/%s', x)
    Table <- XML::readHTMLTable(URL, FALSE, which=2, stringsAsFactors = FALSE)[1:2, 2]
    NAdet <- function(x) grepl("^N/A$", x)
    data.frame(word = x, syllables = as.numeric(Table[1]),
        in_dict = NAdet(Table[2]), stringsAsFactors = FALSE)
}


syllable_scrape('jo-ann')


words <- sort(unique(tolower(c(GradyAugmented, tolower(NAMES[[1]])))))
iter_list <- split((iter <- seq_along(words)), cut(iter, 20))
n <- 1

n <- 1 + n; n
#=====================
tic()
###########


cl <- makeCluster(mc <- getOption("cl.cores", 6))
clusterExport(cl=cl, varlist=c("words", "syllable_scrape"), envir=environment())

sylls <- parallel::parLapply(cl, iter_list[[n]], function(i) {

    Sys.sleep(.1)
    try(syllable_scrape(words[i]))

})

saveRDS(sylls, file = sprintf("sylls/sylls_%s.rds", n))
stopCluster(cl)


redos <- sapply(sylls, inherits, "try-error")

grab_again <- words[iter_list[[n]]][redos]
if (!identical(character(0), grab_again)){

    sylls[redos] <- lapply(grab_again, function(x){
        Sys.sleep(.1)
        try(syllable_scrape(x))
    })

    (wrds <- words[iter_list[[n]]][sapply(sylls, inherits, "try-error")])
    cat(sprintf("%s errors\n", length(wrds)))
    if (length(wrds) > 0) cat(paste(wrds, collapse =", "), "\n")

    sylls[sapply(sylls, inherits, "try-error")] <- lapply(wrds, function(x){
        out <- syllable_count(x)
        data_frame(word = out[1,1], syllables = out[1, 2], in_dict = ifelse(out[1,3] == "NF", FALSE, TRUE))
    })

    saveRDS(sylls, file = sprintf("sylls/sylls_%s.rds", n))
} else {
    cat("no errors\n")
}
#############
toc()
#=====================


syll_df <- dplyr::rbind_all(sylls[!sapply(sylls, inherits, "try-error")])
saveRDS(syll_df, file = sprintf("syll_df/syll_df_%s.rds", n))


syllable_counts_data <- dplyr::rbind_all(lapply(1:20, function(i){

    readRDS(sprintf("syll_df/syll_df_%s.rds", i))
}))




sylls_original <- syllable_counts_data %>%
    filter(!in_dict) %>%
    select(word) %>%
    inner_join(syllable_df) %>%
    `[`(1:47,)


syllable_counts_data <- syllable_counts_data[!syllable_counts_data[["word"]] %in% sylls_original[["word"]], ]

sylls_original[["in_dict"]] <- TRUE

syllable_counts_data <- dplyr::rbind_all(list(syllable_counts_data, sylls_original)) %>%
    arrange(word) %>%
    select(-in_dict) %>%
    as.data.frame(, stringsAsFactors = FALSE)


data.table::setDT(syllable_counts_data)
data.table::setkey(syllable_counts_data, word)





