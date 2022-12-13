library(tidyverse)

# Charts Example ----------------------------------------------------------

#The API call
chart_response <- httr::GET(url = "https://api.aviationapi.com/v1/charts?apt=RDU")

#Extract the content from the response
chart_content <- httr::content(chart_response)

#Format them using tidyverse functions
chart_tbl <- chart_content %>%
  map_dfr(~.x)


# Weather Example ---------------------------------------------------------

#The API call
weather_response <- httr::GET(url = "https://api.aviationapi.com/v1/weather/metar?apt=RDU")

#Extract the content from the response
weather_content <- httr::content(weather_response)

#Format them using tidyverse functions
weather_tbl <- tibble(weather_content) %>%
  unnest_wider(col = c(weather_content)) %>%
  unnest_longer(col = c(sky_conditions)) %>%
  unnest_wider(col = c(sky_conditions))


# Example Functions for Package -------------------------------------------

query_weather_response <- function(airport_code){
  
  glue::glue("https://api.aviationapi.com/v1/weather/metar?apt=", airport_code, sep = '')
  
  
}

get_weather_response <- function(airport_code){
  
  #The API call
  weather_response <- httr::GET(url = query_weather_response(airport_code))
  
  #Extract the content from the response
  weather_content <- httr::content(weather_response)
  
  #Format them using tidyverse functions
  weather_tbl <- tibble(weather_content) %>%
    unnest_wider(col = c(weather_content)) %>%
    unnest_longer(col = c(sky_conditions)) %>%
    unnest_wider(col = c(sky_conditions))
  
  return(weather_tbl)
  
}

atl_weather <- get_weather_response('ATL')
