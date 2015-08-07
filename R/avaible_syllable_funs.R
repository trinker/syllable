#' Available Syllable Functions
#'
#' See a listing of all available syllable functions.
#'
#' @param ncols The number of columns to use.
#' @param \ldots Other arguments passed to \code{\link[base]{matrix}}.
#' @return Returns a \code{\link[base]{character}} vector,
#' \code{\link[base]{matrix}} of all syllable functions, or a
#' \code{\link[base]{list}} of syllable functions by type.
#' @keywords type
#' @export
#' @examples
#' avaible_syllable_funs()
#'
#' avaible_syllable_funs(ncols=3)
#' avaible_syllable_funs(1)
#' avaible_syllable_funs(byrow = TRUE)
avaible_syllable_funs <- function (ncols = 4, ...) {
    out <- get_variable_functions()
    return(variables_as_matrix(out, ncols = ncols, ...))
}


get_variable_functions <- function () {
    db <- tools::Rd_db("syllable")
    syllfl <- as.character(db[["count_vector.Rd"]])
    seealso <- 1 + grep("Other syllable.functions: ", syllfl,
        ignore.case = TRUE)
    exmpls <- -1 + grep("\\\\examples", syllfl, ignore.case = TRUE)
    funs <- paste(syllfl[seealso:exmpls], collapse = "")
    funs <- regmatches(funs, gregexpr("(?<=link\\{)(.*?)(?=\\})",
        funs, perl = TRUE))[[1]]
    sort(unique(c(funs, "count_vector")))
}

variables_as_matrix <- function (variable_functions, ncols = 5, ...) {
    needed_blanks <- round(ncols * (ceiling(length(variable_functions)/ncols) -
        length(variable_functions)/ncols))
    blanks <- rep(NA, times = needed_blanks)
    output <- matrix(c(variable_functions, blanks), ncol = ncols, ...)
    class(output) <- c("available", "available_matrix", class(output))
    attributes(output)[["blanks"]] <- needed_blanks
    output
}


' Prints an available Object.
#'
#' Prints an available object.
#'
#' @param x The available object
#' @param \ldots ignored
#' @method print available
#' @export
print.available <- function(x, ...){

    rms <- c("available", "available_matrix", "available_list")

    class(x) <- class(x)[!class(x) %in% rms]
    attributes(x)[["blanks"]] <- NULL
    print(x, na.print = "")

}

