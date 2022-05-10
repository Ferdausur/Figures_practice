# pie chart is the circular representation of sectors/portion of whole.
# parentage frequency of each group is plotted in circular manner. 

# load and install library----
library(tidyverse)


# load data-----
data("iris")
data("mtcars")

# visualization----

# basic plot
# ggplot does not have dedicated function for pie plot.
# therefore, base plotting system is used at the first place

pie(count(x= iris, Species)[,2], 
    labels = count(x= iris, Species)[,1], col= c("red", "green", "blue"))

# "border= " argument changes the color of border 
pie(count(x= iris, Species)[,2], 
    labels = count(x= iris, Species)[,1], 
    col= c("red", "green", "blue"), 
    border = "white")

# the "edge=" argument regulates the number of lines to draw the polygon.
# smaller values will generate triangular and cuboid shape 
# while value greater than 15 will provide with circular shape.
pie(count(x= iris, Species)[,2], 
    labels = count(x= iris, Species)[,1], 
    edges = 25)

# pie chart with stripes
pie(count(x= iris, Species)[,2], 
    labels = count(x= iris, Species)[,1], 
    density = 10, 
    angle = c(5,15,35), 
    col = c("grey", "cyan", "purple"),
    border= "tomato")

# using ggplot----
# basic plot
## ggplot does not have dedicated pie plot function,
## a stacked bar plot can be made circular with "coord_polar()"
## the argument (x= "") considers the whole data as one variable

count(x= iris, Species)%>%
        arrange(desc(Species))%>%
        mutate(prop=n*100/sum(n))%>%
        # "0.5* prop" to keep the lavel at the middle
        mutate(y_pos=cumsum(prop)-0.5*prop[1])%>%
        # "y= prop" because prop represent the frequency
        ggplot(aes(x= "", y= prop, fill= Species))+
        geom_bar(stat = "identity")+
        geom_text(aes(y=y_pos ,label= Species))+
        coord_polar("y", start = 0)+
        theme_void()


# problems----
# Pie charts are not recommended as,
## comparing close values of angle is difficult
## pie chart with too many factors are difficult to understand
## if the labels are too large, that might not fit well 
# resulting difficulty understanding.
