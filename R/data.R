#'Mesure de biometrie humaine
#'
#'Compilation d'un ensemble de mesures biometriques réalisée par les étudiants
#' de l'UMONS dans le cadre du cours de biostatistique et probabilités
#' entre 2013 et 2017.
#'
#' @format Un tableau de données de 7 variables:
#' \describe{
#'  \item{\code{genre}}{une variable facteur à deux niveaux :
#'    Homme (H) et Femme (F).}
#'  \item{\code{ddn}}{Date de naissance (YYYY-MM-DD).}
#'  \item{\code{masse}}{Masse des individus (en kg).}
#'  \item{\code{taille}}{Taille des individus (en cm).}
#'  \item{\code{poignet}}{Circomférence du poignet (en mm).}
#'  \item{\code{ddm}}{Date des mesures.}
#'  \item{\code{age}}{Age des individus lors de la prise des mesures.}
#' }
#'
#' @examples
#' data(biometrie)
#' class(biometrie)
#' head(biometrie)
#' plot(biometrie)
"biometrie"

#' Measure of human biometry at Hainaut, Belgium
#'
#' Measure of human biometry to study health status with several index
#' as Body Weight Index (BMI) between 2013 an 2017.
#'
#' @format A data frame with 7 variables and 395 observations:
#' \describe{
#'   \item{\code{gender}}{A **factor** with two levels: `"Men"`, and `"Women"`.}
#'   \item{\code{day_birth}}{Day of birth (YYYY-MM-DD).}
#'   \item{\code{weight}}{Weight (in kg).}
#'   \item{\code{height}}{Height (in cm).}
#'   \item{\code{wrist}}{Wrist circumfernce (in mm).}
#'   \item{\code{year_measure}}{Year of the biometric measure.}
#'   \item{\code{age}}{Age of people.}
#' }
#'
"biometry"
