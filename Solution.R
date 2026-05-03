# Add tidymodels to ensure it installs in your environment
packages <- c("tidymodels", "readr", "rpart")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidymodels))

# 1. Load the mpg dataset
# use show_col_types = FALSE to keep the console clean
mpg <- read_csv("mpg.csv", show_col_types = FALSE)

# 2. Subset the data containing mpg, weight, and model_year
# We select by name to ignore that extra "...1" column
mpgRegression <- mpg %>% 
  select(mpg, weight, model_year)

# 3. Initialize a regression tree (Depth 3, Min Leaf Size 5)
set.seed(14092022)
mpgRT <- decision_tree(
  tree_depth = 3,
  min_n = 5
) %>% 
  set_engine("rpart") %>% 
  set_mode("regression")

# 4. Fit the model
fitTree <- mpgRT %>% 
  fit(mpg ~ weight + model_year, data = mpgRegression)
  
# 5. Print regression tree
print(fitTree)
