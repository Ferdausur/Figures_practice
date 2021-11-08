# load library
library(ggplot2)
library(tidyverse)
library(RColorBrewer)

# load data
# we will use iris database for this purpose
data(iris)

# inspecting data and structure
head(iris, 5)
tail(iris, 5)
str(iris)


# a scatter plot plots two continuous variables as dots or points
# geom_point() is used for scatter plot

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point()

# the points can be colored 
ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, col= "tomato"))+ 
        geom_point()


ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(col= "orange")

# the shape of the points can be changed 

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(shape= 2)

# size can be changed 
ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(col= "orange", size= 5)

# transparency of the points can be changed

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(col= "orange", size= 5, alpha= 1)

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(col= "orange", size= 5, alpha= 0.5)


# labels can be set on the figures with labs()
# main is for title
# sub is for subtitle
# xlab for x axis labeling
# ylab is for y axis labeling

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, ))+ 
        geom_point(col= "tomato")+
        ggtitle("Sepal length vs Petal length", 
                subtitle = "Sepal length vs petal length scatter plot from iris")+
        xlab("sepal length")+
        ylab("petal length")

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(col= "orange")+
        labs(title = "Sepal length vs Petal length", 
             subtitle = "Sepal length vs petal length scatter plot from iris", 
             caption = "ferdausur Rahman")+
        xlab("Sepal length")+
        ylab("Petal length")


# all the features can also be changed with a variable on the data

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length))+ 
        geom_point(col= "orange", size= iris$Sepal.Width, alpha= 0.5)

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, col= Species))+ 
        geom_point(size= 3, alpha= 0.5)


# lines can be made on the points like linier regression 
ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, col= Species))+ 
        geom_point(size= 3, alpha= 0.5)+
        geom_smooth(method = "lm", fullrange= TRUE)


# label and text of points can be produced with geom_text()

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, col= Species))+ 
        geom_point(size= 3, alpha= 0.5)+
        geom_text(label= iris$Species, nudge_x = 0.25, nudge_y = 0.25, 
                  check_overlap = TRUE)

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, col= Species))+ 
        geom_point(size= 3, alpha= 0.5)+
        geom_label(label= iris$Species, color= "black")

# labels can be customized for specifics

ggplot(data = iris, aes(x= Sepal.Length, y= Petal.Length, col= Species))+ 
        geom_point(size= 3, alpha= 0.5)+
        geom_text(data = iris%>%
                          filter(Species== "versicolor"), 
                  aes(label= Species, color= "black"), 
                  nudge_x = 0.25, nudge_y = 0.25, 
                  check_overlap = TRUE
                          )




