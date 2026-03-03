suppressPackageStartupMessages(library(tidyverse))

# Read in hmeq_small.csv
hmeq <- # Your code here

hmeq$CLNO <- as.numeric(hmeq$CLNO)

# Create a new data frame with the rows with missing values dropped
hmeqDelete <- # Your code here

# Calculate the means of CLNO and YOJ
meanCLNO = mean(hmeq$CLNO, na.rm=TRUE)
meanYOJ = mean(hmeq$YOJ, na.rm=TRUE)

# Create a new data frame with the missing values of CLNO and YOJ filled in by the mean of the column
hmeqReplace <- # Your code here
                        
# Print the summary for each new data frame
print("Summary of hmeqDelete is ")
print(summary(hmeqDelete))
print("Summary of hmeqReplace is ")
print(summary(hmeqReplace))
