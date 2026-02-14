# add needed packages here separated by commas
packages <- c("tidyverse")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Read in the file mtcars.csv
cars <- read.csv("mtcars.csv")

# Find the mean of the column wt
mean <- mean(cars$wt)

# Find the median of the column wt
median <- median(cars$wt)

print(paste0("mean = ", format(round(mean, 3)), ", median = ", format(round(median, 3))))