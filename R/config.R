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
.key         <- "SDD_PASSWORD_2025"
.msg         <- "Mot de passe de votre cours:"
.msg2        <- "Mot de passe de d\u00E9chiffrage learnr:"
.url         <- "https://wp.sciviews.org/biodatascience_config_2025"
.user_file   <- "~/.biodatascience_user_2025"
.config_file <- "~/.biodatascience_config_2025"
.pass_admin  <- "Jnn6GH26nV5Y6dMRXUpYx5G4oU8zXY4tQqV37OZERAs="
.pass_conf   <- "rwxun3aYqz8TsA0pB3JQgj7QFzYB4KwH+ORTJX10B2vRd3hX4EkI4JgGP25xT3DC"
.pass_user   <- "463Aq20z1PqMf88TsH6LXJIrdojq0GqQ3BPOT3sxmNslkc5XMTxEAKyVzrHbRQiA"
.iv_user     <- "9515146957321630"
.pass_check  <- "yftUFGicGLQfjB4LrYnd0w=="
