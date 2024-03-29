% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sdd_repo_issue.R
\name{sdd_repo_issue}
\alias{sdd_repo_issue}
\title{Create an issue in the current GitHub repository}
\usage{
sdd_repo_issue()
}
\value{
Invisibly \code{TRUE} if it succeeds, or \code{FALSE}, e.g., no repository is
currently edited (and a warning is issued too).
}
\description{
Use this function to quickly of a new issue in the repository that is
currently edited in RStudio.
}
\examples{
sdd_repo_issue()
}
