
# load library
library(tidyverse)
library(RColorBrewer)
# load data
# we will use mtcars and iris database for this purpose
data(mtcars)
data(iris)

# inspecting data and structure
head(mtcars, 5)
tail(mtcars, 5)
str(mtcars)


# a density plot plots one continuous variables as dots or points
# geom_density() is used for density plot
# Density plots are smoothed histograms 
# a probability is set to the values along the x axis, 
# the probability is between (+1 and -1) 
# the probability indicates the chance of having the value
# peak can be considered as mean as in a normal distribution, 
# mean is the most occurring. 

# demonstrates the distribution of variables and groups
# color and transparency allows to take a look at 

ggplot(data = mtcars, aes(x= mpg))+
        geom_density(fill= "orange", color= "black",alpha= 0.4)+
        ggtitle("Density plot of miles per gallon on mtcars data")+
        theme_classic()


# 
#two variables can be plotted together if the unit is same 

ggplot(data = iris, aes(x=x))+
        geom_density( 
                     aes(x= Sepal.Length, y= ..density..), 
                     fill= "blue", alpha= 0.6)+
        geom_label(aes(x= 2, y= 0.3, label= "Sepal length", color= "#69b3a2"))+
        geom_density( 
                aes(x= Petal.Length, y= -..density..), 
                fill= "orange", alpha= 0.6)+
        geom_label(aes(x= 7, y= -0.2, label= "Petal length", color= "#404080"))
        

# multiple density charts
# density chart is plotted based on factor variable separeatd by color

mtcars$gear<- as.factor(mtcars$gear)

ggplot(data = mtcars, aes(x=mpg, group = gear, fill= gear ))+
        geom_density(adjust= 1.5,alpha= 0.4)




text<- levels(mtcars$gear)
x_axis<- c(18,25,27)
y_axis<- c(0.08,0.06,0.25)

class(c)

annot_text<- rbind.data.frame(text, x_axis,y_axis)

# adding text to the plot
# text indicates the name of the colored layers 

ggplot(data = mtcars, aes(x=mpg, group = gear, fill= gear ))+
        geom_density(adjust= 1.5,alpha= 0.4)+
        geom_text(data = annot_text, aes(x=x_axis, y=y_axis, 
                  label= text, color= text), hjust= 0, size= 4.5)


# facet
# plots density curve bases on factor as separate plot

ggplot(data = mtcars, aes(x=mpg, group = gear, fill= gear ))+
        geom_density(adjust= 1.5,alpha= 0.4)+
        facet_grid(~gear)

# stacked
# plots density curve bases on factor and are stacked one above another

ggplot(data = mtcars, aes(x=mpg, group = gear, fill= gear ))+
        geom_density(adjust= 1.5,alpha= 0.4, position = "fill")















