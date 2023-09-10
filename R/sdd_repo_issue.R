#' Create an issue in the current GitHub repository
#'
#' Use this function to quickly of a new issue in the repository that is
#' currently edited in RStudio.
#'
#' @return Invisibly `TRUE` if it succeeds, or `FALSE`, e.g., no repository is
#'   currently edited (and a warning is issued too).
#' @export
#' @importFrom gert git_remote_info
#' @umportFrom rstudioapi showDialog
#'
#' @examples
#' sdd_repo_issue()
sdd_repo_issue <- function() {
  repo_url <- try(gert::git_remote_info()$url, silent = TRUE)
  if (inherits(repo_url, "try-error")) {
    warning("Cannot get info about current GitHub repository (is one edited?)")
    return(invisible(FALSE))
  }
  # Rework the URL if it is a git@github.com:... URL
  repo_url <- sub("^git@github\\.com:", "https://github.com/", repo_url)
  # Replace the end (.git) with "/issues/new"
  repo_url <- sub("\\.git$", "/issues/new", repo_url)
  # Display a message with short instructions + url
  rstudioapi::showDialog(title = "Nouvelle issue sp\u00e9cifique au projet",
    url = repo_url,
    message = paste0(
      "Cliquez sur le lien ci-dessous pour cr\u00e9er l'issue. ",
      "Indiquez un titre et commencez le message par ",
      "@BioDataScience-Course/teachers pour notifier ",
      "imm\u00e9diatement vos enseignants de votre question. ",
      "Ajoutez \u00e9ventuellement une capture d'\u00e9cran explicite."))
  invisible(TRUE)
}
