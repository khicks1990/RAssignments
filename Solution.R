# add needed packages here separated by commas
packages <- c("tidymodels")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidymodels))

# Load the mpg dataset
mpg <- read.csv("mpg.csv") # Your code here

# Subset the data containing mpg, weight, and model_year
mpgRegression <- mpg |>
  select(mpg, weight, model_year) # Your code here

# Initialize a regression tree that has depth 3 and a minimum number of samples in each leaf of 5
set.seed(14092022)
mpgRT <- decision_tree(
  mode = "regression",
  tree_depth = 3,
  min_n = 5) |>
  set_engine("rpart") # Your code here

# Fit the model
fitTree <- mpgRT |>
  fit(mpg ~ ., data = mpgRegression) # Your code here
  
# Print regression tree
print(fitTree)