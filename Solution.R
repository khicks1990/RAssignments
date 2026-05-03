# add needed packages here separated by commas
packages <- c()

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidyverse))

# Read in forestfires.csv
fires <- read.csv("forestfires.csv")

# Create a new data frame with the columns FFMC, DMC, DC, ISI, temp, RH, wind, and rain, in that order
X <- fires %>% select(FFMC, DMC, DC, ISI, temp, RH, wind, rain)

# Calculate the correlation matrix for the data in the data frame X
XCorr <- round(as.data.frame(cor(X)), 2)
print(XCorr)

# Perform four-component factor analysis on the scaled data.
firePCA <- princomp(X, cor = TRUE, scores = TRUE)

# Print the factors and the explained variance.
eigenvectors <- unclass(loadings(firePCA))[, 1:4]
print(eigenvectors)

eigenvalues <- # Your code here
print("Explained variance: ")
print(eigenvalues)