#' Record results on a centralized database
#'
#' @param tutorial_id The identifier of the tutorial.
#' @param tutorial_version The version of the tutorial.
#' @param user_id The user identifier for this learnr process.
#' @param event The event that triggers the record, like `exercise_submission`
#' or `question_submission`
#' @param data A JSON field with event-dependent data content.
#' @param value The new value for user name or email (if not provided, the
#' current value is returned).
#'
#' @description Record tutorial submissions in a centralized database. The
#' function is used by learnr tutorials and is not for end-users.
#'
#' @return Nothing. The function is used for its side-effects.
#' @export
#' @seealso [run()]
#' @keywords utilities
#' @concept record events from the BioDataScience package
record_sdd <- function(tutorial_id, tutorial_version, user_id, event, data) {
  bds_file <- "~/.local/share/R/learnr/biodatascience"
  add_file_base64 <- function(entry, file) {
    str <- gsub("\n", "", base64_enc(serialize(entry, NULL)))
    dir.create(dirname(file), showWarnings = FALSE, recursive = TRUE)
    cat(str, "\n", file = file, append = TRUE)
  }
  label <- data$label
  if (is.null(label)) label <- ""
  data$label <- NULL
  correct <- data$correct
  if (is.null(correct)) {
    correct <- data$feedback$correct
    if (is.null(correct))
      correct <- ""
  }
  data$correct <- NULL
  entry <- data.frame(
    date = format(Sys.time(), format = "%Y-%m-%d %H:%M:%OS6", tz = "GMT"),
    tutorial = tutorial_id, version = tutorial_version, user = user_id,
    user_name = user_name(), user_email = user_email(), label = label,
    correct = correct, event = event, data = list_to_json(data))
  # Not a good idea: if user never clicks "Submit", nothing is fed to database
  #if (correct == "") {
  #  add_file_base64(entry, file = bds_file)
  #  return()
  #}
  # Once http request with stitch will be available, we could do something like
  #https://stitch.mongodb.com/api/client/v2.0/app/sdd-relay-aizkd/service/sdd-http/incoming_webhook/webhook0
  db_injected <- FALSE
  m <- try(mongo("sdd",
    #url = "mongodb://sdd:sdd@ds125388.mlab.com:25388/sdd-test")$insert(entry)
    url = "mongodb://sdd:sdd@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin"),
    silent = TRUE)
  if (!inherits(m, "try-error") #&&
      # No run() methods in mongolite 1.5
      #m$run(command = "{\"ping\": 1}", simplify = TRUE)$ok == 1) {
      #m$count() > -1
      ) {
    res <- try(m$insert(entry), silent = TRUE)
    # If there is something in the biodatascience file, inject it also now
    if (!inherits(res, "try-error")) {
      db_injected <- TRUE
      # Check if we also need to inject pending records
      if (file.exists(bds_file)) {
        dat <- readLines(bds_file)
        unlink(bds_file)
        if (length(dat))
          for (i in 1:length(dat))
            m$insert(unserialize(base64_dec(dat[i])))
      }
    }
    # No disconnect() method in mongolite 1.5
    #m$disconnect()
  }
  # Only get rid of the entry if it was actually injected in the database
  if (!isTRUE(db_injected)) {# MongoDB database not available, or error... save locally
    add_file_base64(entry, file = bds_file)
  }
}
# Use: options(tutorial.event_recorder = record_sdd)
#
# To collect these data:
collect_sdd <- function(user, password) {
  mdb <- mongolite::mongo("sdd",
    url = paste0("mongodb://", user, ":", password, "@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin"))
  #print(mdb)
  if (mdb$count())
    mdb$find()
}
#sdd_data <- collect_sdd(); View(sdd_data)

#' @export
#' @rdname record_sdd
user_name <- function(value) {
  if (missing(value)) {
    Sys.unsetenv("SDD_USER")
    user <- Sys.getenv("SDD_USER", unset = "")
    if (user == "") {
      user <- try(suppressWarnings(system("git config --global user.name",
        intern = TRUE, ignore.stderr = TRUE)), silent = TRUE)
      if (inherits(user, "try-error")) user <- ""
    }
    user
  } else {# Change user
    # Make sure new_user is correct
    new_user <- as.character(value)[1]
    new_user <- gsub(" ", "_", new_user)
    Sys.setenv(SDD_USER = new_user)
    cmd <- paste0("git config --global user.name '", new_user, "'")
    try(suppressWarnings(system(cmd, intern = TRUE, ignore.stderr = TRUE)),
      silent = TRUE)
    new_user
  }
}

#' @export
#' @rdname record_sdd
user_email <- function(value) {
  if (missing(value)) {
    Sys.unsetenv("SDD_EMAIL")
    email <- Sys.getenv("SDD_EMAIL", unset = "")
    if (email == "") {
      email <- try(suppressWarnings(system("git config --global user.email",
        intern = TRUE, ignore.stderr = TRUE)), silent = TRUE)
      if (inherits(email, "try-error")) email <- ""
    }
    email
  } else {# Change email
    # Make sure new_email is correct
    new_email <- as.character(value)[1]
    new_email <- gsub(" ", "_", new_email)
    Sys.setenv(SDD_EMAIL = new_email)
    cmd <- paste0("git config --global user.email '", new_email, "'")
    try(suppressWarnings(system(cmd, intern = TRUE, ignore.stderr = TRUE)),
      silent = TRUE)
    new_email
  }
}
