# BioDataScience 2020.0.0

- Clean up finished. Most code moved to learndown. Learnr tutorials and Shiny
applications moved to {BioDataScience1}.

- The datasets`biometry` and `biometrie` are left here.

- The package now contains `config()`, `sign_in()` and `sign_out()` only for
database access and user identification.

- A sign ou addin is added.

# BioDataScience 2020.0.9002

- Add `MONGO_URL_SERVER` environment variable in `init()`.

# BioDataScience 2020.0.9001

- Separate `MONGO_USER` and `MONGO_PASSWORD` variables in `init()` and do not
set them if already there.

# BioDataScience 2020.0.9000

- In `record_sdd()`, date is now recorded in GMT timezone and with microseconds.

- An `init()` function is added to set globally `MONGO_URL` and `MONGO_BASE`
  environment variables for learndown Shiny and learnr applications.

## Changes in version 2019.6.0

- correction tutorial 06b_recombinaison 

## Changes in version 2019.5.0

- correction tutorial 06b_recombinaison 

## Changes in version 2019.4.0

- tutorial 06b_recombinaison finalized

## Changes in version 2019.3.0

- tutorial 01a_base finalized

## Changes in version 2019.2.0

- tutorial 01a_base finalized

## Changes in version 2019.1.0

- Review of the all tutorials (00a - 13c) with the **svbox 2019**

## changes in version 2018.1.0

- Review of the all tutorials (00a - 13c) with the **svbox 2018** and with the new function `collect_sdd()` 

## Changes in version 2019.0.0

- Review of the all tutorials (00a - 13c) with the **svbox 2019**

- Internal function `collect_sdd()` now has `user =` and `password =` arguments
  and the user/password used by default by `record_sdd()` cannot read data in
  the database anymore.


## Changes in version 2018.0.0

- `run()` modified to install latest release matching svbox year.


## Changes in version 0.25.0

- Review of the all tutorials (00a - 13c) with the **svbox 2018**

## Changes in version 0.24.0

- Tutorial examen_c finalized


## Changes in version 0.23.1

- Review tutorials 00 and 02 with svbox2019


## Changes in version 0.23.0

- Review of the all tutoriels (02a - 12a)


## Changes in version 0.22.0

- Tutorial examen_b finalized


## Changes in version 0.21.0

- Tutorial examen_a finalized


## Changes in version 0.20.0

- Tutorial 12a_correlation finalized


## Changes in version 0.19.0

- Correction of bugs to 11b and 11a


## Changes in version 0.18.2

- Tutorial 11b_syntaxr finalized

- Tutorial 11a_anova2 finalized


## Changes in version 0.18.0

- Tutorial 11b_syntaxr finalized


## Changes in version 0.17.0

- Tutorial 11a_anova2 finalized


## Changes in version 0.16.0

- Tutorial 10b_anova finalized


## Changes in version 0.15.0

- Tutorial 10a_anova finalized

- Addition of a test shiny app (histogram.R)


## Changes in version 0.14.0

- Tutorial 09b_student finalized


## Changes in version 0.13.0

- Tutorial 09a_student finalized


## Changes in version 0.12.1

- Tutorial 08b_chi2 finalized

- Add html file 08b_chi2


## Changes in version 0.12.0

- Tutorial 08b_chi2 finalized


## Changes in version 0.11.0

- Tutorial 08a_chi2 finalized


## Changes in version 0.10.0

- Tutorial 07b_distri finalized


## Changes in version 0.9.0

- Tutorial 07a_proba finalized

- Tutorial 06a_test finalized


## Changes in version 0.8.0

- Tutorial 05a_test finalized


## Changes in version 0.7.0

- Tutorial 04a_test finalized


## Changes in version 0.6.1

- More robust code for record_sdd()


## Changes in version 0.6.0

- Tutorial 03a_test finalized


## Changes in version 0.5.0

- Add new dataset biometry


## Changes in version 0.4.0

- Tutorial 02c_nuage_de_points finalized


## Changes in version 0.3.0

- Tutorial 02b_decouverte finalized


## Changes in version 0.2.0

- Tutorial 02a_base finalized


## Changes in version 0.1.2

- The run() function allows for selecting tutorials in a list.


## Changes in version 0.1.1

- The run() function now looks if there is an updated release and proposes to
  install it. Also, it provides a menu to select tutorials, in case no arguments
  are provided.


## Version 0.1.0

First version of the package on Github.
