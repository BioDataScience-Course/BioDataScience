#' Record results on a centralized database
#'
#' @param tutorial_id The identifier of the tutorial.
#' @param tutorial_version The version of the tutorial.
#' @param user_id The user identifier for this learnr process.
#' @param event The event that triggers the record, like `exercise_submission`
#' or `question_submission`
#' @param data A JSON field with event-dependent data content.
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
  user_name <- suppressWarnings(system("git config user.name",
    intern = TRUE, ignore.stderr = TRUE))
  user_email <- suppressWarnings(system("git config user.email",
    intern = TRUE, ignore.stderr = TRUE))
  #user_full_id <- paste(user_id, user_name, user_email, sep = "/")
  date <- Sys.time()
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
  entry <- data.frame(date = date, tutorial = tutorial_id,
    version = tutorial_version, user = user_id, user_name = user_name,
    user_email = user_email, label = label, correct = correct, event = event,
    data = list_to_json(data))
  # Not a good idea: if user never clicks "Submit", nothing is fed to database
  #if (correct == "") {
  #  add_file_base64(entry, file = bds_file)
  #  return()
  #}
  # Once http request with stitch will be available, we could do something like
  #https://stitch.mongodb.com/api/client/v2.0/app/sdd-relay-aizkd/service/sdd-http/incoming_webhook/webhook0
  m <- try(mongo("sdd",
    #url = "mongodb://sdd:sdd@ds125388.mlab.com:25388/sdd-test")$insert(entry)
    url = "mongodb://sdd:sdd@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin"),
    silent = TRUE)
  if (!inherits(m, "try-error") &&
      #m$run(command = "{\"ping\": 1}", simplify = TRUE)$ok == 1) {
      m$count() > -1) {
    m$insert(entry)
    # If there is something in the biodatascience file, inject it also now
    if (file.exists(bds_file)) {
      dat <- readLines(bds_file)
      unlink(bds_file)
      if (length(dat))
        for (i in 1:length(dat))
          m$insert(unserialize(base64_dec(dat[i])))
    }
    m$disconnect()
  } else {# MongoDB database not available... save locally
    add_file_base64(entry, file = bds_file)
  }
}
# Use: options(tutorial.event_recorder = record_sdd)
#
# To collect these data:
collect_sdd <- function() {
  mdb <- mongolite::mongo("sdd", #url = "mongodb://sdd:sdd@ds125318.mlab.com:25318/sdd-cours")
    #url = "mongodb://sdd:sdd@ds125388.mlab.com:25388/sdd-test")
    url = "mongodb://sdd:sdd@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin")
    # url = "mongodb://sdd:sdd@sdd-umons-shard-00-01-umnnw.mongodb.net:27017")
    #mongodb://sdd:<PASSWORD>@sdd-umons-shard-00-00-umnnw.mongodb.net:27017,sdd-umons-shard-00-01-umnnw.mongodb.net:27017,sdd-umons-shard-00-02-umnnw.mongodb.net:27017/test?ssl=true&replicaSet=sdd-umons-shard-0&authSource=admin
  #print(mdb)
  if (mdb$count())
    mdb$find()
}
#sdd_data <- collect_sdd(); View(sdd_data)
