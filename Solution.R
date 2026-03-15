suppressPackageStartupMessages(library(tidyverse))

# Read in hmeq_small.csv
hmeq <- read_csv("hmeq_small.csv", show_col_types = FALSE)# Your code here

hmeq$CLNO <- as.numeric(hmeq$CLNO)

# Create a new data frame with the rows with missing values dropped
hmeqDelete <- hmeq %>% drop_na()# Your code here

# Calculate the means of CLNO and YOJ
meanCLNO = mean(hmeq$CLNO, na.rm=TRUE)
meanYOJ = mean(hmeq$YOJ, na.rm=TRUE)

# Create a new data frame with the missing values of CLNO and YOJ filled in by the mean of the column
hmeqReplace <- hmeq %>%
  mutate(
    CLNO = if_else(is.na(CLNO), meanCLNO, CLNO),
    YOJ = if_else(is.na(YOJ), meanYOJ, YOJ)
  )# Your code here
                        
# Print the summary for each new data frame
print("Summary of hmeqDelete is ")
print(summary(hmeqDelete))
print("Summary of hmeqReplace is ")
print(summary(hmeqReplace))