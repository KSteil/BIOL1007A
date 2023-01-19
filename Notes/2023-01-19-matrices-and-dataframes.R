##### Finishing up matrices and Data Frames
##### 19 January 2023
##### SS

m <- matrix(data = 1:12, nrow=3)

##subsetting based on elements
m[1:2, ]
m[,2:4]

## Subset with logical (conditional) statements
## select all columns for which totals are > 15

colSums(m) > 15 ## logical output to which columns are over 15
m[,colSums(m)>15] ## gives the columns of the rows that are over 15

## row sums now
## select rows that sum up to 22
m[rowSums(m) == 22,] ##the double equal sign (==) is the logical operator
#outputs the row that the sum is 22
m[rowSums(m) != 22,] ##the rows that do not sum to 22

## Logical operators: == != > <

## subsetting to a vector changes the data type
z <- m[1,]
print(z)
str(z) #structure of z is now integers, no longer matrix

z2 <- m[1, , drop=FALSE]  
z2

#### Simulating Matrices
###
###

### use assignmemt operator to substitute values
m2[m2 > 0.6] <- NA ## values over .6 is NA

data <- iris
head(data) #first 6 entries
tail(data) #last 6 entries

data [3,2] # numbered indices still work

dataSub <- data[,c("Species", "Petal.Length")]
str(dataSub)

### sort a data frame by values
orderedIris <- iris[order(iris$Petal.Length),] # dollar sign finds named element
head(orderedIris)
