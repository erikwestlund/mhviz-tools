library(shiny)
library(dplyr)
library(ggplot2)
library(ggridges)
library(kableExtra)
library(forcats)

source("../theme.R")

# Load your processed data
data <- readRDS("data.rds")  # Replace with your actual data import

# UI
ui <- fluidPage(
  titlePanel("State-Level Cost of Stay Analysis"),

  sidebarLayout(
    sidebarPanel(
      selectInput("state", "Select a State:",
                  choices = unique(data$state),
                  selected = "WI")  # Default to Wisconsin
    ),

    mainPanel(
      h3("Summary Statistics"),
      tableOutput("summary_table"),

      h3("County-Level Cost Distribution"),
      plotOutput("density_plot", height = "500px"),
      h3("County-Level Cost Bar Plot"),
      plotOutput("bar_plot", height = "1200px")
    )
  )
)

# Server
server <- function(input, output) {

  # Filter data based on selected state
  state_data <- reactive({
    data |> filter(state == input$state)
  })

  # Generate summary table
  output$summary_table <- renderTable({
    state_data() |>
      summarize(
        n = n(),
        mean_cost = mean(average_hospital_costs_per_stay, na.rm = TRUE),
        median_cost = median(average_hospital_costs_per_stay, na.rm = TRUE),
        min_cost = min(average_hospital_costs_per_stay, na.rm = TRUE),
        max_cost = max(average_hospital_costs_per_stay, na.rm = TRUE)
      ) |>
      mutate(across(mean_cost:max_cost, scales::dollar))  # Format as dollars
  })

  # Generate density plot
  output$density_plot <- renderPlot({
    ggplot(state_data(), aes(x = average_hospital_costs_per_stay)) +
      geom_density(fill = colors$HopkinsBlue) +  # Use accessible blue
      geom_vline(aes(xintercept = median(average_hospital_costs_per_stay, na.rm = TRUE)),
                 linetype = "dashed", color = colors$Gray3) +
      labs(
        title = paste("Distribution of Average Cost of Stay for", input$state),
        subtitle = "Dashed Line Represents Median",
        x = "Average Cost of Stay (USD)",
        y = "Density"
      ) +
      theme_jhu()  # Apply JHU theme
  })

  # Generate bar plot
  output$bar_plot <- renderPlot({
    p_data <- state_data() |>
      mutate(county_factor = fct_reorder(county, average_hospital_costs_per_stay))

    most_expensive <- p_data |> filter(average_hospital_costs_per_stay == max(average_hospital_costs_per_stay)) |> pull(county)
    least_expensive <- p_data |> filter(average_hospital_costs_per_stay == min(average_hospital_costs_per_stay)) |> pull(county)

    label_counties <- c("US Total", "State Total", most_expensive, least_expensive)

    text_offset <- max(p_data$average_hospital_costs_per_stay) * 0.025

    ggplot(p_data, aes(x = county_factor,
                     y = average_hospital_costs_per_stay,
                     fill = case_when(
                       county == "US Total" ~ "US Total",
                       county == "State Total" ~ "State Total",
                       TRUE ~ "Other"
                     ))) +
      geom_col() +
      geom_text(data = p_data |> filter(county %in% label_counties),
                aes(label = scales::dollar(average_hospital_costs_per_stay),
                    y = average_hospital_costs_per_stay + text_offset),
                hjust = 0,
                size = 4,
                fontface = "bold") +
      coord_flip() +
      scale_fill_manual(
        values = c("US Total" = "#E69F00", "State Total" = "#E69F00", "Other" = colors$HopkinsBlue),
        guide = "none"
      ) +
      expand_limits(y = max(p_data$average_hospital_costs_per_stay) * 1.1) +
      labs(
        title = "Average Hospital Costs per Stay by County",
        subtitle = paste0("OB Patients with Births Complicated By Hypertension, ", input$state, ", 2020"),
        x = NULL,
        y = "Average Hospital Costs per Stay ($)"
      ) +
      theme_jhu_bar() +
      theme(
        axis.text.y = element_text(
          size = 10,
          face = ifelse(levels(p_data$county_factor) %in% c("US Total", "State Total"), "bold", "plain")
        )
      )
  })
}

# Run App
shinyApp(ui = ui, server = server)
