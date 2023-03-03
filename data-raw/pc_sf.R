## code to prepare `pc_sf` dataset goes here
library(dplyr)
library(tidyr)
library(readr)
library(here)
library(purrr)
library(stringr)
library(janitor)
library(sf)


pc_sf <- here("PC_2020_PT_SH", "PCODE_2020_PT_SH.shp") |>
    read_sf() |>
    clean_names() |>
    select(
        postcode,
        country = cntr_id,
        nuts3 = nuts3_2021
    ) |>
    mutate_at(
        vars(nuts3),
        str_replace_all, pattern = "\\'", replacement = ""
    )

usethis::use_data(pc_sf, overwrite = TRUE)
