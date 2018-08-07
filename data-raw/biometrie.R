SciViews::R

biometrie <- data::read(file = "data-raw/biometrie.rds")
biometrie <- filter(biometrie, masse != "NA")
#
devtools::use_data(biometrie, overwrite = TRUE)