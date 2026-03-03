suppressPackageStartupMessages(library(tidyverse))

# Read in hmeq_small.csv
hmeq <- read.csv("hmeq_small.csv")

hmeq$CLNO <- as.numeric(hmeq$CLNO)

# Create a new data frame with the rows with missing values dropped
hmeqDelete <- na.omit(hmeq)

# Calculate the means of CLNO and YOJ
meanCLNO = mean(hmeq$CLNO, na.rm=TRUE)
meanYOJ = mean(hmeq$YOJ, na.rm=TRUE)

# Create a new data frame with the missing values of CLNO and YOJ filled in by the mean of the column
hmeqReplace <- hmeq %>% mutate(CLNO=ifelse(is.na(CLNO), meanCLNO, CLNO), YOJ=ifelse(is.na(YOJ), meanYOJ, YOJ))
  
                        
# Print the summary for each new data frame
print("Summary of hmeqDelete is ")
print(summary(hmeqDelete))
print("Summary of hmeqReplace is ")
print(summary(hmeqReplace))
