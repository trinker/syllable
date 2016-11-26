library(data.table)
syllable_counts_data <- syllable::syllable_counts_data

syllable_counts_data[word == 'julia', 'syllables'] <- 3

syllable_counts_data <- rbindlist(list(syllable_counts_data, list('silge', 2)))

syllable_counts_data <- syllable_counts_data[order(word),]
data.table::setkey(syllable_counts_data, word)


syllable_counts_data[word == 'julia', ]
syllable_counts_data[word == 'silge', ]


pax::new_data(syllable_counts_data)
