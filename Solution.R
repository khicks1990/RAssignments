suppressPackageStartupMessages(library(tidyverse))

# Increases font size for all ggplot2 plots
theme_set(theme_gray(base_size=18))

# List of colors for customizing plots
colors <- c("#1f77b4","#ff7f0e", "#2ca02c", "#d62728",
            "#9467bd","#8c564b", "#e377c2", "#7f7f7f",
            "#bcbd22", "#17becf")

titanic <- read.csv("titanic.csv")

# Subset the titanic dataset to include first class passengers who embarked in Southampton

# Using dplyr
# firstSouth <- titanic |> filter(pclass == 1) |> filter(embarked == "S")

# Using base R
firstSouth <- titanic[titanic$pclass == 1 & titanic$embarked == "S",]

# Subset the titanic dataset to include either second or third class passenger

# Using dplyr
# secondThird <- titanic |> filter(pclass == 2 | pclass == 3)

# Using base R
secondThird <- titanic[titanic$pclass == 2 | titanic$pclass == 3,]

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
firstSouth |> ggplot(aes(x=pclass)) + 
    geom_bar(aes(fill=sex), position="dodge") +
    scale_fill_manual(values=colors) + 
    labs(x="Class", y="Count", fill="Sex")

  ggsave("titanicBar1.png", plot = , width = 6, height = 4, dpi = 300)
    
# Create a bar chart for the second and third class passengers grouped by survival status
png(file="titanicBar2.png")
secondThird |> ggplot(aes(x=pclass)) + 
    geom_bar(aes(fill=alive), position="dodge") +
    scale_fill_manual(values=colors) + 
    labs(x="Class", y="Count", fill="Alive")

ggsave("titanicBar2.png", plot = p2, width = 6, height = 4, dpi = 300)