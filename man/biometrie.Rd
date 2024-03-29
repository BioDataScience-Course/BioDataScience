% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{biometrie}
\alias{biometrie}
\title{Mesure de biométrie humaine}
\format{
Un tableau de données de sept variables et 395 observations:
\describe{
\item{\code{genre}}{une variable facteur à deux niveaux :
Homme (H) et Femme (F).}
\item{\code{ddn}}{Date de naissance (YYYY-MM-DD).}
\item{\code{masse}}{Masse des individus (en kg).}
\item{\code{taille}}{Taille des individus (en cm).}
\item{\code{poignet}}{Tour de poignet (en mm).}
\item{\code{ddm}}{Date des mesures.}
\item{\code{age}}{Âge des individus lors de la prise de mesures (en années).}
}
}
\usage{
biometrie
}
\description{
Compilation d'un ensemble de mesures biométriques réalisée par les étudiants
de l'Université de Mons dans le cadre du cours de biostatistique et
probabilités entre 2013 et 2017.
}
\examples{
data(biometrie)
class(biometrie)
head(biometrie)
plot(biometrie)
}
\keyword{datasets}
