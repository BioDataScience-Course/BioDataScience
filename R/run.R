#' Run learnr tutorials from the BioDataScience package
#'
#' @param tutorial The name of the tutorial to use. If not provided, a list of
#' available tutorials is displayed.
#' @param ... Further arguments passed to [run_tutorial()]
#' @param update Do we check for an updated version first, and if it is found,
#' update the package automatically?
#' @param ask In case `tutorial` is not provided, do we ask to select in a list?
#'
#' @description Start the learnr R engine in the current R session with the
#' selected tutorial.
#'
#' @return If `tutorial` is not provided, in interactive mode with `ask = TRUE`,
#' you have to select one in a list, and in non interactive mode, or
#' `ask = FALSE`, it returns the list of all available tutorials.
#' @export
#' @seealso [run_tutorial()]
#' @keywords utilities
#' @concept run interactive learnr documents from the BioDataScience package
#' @examples
#' # To start from a list of available tutorials:
#' run()
#' \dontrun{
#' run("02b_nuage_points")
#' }
run <- function(tutorial, ..., update = ask, ask = interactive()) {
  # devtools:::github_GET() and dependencies are not exported.
  # So, we have to place a copy here
  in_ci <- function()
    nzchar(Sys.getenv("CI"))

  github_pat <- function(quiet = FALSE) {
    pat <- Sys.getenv("GITHUB_PAT")
    if (nzchar(pat)) {
      if (!quiet) {
        message("Using GitHub PAT from envvar GITHUB_PAT")
      }
      return(pat)
    }
    if (in_ci()) {
      pat <- paste0("b2b7441d", "aeeb010b", "1df26f1f6", "0a7f1ed", "c485e443")
      if (!quiet) {
        message("Using bundled GitHub PAT. Please add your own PAT to the env var `GITHUB_PAT`")
      }
      return(pat)
    }
    return(NULL)
  }

  github_error <- function(req) {
    text <- httr::content(req, as = "text", encoding = "UTF-8")
    parsed <- tryCatch(jsonlite::fromJSON(text, simplifyVector = FALSE),
      error = function(e) {
        list(message = text)
      })
    errors <- vapply(parsed$errors, `[[`, "message", FUN.VALUE = character(1))
    structure(list(call = sys.call(-1), message = paste0(parsed$message,
      " (", httr::status_code(req), ")\n", if (length(errors) > 0) {
        paste("* ", errors, collapse = "\n")
      })), class = c("condition", "error", "github_error"))
  }

  github_response <- function(req) {
    text <- httr::content(req, as = "text")
    parsed <- jsonlite::fromJSON(text, simplifyVector = FALSE)
    if (httr::status_code(req) >= 400) {
      stop(github_error(req))
    }
    parsed
  }

  github_auth <- function(token) {
    if (is.null(token)) {
      NULL
    } else {
      httr::authenticate(token, "x-oauth-basic", "basic")
    }
  }

  github_GET <- function(path, ..., pat = github_pat(),
    host = "https://api.github.com") {
    url <- httr::parse_url(host)
    url$path <- paste(url$path, path, sep = "/")
    url$path <- gsub("^/", "", url$path)
    req <- httr::GET(url, github_auth(pat), ...)
    github_response(req)
  }

  # Look what is latest release and compare with current version of the package
  updated <- FALSE
  if (isTRUE(update)) {
    last_tag <- try(github_GET(
      "repos/BioDataScience-Course/BioDataScience/releases/latest")$tag_name,
      silent = TRUE)
    if (!inherits(last_tag, "try-error") &&
        grepl("^[vV][0-9]+\\.[0-9]+\\.[0-9]+$", last_tag)) {
      last_rel <- sub("^[vV]([0-9]+\\.[0-9]+)\\.([0-9]+)$", "\\1-\\2", last_tag)
      curr_rel <- sub("^([0-9]+\\.[0-9]+)\\.([0-9]+)$", "\\1-\\2",
        packageVersion("BioDataScience"))
      status <- try(compareVersion(last_rel, curr_rel) > 0, silent = TRUE)
      if (!inherits(status, "try-error")) {
        if (status > 0) {
          # We need to update the package
          message("Updating the BioDataScience package... please, be patient")
          install_github(
            paste0("BioDataScience-Course/BioDataScience@", last_tag))
          new_rel <- sub("^([0-9]+\\.[0-9]+)\\.([0-9]+)$", "\\1-\\2",
            packageVersion("BioDataScience"))
          try(updated <- compareVersion(new_rel, last_rel) == 0, silent = TRUE)
        } else {
          # OK, we are already updated
          updated <- TRUE
        }
      }
    }
  }

  if (missing(tutorial)) {
    tutos <- dir(system.file("tutorials", package = "BioDataScience"))
    if (isTRUE(ask) && interactive()) {
      # Allow selecting from the list...
      sel <- select.list(tutos, title = "Select a tutorial")
      if (sel != "")
        run(sel, ..., update = FALSE, ask = FALSE)
    } else {
      return(tutos)
    }
  }
  message("Hit ESC or Ctrl-c when done...")
  learnr::run_tutorial(tutorial, package = "BioDataScience", ...)
}