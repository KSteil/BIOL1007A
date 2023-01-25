##### ggplot2
#### 24 January 2023
### SS

library(ggplot2)
library(ggthemes)
library(patchwork)
library(dplyr)

#### Template for ggplot code
## p1 <- ggplot(data = <DATA>, mapping = aes(x = xVar, y = yVar)) + 
## <GEOM FUNCTION> ##geom_boxplot()
## print(p1)

##Load in a built-in data set
d <- mpg
str(mpg)
glimpse(d)

###### qplot: quick plotting
qplot(x = d$hwy) # plots hwy on x axis

qplot(x = d$hwy, fill = I("darkblue"), color = I("black"))
  # must use the I() function to get the colors you want
  # filled in columns with blue, outlined in black

#scatterplot
qplot(x=d$displ, y = d$hwy, geom=c("smooth", "point"))

qplot(x=d$displ, y = d$hwy, geom=c("smooth", "point"), method = "lm")

#boxplot
qplot(x=d$fl, y = d$cty, geom="boxplot", fill = I("forestgreen"))

#Barplot
qplot(x=d$fl, geom = "bar", fill= I("forestgreen"))

### Create some data (specified counts)
x_trt <- c("control", "Low", "High")
y_resp <- c(12,2.5, 22.9)

qplot(x=x_trt, y=y_resp, geom="col", fill= I(c("darkred","slategrey", "midnightblue")))

#viridis color pallete

p1 <- ggplot(data = d, mapping = aes(x=displ, y=cty, color = cyl)) +
  geom_point()
  # color = cyl groups color by variable
p1

p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_minimal()
p1 + theme_void()
p1 + theme_economist()

p1 + theme_bw()(base_size==30, base_family="serif")

p2 <- ggplot(data = d, aes(x=fl, fill=fl)) +
  geom_bar()
p2
p2 + coord_flip() + theme_classic(base_size = 15, base_family="sans")

#### Theme modifications
p3 <- ggplot(data=d, aes(x=displ, y=cty)) +
  geom_point(size = 3, shape = 21, color = "magenta", fill = "black") +
  xlab("Count") + 
  ylab("fuel") +
  labs(title = "My title here", subtitle = "my subtitle goes here") #x=/y= axis
  
p3 + xlim(1,10) + ylim(0,35)
  
  ## shape list on the internet

library(viridis)
cols <- viridis(7, option = "viridis") 
  # plasma, magma, turbo, viridis
ggplot(data = d, aes(x=class, y=hwy, fill = class)) +
  geom_boxplot() +
  scale_fill_manual(values=cols)
# scale_fill_manual can be any value as long as it matches the number of variables


library(patchwork)
p1 + p2 + p3 # side by side
p1 / p2 / p3 # one over the other
(p1 + p2) / p3

