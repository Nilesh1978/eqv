# load packages
library(devtools)
library(roxygen2)
library(dplyr)
library(ggplot2)
library(chron)
library(eqv)
install_github("Nilesh1978/eqv")


# step1: update documents
devtools::document()

# step2: load updated documentation
load_all()

# step3: run build & reload tab under build
devtools::check()

# add vignites
devtools::use_vignette("eqv-vignette")

# travis
use_travis()

head(data)
tt<- data %>%
  eq_clean_data() %>%
  eq_location_clean()
str(tt)
