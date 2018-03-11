#' Clean source data from NOAA
#'
#' \code{eq_clean_data} generate dates, & format latitude and longitude columns
#'
#' @param data A data frame with raw data obtained from NOAA website (see below)
#'
#' @return A data frame date & nyumeric latitude, longitude variables
#'
#' @details The function requires raw date obtained from NOAA site
#' \url{https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1}. It adds
#' a column DATE with cleaned date (Date format), transforms LATITUDE and
#' LONGITUDE columns as numeric objects
#'
#' @examples
#' \dontrun{
#' data <- readr::read_delim("signif.txt", delim = "\t")
#' clean_data <- eq_clean_data(data)
#' }
#'
#' @importFrom dplyr %>% mutate select
#'
#' @export
eq_clean_data<- function(dataset){

  # create DATE column by combining year, month, & day cols
  dataset2<- dataset %>%
    dplyr::mutate(MONTH = ifelse(is.na(MONTH), 1, MONTH),
                  DAY = ifelse(is.na(DAY), 1, DAY),
                  julian_days = julian(MONTH, DAY, YEAR),
                  DATE = as.Date(julian_days, origin = "1970-01-01"),
                  LATITUDE = as.numeric(LATITUDE),
                  LONGITUDE = as.numeric(LONGITUDE)) %>%
    dplyr::select(I_D, FLAG_TSUNAMI, DATE, everything()) %>%
    dplyr::select(-julian_days)

}

#' Cleans earthquake location data
#'
#' @param data A data frame with raw data obtained from NOAA website
#'
#' @return A data frame with cleaned LOCATION_NAME column
#'
#' @details This function transforms NOAA data frame LOCATION_NAME column by
#' trimming the country name (if applicable) and converting to title case
#'
#' @note The function is not exported
#'
#' @examples
#' \dontrun{
#' data <- readr::read_delim("earthquakes.tsv.gz", delim = "\t")
#' clean_data <- eq_location_clean(data)
#' }
#'
#' @importFrom dplyr %>% mutate
#' @importFrom stringr str_to_title
#' @export
eq_location_clean<- function(dataset){

  # clean up location names
  dataset2<- dataset %>%
    dplyr::mutate(LOCATION_NAME = gsub("^.*:\\s*", "",LOCATION_NAME),
                  LOCATION_NAME = stringr::str_to_title(LOCATION_NAME))

}
