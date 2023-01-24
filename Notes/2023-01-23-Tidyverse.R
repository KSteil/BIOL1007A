### tidyverse
##collection of packages that share philosophy, grammar (or how the code is structured), and data structures
library(tidyverse) # library function to load in package

## Operators: symbols that tells R to perform different operations (between variables, functions, etc.)
# Arithmetic operators: + - * / ^
# Assignment operator: <- 
# Logical operators: ! & |
# Relational operators: == != > < >= <=

## Miscellaneous operators: %>% (forward pipe operator) %in%

#dplyr : new(er) packages set of tools for manipulating

###Core Verbs
## filter()
## arrange()
## select()
## group_by() and summarize()
## mutate()

data(starwars)
head(star)
class(starwars)

### tibble ????
  # number of rows and columns

###NAs
anyNA(starwars) #is.na #complete.cases
starwarsClean <- starwars[complete.cases(starwars[,1:10])]
anyNA(starwarsClean[,1:10])

## filter(): picks/subsets observarions (ROWS) by their values
filter(starwars, gender == "masculine" & height < 180)
filter(starwarsClean, gender == "masculine", height < 180, height > 100 ) ## , is the same as &


#### %in% operator (matching); similar == but you can compare vectors of different lengths

#sequence of letters
a <- LETTERS[1:10]
length(a) # length of vector
b <- LETTERS[4:10]

## output of %in% depends on first vector
a %in% b # elements in a are missing in b, first four outputs are false
b %in% a # all elements in b are in a, results are all TRUE

#use
eyes <- filter(starwars, eye_color %in% c("blue", "brown"))
eyes2 <- filter(starwars, eye_color == "brown" | eye_color == "blue")
View(eyes) # opens a new 'tab' to view the dataset

### Arrange
# arrange(): reorders rows
arrange(starwars, by=height) #default is ascending order (lowest to highest)
# can use helper function desc()
arrange(starwars, by=desc(height))
arrange(starwars, height, desc(mass)) ##the second variable used to break ties

sw <- arrange(starwars, by=height)
tail(sw) #NAs are always at the bottom (missing values are at the end)

####### select(): chooses variables (COLUMNS) by their names
names(starwars) # list of the names in the dataset
select(starwars, 1:10)
select(starwars, name:species) # name through species
select(starwars, -(films:starships)) # do not want columns films through starships
starwars[,1:11] # also does the same

###### Rearrange columns
select(starwars, name, gender, species, everything())
# everything() helper function; useful if you have a couple variables you want to move to the beginning

### contains() helper function
select(starwars, contains ("color")) # Just pulled the columns that include "color"

#others include: ends_with(), starts_with(), num_range()

# select can also rename columns
select(starwars, haircolor = hair_color) # returns the new column with the new name

rename(starwars, haircolor = hair_color) # returns entire data frame
select(starwars, haircolor = hair_color, everything()) #returns entire data frame with the renamed column as the first


###### mutate(): creates new variables using functions of existing variables
# creating a new column that is height divided by mass

mutate(starwars, ratio = height/mass) # data, new named column, what the function is

starwars_lbs <- mutate(starwars, mass_lbs = mass*2.2)
starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything()) # brought it to the front using select
glimpse(starwars_lbs)

# .after=""/.before=""
starwars_lbs <- mutate(starwars, mass_lbs = mass * 2.2, .after= mass) #adds new columns after mass column

#transmute
transmute(starwars, mass_lbs = mass *2.2) # only returns mutated columns
transmute(starwars, mass, mass_lbs= mass * 2.2, height) # gives previous variable and the new, mutated column


###### group_by and summarize()
summarize(starwars, meanHeight = mean(height)) # gives NA 
summarize(starwars, meanHeight = mean(height, na.rm=T))

summarize(starwars, meanHeight = mean(height, na.rm=T), TotalNumber = n())

# use group_by for maximum usefulness
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders) # seperated into 2 groups of gender

summarize(starwarsGenders, meanHeight = mean(height, na.rm=T), TotalNumber=n()) # will also show the means for the NA gender group

###### Piping %>%
# used to emphasize a sequence of actions 
# allows you to pass an intermediate result onto the next function (uses output of one function as input of the next function
# avoid if you need to manipulate more than one object/variable at a time; or if variable is meaningful
# formatting: should have a space before %>% followed by a new line

starwars %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height, na.rm=TRUE), TotalNumber = n())
  # much cleaner code. skips the intermediates

### case_when() is useful for multiple if or ifelse statements
# more complex coding
starwars %>%
  mutate(sp = case_when(species == "Human" ~ "Human", TRUE ~ "Non-Human"))
  # if that condition is true, it is in the human column, if not, the second column
  # uses condition, puts "Human" if True in sp columns, puts "Non-Human" if false



