#' Convert to HTML documents all Rmarkdown in a project
#'
#'Find all R markdown files in a Rstudio project and try to convert then an HTML document.
#'This functions use \code{html_document()} and a serie of predefined arguments
#'in order to meet the requirements of the biological data science course.
#'
#' @param path the path of the project
#' @param correction If the correction is TRUE, a copy of rmd file do not convert is created.
#'
#' @import rprojroot rmarkdown
#'
#' @return  a data.frame with the results of the compilations in html
#' @export
#'
#' @examples
#' #library(pfunctions)
#' #test <- render_all_rmd_project()
#'
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
