#' Convert to HTML documents an Rmarkdown with specific rules
#'
#' Convert Rmarkdown file in an HTML document a serie of predefined arguments
#' in order to meet the requirements of the biological data science course.
#' This functions use \code{render()} and \code{html_document()}
#'
#'
#' @param path the path of the Rmd file.
#' @param ... The arguments of render()
#'
#' @import rmarkdown
#'
#' @return  an html document
#' @export
#'
#' @examples
#' #library(pfunctions)
#' #test <- render_sdd(path = "file.Rmd")
#'
render_sdd <- function(path, ...){
  rmarkdown::render(path,
      output_format = rmarkdown::html_document(
        toc = TRUE, number_sections = TRUE, code_folding = "hide",
        anchor_sections = TRUE, self_contained = FALSE), quiet = TRUE,...)
}

