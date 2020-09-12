#' Configure the R environment to access my MongoDB database, and provide or
#' cache user information for reuse in learnr and shiny applications that are
#' run locally.
#'
#' Environment variables are added with infos about my database and files
#' are written in the user's directory with cache data.
#'
#' @param data Fingerprint data (user information) either in clear, or ciphered. In
#' this case, the string must start with "fingerprint=".
#' @param debug Do we issue debugging messages (by default, yes if the
#' environment variables `LEARNDOWN_DEBUG` is not `0`).
#'
#' @return `TRUE` or `FALSE` invisibly, if it succeeds or not (with database
#' access test).
#' @export
config <- function(debug = Sys.getenv("LEARNDOWN_DEBUG", 0) != 0) {
  learndown::config(
    url = "https://wp.sciviews.org/biodatascience_config",
    password = .pass_conf,
    cache = "~/.biodatascience_config",
    debug = debug)
}

#' @rdname config
#' @export
sign_in <- function(data, debug = Sys.getenv("LEARNDOWN_DEBUG", 0) != 0) {
  learndown::sign_in(data = data,
    password = .pass_user, iv = .iv_user,
    cache = "~/.biodatascience_user",
    debug = debug)
}

#' @rdname config
#' @export
sign_out <- function(debug = Sys.getenv("LEARNDOWN_DEBUG", 0) != 0) {
  learndown::sign_out(title = "D\u00e9senregistement",
    message = "Confirmez-vous que vous voulez vous d\u00e9senregistrer (votre activit\u00e9 dans les tutoriels learnr et les applications Shiny ne sera plus enregistr\u00e9e) ?",
    cache = "~/.biodatascience_user",
    debug = debug)
}

# These items should better be hidden... but how?
.pass_conf <- "$G8rLCuk4D7g!G%!kH@BzzvWKpa&LT6d"
.pass_user <- "R*.px_#:4hVXZ#d#&,0fU52lEzc6.,Qv"
.iv_user <- "1638369746832634"
