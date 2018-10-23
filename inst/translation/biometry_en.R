.biometry_en <- function(biometry, labels_only = FALSE,
                           as_labelled = FALSE) {
  biometry <- labelise(biometry, self = FALSE,
                         label = list(
                           gender = "Gender",
                           day_birth = "Day of birth",
                           weight = "Weight",
                           height = "Height",
                           wrist = "Wrist circumference",
                           year_measure = "Year of the measure",
                           age = "Age"),
                         units = list(
                           gender = NA,
                           day_birth = NA,
                           weight = "kg",
                           height = "cm",
                           wrist = "mm",
                           year_measure = "year",
                           age = "year"),
                         as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    levels(biometry$gender) <- c("M", "W")
  }

  biometry
}
