#' Initialize the environment for our BioDataScience courses
#'
#' This function creates several environment variables that are widely used by
#' other packages and applications. Currently, `MONGO_URL`, `MONGO_BASE`,
#' `MONGO_USER` and `MONGO_PASSWORD` are set to default values if not already
#' there.
#'
#' @return Nothing, the function is used for its side-effect of creating global
#' variables.
#' @export
#'
#' @examples
#' # Use this at the beginning of your learndown Shiny or learnr applications
#' BioDataScience::init()
#' # Now, you have access to MONGO_URL and MONGO_BASE
#' Sys.getenv("MONGO_URL")
#' Sys.getenv("MONGO_BASE")
init <- function() {
  # Set variable environment required to locate our sdd MongoDB database
  if (Sys.getenv("MONGO_URL") == "")
    Sys.setenv(MONGO_URL = "mongodb://{user}:{password}@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin")
  if (Sys.getenv("MONGO_BASE") == "")
    Sys.setenv(MONGO_BASE = "sdd")
  if (Sys.getenv("MONGO_USER") == "")
    Sys.setenv(MONGO_USER = "sdd")
  if (Sys.getenv("MONGO_PASSWORD") == "")
    Sys.setenv(MONGO_PASSWORD = "sdd")
  # ... other global stuff to do here...
  return()
}
