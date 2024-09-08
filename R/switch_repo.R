#' Switch the remote URL of a GitHUb repository between HTTPS and SSH
#'
#' Use this function to easily switch the remote URL of a GitHub repository
#' between HTTPS and SSH. GitHub allows for the two modes, but if the machine is
#' configured in one mode and a clone is created in the other mode, one cannot
#' push or pull. The correction is easy to do at the command line, but this
#' function makes it even easier.
#'
#' @param verbose If `TRUE` (by default), the function produces a message that explain what
#'   was done.
#'
#' @return The new remote URL for the GitHub repository is returned.
#' @export
#' @importFrom gert git_remote_info git_remote_set_url
#'
#' @examples
#' # Run only when you know what you are doing: the remote URL is changed!
#' #switch_repo()
switch_repo <- function(verbose = TRUE) {
  repo_url <- try(gert::git_remote_info()$url, silent = TRUE)
  if (inherits(repo_url, "try-error"))
    stop("Cannot get info about current GitHub repository (is one edited?)")

  # The two forms are:
  # git@github.com:<user_or_org>/<repo>.git
  # https://github.com/<user_or_org>/<repo>.git
  if (!grepl("^git@github\\.com:.+/.+\\.git$", repo_url) &&
      !grepl("^https://github\\.com/.+/.+\\.git$", repo_url))
    stop("Unrecognized remote: ", repo_url)

  if (grepl("^git@github\\.com:.+/.+\\.git$", repo_url)) {# SSH -> HTTPS
    repo_url2 <- sub("^git@github\\.com:(.+/.+\\.git)$",
      "https://github.com/\\1", repo_url)
  } else {#HTTPS -> SSH
    repo_url2 <- sub("^https://github\\.com/(.+/.+\\.git)$",
      "git@github.com:\\1", repo_url)
  }

  res <- try(gert::git_remote_set_url(repo_url2), silent = TRUE)
  if (inherits(res, "try-error"))
    stop("Error while changhing the remote URL: ", res)

  if (isTRUE(verbose))
    message("Remote URL changed from: ", repo_url, " to ", repo_url2)

  repo_url2
}
