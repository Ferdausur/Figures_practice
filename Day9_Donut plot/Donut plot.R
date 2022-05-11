# Donut plot is a circular representation of sectors/portion of whole.
# parentage frequency of each group is plotted in circular manner. 

# load and install library----
library(tidyverse)


# load data-----
data("iris")
data("mtcars")

# visualization----

# basic plot
# ggplot does not have dedicated function for donut plot.

count(x= iris, Species)%>%
        arrange(desc(Species))%>%
        mutate(prop= n*100/sum(n))%>%
        # the maximum and minimum position for groups
        mutate(y_max= cumsum(prop))%>%
        mutate(y_min= y_max-prop[1])%>%
        # for setting text in the middle
        mutate(y_pos= y_max-0.5*prop[1])%>%
        ggplot()+
        geom_rect(aes(xmin= 3, xmax= 4, 
                      ymin= y_min, ymax= y_max, 
                      fill= Species))+
        coord_polar("y")+
        # lower value of "xlim()" is set a bit lower than the xmin 
        # to get the hole in the middle
        # upper value is close to ymax to utilize maximum space
        xlim(c(2,4))+
        theme_void()+
        # "x= " argiument set at average between xmin and xmax
        # to get the text in middle
        geom_text(aes(y= y_pos, x=3.5, label= round(prop, 2)))

# problems----
# Donut plot has similar problem as pic chart.
# Thus, donut plot is also not recommended.

## comparing close values are difficult
## donut plot with too many factors are difficult to understand
## if the labels are too large, that might not fit well 
# resulting difficulty understanding.
