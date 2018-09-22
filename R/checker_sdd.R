#' A default checker that just aknowledge submission
#'
#' @param label The label for the learnr exercice.
#' @param user_code The code submitted by the user.
#' @param check_code The code to check against.
#' @param envir_result The environment for results.
#' @param evaluate_result Result from evaluation of the code.
#' @param ... Additional parameters.
#'
#' @description Check code submitted during an exercice. This version just
#' acknowledges reception of the submission. This function is used internally
#' by the tutorials and is not intended for the end-user.
#'
#' @return A list with components `message`, `correct` and `location`.
#' @export
#' @seealso [run()]
#' @keywords utilities
#' @concept record events from the BioDataScience package
checker_sdd <- function(label, user_code, check_code, envir_result,
evaluate_result, ...) {
  list(message = "Your answer is recorded!", correct = TRUE, location = "append")
}
#Use: tutorial_options(exercise.checker = checker_sdd)
#
# Later, we would do something like this:
#library(checkr)
#tutorial_options(exercise.checker = checkr::check_for_learnr)
#check_two_plus_two <- function(USER_CODE) {
#  code <- for_checkr(USER_CODE)
#  # The messages
#  m1 <- "Correct!"
#  m2 <- "You should use the '+' operator."
#  m3 <- "Another error."
#  m4 <- "Again another error message."
#
#  result <- line_where(code,
#                      passif(Z == "+"),
#                      failif(Z == "", m3),
#                      failif(TRUE, m4))
#  result
#}