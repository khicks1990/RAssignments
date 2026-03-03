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
hmeq <- read.csv("hmeq_small.csv")

# Drop rows with NAs
hmeq <- drop_na(hmeq)

# Standardize the columns LOAN and VALUE
hmeqStand <- hmeq %>%
  mutate(
    LOAN_STAND = as.vector(scale(LOAN)),
    VALUE_STAND = as.vector(scale(VALUE))
  )

# Normalize the columns LOAN and VALUE
hmeqNorm <- hmeq %>%
  mutate(
    LOAN_NORM = (LOAN - min(LOAN)) / (max(LOAN) - min(LOAN)),
    VALUE_NORM = (VALUE - min(VALUE)) / (max(VALUE) - min(VALUE))
  )

# Print the summaries of the data frames hmeqStand and hmeqNorm
print("Summary of standardized data:")
print(summary(hmeqStand))
print("Summary of normalized data:")
print(summary(hmeqNorm))



