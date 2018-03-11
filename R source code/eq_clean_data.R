eq_clean_data<- function(dataset){
  
  # create DATE column by combining year, month, & day cols
  dataset2<- dataset %>%
    dplyr::mutate(MONTH = ifelse(is.na(MONTH), 1, MONTH),
           DAY = ifelse(is.na(DAY), 1, DAY),
           julian_days = julian(MONTH, DAY, YEAR),
           DATE = as.Date(julian_days, origin = "1970-01-01"),
           LATITUDE = as.numeric(LATITUDE),
           LONGITUDE = as.numeric(LONGITUDE)) %>%
    dplyr::select(I_D, FLAG_TSUNAMI, DATE, everything())
  
}
