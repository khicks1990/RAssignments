# add needed packages here separated by commas
packages <- c("tidyverse", "tidymodels", "kknn")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Load packages
suppressPackageStartupMessages(library(tidymodels))
suppressPackageStartupMessages(library(tidyverse))

# Load the dataset
skySurveyRaw <- read.csv('SDSS.csv')
skySurvey <- skySurveyRaw |> mutate(class = as_factor(str_to_title(class)))

# Create a new feature from u - g
skySurvey$u_g <- skySurvey$u - skySurvey$g

set.seed(42)

# Split data into training and test sets
data_split <- initial_split(skySurvey, prop = 0.7, strata = class)
train_data <- training(data_split)
test_data <- testing(data_split)

# Define model with k=3
skySurveyKNNClass <- nearest_neighbor(neighbors=3) %>% set_mode("classification") %>% set_engine("kknn")

# Define recipe to normalize data
skySurveyRecipe <- recipe(class ~ redshift + u_g, data = train_data) %>% step_normalize(all_predictors())

# Assemble workflow
skySurveyClassWflow <- workflow() %>% add_model(skySurveyKNNClass) %>% add_recipe(skySurveyRecipe)

# Fit model
skySurveyClassFit <- fit(skySurveyClassWflow, data = train_data)

# Predict values for the test set and add those values onto to the test set.
testPred <- predict(skySurveyClassFit, test_data) %>% bind_cols(test_data)

# Print accuracy and confusion matrix
testPred |> accuracy(truth= class,  estimate = .pred_class)
confusionMatrix <- testPred |> conf_mat(truth = class, estimate = .pred_class) 
print(confusionMatrix)