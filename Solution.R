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

set.seed(123)
df <- read.csv("nbaallelo_slr.csv")
NBA <- df[sample(nrow(df), size=50), ]

# Create a new column in the data frame that is the SUM of pts and opp_pts
NBA$total_score <- NBA$pts + NBA$opp_pts

# Split the data into training and test sets
split <- initial_split(NBA, prop = 0.7)

NBATestData <- testing(split)
NBATrainData <- training(split)

# Fit a linear regression model using tidymodels to the training data
linearModel <- linear_reg(mode = "regression", engine = "lm")

# Fit a regression model in tidymodels
linearModel_fit <- linearModel |>
  fit(total_score ~ elo_i, data = NBATrainData)
    
# Define a set of 10 cross-validation folds
folds <- vfold_cv(NBATrainData, v = 10)

# Define a workflow, or set of modeling steps
NBA_workflow <- 
  workflow() |>
  add_model(linearModel) |>
  add_formula(total_score ~ elo_i)
    
# Fit the linear regression model to each cross-validation fold
NBA_fit_cv <- 
  NBA_workflow |>
  fit_resamples(folds)

tenFoldScores <- NBA_fit_cv |>
  collect_metrics()

print(tenFoldScores)