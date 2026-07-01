# Load the housing dataset. The CSV has a header row, so header = TRUE.
data1 <- read.csv("../data/housing.csv", stringsAsFactors = FALSE, header = TRUE)

# A small number of rows (about 1% of the data) are missing total_bedrooms.
# cor() and the panel functions below do not handle NA values, so those
# rows are dropped for this analysis.
data1 <- na.omit(data1)

# Lower-panel function: print the Pearson correlation coefficient for
# each pair of variables, with text size scaled by the correlation strength
panel.cor <- function(x, y) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- round(cor(x, y), digits = 2)
  txt <- paste0("R =", r)
  cex.cor <- 0.8 / strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

# Upper-panel function: plot the raw scatter points, colored by category
upper.panel <- function(x, y) {
  points(x, y, pch = 19, col = my_cols)
}

# Color palette used to distinguish points in the scatterplots
my_cols <- c("#65ff44", "#543aa2", "#437810")

# Scatterplot matrix for total_rooms, total_bedrooms, and median_house_value
# (columns 4, 5, and 9), with correlations on the lower panel and colored
# points on the upper panel
pairs(data1[, c(4, 5, 9)],
      lower.panel = panel.cor,
      upper.panel = upper.panel)

# Same three columns, plotted directly with colored points and no
# correlation panel
pairs(data1[, c(4, 5, 9)], pch = 19, col = my_cols)
