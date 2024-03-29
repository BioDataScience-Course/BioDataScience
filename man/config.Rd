% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/config.R
\name{config}
\alias{config}
\alias{sign_in}
\alias{sign_out}
\alias{obfuscator}
\title{Configure the R environment to access the database, to register users and to
decipher learnr items}
\usage{
config(debug = Sys.getenv("LEARNITDOWN_DEBUG", 0) != 0)

sign_in(data, debug = Sys.getenv("LEARNITDOWN_DEBUG", 0) != 0)

sign_out(debug = Sys.getenv("LEARNITDOWN_DEBUG", 0) != 0)

obfuscator()
}
\arguments{
\item{debug}{Do we issue debugging messages (by default, yes if the
environment variables \code{LEARNITDOWN_DEBUG} is not \code{0}).}

\item{data}{Fingerprint data (user information) either in clear, or ciphered.
In this case, the string must start with "fingerprint=".}
}
\value{
\code{TRUE} or \code{FALSE} invisibly, if it succeeds or not (with database
access test). For \code{\link[=obfuscator]{obfuscator()}} a list with configuration data is
returned.
}
\description{
These functions configure the R environment to allow recording of learnr and
Shiny apps activity in a database, for a given user. Environment variables
are added with info about the database and files are written in the user's
directory with cache data.
}
