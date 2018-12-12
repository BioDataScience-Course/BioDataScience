SciViews::R

biometry <- read(file = "data-raw/biometry.rds")

#rename variable french -> english and filter NA

biometry %>.%
  rename(., gender = genre,
         day_birth = ddn,
         year = year,
         weight = masse,
         height = taille,
         wrist = poignet,
         year_measure = ddm,
         age = age) %>.%
  filter(., weight != "NA") %>.%
  select(., - year)-> biometry

## Recodage de biometry$gender
biometry$gender <- recode(biometry$gender,
               "H" = "M",
               "F" = "W")

#
devtools::use_data(biometry, overwrite = TRUE)
