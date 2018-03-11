eq_location_clean<- function(dataset){
  
  # clean up location names
  dataset2<- dataset %>%
    dplyr::mutate(LOCATION_NAME = gsub("^.*:\\s*", "",LOCATION_NAME),
           LOCATION_NAME = stringr::str_to_title(LOCATION_NAME))
  
}