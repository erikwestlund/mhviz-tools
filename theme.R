colors <- list(
  "HopkinsBlue" = "#002D72",
  "Blue" = "#005eb8",
  "BlueLight" = "#68ACE5",
  "PaleBlue" = "#A7BCD6",
  "Purple" = "#470a68",
  "LightPurple" = "#7c7fab",
  "Tan" = "#D9C89E",
  "Gray1" = "#E5E2E0",
  "Gray2" = "#B4B2AD",
  "Gray3" = "#7E7E7C",
  "Gray4" = "#4A484C",
  "Gray5" = "#2C2C33",
  "Teal" = "#6399AE",
  "Green" = "#007A53"
)

theme_jhu <- function() {
  update_geom_defaults("bar", list(fill = colors$HopkinsBlue))

  theme_minimal(base_family = "Tahoma") +
    theme(
      plot.title = element_text(
        family = "Georgia", size = 18, hjust = 0.5, face = "bold",
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        hjust = 0.5, family = "Tahoma", size = 12,
        margin = margin(t = 5, b = 15)
      ),
      plot.caption = element_text(
        family = "Tahoma", size = 10, color = colors$Gray3,
        margin = margin(t = 15)
      ),
      axis.text.y = element_text(
        family = "Tahoma", size = 12, color = colors$Gray5
      ),
      axis.line.x = element_line(color = colors$Gray1, linewidth = 0.5),
      axis.line.y = element_line(color = colors$Gray1, linewidth = 0.5),
      panel.grid.major.x = element_line(
        color = colors$Gray1, linewidth = 0.5, linetype = "solid"
      ),
      panel.grid.minor = element_blank(),

    )
}

theme_jhu_bar <- function() {
  theme_jhu() +
    theme(
      # axis.title = element_blank(),
      axis.line.x = element_blank(),
      axis.line.y = element_blank(),
      axis.ticks = element_line(color = colors$Gray1, linewidth = 0.25),
      axis.ticks.length = unit(0.2, "cm"),
      panel.border = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    )
}
