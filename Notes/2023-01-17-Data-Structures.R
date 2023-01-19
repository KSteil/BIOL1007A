##### Vectors, Matrices, Data Frames, and Lists
##### 17 January 2023
##### SS

## Vectors Continued
## Properties

##Coercion

### All atomic vectors are the same data type
## If you use c() to assemble different types, R coerces them
## Logical -> integer -> double -> character

a <- c(2, 2.2) 
typeof(a)
#coerces to double


b <- c("purple", "green")
typeof(b)
#coerces to character

d <- c(a,b)
typeof(d)
#coerces to character

### comparison operators yield a logical result
a <- runif(10)
print(a)

a > 0.5 ## conditional statement

### How many elements in the vector are > 0.5
sum(a > 0.5)
mean(a > 0.5) #what proportion of the vector are greater than 0.5

#### Vectorization
### Add a constant to a vector 

z <- c(10, 20, 30)
z + 1 # adds 1 to each element in the vector

#what happens when vectors are added together
y<- c(1,2,3)
z + y #Matches by element, results in an 'element by element' operation on the vector

z^2
## Recycling
# What if vector lengths are not equal?

z
x <- c(1,2)

z + x # Goes back through the shorter vector, shorter vector is always recycled 
      # Warning is issued but calculation is still made

#### Simulating data: runif nd rnorm()

runif(n=5, min=5, max=10) #n = sample size, min = minimum value, max = maximum value

set.seed(123) # Important for making random numbers reproducible
# Seeds must be set for each  individual runif command
# set.seed can any number, sets random number generator (is reproducible)

## rnorm: random normal values, with a mean of 0 and a std of 1
randomNormalNumbers <- rnorm(100)
mean(randomNormalNumbers) #hist function shows distribution
hist(randomNormalNumbers)

hist(runif(n=100, min=5, max=10))
rnorm(n=100, mean=100, sd=30)
hist(rnorm(n=100, mean=100, sd=30))

####Matrix data structure
### 2 dimensional (rows and columns)
### homogeneous data type

# Matrix is an atomic vector organized into rows and columns
my_vec <- 1:12
m <- matrix(data = my_vec, nrow=4) # sets number of rows
print(m)

m <- matrix(data = my_vec, ncol=3) # Sets number of columns
m <- matrix(data = my_vec, ncol=3, byrow=T) #Fills in by the row

#### Lists
## are atomic vectors BUT each element can hold different data types (and different values)

myList <- list(1:10, matrix(1:8, nrow=4, byrow=TRUE), letters[1:3], pi)
class(myList)
str(myList)

#### subsetting lists
## using [] gives you a single item BUT not the elements

myList[4]
myList[4] - 3 #single brackets gives you only elements in slot which is always type of list

#to grab object itself, use [[]] double brackets
myList[[4]] ##now we access contents
myList[[4]] -3

myList[[2]] #can access the matrix
myList[[2]][4,1] #called the second element of the list, accessed the fourth row, 1st column
## 2 dim subsetting -> first number is row index, second is column [4,1] gives you 4th row, 1st column

myList[c(1,2)] #to obtain multiple **

c(myList[[1]], myList[[2]])#to obtain multiple elements within lists

### Name list items when they are created
myList2 <- list(Tester = FALSE, littleM = matrix(1:9, nrow=3))

myList2$Tester #calls the named element
  ### Dollar sign accesses named element

myList2$littleM[2,3] #extracts second row, third column of littleM

myList2$littleM[2,] #leave blank if you want all elements in the second row

myList2$littleM[5] #gives 5th element

### unlist to string everything to vector
unRolled <- unlist(myList2)
unRolled #each element is named

data(iris)
head(iris) #lets you see the first 6 rows
plot(Sepal.Length ~ Petal.Length, data = iris) #How Sepal.Length (y axis) relates to Petal.Length (x axis) from the iris data set

model <- lm(Sepal.Length ~ Petal.Length, data = iris) #lm = linear model
model
results <- summary(model) #A summary of teh results of the linear model
results

str(results) #str = structure
results$coefficients

results$coefficients[2,4]
results$coefficients["Petal.Length", "Pr(>|t|)"]

unlistedCoefficients <- unlist(results$coefficients)
unlistedCoefficients[8]
length(unlistedCoefficients)

#different way: use unlist()
unlist(results)$coefficients8


### Data Frames
## (list of) equal - lengthed vectors, each of which is a column

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each=4)
varC <- runif(12)

dFrame <- data.frame(varA, varB, varC, stringsAsFactors =FALSE)
print(dFrame)
str(dFrame)

# add another row
newData <- list(varA=13, varB= "HighN", varC = 0.668)

#use rbind()
dFrame <- rbind(dFrame, newData) #original data frame, what is being added

newData2 <- c(14, "HighN", 0.668) #data types are now all going to be chr
dFrame <- rbind(dFrame, newData2)
str(dFrame)

### add a column
newVar <- runif(14)
## use cbind() function to add column
dFrame <- cbind(dFrame, newVar) #adds new column called newVar
dFrame


### Data Frames vs Matrices
zMat <- matrix(data=1:30, ncol=3, byrow=TRUE)
zDframe <- as.data.frame(zMat) #as functions coerces data into something else **?
str(zDframe) #
str(zMat) #list of integers

zMat[3,3]
zDframe[3,3] #laid our the 

zMat[,3]
zDframe[,3]
zDframe$V3

zMat[3,]
zDframe[3,]

zMat[3]  #third element (counts down on columns)
zDframe[3] #third column

##### Eliminating NAs
## complete.cases() function
zD <- c(NA, rnorm(10), NA, rnorm(3))
complete.cases(zD) #gives logical output

#clean out NAs
zD[complete.cases(zD)] #returns vector without NAs
which(!complete.cases(zD)) #gives element number of NA
which(is.na(zD))#outputs same as above

#use with matrix
m <- matrix(1:20, nrow=5)
m[1,1] <- NA #assigns element to a specific point in the matrix
m[5,4] <- NA
complete.cases(m)#gives t/f as to whether whole row is complete
m[complete.cases(m),] #gives the rows that do not have NAs

## get complete cases for only certain rows
m[complete.cases(m[,c(1:2)]),] #only look at the first 2 rows
