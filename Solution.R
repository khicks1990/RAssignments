# Functions from base and stats package used, 
# no additional packages needed.

# Input two IQs, making sure that IQ1 is less than IQ2
inputs <- as.integer(x = readLines(con = "stdin", n = 2, warn=FALSE))

IQ1 <- inputs[1]
IQ2 <- inputs[2]

if(IQ1 > IQ2){
    print("IQ1 should be less than IQ2. Enter numbers again.")
    quit(save = "no")
}

# Calculate the probability that a randomly selected person has an IQ less than or equal to IQ1.
probLT <- pnorm(IQ1, mean=100, sd=15)

# Calculate the probability that a randomly selected person has an IQ between IQ1 and IQ2
probBetw <- pnorm(IQ2, mean=100, sd=14) - pnorm(IQ1, mean=100, sd=15)

print(paste0("The probability that a randomly selected person has an IQ less than or equal to ", format(round(IQ1, 3)), " is ", format(round(probLT, 3)), "."))
print(paste0("The probability that a randomly selected person has an IQ between ", format(round(IQ1, 3)), " and ", format(round(IQ2, 3)), " is ", format(round(probBetw, 3)),  "."))