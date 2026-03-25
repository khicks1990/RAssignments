# add needed packages here separated by commas
packages <- c("tidyverse")

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Load nbaallelo_log.csv into a dataframe
NBA <- read.csv("nbaallelo_log.csv")

# Hot encode the game_result variable as a numeric variable with 0 for L and 1 for W
NBA$game_result <- ifelse(NBA$game_result == "W", 1, 0)

# Fit the logistic model
logisticModel <- glm(game_result ~ elo_i, family = "binomial", data = NBA)
summary(logisticModel)

# Predict the probability that an elo_i score of 1310 is a win / loss.
outcomeProb = predict(logisticModel, newdata = data.frame(elo_i = 1310), type="response")

print(paste0("A team with the given elo_i score has predicted probability ", format(round(outcomeProb, 3)), " of winning."))