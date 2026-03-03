suppressPackageStartupMessages(library(tidyverse))

# Increases font size for all ggplot2 plots
theme_set(theme_gray(base_size=18))

# List of colors for customizing plots
colors <- c("#1f77b4","#ff7f0e", "#2ca02c", "#d62728",
            "#9467bd","#8c564b", "#e377c2", "#7f7f7f",
            "#bcbd22", "#17becf")
            
# Load the data set mpg
mpg <- read.csv("mpg.csv")

# Print summary of data frame
summary(mpg)

# Create a scatter plot of weight vs mpg with origin represented by color
#  x label should be "Weight" and y label should be "MPG"
png(file="mpg_scatter.png")
mpg |>
    ggplot(aes(x=weight, y=mpg)) + 
    geom_point(aes(col=origin)) + 
    scale_color_manual(values=colors) + 
    labs(x="Weight", y="MPG", 
         color="Origin")