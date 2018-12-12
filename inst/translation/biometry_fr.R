.biometry_fr <- function(biometry, labels_only = FALSE,
                         as_labelled = FALSE) {
  biometry <- labelise(biometry, self = FALSE,
                       label = list(
                         gender = "Genre",
                         day_birth = "Date de naissance",
                         weight = "Masse",
                         height = "Taille",
                         wrist = "Circomférence du poignet",
                         year_measure = "Année de la mesure",
                         age = "Age"),
                       units = list(
                         gender = NA,
                         day_birth = NA,
                         weight = "kg",
                         height = "cm",
                         wrist = "mm",
                         year_measure = "année",
                         age = "année"),
                       as_labelled = as_labelled)

  if (!isTRUE(labels_only)) {
    levels(biometry$gender) <- c("H", "F")
  }

  biometry
}
