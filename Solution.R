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

# Increases font size for all ggplot2 plots
theme_set(theme_gray(base_size=18))

# List of colors for customizing plots
colors <- c("#1f77b4","#ff7f0e", "#2ca02c", "#d62728",
            "#9467bd","#8c564b", "#e377c2", "#7f7f7f",
            "#bcbd22", "#17becf")
# Load titanic.csv
titanic <- read.csv("titanic.csv")

# Subset: First class passengers who embarked from Southampton
firstSouth <- titanic |>
  filter(pclass == 1, embarked == "S")

# Subset: Second or Third class passengers
secondThird <- titanic |>
  filter(pclass == 2 | pclass == 3)

# Print first table
print(
  firstSouth |>
    group_by(pclass, sex) |>
    summarize(n = n(), .groups = "drop_last") |>
    spread(sex, n)
)

# Print second table
print(
  secondThird |>
    group_by(pclass, alive) |>
    summarize(n = n(), .groups = "drop_last") |>
    spread(alive, n)
)

# Bar chart 1
png(file="titanicBar1.png")

p <- ggplot(firstSouth, aes(x = sex)) +
  geom_bar() +
  labs(title = "First Class Passengers (Southampton)",
       x = "Sex",
       y = "Count")

dev.off()

# Bar chart 2
png(file="titanicBar2.png")

p2 <- ggplot(secondThird, aes(x = factor(pclass), fill = alive)) +
  geom_bar(position = "dodge") +
  labs(title = "Second and Third Class Survival",
       x = "Passenger Class",
       y = "Count",
       fill = "Alive")

dev.off()