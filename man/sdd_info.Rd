% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sdd_info.R
\name{sdd_info}
\alias{sdd_info}
\title{Get centralized information for the BioDataScience course}
\usage{
sdd_info(echo = TRUE, skipNul = TRUE)
}
\arguments{
\item{echo}{Is the textual information echoed in the console (\code{TRUE} by default).}

\item{skipNul}{Do we skip nul characters in the text (\code{TRUE}  by default)?}
}
\value{
The downloaded text is returned invisibly.
}
\description{
Use this function to get small pieces of text from a centralized repository.
This is a convenience function to retrieve, say, links, pieces of R code, or
other textual information in relation with the current BioDataScience course.
To be used only by students currently involved in a course.
}
\examples{
# If there is some textual information currently available in the central
# repository, you get it and dispaly it this way:
sdd_info()

# To place this text in a variable silently, do this:
txt <- sdd_info(echo = FALSE)
txt
}
