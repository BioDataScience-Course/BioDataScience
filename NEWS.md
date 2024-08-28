# BioDataScience 2024.0.0

-   New version for academic year 2024-2024. New passwords.

# BioDataScience 2023.1.0

-   An RStudio addin to check disk space used in `/home/jovyan` is added (useful for SaturnCloud). The corresponding function is `disk_info()`, which allows for testing other disks than the one corresponding to `/home/jovyan` (or all disks with `path = ""`).

# BioDataScience 2023.0.1

-   Small correction in `biometrie`: "circomférence du poignet" (typo), but corrected anyway into "tour de poignet", and no unit for "année de la mesure" (idem in `biometry`).

# BioDataScience 2023.0.0

-   New version for academic year 2023-2024. New passwords.

-   New addin "New repo issue", paired with function `sdd_repo_issue()` for easily creating a new issue in the currently edited repository.

# BioDataScience 2022.1.0

-   Course key changed to match Saturn Cloud workflow.

# BioDataScience 2022.0.0

-   New version for academic year 2022-2023. New passwords for users and databases.

# BioDataScience 2021.1.0

-   `sdd_info()` function and corresponding RStudio addin are introduced for easily sharing small pieces of text in a central repository.

# BioDataScience 2021.0.0

-   Dependency moved from {learndown} to {learnitdown}. Preparation of series 2021-2022.

-   Management of security reworked. Now, an external course password is required.

-   The `obfuscator()` function provides configuration parameters to obfuscate sensible code in {learnr} tutorials (only visible with a teacher password).

# BioDataScience 2020.0.0

-   Clean up finished. Most code moved to {learndown}. Learnr tutorials and Shiny applications moved to {BioDataScience1}.

-   The datasets `biometry` and `biometrie` are left here.

-   The package now contains `config()`, `sign_in()` and `sign_out()` only for database access and user identification.

-   A sign out addin is added.

# BioDataScience 2020.0.9002

-   Add `MONGO_URL_SERVER` environment variable in `init()`.

# BioDataScience 2020.0.9001

-   Separate `MONGO_USER` and `MONGO_PASSWORD` variables in `init()` and do not set them if already there.

# BioDataScience 2020.0.9000

-   In `record_sdd()`, date is now recorded in GMT timezone and with microseconds.

-   An `init()` function is added to set globally `MONGO_URL` and `MONGO_BASE` environment variables for {Shiny} and {learnr} applications.

# BioDataScience 2019.6.0

-   Correction for tutorial `06b_recombinaison`.

# BioDataScience 2019.5.0

-   Correction for tutorial `06b_recombinaison`.

# BioDataScience 2019.4.0

-   Tutorial `06b_recombinaison` finalized.

# BioDataScience 2019.3.0

-   Tutorial `01a_base` finalized.

# BioDataScience 2019.2.0

-   Tutorial `01a_base` finalized.

# BioDataScience 2019.1.0

-   Recheck of the all tutorials (`00a` - `13c`) with the **svbox2019** software environment: minor corrections and version updated to `2019.x.y`.

# BioDataScience 2018.1.0

-   Recheck of the all tutorials (`00a` - `13c`) with the **svbox2018** software environment and with the new function `collect_sdd()`: minor corrections and version updated to `2018.x.y`.

# BioDataScience 2019.0.0

-   Review of the all tutorials (`00a` - `13c`) with the **svbox2019** software environment.

-   Internal function `collect_sdd()` now has `user =` and `password =` arguments and the user/password used by default by `record_sdd()` cannot read data in the database anymore.

# BioDataScience 2018.0.0

-   `run()` modified to install latest release matching **svbox** year.

# BioDataScience 0.25.0

-   Review of the all tutorials (`00a` - `13c`) with the **svbox2018** software environment.

# BioDataScience 0.24.0

-   Tutorial `examen_c` finalized.

# BioDataScience 0.23.1

-   Review tutorials `00` and `02` with **svbox2019** software environment.

# BioDataScience 0.23.0

-   Review of the all tutorials (`02a` - `12a`): corrections.

# BioDataScience 0.22.0

-   Tutorial `examen_b` finalized.

# BioDataScience 0.21.0

-   Tutorial `examen_a` finalized.

# BioDataScience 0.20.0

-   Tutorial `12a_correlation` finalized.

# BioDataScience 0.19.0

-   Correction of bugs in `11b` and `11a` tutorials.

# BioDataScience 0.18.2

-   Tutorial `11b_syntaxr` finalized.

-   Tutorial `11a_anova2` finalized.

# BioDataScience 0.18.0

-   Tutorial `11b_syntaxr` finalized.

# BioDataScience 0.17.0

-   Tutorial `11a_anova2` finalized.

# BioDataScience 0.16.0

-   Tutorial `10b_anova` finalized.

# BioDataScience 0.15.0

-   Tutorial `10a_anova` finalized.

-   Addition of a test {Shiny} application (histogram.R).

# BioDataScience 0.14.0

-   Tutorial `09b_student` finalized.

# BioDataScience 0.13.0

-   Tutorial `09a_student` finalized.

# BioDataScience 0.12.1

-   Tutorial `08b_chi2` finalized.

-   Add html file `08b_chi2`.

# BioDataScience 0.12.0

-   Tutorial `08b_chi2` finalized.

# BioDataScience 0.11.0

-   Tutorial `08a_chi2` finalized.

# BioDataScience 0.10.0

-   Tutorial `07b_distri` finalized.

# BioDataScience 0.9.0

-   Tutorial `07a_proba` finalized.

-   Tutorial `06a_test` finalized.

# BioDataScience 0.8.0

-   Tutorial `05a_test` finalized.

# BioDataScience 0.7.0

-   Tutorial `04a_test` finalized.

# BioDataScience 0.6.1

-   `record_sdd()` refactored.

# BioDataScience 0.6.0

-   Tutorial `03a_test` finalized.

# BioDataScience 0.5.0

-   Add new dataset `biometry`.

# BioDataScience 0.4.0

-   Tutorial `02c_nuage_de_points` finalized.

# BioDataScience 0.3.0

-   Tutorial `02b_decouverte` finalized.

# BioDataScience 0.2.0

-   Tutorial `02a_base` finalized.

# BioDataScience 0.1.2

-   The `run()` function allows for selecting tutorials in a list.

# BioDataScience 0.1.1

-   The `run()` function now looks if there is an updated release and proposes to install it. Also, it provides a menu to select tutorials, in case no arguments are provided.

# BioDataScience 0.1.0

First version of the {BioDataScience} package on GitHub.
