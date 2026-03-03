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

# Subset the titanic dataset to include first class passengers who embarked in Southampton
firstSouth <- titanic |>
  filter(pclass == 1, embarked == "S")

# Subset the titanic dataset to include either second or third class passenger
secondThird <- titanic |>
  filter(pclass == 2 | pclass == 3)

firstSouth |>
group_by(pclass, sex) |>
    summarize(n=n(), .groups="drop_last") |>
    spread(sex, n)
    
secondThird |>
group_by(pclass, alive) |>
    summarize(n=n(), .groups="drop_last") |>
    spread(alive, n)

# Create a bar chart for the first class passengers who embarked in Southampton grouped by sex
png(file="titanicBar1.png")

p <- ggplot(firstSouth, aes(x = sex, fill = sex)) +
  geom_bar() +
  labs(x = "Sex", y = "Count") +
  scale_fill_manual(values = colors)

ggsave("titanicBar1.png", plot=p, width=6, height=4, dpi=300)

# Create a bar chart for the second and third class passengers grouped by survival status
png(file="titanicBar2.png")

p2 <- ggplot(secondThird, aes(x = alive, fill = alive)) +
  geom_bar() +
  labs(x = "Survival Status", y = "Count") +
  scale_fill_manual(values = colors)

ggsave("titanicBar2.png", plot=p2, width=6, height=4, dpi=300)