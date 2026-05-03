# add needed packages here separated by commas
packages <- c("randomForest")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidymodels))

# Load the mpg dataset
mpg <- read.csv("mpg.csv")

# Create a binary outcome variable for high mpg
mpg$high_mpg <- ifelse(mpg$mpg >= 25, "yes", "no") |> as.factor()

# Subset the data for classification
mpgClassification <- mpg |> select(weight, horsepower, model_year, high_mpg)

# Initialize a classification tree with max depth 4 and minimum 10 samples per leaf
set.seed(14092022)
mpgCT <- decision_tree(mode = "classification", tree_depth = 4, min_n = 10)

# Fit the classification tree
fitClassTree <- mpgCT |> fit(high_mpg ~ ., data = mpgClassification)

# Print classification tree
fitClassTree


# Initialize a random forest classifier with 300 trees and 2 variables tried at each split
set.seed(14092022)
mpgRF <- rand_forest(mode = "classification", mtry = 2, trees = 300) |>
  set_engine("randomForest", importance = TRUE)
  
# Fit the random forest model
fitRF <- mpgRF |> fit(high_mpg ~ ., data = mpgClassification)

# Display variable importance
print(fitRF$fit$importance)