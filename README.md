# BioDataScience - Initialize the R environment for BioDataScience courses at the University of Mons, Belgium

[![Linux & OSX Build Status](https://travis-ci.org/SciViews/BioDataScience.svg )](https://travis-ci.org/SciViews/BioDataScience)
[![Win Build Status](https://ci.appveyor.com/api/projects/status/github/SciViews/BioDataScience?branch=master&svg=true)](http://ci.appveyor.com/project/phgrosjean/BioDataScience)
[![Coverage Status](https://img.shields.io/codecov/c/github/SciViews/BioDataScience/master.svg)
](https://codecov.io/github/SciViews/BioDataScience?branch=master)
[![CRAN Status](http://www.r-pkg.org/badges/version/BioDataScience)](http://cran.r-project.org/package=BioDataScience)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)


## Installation

### Latest stable version

The latest stable version of {BioDataScience} can be installed from [CRAN](http://cran.r-project.org) (note: not yet!):

```r
install.packages("BioDataScience")
```


### Development version

Make sure you have the {remotes} R package installed:

```r
install.packages("remotes")
```

Use `install_github()` to install the {BioDataScience} package from Github (source from **master** branch will be recompiled on your machine):

```r
remotes::install_github("BioDataScience-Course/BioDataScience")
```

R should install all required dependencies automatically, and then it should compile and install {BioDataScience}.

Latest development version of {BioDataScience} (source + Windows binaries for the latest stable version of R at the time of compilation) is also available from [appveyor](https://ci.appveyor.com/project/phgrosjean/BioDataScience/build/artifacts).


## Usage

There is really only one useful function: `init()` whose role is to initialize a series of variables required by the various {BioDataScienceX} packages.

```r
BioDataScience::init()
```

Get help about this package:

```r
library(help = "BioDataScience")
help("BioDataScience-package")
```

For further instructions, please, refer to these help pages.


## Note to developers

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
