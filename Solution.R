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
X <- fires |> select(FFMC, DMC, DC, ISI, temp, RH, wind, rain)

# Calculate the correlation matrix for the data in the data frame X
XCorr <- as.data.frame(round(cor(X, use = "complete.obs"), 2))
print("Correlation matrix: ")
print(XCorr)

# Perform four-component factor analysis on the scaled data.
pcaModel <- princomp(X, cor = TRUE)
print("PCA summary: ")
print(pcaModel)

# Print the factors and the explained variance.
eigenvectors <- pcaModel$loadings[,1:4]
print("Eigenvectors: ")
print(eigenvectors)

eigenvalues <- (pcaModel$sdev)^2

print("Explained variance: ")
print(eigenvalues[1:4])