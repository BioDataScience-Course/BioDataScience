#' Get centralized information for the BioDataScience course
#'
#' Use this function to get small peices of text from a centralized repository.
#' This is a convenience function to retrieve, say, links, pieces of R code, or
#' other textual information in relation with the current BioDataScience course.
#' To be used only by students currently involved in a course.
#'
#' @param echo Is the textual information echoed in the console (`TRUE` by default).
#' @param skipNul Do we skip nul characters in the text (`TRUE`  by default)?
#'
#' @return The downloaded text is returned invisibly.
#' @export
#'
#' @examples
#' # If there is some textual information currently available in the central
#' # repository, you get it and dispaly it this way:
#' sdd_info()
#'
#' # To place this text in a variable silently, do this:
#' txt <- sdd_info(echo = FALSE)
#' txt
sdd_info <- function(echo = TRUE, skipNul = TRUE) {
  sdd_url <- url("https://go.sciviews.org/sdd_info")
  open(sdd_url)
  on.exit(try(close(sdd_url), silent = TRUE))
  sdd_data <- readLines(sdd_url, encoding = "UTF-8", warn = FALSE,
    skipNul = skipNul)
  if (isTRUE(echo))
    cat(sdd_data, sep = "\n")
  invisible(sdd_data)
}
