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

# Read in forestfires.csv
fires <- read.csv("forestfires.csv") # Your code here

# Create a new data frame with the columns FFMC, DMC, DC, ISI, temp, RH, wind, and rain, in that order
X <- fires |> select(FFMC, DMC, DC, ISI, temp, RH, wind, rain) # Your code here

# Calculate the correlation matrix for the data in the data frame X
XCorr <- round(as.data.frame(cor(X)), 2) # Your code here
XCorr

# Perform four-component factor analysis on the scaled data.
pcaModel <- princomp(X, cor = TRUE) # Your code here

# Print the factors and the explained variance.
eigenvectors <- loadings(pcaModel)[, 1:4] # Your code here
eigenvectors

eigenvalues <- pcaModel$sdev[1:4]^2 # Your code here
print("Explained variance: ")
eigenvalues