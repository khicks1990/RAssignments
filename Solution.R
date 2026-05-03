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

set.seed(42)

# Initialize the model with XGBoost and 50 trees
boost_model <-boost_tree(
  trees=50,
  engine="xgboost",
  mode="classification"
)

# Fit the model
boost_fit <- boost_model %>%
  fit(
    target ~ age + cp + trestbps + chol + fbs + restecg + thalach + exang + oldpeak,
    data = heart
  )

# Add predictions and class probabilities to heart dataset
heart$pred_class <- predict(boost_fit, heart, type="class")$.pred_class
heart_probs <- predict(boost_fit, heart, type="prob")
heart <- cbind(heart, heart_probs)

# Confusion matrix using the caret package
heartConf <- caret::confusionMatrix(
  data=heart$pred_class,
  reference=heart$target
)
print(heartConf)
#done