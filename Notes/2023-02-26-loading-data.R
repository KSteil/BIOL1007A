### LEcture 8: Loading in Data
### 26 January 2023
### SS

## Create and save dataset
### write.table(x=varName, file="outputFileName.csv", header=TRUE, sep=",")
  ## "," notates that it's seperated with a comma


#### These functions read in a data set
### read.table(file="path/to/data.csv", header = TRUE, sep = ",")
### read.csv(file='data.csv", header = T)

##### Use RDS object when only working in T
## saveRDS(my_data, file="FileName.RDS")
## readRDS("FileName.RDS")
## p <- readRDS("FileName.RDS")

## RDS - creates an object in r - can take up less storage (helpful for large data sets)

### Long vs Wide data formats
## Wide format = contain values that do NOT repeat in the ID column
### long format = contains values that DO repeat in the ID column

library(tidyverse)
head(billboard)

b1 <- billboard %>%
  pivot_longer(
    cols = starts_with("wk"), #specifies which columns you want to make 'longer'
    names_to = "Week", #name of new column which will contain the header names
    values_to = "Rank", #name of new column which will contain the values
    values_drop_na= TRUE # removes any rows where the value = NA
  )
view(b1) # r markdown doesnt like the 'view' function. Remove if knitting

#### pivot_wider
### best for making occupancy matrix
glimpse(fish_encounters)
view(fish_encounters)

fish_encounters %>%
  pivot_wider(
    names_from = station, # which column wants to be turned into multiple columns
    values_from= seen, # which column contains values for the new column cells
    values_fill = 0 #fills NAs with zeros
  )

#### Dryad: makes research data freely reusable, citable, and discoverable

## read.table()
dryadData <- read.table(file="data/veysey-babbitt_data_amphibians2.csv", header = TRUE, sep = ",")

glimpse(dryadData)
head(dryadData)
table(dryadData$species) # allows you to see different groups of character column
summary(dryadData$mean.hydro)



dryadData$species<-factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) #creating 'labels' to use for the plot

class(dryadData$treatment)
dryadData$treatment <- factor(dryadData$treatment, 
                              levels=c("Reference",
                                       "100m", "30m"))
  # ordered it in the same manor as the official plot

p<- ggplot(data=dryadData, 
           aes(x=interaction(wetland, treatment), # group treatment and wetland
               y=count.total.adults, fill=factor(year))) + geom_bar(position="dodge", stat="identity", color="black") +
  ylab("Number of breeding adults") +
  xlab("") +
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) ##y axis should be broken up by 100s +
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)","39 (100m)","55 (100m)","129 (100m)", "7 (30m)","19 (30m)","20 (30m)","59 (30m)")) +
  facet_wrap(~species, nrow=2, strip.position="right") +
  theme_few() + scale_fill_grey() + 
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), legend.position="top",  legend.title= element_blank(), axis.title.y = element_text(size=12, face="bold", colour = "black"), strip.text.y = element_text(size = 10, face="bold", colour = "black")) + 
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) 

p
