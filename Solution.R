# add needed packages here
packages <- c("tidyverse")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidyverse))

# Load the hmeq dataset
hmeq <- read_csv("hmeq_small.csv", show_col_types = FALSE)# Your code here

# Drop rows with NAs
hmeq <- drop_na(hmeq)

# Standardize the columns LOAN and VALUE
hmeqStand <- hmeq %>%
  mutate(
    LOAN_STAND = as.numeric(scale(LOAN)),
    VALUE_STAND = as.numeric(scale(VALUE))
  )# Your code here

# Normalize the columns LOAN and VALUE
hmeqNorm <- hmeq %>%
  mutate(
    LOAN_NORM = (LOAN - min(LOAN)) / (max(LOAN) - min(LOAN)),
    VALUE_NORM = (VALUE - min(VALUE)) / (max(VALUE) - min(VALUE))
  )# Your code here

# Print the summaries of the data frames hmeqStand and hmeqNorm
print("Summary of standardized data:")
print(summary(hmeqStand))# Your code here

print("Summary of normalized data:")
print(summary(hmeqNorm))# Your code here