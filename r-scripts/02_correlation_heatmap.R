# Load the housing dataset. The CSV has a header row, so header = TRUE.
data1 <- read.csv("../data/housing.csv", stringsAsFactors = FALSE, header = TRUE)

# A small number of rows (about 1% of the data) are missing total_bedrooms;
# heatmap() cannot cluster rows/columns that contain NA values, so those
# rows are dropped for this analysis.
data1 <- na.omit(data1)

# Convert the dataframe to a numeric matrix so it can be passed to heatmap().
# data.matrix() converts the categorical ocean_proximity column to its
# underlying integer codes instead of producing NA, unlike a plain
# as.numeric() call on a character column.
data2 <- data.matrix(data1, rownames.force = NA)

# Heatmap of the full feature matrix (rows and columns are both clustered
# by default; scale = "none" leaves the raw values unscaled)
heatmap(data2, scale = "none")
