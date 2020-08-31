#' Initialize the environment for our BioDataScience courses
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
  Sys.setenv(MONGO_URL = "mongodb://sdd:sdd@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin")
  Sys.setenv(MONGO_BASE = "sdd")
  # ... other global stuff to do here...
  return()
}
