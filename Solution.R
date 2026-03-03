# add any needed packages here separated by commas
packages <- c()

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Load the package
library(sqldf)

Movie <- read.csv("movies.csv")

Movie$ReleaseDate <- as.Date(Movie$ReleaseDate, "%d-%b-%y")
print(head(Movie))

# EXAMPLE
# SELECT Title
# FROM Movie
# WHERE Rating = "G"
print(sqldf("SELECT Title FROM Movie WHERE Rating='G'"))

# Convert the given SQL statements

# SELECT Title, ReleaseDate
# FROM Movie
# WHERE Budget > Gross
print(sqldf("SELECT Title, ReleaseDate FROM Movie WHERE Budget > Gross"))

# SELECT Title
# FROM Movie
# WHERE Budget < Gross AND Rating = "G"
print(sqldf("SELECT Title FROM Movie WHERE Budget < Gross AND Rating = 'G'"))

# SELECT Title, Year, Budget
# FROM Movie
# WHERE Budget > 300000000
print(sqldf("SELECT Title, Year, Budget FROM Movie WHERE Budget > 300000000"))

