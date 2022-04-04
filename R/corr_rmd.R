#' Convert to HTML documents all Rmarkdown in a project
#'
#'Find all R markdown files in a Rstudio project
#'and try to convert then an HTML document with \code{render_sdd()}.
#'
#' @param path the path of the project
#' @param correction If correction is TRUE, a copy of rmd file do not convert is created.
#'
#' @import rprojroot
#'
#' @return  a data.frame with the results of the compilations in html
#' @export
#'
#' @examples
#' #library(pfunctions)
#' #test <- corr_project()
#'
corr_rmd <- function(path = ".", correction = TRUE) {

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
    rmd_res <- try(render_sdd(paths[i]),
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
