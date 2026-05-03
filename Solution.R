# add needed packages here separated by commas
packages <- c("tidyverse", "tidymodels", "caret", "xgboost")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Import the necessary packages
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(tidymodels))
suppressPackageStartupMessages(library(caret))

heart <- read.csv("heart.csv")
heart$target <- as.factor(heart$target)

# Initialize the model with XGBoost and 50 trees
heartBoost <- boost_tree(trees = 50) %>%
  set_engine("xgboost") %>%
  set_mode("classification")# Your code here

# Fit the model
heartFit <- heartBoost %>%
  fit(
    target ~ age + cp + trestbps + chol + fbs + restecg + thalach + exang + oldpeak,
    data = heart
  )# Your code here

# Add predictions and class probabilities to heart dataset
heartPred <- predict(heartFit, new_data = heart) 

heartProb <- predict(heartFit, new_data = heart, type = "prob")

heart <- bind_cols(heart, heartPred, heartProb) # Your code here

# Confusion matrix using the caret package
heartConf <- confusionMatrix(
  data = heart$.pred_class,
  reference = heart$target
) # Your code here

print(heartConf)