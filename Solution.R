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
NBA <- df[sample(nrow(df), size=1000), ]

# Hot encode the game_result variable as a numeric variable with 0 for L and 1 for W
NBA$game_result <- ifelse(NBA$game_result == "L",0,1)

# Create a duplicate of NBA called NBAScaled and then scale the features
NBAScaled <- NBA
NBAScaled[, c("pts", "elo_i", "win_equiv")] <- scale(NBA[, c("pts", "elo_i", "win_equiv")])

# Split the data into train and test sets
NBAScaledSplit <- initial_split(NBAScaled, prop = 0.70)

trainData <- training(NBAScaledSplit)
testData <- testing(NBAScaledSplit)

# Fit a perceptron model with a learning rate of 0.05 and 20000 epochs
classifyNBA <- neuralnet(game_result ~ pts + elo_i + win_equiv,
  data = trainData,
  hidden = 0,
  learningrate = 0.05,
  stepmax = 20000,
  linear.output = FALSE,
  algorithm ="backprop")

# Create a list of predictions from the test features
yPred <- compute(classifyNBA, testData[, c("pts", "elo_i", "win_equiv")])$net.result

testData$yPred <- as.factor(as.numeric(yPred[, 1] >= 0.5))

# Find the weights for the input variables
weightVar <- classifyNBA$weights
print(weightVar)

# Find the accuracy score
score <- accuracy(testData, truth = as.factor(game_result), estimate = yPred)
print(score)