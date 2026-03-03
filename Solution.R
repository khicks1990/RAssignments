# Test Program for Popular R Packages

# List of required packages
packages <- c("ggplot2", "dplyr", "tidyr", "lubridate", "data.table")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Load the packages
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(data.table)

# Checking R version
cat("R version:", R.Version()$version.string, "\n")

# Simple data frame for testing
data <- data.frame(
  Date = seq.Date(from = as.Date("2023-01-01"), by = "month", length.out = 6),
  Value = c(10, 20, 30, 25, 15, 30)
)

cat("Original Data Frame:\n")
print(data)

# Using dplyr to mutate and summarize
summary_data <- data %>%
  mutate(Month = month(Date)) %>%
  group_by(Month) %>%
  summarize(Average = mean(Value))

cat("Summary Data (Average by Month):\n")
print(summary_data)

# Create a plot and explicitly print it
plot <- ggplot(data, aes(x = Date, y = Value)) +
  geom_line() +
  geom_point() +
  labs(title = "Values Over Time", x = "Date", y = "Value")

# Print the plot
print(plot)

# Using tidyr to pivot the data
pivot_data <- data %>%
  pivot_longer(cols = Value, names_to = "Metric", values_to = "Value")

cat("Pivoted Data:\n")
print(pivot_data)

# Using lubridate to manipulate dates
data$Date_plus_10 <- data$Date + days(10)
cat("Data with Dates Increased by 10 Days:\n")
print(data)

# Using data.table for fast aggregation
dt <- data.table(data)
agg_data <- dt[, .(Total = sum(Value)), by = .(Month = month(Date))]
cat("Aggregate Data Table:\n")
print(agg_data)