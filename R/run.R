#' Run learnr tutorials from the BioDataScience package
#'
#' @param tutorial The name of the tutorial to use. If not provided, a list of
#' available tutorials is displayed.
#' @param ... Further arguments passed to [run_tutorial()]
#'
#' @description Start the learnr R engine in the current R session with the
#' selected tutorial.
#'
#' @return If `tutorial` is not provided, a list of available tutorials.
#' @export
#' @seealso [run_tutorial()]
#' @keywords utilities
#' @concept run interactive learnr documents from the BioDataScience package
#' @examples
#' # To list the availalble tutorials:
#' run()
#' \dontrun{
#' run("module02a_nuage_de_points")
#' }
run <- function(tutorial, ...) {
  if (missing(tutorial))
    return(dir(system.file("tutorials", package = "BioDataScience")))
  learnr::run_tutorial(tutorial, package = "BioDataScience", ...)
}