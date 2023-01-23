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


####### FUNCATIONS IN R

# everything in r is a function
sum(3,2) # sum
3 + 2 # + sign is a function
sd # will show the code of a function if you run JUST the argument

### User-defined functions
#functionName <- function(argX=defualtX, argY=default Y) {
  ##curly bracket starts the body of the function
  ### lines of code and notes
  ### create local variables (only visible to R within the function)
    #argX<-(smth)
  ### return(z)
#}


myFunk <- function(a=3, b=4){
  z <- a + b
  return(z) #return stops the function at that line 
}

myFunk() #returns the defaults
myFunk(a=100, b=3.4) # runs with specified variables


myFunkBad <- function(a=3){
  z <- a + b
  return(z)
}
myFunkBad()#returns an error, object 'b' not found
b <- 100
myFunkBad() #can run and recognizes the global value, but BAD practice

myFunkEmpty <- function(a=NULL, b=NULL){
  z <- a + b
  return(z)
}
myFunkEmpty() #does not return an error, returns 0

print(z) # cannot print z, not defined outside of the function

z <- myFunk() #NOW saves z as the default ran through the function

### Multiple return statements

##############################################################
# Function: HardyWeinberg
# input: all allele frequenecy p (0,1)
# output: p and the frequencies of 3 genotypes AA AB BB
#-------------------------------------------------------------
HardyWeinberg <- function(p = runif(1)){
  if(p>1.0 | p<0){
    return("Function Failure: p must be between 0 and 1")
  } ## '|' OR
  q <- 1 -p
  fAA <- p^2
  fAB <-2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p, AA=fAA, AB=fAB, BB=fBB), digits=3) #signif returns significant figures
  return(vecOut)
}
#############################################################

HardyWeinberg()
freqs <- HardyWeinberg()

HardyWeinberg(p=3) # returns an error, as stated in the function


####### Create a more complex default value
##################################################
# Function: fitLinear2
# fits simple regression line
# input: numeric list (p) of predictor (x) and response (y)
# outputs: slope and p-value

fitLinear2 <-function(p=NULL){
  if(is.null(p)){
    p <- list(x=runif(20), y=runif(20))
  }
  myMod <- lm(p$x~p$y)
  myOut <- c(slope= summary(myMod)$coefficients[2,1],
             pValue = summary(myMod)$coefficients[2,4])
  plot(x=p$x, y=p$y) #quick plot to check output
  return(myOut)
}

fitLinear2()
myPars <- list(x=1:10, y=runif(10))
fitLinear2(p=myPars)



