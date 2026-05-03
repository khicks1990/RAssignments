# add needed packages here separated by commas
packages <- c("rsample", "neuralnet", "tidymodels")

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
NBAScaled[, c("pts", "elo_i", "win_equiv")] <- scale(NBA[, c("pts", "elo_i", "win_equiv")])

# Split the data into train and test sets
NBAScaledSplit <- initial_split(NBAScaled, prop = 0.70)

trainData <- training(NBAScaledSplit)
testData <- testing(NBAScaledSplit)

# Fit a multilayer perceptron
classifyNBA_MLP <- neuralnet(
  game_result ~ pts + elo_i + win_equiv,
  data = trainData,
  hidden = 3,
  learningrate = 0.03,
  stepmax = 15000,
  linear.output = FALSE,
  algorithm = "backprop"
)

# Create predictions on the test set
yPred <- neuralnet::compute(classifyNBA_MLP, testData[, c("pts", "elo_i", "win_equiv")])
testData$yPred <- as.factor(as.numeric(yPred$net.result >= 0.5))

# Extract and print the network weights
weightVar <- classifyNBA_MLP$weights
print(weightVar)

# Compute accuracy score
score <- mean(testData$yPred == as.factor(testData$game_result))
print(score)
