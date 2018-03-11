eq_map <- function(data, annot_col) {
  
  m <- leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(lng = data$LONGITUDE, lat = data$LATITUDE,
                              radius = data$EQ_PRIMARY, weight = 1,
                              popup = data[[annot_col]])
  
  m
}