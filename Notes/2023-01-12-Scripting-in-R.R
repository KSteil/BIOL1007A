##### Programming in R   
##### 12 January 2023   
##### SS

# Advantages
## interactive use
## graphics, statistics
## very active community of contributors
## works on multiple platforms

# Disadvantages
## lazy evaluation
## some packages are poorly documented
## some functions are hard to learn (steep learning curve)
## unreliable packages 
## problems with big data (multiple GBs)

# Start with the basics!!

## Assignment operator: used to assign a new value to a variable

x <- 5
print(x)
x

y = 4 #legal but not used except in function arguments
print(y)
y = y + 1.1
y <- y + 1.1

## Variables: used to store information (a container)

z <- 3 #single letter variables
plantHeight <- 10 #camel case format
plant_height <- 3.3 #snake case #a preferred case
plant.height <- 4.2 
. <- 5.5 #reserve for temporary variable #doesn't show up in the environment

## Functions: blocks of code that performs a task; use a short command over again instead of writing out that block of code multiple times

# you can create your own function
square <- function(x = NULL){
  x <- x^2
  print(x)
}

square(x=3)
z <- 103
square(x = z) #the argument name is x

### or there are built in functions
sum(109, 3, 10) ## look at package info using ?sum or going to Help panel


#### Atomic Vectors
# one dimensional (a single row)
# data structures in R programming

### Types 
# character strings (usually within quotes)
# integers (whole numbers)
# double (real numbers, decimal)
# both integers and doubles are numeric
# logical (TRUE or False)
# factor (categorizes, groups variable)

# c function (combine)
z <- c(3.2, 5, 5, 6)
print(z) # prints
class(z) # returns class
typeof(z) # returns type of variable
is.numeric(z) # returns T/F

## c() always 'flattens' to a vector
z <- c(c(3,4), c(5,6))

### c() useful for creating vectors
#character vectors
z <- c("perch", "bass", "trout")
z<- c("This is only one character string", "a second", 'a third')
print(z)
typeof(z)
class(z)
is.character(z) #is. functions tests whether it is a certain data type

z <- c(T, F, T, F) #as. functions coerces data
is.logical(z)
z <- as.character(z) #must  have '<-'
is.logical(z)


## Type
# is.numeric / as.character
# typeof()

# Length
length(z)
dim(z) #NULL because vectors are 1 dimensional

## Names
z <- runif(5)  ##random numbers between 0 and 1 (random uniform distribution)
z <- rnorm(5)  ##random normal numbers (?? I guess)
names(z)

# add names
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita")
print(z) #now displays names and values
names(z) <- NULL #removes names

### NA values
## missing data
z <- c(3.2, 3.5, NA)
typeof(z)
mean(z) #arithmetic won't work with an NA
anyNA(z) #returns logical is there is an NA
is.na(z) #returns 'F F T', showing which is NA
which(is.na(z)) #helpful for exploring data and determining where NAs are

## Subsetting vectors
#vectors are indexed
z<- c(3.1, 9.2, 1.3, 0.4, 7.5)
print(z)
z[4] #use square brackets to subset by index
z[c(4,5)] #need to use c for multiple indices
z[-c(2,3)] #minus signs to exclude elements
z[-1] #excludes first index
z[z==7.5] #returns if the condition is met #double equals for exact match
z[z<7.5] #use logical statements within square brackets to subset by conditions

which(z < 7.5)
z[which(z<7.5)] #which only outputs indices; within [] it subsets those values

#creating logical vector
z < 7.5 #returns logical values

## subsetting characters (named elements)
names(z) <- c('a', 'b', 'c', 'd', 'e')
z[c('a','d')] # outputs names and values of specified characters

## subset 
subset(x=z, subset= z>1.5)

#randomly sample
#sample function
story_vec <- c("A", "frog", 'jumped', 'here')
sample(story_vec) #shuffles the vector 

#randomly select 3 elements from vector
sample(story_vec, size = 3)

story_vec <- c(story_vec[1], "Green", story_vec[2:4]) #adds green after index 1, before indices 2:4

story_vec[2] <- "Blue" #replaces second index in vector
  
#vector function
vec <- vector(mode = "numeric", length=5) #populates a vector with numbers

### rep and seq functions
z <- rep(x=0, times = 100) #now z has 100 zero values
z <- rep(x= 1:4) #string of numbers
z<- rep(x=1:4, each = 3) #repeats each value 3 times
z <- rep(x=1:4, times = 3) #repeats 'x' 3 times

z <- seq(from=2, to=4) #populates z with a sequence from 2 to 4
z
seq(from=2, to=4, by=0.5)

z<-runif(5)
seq(from=1, to=length(z))
