# add needed packages here separated by commas
packages <- c("tidyverse")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidyverse))

# Increases font size for all ggplot2 plots
theme_set(theme_gray(base_size=18))

# List of colors for customizing plots
colors <- c("#1f77b4","#ff7f0e", "#2ca02c", "#d62728",
            "#9467bd","#8c564b", "#e377c2", "#7f7f7f",
            "#bcbd22", "#17becf")
            
# Load the data set mpg
mpg <- read_csv("mpg.csv")# Your code here

# Print summary of data frame
print(summary(mpg))# Your code here

# Create a scatter plot of weight vs mpg with origin represented by color
#  x label should be "Weight" and y label should be "MPG"
png(file="mpgScatterK.png")

p <- ggplot(mpg, aes(x = weight, y = mpg, color = factor(origin))) +
  geom_point() +
  labs( x = "Weight",
        y = "MPG",
        color = "Origin")

ggsave("mpgScatterK.png", plot=p, width=6, height=4, dpi=300)