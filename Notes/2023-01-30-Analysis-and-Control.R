### Lecture 9 Simple Data Analysis and More Complex Control Structures
### 30 January 2023
### SS

# load in data
dryadData <- read.table(file="data/veysey-babbitt_data_amphibians2.csv", header=TRUE, sep=",")

## Set up libraries
library(tidyverse)
library(ggthemes)

#### Analyses
### Experimental designs
### independent/explanatory variable (x axis) vs dependent/ response variable (y axis)
### continuous (range of numbers: height, weight, temperature) vs discrete/categorical (categories: species, treatment groups, site)

glimpse(dryadData)

### Basic linear regression analysis (2 continuous variables)
## Is there a relationship between the mean pool hydroperiod and the number of breeding frogs

## y ~ x
regModel <- lm(count.total.adults ~ mean.hydro, data=dryadData)
print(regModel)
summary(regModel)
hist(regModel$residuals) ## histogram
summary(regModel)$"r.squared" ## returns just the r squared value
summary(regModel)[["r.squared"]]

#View(summary(regModel))

regPlot <- ggplot(data = dryadData, aes(x=mean.hydro, y=count.total.adults+1)) + 
  geom_point() + 
  stat_smooth(method="lm", se = 0.99)
regPlot + theme_few()

### Basic ANOVA
### Was there a statistically significant difference in the number of adults among wetlands?
#y~x

ANOmodel <- aov(count.total.adults ~ factor(wetland), data = dryadData) # factor makes the argument categorical
summary(ANOmodel) # P Value is the most important information usually

dryadData %>%
  group_by(wetland) %>%
  summarise(avgHydro = mean(count.total.adults, na.rm =T), N=n())

### Boxplot
dryadData$wetland <- factor(dryadData$wetland) # originally read as an int, now is read as a factor
class(dryadData$wetland)

ANOplot <- ggplot(data=dryadData, mapping = aes(x= wetland, y=count.total.adults, fill=species)) + # filled by species -> displays the colors based on the species. A legend is provided
  geom_boxplot()+
  scale_fill_grey() # makes the fill grey scale
ANOplot

# can save the image by exporting it OR
ggsave(file = "SpeciesBoxplots.pdf", plot=ANOplot, device="pdf")

#to resize, click the zoom option, resize to the desired size, right click and save from there

### Logistic regression
## data frame

#gamma probabilities are best for continuous variables that are always positive and have a skewed distribution 
xVar <- sort(rgamma(n=200, shape = 5, scale = 5)) # shape and scale are more statistics
hist(xVar)
yVar <- sample(rep(c(1,0), each = 100), prob = seq_len(200))

logRegData <- data.frame(xVar, yVar)
glimpse(logRegData)

##Logistic regression
logRegModel <- glm(yVar ~ xVar, data = logRegData, family = binomial(link=logit))
  summary(logRegModel)

LogRegPlot <- ggplot(data = logRegData, aes(x=xVar, y=yVar)) +
  geom_point()+
  stat_smooth(method = "glm", method.args=list(family=binomial))
print(LogRegPlot)  


##Contingency table (chi-squared) Analysis
  ## both are categorical (?)
  ## Are there differences between males and females between species

countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males =sum(No.males, na.rm = T), Females = sum(No.females, na.rm=T)) %>%
  select(-species) %>%
  as.matrix()
  
  row.names(countData) = c("SS","WF")
countData  

## Chi-squared
chisq.test(countData)$residuals
testResults <-chisq.test(countData)  
testResults$residuals  
testResults$expected  

###### mosiac pplot (base R)
mosaicplot(x=countData,
           col=c("goldenrod", "steelblue"), shade = FALSE)

### bar plot
countDataLong <- countData %>%
  as_tibble() %>%
  mutate(Species = c(rownames(countData))) %>%
  pivot_longer(cols = Males:Females, names_to = "Sex", values_to="Count")

### Plot bar graph
ggplot(data = countDataLong,
       mapping = aes(x=Species, y=Count, fill= Sex)) +
  geom_bar(stat="identity", position = "dodge") + #plots bars next to each other
  scale_fill_manual(values=c("darkslategrey","midnightblue"))



##############################################################
#### Control Structures

# if and ifelse statements

###### if statement
#### if (condition) {expression 1}


#### if (condition) {expression1} else {expression2}

### if any unspecified else, captures the rest of unspecified conditions
# else Must appear on the same line as the expression 
# use it for single values

z <- signif(runif(1), digits=2)
z > .5

### use {} or not

if (z > 0.8) {cat(z, "is a large number", "\n")} else 
  if (z < 0.2) {cat(z, "is a small number", "\n")} else
  {cat(z, "is a number of typical size", "\n") 
    cat("z^2 = ", z^2, "\n")}


# "\n' end with a line break

##### ifelse to fill vectors

#### ifelse(condition, yes, no)

## Insect population where females lay 10.2 eggs on average, follows a Poisson distribution (discrete probability distribution showing the likely number of times an event will occur). 35% parasitism where no eggs are laid. Let's make a distribution for 1000 individuals

tester <- runif(1000)
eggs <- ifelse(tester > 0.35, rpois(n=1000, lambda = 10.2), 0)
hist(eggs)


### vector of p-values from a simulation and we want to create a vector to highlight the significant ones for plotting

pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lowerTail", "nonSig")

z[pVals >= 0.975] <- "upperTail"
table(z)


###### for loops
#### workhorse function for doing repetitive tasks
## universal in a ll computer languages
## controversial in R because it is often unnecessary (vectorization in R)
# - Also, very slow with certain operations
# - family of apply functions

#### Anatomy of for loop
### for(var in sequence){#starts the forloop
  #body of the for loop
  #end of for loop}

# var  is a counter variable that holds the current value of the loop (i, j, k)
# sequence is an integer vector that defines start/end of loop

for(i in 1:5){
  cat("stuck in a loop. Please help.", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "\n")
}

print(i) # 5, the number the for loop ended on

### Use a counter variable that maps to the position of each element

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for(i in 1:length(my_dogs)){
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}

### use double for loops
m <- matrix(round(runif(20), digits=2), nrow=5)

for (i in 1:nrow(m)){
  m[i,] <- m[i,] + i
}
m

## loop over columns
m <- matrix(round(runif(20), digits=2), nrow=5)

for (j in 1:ncol(m)){
  m[,j] <- m[,j] + j
}
m

#### loop over rows and columns
m <- matrix(round(runif(20), digits=2), nrow=5)

for (i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}
m


