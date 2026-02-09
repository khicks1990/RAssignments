# add any needed packages here separated by commas
packages <- c()

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Import the file homes.csv into the dataframe homes
# Your code here
homes <- read.csv("homes.csv")

# Display the column names
# Your code here
print(colnames(homes))

# Display the number of instances
# Your code here
print(nrow(homes))

# Display the columns Price, Bath, Bed, Year, and Status for instances
# for which School is Edison
# Your code here
print(homes[homes$School == "Edison", c("Price", "Bath", "Bed", "Year", "Status")])

# Add the column PriceSqFt to the dataframe with the
# values of Price divided by Floor
# Your code here
homes$PriceSqFt <- homes$Price / homes$Floor

# Display the first six rows of the dataframe with the new column
# Your code here
print(head(homes))