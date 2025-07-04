library(sf)
# Packages not on CRAN
# devtools::install_github("seananderson/ggsidekick") # not on CRAN 
library(ggsidekick)
# library(rnaturalearth)
# library(rnaturalearthdata)

theme_set(theme_sleek())

sf::sf_use_s2(FALSE)

# Specify map ranges
ymin = 52; ymax = 60.5; xmin = 10; xmax = 24

map_data <- rnaturalearth::ne_countries(
  scale = "medium",
  returnclass = "sf", continent = "europe")

# Crop the polygon for plotting and efficiency:
# st_bbox(map_data) # find the rough coordinates
swe_coast <- suppressWarnings(suppressMessages(
  st_crop(map_data,
          c(xmin = xmin, ymin = ymin, xmax = xmax, ymax = ymax))))

# Transform our map into UTM 33 coordinates, which is the equal-area projection we fit in:
utm_zone33 <- 32633
swe_coast_proj <- sf::st_transform(swe_coast, crs = utm_zone33)

# Define plotting theme for facet_wrap map with years
theme_facet_map <- function(base_size = 11, base_family = "") {
  theme_sleek(base_size = base_size, base_family = "") +
    theme(
      legend.direction = "horizontal",
      legend.margin = margin(1, 1, 1, 1),
      legend.box.margin = margin(0, 0, 0, 0),
      legend.key.height = unit(0.4, "line"),
      legend.key.width = unit(2, "line"),
      legend.spacing.x = unit(0.1, 'cm'),
      legend.position = "bottom",
    )
}

# Make default base map plot
xmin2 <- 303000
#xmax2 <-916000
xmax2 <-1036200
xrange <- xmax2 - xmin2

ymin2 <- 5980000
#ymax2 <- 6450000
ymax2 <- 6645000

yrange <- ymax2 - ymin2

plot_map <- 
  ggplot(swe_coast_proj) + 
  xlim(xmin2, xmax2) +
  ylim(ymin2, ymax2) +
  labs(x = "Longitude", y = "Latitude") +
  geom_sf(size = 0.3, color = "gray80") + 
  theme_sleek() +
  guides(colour = guide_colorbar(title.position = "top", title.hjust = 0.5),
         fill = guide_colorbar(title.position = "top", title.hjust = 0.5)) +
  NULL


plot_map_fc <- 
  ggplot(swe_coast_proj) + 
  xlim(xmin2, xmax2) +
  ylim(ymin2, ymax2) +
  labs(x = "Longitude", y = "Latitude") +
  geom_sf(size = 0.3, color = "gray80") + 
  theme_facet_map() +
  guides(colour = guide_colorbar(title.position = "top", title.hjust = 0.5),
         fill = guide_colorbar(title.position = "top", title.hjust = 0.5)) +
  NULL

plot_map_labels <- 
  plot_map + 
  annotate("text", label = "Sweden", x = xmin2 + 0.25*xrange, y = ymin2 + 0.75*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Denmark", x = xmin2 + 0.029*xrange, y = ymin2 + 0.32*yrange, color = "gray50", size = 1.9, angle = 75) +
  annotate("text", label = "Germany", x = xmin2 + 0.07*xrange, y = ymin2 + 0.022*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Poland", x = xmin2 + 0.55*xrange, y = ymin2 + 0.08*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Russia", x = xmin2 + 0.95*xrange, y = ymin2 + 0.18*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Lithuania", x = xmin2 + 1*xrange, y = ymin2 + 0.43*yrange, color = "gray50", size = 1.9, angle = 75) +
  annotate("text", label = "Latvia", x = xmin2 + 0.99*xrange, y = ymin2 + 0.65*yrange, color = "gray50", size = 1.9, angle = 75)

plot_map_labels_fc <- 
  plot_map_fc + 
  annotate("text", label = "Sweden", x = xmin2 + 0.25*xrange, y = ymin2 + 0.75*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Denmark", x = xmin2 + 0.029*xrange, y = ymin2 + 0.32*yrange, color = "gray50", size = 1.9, angle = 75) +
  annotate("text", label = "Germany", x = xmin2 + 0.07*xrange, y = ymin2 + 0.022*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Poland", x = xmin2 + 0.55*xrange, y = ymin2 + 0.08*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Russia", x = xmin2 + 0.95*xrange, y = ymin2 + 0.18*yrange, color = "gray50", size = 1.9) +
  annotate("text", label = "Lithuania", x = xmin2 + 1*xrange, y = ymin2 + 0.43*yrange, color = "gray50", size = 1.9, angle = 75) +
  annotate("text", label = "Latvia", x = xmin2 + 0.99*xrange, y = ymin2 + 0.65*yrange, color = "gray50", size = 1.9, angle = 75)