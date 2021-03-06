% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_syllable_counts.R
\name{compute_syllable_counts}
\alias{compute_syllable_counts}
\title{Compute Syllable Counts}
\usage{
compute_syllable_counts(x, ...)
}
\arguments{
\item{x}{A character vector of terms.}

\item{\ldots}{ignored.}
}
\value{
Returns a vector of syllable counts.
}
\description{
A computational approach to determine syllable counts.  The function uses
regular expressions and linguistical logic to compute the number of syllables
in a term.
}
\examples{
terms <- c("other", "about", "many", "into", "number", "people", "water",
    "over", "only", "little", "very", "after", "sentence", "before",
    "any", "follow", "also", "around", "another", "even", "because",
    "different", "picture", "again", "away", "animal", "letter",
    "mother", "answer", "study", "America")

stats::setNames(compute_syllable_counts(terms), terms)
}

