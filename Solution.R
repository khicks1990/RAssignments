# add needed packages here separated by commas
packages <- c()

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
mpg <- ifelse(mpg$mpg > median(mpg$mpg), "High", "Low")
mpg$high_mpg <- as.factor(mpg$high_mpg)

# Subset the data for classification
mpgClassification <- mpg[, c("high_mpg", "weight", "horsepower", "model_year")]

# Initialize a classification tree with max depth 4 and minimum 10 samples per leaf
set.seed(14092022)
mpgCT <- decision_tree(
  mode = "classification",
  tree_depth = 4,
  min_n = 10
) %>%
  set_engine("rpart")

# Fit the classification tree
fitClassTree <- mpgCT %>%
  fit(high_mpg ~ ., data = mpgClassification)

# Print classification tree
fitClassTree


# Initialize a random forest classifier with 300 trees and 2 variables tried at each split
set.seed(14092022)
mpgRF <- rand_forest(
  mode = "classification",
  trees = 300,
  mtry = 2
) %>%
  set_engine("ranger", importance = "impurity")

# Fit the random forest model
fitRF <- mpgRF %>%
  fit(high_mpg ~ ., data = mpgClassification)

# Display variable importance
vip(fitRF$fit) 