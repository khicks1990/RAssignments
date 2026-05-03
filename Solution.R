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
# Your code here
heartModel <- boost_tree(trees = 50) %>%
  set_engine("xgboost") %>%
  set_mode("classification")


# Fit the model
# Your code here
heartFit <- heartModel %>%
  fit(target ~ age + cp + trestbps + chol + fbs + restecg + thalach + exang + oldpeak,
      data = heart)

# Add predictions and class probabilities to heart dataset
# Your code here
heartPred <- predict(heartFit, new_data = heart)
heartProb <- predict(heartFit, new_data = heart, type = "prob")
heart <- bind_cols(heart, heartPred, heartProb)

print(head(heart))


# Confusion matrix using the caret package
heartConf <- confusionMatrix(heart$.pred_class, heart$target)
heartConf