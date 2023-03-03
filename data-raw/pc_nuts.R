## code to prepare `nuts_matrix` dataset goes here
library(dplyr)
library(tidyr)
library(readr)
library(here)
library(purrr)
library(stringr)
library(janitor)
library(sf)

files <- here("pc2020_NUTS-2021_v4.0") |>
    list.files()

paths <-  here(
    "pc2020_NUTS-2021_v4.0",
    files
)

pc_nuts <- tibble(
    file = files,
    path = paths,
    country = str_match(file, "2020_([A-Z]{2})")[, 2]
) |>
    group_by(country) |>
    group_modify(
        function(data, ...) {
            map_dfr(
                data$path,
                read_csv2
            )
        }
    ) |>
    clean_names() |>
    mutate_at(
        vars(nuts3, code),
        str_replace_all, pattern = "\\'", replacement = ""
        ) |>
    rename(
        postcode = code
    )




usethis::use_data(pc_nuts, overwrite = TRUE)
