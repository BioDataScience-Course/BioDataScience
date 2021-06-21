#' Configure the R environment to access the database, to register users and to
#' decipher learnr items
#'
#' These functions configure the R environment to allow recording of learnr and
#' Shiny apps activity in a database, for a given user. Environment variables
#' are added with info about the database and files are written in the user's
#' directory with cache data.
#'
#' @param data Fingerprint data (user information) either in clear, or ciphered.
#' In this case, the string must start with "fingerprint=".
#' @param debug Do we issue debugging messages (by default, yes if the
#' environment variables `LEARNITDOWN_DEBUG` is not `0`).
#'
#' @return `TRUE` or `FALSE` invisibly, if it succeeds or not (with database
#' access test). For [obfuscator()] a list with configuration data is
#' returned.
#' @export
config <- function(debug = Sys.getenv("LEARNITDOWN_DEBUG", 0) != 0) {
  learnitdown::config(url = .url, cache = .config_file, debug = debug,
    password = learnitdown::unlock(.pass_conf, key = .key, message = .msg,
      ref1 = .pass_check))
}

#' @rdname config
#' @export
sign_in <- function(data, debug = Sys.getenv("LEARNITDOWN_DEBUG", 0) != 0) {
  learnitdown::sign_in(data = data, cache = .user_file, debug = debug,
    password = learnitdown::unlock(.pass_user, key = .key, message = .msg,
      ref1 = .pass_check),
    iv = .iv_user)
}

#' @rdname config
#' @export
sign_out <- function(debug = Sys.getenv("LEARNITDOWN_DEBUG", 0) != 0) {
  learnitdown::sign_out(title = "D\u00e9senregistrement",
    message = paste(
      "Confirmez-vous que vous voulez vous d\u00e9senregistrer de",
      "BioDataScience (votre activit\u00e9 dans les tutoriels learnr et les",
      "applications Shiny ne sera plus enregistr\u00e9e) ?"),
    cache = .user_file, debug = debug)
}

#' @rdname config
#' @export
obfuscator <- function() {
  list(key = paste(.key, "obfuscator", sep = "_"), message = .msg2,
    admin = .pass_admin, user = .pass_user)
}

# BioDataScience configuration
.key         <- "BioDataScience-Course_2021"
.msg         <- "Mot de passe de votre cours (si oubli\u00E9, le demander par mail \u00E0 sdd@sciviews.org):"
.msg2        <- "Mot de passe de d\u00E9chiffrage learnr:"
.url         <- "https://wp.sciviews.org/biodatascience_config_2021"
.user_file   <- "~/.biodatascience_user_2021"
.config_file <- "~/.biodatascience_config_2021"
.pass_admin  <- "o0MCeHci7zqJqJxurnxW5yU/21ZcyReqeIvBSNjEBbw/1MnHyoPeDMmfYo4u133P"
.pass_conf   <- "K9RrzXHETpZ9WAUX6tsM1vwivfKYqRke5jg73rB2nezt3IujO6yT2k3XMxcQuK7c"
.pass_user   <- "Etlc0+7OlJ7xj7a2SW+tvhNR+UGDjsXERfmkvWYxXTA1U1gxj3qGhjfrYt4TVgoI"
.iv_user     <- "1638369746832634"
.pass_check  <- "iX8AgLBBDpFrBtFV9zFNMA=="
# TODO: Old version, to be deleted!!!
## These items should better be hidden... but how?
#.pass_conf <- "$G8rLCuk4D7g!G%!kH@BzzvWKpa&LT6d"
#.pass_user <- "R*.px_#:4hVXZ#d#&,0fU52lEzc6.,Qv"
#.iv_user <- "1638369746832634"
