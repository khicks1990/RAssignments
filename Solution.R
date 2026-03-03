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
titanic <- read.csv("titanic.csv") |> as_tibble()

# Subset the titanic dataset to include first class passengers who embarked in Southampton
firstSouth <- titanic |> filter(pclass ==1, embarked=="S")

# Subset the titanic dataset to include either second or third class passenger
secondThird <- titanic |> filter(pclass %in% c(2,3))

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

ggplot(firstSouth, aes(x=sex, fill=sex))+geom_bar()+labs(x="Sex", y="Count")

dev.off()

# Create a bar chart for the second and third class passengers grouped by survival status
png(file="titanicBar2.png")

ggplot(secondThird, aes(x=alive, fill=alive))+geom_bar()+labs(x="Alive", y="Count")

dev.off()