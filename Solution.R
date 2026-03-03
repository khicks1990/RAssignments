#add any needed packages here separated by commas
packages <- c("sqldf")

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

# SELECT Title 
# FROM Movie
# WHERE ReleaseDate > "2020-01-01"
print(sqldf("SELECT Title FROM Movie WHERE ReleaseDate > '2020-01-01'"))

# SELECT Title
# FROM Movie
# WHERE Rating In ("G", "PG")
print(sqldf("SELECT Title FROM Movie WHERE Rating IN ('G', 'PG')"))

# SELECT Title
# FROM Movie 
# WHERE Rating = "PG-13" and Year >= 2008 
print(sqldf("SELECT Title FROM Movie WHERE Rating = 'PG-13' AND Year >= 2008"))