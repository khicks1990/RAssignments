# add any needed packages here separated by commas

packages <- c()

# Install packages if not already installed

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
  }
}

inputs <- as.character(x = readLines(con = "stdin", n = 7, warn = FALSE))

myFlower1 <- inputs[1]
myFlower2 <- inputs[2]
myFlower3 <- inputs[3]

yourInt1 <- inputs[4]
yourInt2 <- inputs[5]
yourInt3 <- inputs[6]
yourInt4 <- inputs[7]

# Define myVector containing myFlower1, myFlower2, and myFlower3 in that order
# Your code here

myVector <- c(myFlower1, myFlower2, myFlower3)

# Print the first element in myVector
# Your code here

print(myVector[1])

# Define yourVector containing yourInt1, yourInt2,
#yourInt3, and yourInt4 in that order
# Your code here

yourVector <- c(yourInt1, yourInt2, yourInt3, yourInt4)

# Print the first and fourth element in yourVector
# Your code here
print(yourVector[c(1, 4)])

# Create a list, `ourList` of `myVector` and `yourVector`, in that order,
# giving the vector elements the names `flowers` and `numbers`.
# Your code here
ourList <- list(flowers = myVector, numbers = yourVector)
# Print ourList
# Your code here
print(ourList)

# Print the list element flowers
# Your code here
print(ourList$flowers)