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

count(x= iris, Species)%>%
    arrange(desc(Species))%>%
    mutate(prop= n*100/sum(n))%>%
    # the maximum and minimum position for groups
    mutate(y_max= cumsum(prop))%>%
    mutate(y_min= y_max-prop[1])%>%
    # for setting text in the middle
    mutate(y_pos= y_max-0.5*prop[1])%>%
    ggplot()+
    geom_rect(aes(xmin= 0, xmax= 4, 
                  ymin= y_min, ymax= y_max, 
                  fill= Species))+
    coord_polar("y")+
    theme_void()+
    # "x= " argiument set at average between xmin and xmax
    # to get the text in middle
    geom_text(aes(y= y_pos, x= 2, label= Species))

# the pie chart can be made as a donut with "xlim()" 
count(x= iris, Species)%>%
    arrange(desc(Species))%>%
    mutate(prop= n*100/sum(n))%>%
    mutate(y_max= cumsum(prop))%>%
    mutate(y_min= y_max-prop[1])%>%
    mutate(y_pos= y_max-0.5*prop[1])%>%
    ggplot()+
    geom_rect(aes(xmin= 3, xmax= 4, 
                  ymin= y_min, ymax= y_max, 
                  fill= Species))+
    coord_polar("y")+
    xlim(c(2,4))+
    theme_void()+
    geom_text(aes(y= y_pos, x=3.5, label= round(prop, 2)))

# problems----
# Pie charts are not recommended as,
## comparing close values of angle is difficult
## pie chart with too many factors are difficult to understand
## if the labels are too large, that might not fit well 
# resulting difficulty understanding.
