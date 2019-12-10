#' Send your BioDataScience submissions by email
#'
#' @param file The file that contains your submissions information.
#'
#' @description Your submissions are send to a central database. However, in
#' case that database is not accessible, the data is stored locally. This
#' function uses your plain email to send your records. Note that, once the
#' email is created, the local version of your records is reset. So, if you
#' finally decide to NOT send the email, these records are lost (in this case,
#' call your teachers to recover them, if you have to.)
#'
#' @return The data are returned invisibly.
#' @export
#' @seealso [run()]
#' @keywords utilities
#' @concept run interactive learnr documents from the BioDataScience package
#' @examples
#' # To start from a list of available tutorials:
#' run()
#' \dontrun{
#' run("02b_nuage_points")
#' }
send_mail_sdd <- function(file = "~/.local/share/R/learnr/biodatascience") {
  if (file.exists(file)) {
    data <- readLines(file)
    file.rename(file, paste0(file, ".bak")) # One backup, just in case!
    create.post("Dear BioDataScience user,

Send this email without changing recipient, title and bottom of the message
to record your tutorial activities.

Thanks,

The BioDataScience Team
",
      description = "post", info = data,
      subject = "sdd-umons", address = "sdd@sciviews.org")
    invisible(data)
  } else {
    message("Nothing to send to the BioDataScience database")
    invisible(character(0))
  }
}