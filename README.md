# Data Visualization

Files used for the Mar 20, 2025 presentation the the [Johns Hopkins Maternal Health Data Innovation and Coordinating Hub](https://maternalhealthhub.jhu.edu/johns-hopkins-university) of the [NIH Maternal Health Research Centers of Excellence](https://www.nih.gov/news-events/news-releases/nih-establishes-maternal-health-research-centers-excellence).

# Presentation File

The presentation file is located in this repository: [`data_visualization_tools_presentation.pdf`](https://github.com/erikwestlund/mhviz-tools/blob/main/data_visualization_tools_presentation.pdf)

# Talk Recording

A recording of this presentation will be published on YouTube. 

# Data

This repository has a data directly that looks like this:

```
data/
├── hcup/        # Put HCUP data in here (state-level data is gitignored)
├── examples/    # Examples for the presentation are here (files are gitignored)
```

To reproduce the examples from this presentation, you will need access to data from the Healthcare Cost and Utilization Project (HCUP), a data product from the Agency for Healthcare Research and Quality (AHRQ).

After adding the HCUP data to the `data/hcup` directory, it will look like this:

```
data/
├── hcup/
│   ├── California
│   ├── Georgia
│   ├── Louisiana
│   ├── Michigan
│   ├── Mississippi
│   ├── New York
│   ├── Oklahoma
│   ├── South Dakota
│   ├── Utah
│   ├── Wisconsin
├── examples/
```

# Examples

This repository contains four examples. Each is numbered with the prefix corresponding to the order in which they were presented.

1. A simple bar chart in Stata (`1_wisconsin_hypertension_complicated_birth_cost_of_stay.do`)
2. A simple bar chart in R using an Rmarkdown Notebook (`2_wisconsin_hypertension_complicated_birth_cost_of_stay.Rmd`)
3. A complex ridgeline plot in R using an Rmarkdown Notebook (`3_nine_states_hypertension_complicated_birth_cost_of_stay.Rmd`)
4. A dynamic data dashboard using Shiny for R (`4_generate_data_for_shiny_app.R`, `mhviz-shiny/app.R`)

# Author/Contact

This repo was created by [Erik Westlund](ewestlund@jhu.edu), a data scientist at the Johns Hopkins Bloomberg School of Public Health.
