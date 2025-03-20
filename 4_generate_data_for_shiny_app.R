library(dplyr)
library(purrr)

data_files <- list(
  ca = "data/hcup/California/HCUPnet_Community_DX1CCSR_County_CA_hyp complicating birth_2020.xlsx",
  ga = "data/hcup/Georgia/HCUPnet_Community_DX1CCSR_County_GA_hyp complicating birth_2020.xlsx",
  la = "data/hcup/Louisiana/HCUPnet_Community_DX1CCSR_County_LA_hyp complicating birth_2020.xlsx",
  mi = "data/hcup/Michigan/HCUPnet_Community_DX1CCSR_County_MI_hyp complicating birth_2020.xlsx",
  ms = "data/hcup/Mississippi/HCUPnet_Community_DX1CCSR_County_MS_hyp complicating birth_2020.xlsx",
  ok = "data/hcup/Oklahoma/HCUPnet_Community_DX1CCSR_County_OK_hyp_2020.xlsx",
  sd = "data/hcup/South Dakota/HCUPnet_Community_DX1CCSR_County_SD_hyp_2020.xlsx",
  wi = "data/hcup/Wisconsin/HCUPnet_Community_DX1CCSR_County_WI_hyp_2020.xlsx"
)

dfs <- lapply(data_files, readxl::read_excel, sheet = 4)


data <- imap(dfs, ~ .x |>
               rename(
                 county = `County`,
                 average_hospital_costs_per_stay = `Average Hospital Costs per Stay (in $)`
               ) |>
               select(county, average_hospital_costs_per_stay) |>
               filter(average_hospital_costs_per_stay != "*") |>
               mutate(
                 average_hospital_costs_per_stay = as.numeric(average_hospital_costs_per_stay),
                 state = str_to_upper(.y)  # Add state abbreviation using the list key
               )
) |> bind_rows()

saveRDS(data, "mhviz-shiny/data.rds")
