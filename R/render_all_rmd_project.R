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
        anchor_sections = TRUE, self_contained = FALSE), quiet = TRUE)
}

render_all_rmd_project <- function(path = ".", correction = FALSE) {

  # Check if us a rstuio project
  rprojroot::find_root(rprojroot::is_rstudio_project, path = path)

  # Find all rmd files
  paths <- list.files(path = path, pattern = "*.Rmd", recursive = TRUE)
  paths_lg <- length(paths)

  res <- data.frame(
    "file" = vector("character", paths_lg),
    "check" = vector("character", paths_lg),
    "result" = vector("character", paths_lg)
  )

  for(i in seq_along(paths)) {
    rmd_res <- try(rmarkdown::render(paths[i],
      output_format = rmarkdown::html_document(toc = TRUE, number_sections = TRUE, code_folding = "hide",
        anchor_sections = TRUE, self_contained = FALSE), quiet = TRUE),
      silent = TRUE)

    rmd_res1 <- list(
      "file" = paths[i] ,
      "check" = ifelse(class(rmd_res) == "try-error", yes = "ERROR", no = "OK"),
      "result" = as.character(rmd_res))

    res[i, ] <- rmd_res1
  }

  if(isTRUE(correction)) {
    res1 <- res[res$check == "ERROR",]

    if(nrow(res1)>0) {
      res1$file_corr <-gsub(".Rmd$", "_corr.Rmd", x = res1$file)
    }
      file.copy(from = res1$file, to = res1$file_corr)
  }

  return(res)
}
