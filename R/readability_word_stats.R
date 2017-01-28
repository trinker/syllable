#' Readability Word Statistics
#'
#' Word statistics commonly used to calculate readability sores.
#'
#' @param x A character vector.
#' @param \ldots ignored.
#' @return Returns a \code{\link[base]{data.frame}}
#' (\code{\link[data.table]{data.table}}) readability word statistics.
#' @export
#' @examples
#' x <- c("I like excellent chicken.", "I want eggs Benedict now.", "Really?",
#'     "I thought that was good.  Well a bit weird.", "I know right!")
#' readability_word_stats(x)
#'
#' \dontrun{
#' readability_word_stats(presidential_debates_2012$dialogue)
#' }
readability_word_stats <- function(x, ...){

    n.complex <- text.var <- count <- element_id <- NULL

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
        n.sents = sum(sent_count(text.var, ...), na.rm = TRUE)),  keyby = "element_id"]

    gunning <- gsub("(?<=[a-z]{3})(ing|es|ed)$", "",
        stringi::stri_trans_tolower(x), perl=TRUE)
    proper_noun_regex <- paste(paste0("\\b",
        .common_polysyllabic_proper_nouns, "\\b"), collapse = "|")

    dat_complex <- data.frame(
        element_id = seq_along(x),
        count = tally_poly_vector(sub("(^.+[^aeiou])e[sd]$", "\\1",
            gsub(proper_noun_regex, "", x, perl=TRUE))),
        stringsAsFactors = FALSE
    )

    data.table::setDT(dat_complex)
    out3 <- dat_complex[, list(n.complexes = sum(count, na.rm = TRUE)),
        keyby = "element_id"]

    out <- Reduce(merge,list(out1, out2, out3))[, element_id:=NULL]

    data.table::setcolorder(out, c("n.sents", "n.words", "n.chars", "n.sylls",
        "n.shorts", "n.polys", "n.complexes"))
    out[]
}

.common_polysyllabic_proper_nouns <- c("aberdeen", "abilene", "abraham", "afghanistan", "african",
"alabama", "alaska", "albania", "albany", "albuquerque", "alexandria",
"algeria", "allentown", "amarillo", "anaheim", "anchorage", "andorra",
"angola", "antigua", "appleton", "argentina", "arizona", "arkansas",
"arlington", "armenia", "arvada", "asheville", "atlanta", "augusta",
"aurora", "australia", "austria", "azerbaijan", "bahamas", "bakersfield",
"baltimore", "bangladesh", "barbados", "barnstable", "belarus",
"bellevue", "benjamin", "bethlehem", "birmingham", "bloomington",
"bolivia", "bosnia", "botswana", "bradenton", "bremerton", "bridgeport",
"brownsville", "buchanan", "buffalo", "bulgaria", "burkina",
"burlington", "burundi", "california", "cambodia", "cameroon",
"canada", "carolina", "carrollton", "chattanooga", "chesapeake",
"chicago", "cincinnati", "clarksville", "clearwater", "colombia",
"colorado", "columbia", "columbus", "comoros", "connecticut",
"corona", "covina", "croatia", "dakota", "danbury", "davenport",
"december", "delaware", "deltona", "djibouti", "dominica", "dominican",
"ecuador", "eisenhower", "elizabeth", "emirates", "equatorial",
"eritrea", "escondido", "estonia", "ethiopia", "evansville",
"fayetteville", "february", "florida", "fontana", "frederick",
"fullerton", "gainesville", "gambia", "gastonia", "germany",
"greensboro", "greenville", "grenada", "guatemala", "hagerstown",
"harrisburg", "harrison", "hawaii", "herzegovina", "hesperia",
"honolulu", "hungary", "idaho", "illinois", "independence", "indiana",
"indianapolis", "indonesia", "inglewood", "iowa", "israel", "italy",
"ivory", "january", "jefferson", "kennedy", "kenosha", "kentucky",
"knoxville", "korea", "lakewood", "lancaster", "latvia", "lauderdale",
"lebanon", "leone", "lesotho", "lewisville", "lexington", "liberia",
"libya", "liechtenstein", "lithuania", "louisiana", "louisville",
"luxembourg", "macedonia", "madagascar", "madison", "malawi",
"malaysia", "manchester", "marina", "marino", "maryland", "marysville",
"massachusetts", "mauritius", "mckinley", "mexico", "michigan",
"micronesia", "minneapolis", "minnesota", "miramar", "mississippi",
"missouri", "moldova", "monaco", "mongolia", "montana", "montenegro",
"montgomery", "morocco", "mozambique", "murrieta", "muskegon",
"nauru", "nebraska", "nevada", "november", "obama", "oceanside",
"october", "odessa", "ohio", "oklahoma", "omaha", "ontario",
"oregon", "papua", "paterson", "pennsylvania", "philippines",
"principe", "providence", "republic", "roosevelt", "rutherford",
"saginaw", "salvador", "samoa", "saturday", "savannah", "senegal",
"september", "serbia", "shreveport", "singapore", "slovakia",
"slovenia", "solomon", "swaziland", "syracuse", "syria", "tacoma",
"tallahassee", "tanzania", "tennessee", "theodore", "tobago",
"topeka", "tunisia", "ulysses", "united", "uzbekistan", "vallejo",
"vancouver", "vanuatu", "vatican", "venezuela", "vietnam", "virginia",
"washington", "waterbury", "waterloo", "wichita", "wilmington",
"wisconsin", "wyoming", "zachary", "zimbabwe")
