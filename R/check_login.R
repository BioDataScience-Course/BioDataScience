#' Check login, Internet and database access
#'
#' This function checks if the login and email provided are already known in
#' the SDD database. It also checks Internet access and SDD database access.
#'
#' @param login The user's login (same one as Github login).
#' @param email The user's email address.
#'
#' @return A vector of three boolean for `internet`, `login` and `db` checks,
#' plus a comment with a message.

#' @export
#' @seealso [run()], [record_sdd()]
#' @keywords utilities
#' @concept check login for the BioDataScience package
check_login <- function(login, email) {
  # Check database access
  m <- try(mongo("sdd",
    url = "mongodb://sdd:sdd@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin"),
    silent = TRUE)
  db_access <- (!inherits(m, "try-error"))

  student_url <- paste("https://biodatascience-course.sciviews.org/logins",
    login, tolower(sub("@", "_at_", email)), sep = "/")
  check <- try(suppressWarnings(readRDS(url(student_url))), silent = TRUE)
  if (inherits(check, "try-error")) {
    # Check if the site is reponding by testing a known login
    check2 <- try(suppressWarnings(readRDS(url(paste(
      "https://biodatascience-course.sciviews.org/logins", "phgrosjean",
      "phgrosjean_at_sciviews.org", sep = "/")))), silent = TRUE)
    if (inherits(check2, "try-error")) {
      res <- structure(c(internet = FALSE, login = NA, db = db_access),
        comment = "Pas de connexion Internet ou site SDD indisponible !")
    } else {# Access verified, thus, login or email is wrong
      res <- structure(c(internet = TRUE, login = FALSE, db = db_access),
       comment = "Login inconnu ou email incorrect !")
    }
  } else {# We got the data
    user <- paste(check$name, check$surname)
    if (!db_access) {
      res <- structure(c(internet = TRUE, login = TRUE, db = FALSE),
        comment = paste0("Bonjour ", user,
          ", base de donn\u00e9es inaccessible !"))
    } else {# Everything is fine!
      res <- structure(c(internet = TRUE, login = TRUE, db = TRUE),
        comment = paste0("Bonjour ", user, ", tout fonctionne."))
    }
  }
  res
}
