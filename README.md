# Housing Dataset: Exploratory Data Analysis

This project explores the California housing dataset, focusing on
distributions, geographic patterns, and correlations between features
such as income, house value, and location.

> **Not the same dataset as other "Housing" projects.** This is the
> California Housing dataset (20,640 records; `longitude`, `latitude`,
> `median_income`, `ocean_proximity`, etc.). If you also have a small
> 4-column `Housing.csv` (`RM`, `LSTAT`, `PTRATIO`, `MEDV`) from a
> different regression-tree exercise, that is a separate, unrelated
> dataset and project — the two are not interchangeable.

## Dataset

`data/housing.csv` contains one row per housing block group, with fields
including `longitude`, `latitude`, `housing_median_age`,
`total_rooms`, `total_bedrooms`, `population`, `households`,
`median_income`, `median_house_value`, and `ocean_proximity`.
207 of the 20,640 rows are missing `total_bedrooms`.

## Contents

### Notebook (Python)

`notebook/housing_eda.ipynb` covers:

1. Grouped statistics by `ocean_proximity`.
2. Distribution histograms for every numeric feature.
3. A geographic map of all housing records using Folium.
4. Pairwise relationships between all features (`seaborn.pairplot`).
5. Pearson correlation between `median_house_value` and `median_income`.
6. The full correlation matrix, visualized as a heatmap.

The Folium map cell embeds a large amount of HTML in its saved output,
which is why this notebook file is larger than the others — this is the
original rendered map output, kept as-is.

### R scripts

| Script | Purpose |
|---|---|
| `01_correlation_scatterplot_matrix.R` | Scatterplot matrix (`pairs()`) of `total_rooms`, `total_bedrooms`, and `median_house_value`, with correlation coefficients on the lower panel and colored points on the upper panel. |
| `02_correlation_heatmap.R` | Correlation heatmap of the full numeric housing matrix. |

Run the scripts from inside the `r-scripts/` folder (they reference the
dataset as `../data/housing.csv`).

## How to run

### Python notebook

```bash
pip install -r requirements.txt
cd notebook
jupyter notebook housing_eda.ipynb
```

### R scripts

```r
setwd("r-scripts")
source("01_correlation_scatterplot_matrix.R")
source("02_correlation_heatmap.R")
```
<!-- 
## Notes on this cleanup

The original R code existed as three near-duplicate files, each a
slightly extended copy of the previous one. They have been merged into
the two scripts above without losing any part of the analysis: the
scatterplot-matrix script and the heatmap script.

Assembling the final project against the actual `housing.csv` file
surfaced a few issues that would have stopped the scripts from running
correctly, all now fixed:

- **Missing header flag.** Both scripts called `read.csv(..., header =
  FALSE)`, but `housing.csv` does have a header row. With
  `header = FALSE`, the header text is read as if it were a data row,
  which forces every column to be treated as text and breaks `cor()`,
  `pairs()`, and `heatmap()`. Both scripts now use `header = TRUE`.
- **Wrong column indices.** With a correct header, column 3 is
  `housing_median_age`, not `total_rooms`. The scatterplot script's
  comments describe `total_rooms`, `total_bedrooms`, and
  `median_house_value`, which are actually columns 4, 5, and 9 — the
  script has been updated to select those columns instead of the
  original `c(3, 4, 9)`.
- **Missing values.** 207 of the 20,640 rows have no `total_bedrooms`
  value. `cor()` and `heatmap()` do not handle `NA` values gracefully, so
  both scripts now drop those rows with `na.omit()` right after loading
  the data (about 1% of the rows).
- **Broken numeric conversion in the heatmap script.** The heatmap
  script computed a second matrix, `data3`, via
  `as.matrix(sapply(data1, as.numeric))`. Since `ocean_proximity` is
  categorical text (e.g. `"NEAR BAY"`), `as.numeric()` on that column
  produces `NA` for every row, and `data3` was the matrix actually passed
  to `heatmap()`. This broken line has been removed; `heatmap()` now
  uses `data2` (built with `data.matrix()`), which converts categorical
  columns to their integer codes instead of `NA`.
- The `my_cols`/`ddd` naming inconsistency and the duplicated, mistyped
  second `read.csv(...)` line from the earlier merge (see previous
  cleanup pass) were already removed.

No plotted result or interpretation was removed by any of these fixes —
they only make the existing analysis actually run against the real
dataset and produce the columns/values the code comments already claimed
to be showing.

The Python notebook's file paths were updated from a bare `'housing.csv'`
to `'../data/housing.csv'` to match this project's folder layout
(`notebook/` and `data/` as siblings); no other code was changed. -->
