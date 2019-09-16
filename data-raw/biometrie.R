SciViews::R

biometrie <- read(file = "data-raw/biometrie.rds")
biometrie <- filter(biometrie, masse != "NA")

biometrie <- select(biometrie, - year)
#
devtools::use_data(biometrie, overwrite = TRUE)
