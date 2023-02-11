### Final looking into the purr function
### 2/1/2023
### SS

### call packages
library(tidyverse)

#call data
swData <- starwars

view(swData)

##pluck

pluck_exists(swData, 16) # checks if that index exits
pluck_exists(swData, "species")

pluck_depth(swData) # returns 3, the depth value of the frame

pluck(swData, "name")
pluck(swData, "height", 3) #returns the height at that point

#vec_depth(swData) <- no longer works

height<- pluck(swData, "height") # takes that index/list

# set BB8's height to 67
pluck(swData, "height", 85) <- 67


#map
funk <- function(value = NULL){
 return(value * 2) 
}

#if they drank twice as much milk, they would be twice as tall
swData$height <- map(swData$height, funk)


#keep,discard (discard)
blue_eyes <- keep(swData$eye_color, function(x)x == "blue")
view(blue_eyes)

#compact
nuEx <- c("a", "b", NULL, "c")
cleanEx <- compact(nuEx) # gets rid of Null or empty values


#imodify
view(iris)
sepalLength <- modify(iris$Sepal.Length, function(x) x*2)


#compose- combines two functions into one
funk2<-function(val= NULL){
  return(val*3)
}

funk3 <- compose(funk, funk2)

funk3(3)

swData$height <- map(swData$height, funk3)


#has_element
has_element(swData$species,"Human")
has_element(swData$name, "R2-D2")


#list_c, list_flatten, list_cbind

x <- list(1,3,4,6,8,9)
  class(x) #list 

  
v <- list_c(x)
  class(v) #numeric

x2 <- list(
  a = data.frame(x=1:2),
  b = data.frame(y = "a")
)

v2<-list_c(x2)

class(x2) #list
class(v2) #data.frame

pluck_depth(x2)

 
list_rbind(x2) # adds a row to the list
list_cbind(x2) # adds a column to the list


