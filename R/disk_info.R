#' Show disk information
#'
#' @description
#' Calculate disk size total, used and free for a path (or for all disks if
#' `path = ""`) using the `df` unix command.
#'
#' @param path The path to look for.
#' @param intern If `TRUE`, the output is returned as a character vector,
#' otherwise the output is directly printed at the console.
#'
#' @return With `intern = TRUE`, a character vector with the output of the
#' command. Otherwise, the function is used for its side effect of printing the
#' information at the console.
#'
#' @export
#'
#' @examples
#' disk_info()
#' disk_info("")
disk_info <- function(path = "/home/jovyan", intern = FALSE) {
  system(paste("df -h", path), intern = intern)
}
