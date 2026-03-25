# add needed packages here separated by commas
packages <- c("tidyverse")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Read in nbaallelo_slr.csv
nba <- read.csv("nbaallelo_slr.csv")

# Create a new column in the data frame that is the difference between pts and opp_pts
nba$y <- nba$pts - nba$opp_pts

# Fit a least squares regression model on y and elo_i
SLRModel <- lm(y ~ elo_i, data = nba)

# Print the intercept
intercept <- coef(SLRModel)[1]
print(paste0("The intercept of the linear regression line is ", format(round(intercept, 3)), "."))

# Print the slope
slope <- coef(SLRModel)[2]
print(paste0("The slope of the linear regression line is ", format(round(slope, 3)), "."))

# Compute the proportion of variation explained by the linear regression
rSquare <- summary(SLRModel)$r.squared
print(paste0("The proportion of variation explained by the linear regression model is ", format(round(rSquare, 3)), "."))