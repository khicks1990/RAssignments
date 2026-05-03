# add needed packages here separated by commas
packages <- c("tidymodels", "baguette", "rpart")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Import the necessary packages
suppressPackageStartupMessages(library(tidymodels))
suppressPackageStartupMessages(library(baguette))
suppressPackageStartupMessages(library(rpart))

heart <- read.csv("heart.csv")

# Read in the tree depth
inputs <- readLines(con = "stdin", n = 1, warn=FALSE)
depth <- as.integer(inputs)

if (is.na(depth)) {
  depth <- 3
}

set.seed(42)

# Initialize the model with user-defined depth
bag_model <- bag_tree(tree_depth = depth, var_imp = TRUE) %>%
  set_engine("rpart") %>%
  set_mode("regression")

# Fit the model
bag_fit <- fit(
  bag_model,
  chol ~ age + cp + trestbps + fbs + restecg + thalach + exang + oldpeak,
  data = heart)

# Add predictions to heart dataset
heart$predicted_chol <- predict(bag_fit, heart)$.pred

# Calculate regression metrics
results <- yardstick::metrics(heart, truth=chol, estimate = predicted_chol)

print(results)