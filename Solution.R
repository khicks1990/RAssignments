# add needed packages here separated by commas
packages <- c()

# Install packages if not already installed
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

suppressPackageStartupMessages(library(tidyverse))

theme_set(theme_gray(base_size=18))

colors <- c("#1f77b4","#ff7f0e", "#2ca02c", "#d62728", 
"#9467bd","#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf")

set.seed(42)

# Load the dataset
mammalSleepRaw <- read.csv('msleep.csv')

# Create a dataframe with the columns sleep_total and sleep_rem
mammalSleep <- mammalSleepRaw %>% select(sleep_total, sleep_rem)

# Clean the data
mammalSleep <- drop_na(mammalSleep)

# Fit a k-means model with k=4
kmModel <- kmeans(mammalSleep, centers = 4)
kmModel

# Find the centroids of the clusters
mammalSleepCentroids <- as.data.frame(kmModel$centers)
mammalSleepCentroids

mammalSleep$cluster <- as.factor(kmModel$cluster)

# Plot the clusters and centroids
png(file = "msleep_clusters.png")

mammalSleep |>
  ggplot(aes(x = sleep_total, y = sleep_rem, color = cluster)) +
  geom_point() +
  geom_point(data = mammalSleepCentroids,
             aes(x = sleep_total, y = sleep_rem),
             color = "black", shape = 18, size = 5) +
  labs(x = "Sleep total", y = "Sleep REM") +
  theme(legend.position = "none") +
  scale_color_manual(values = colors)

dev.off()

# Fit k-means clustering with k=1,...,5 and save WCSS for each
WCSS <- sapply(1:5, function(k) 
  kmeans(mammalSleep[, c("sleep_total", "sleep_rem")], centers = k)$tot.withinss
)
print(WCSS)