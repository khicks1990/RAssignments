# add needed packages here separated by commas
packages <- c()

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

# Load packages
suppressPackageStartupMessages(library(rsample))
suppressPackageStartupMessages(library(neuralnet))
suppressPackageStartupMessages(library(tidymodels))

# Load input into a dataframe
set.seed(42)
df <- read.csv("nbaallelo_log.csv")
NBA <- df[sample(nrow(df), size = 1000), ]

# Encode game_result as numeric (0 = Loss, 1 = Win)
NBA$game_result <- ifelse(NBA$game_result == "L", 0, 1)

# Create a duplicate of NBA called NBAScaled and scale the features
NBAScaled <- NBA
NBAScaled[, c("pts", "elo_i", "win_equiv")] <- scale(NBAScaled[, c("pts", "elo_i", "win_equiv")])

# Split the data into train and test sets
NBAScaledSplit <- initial_split(NBAScaled, prop = 0.70)

trainData <- training(NBAScaledSplit)
testData <- testing(NBAScaledSplit)

# Fit a multilayer perceptron with one hidden layer of 3 neurons,
# learning rate 0.03, and 15000 epochs
classifyNBA_MLP <- neuralnet(
  game_result ~ pts + elo_i + win_equiv,
  data = trainData,
  hidden = 3,
  linear.output = FALSE,
  learningrate = 0.03,
  stepmax = 1e6,
  algorithm = "backprop"
)

# Create predictions on the test set
yPred <- # Your code here
testData$yPred <- as.factor(as.numeric(yPred[, 1] >= 0.5))

# Extract and print the network weights
weightVar <- classifyNBA_MLP$weights
print(weightVar)

# Compute the accuracy score
score <- mean(testData$yPred == testData$game_result)
print(score)