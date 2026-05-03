# add needed packages here separated by commas
packages <- c("rpart", "ranger", "vip")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidymodels))
library(vip) 

# Load the mpg dataset
# Make sure mpg.csv is in your /workspaces/... folder
mpg <- read.csv("mpg.csv") %>%
  select(-1) %>%
  mutate(high_mpg = factor(ifelse(mpg >= 25, "yes", "no")))

# Subset the data for classification
mpgClassification <- mpg %>%
  select(weight, horsepower, model_year, high_mpg)

# Initialize a classification tree with max depth 4 and minimum 10 samples per leaf
set.seed(14092022)
mpgCT <- decision_tree(tree_depth = 4, min_n = 10) %>%
  set_engine("rpart") %>%
  set_mode("classification")

# Fit the classification tree
fitClassTree <- mpgCT %>%
  fit(high_mpg ~ ., data = mpgClassification)

# Print classification tree
print(fitClassTree)


# Initialize a random forest classifier with 300 trees and 2 variables tried at each split
set.seed(14092022)
mpgRF <- rand_forest(mtry = 2, trees = 300) %>%
  set_engine("ranger", importance = "permutation") %>%
  set_mode("classification")

fitRF <- mpgRF %>%
  fit(high_mpg ~ ., data = mpgClassification)

rf_fit <- extract_fit_engine(fitRF)$fit
print(rf_fit$variable.importance)

rf_fit <- extract_fit_engine(fitRF)$fit
print(rf_fit$call)
print(rf_fit$importance)