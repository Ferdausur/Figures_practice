# load library
library(tidyverse)
library(RColorBrewer)
library(ggExtra)



# load data
data(mtcars)
data(iris)


# histogram demonstrates the distribution frequency of numeric variables.
# the variable is continuous and divided into bins throughout the range 
# frequency is set for each bins and plotted as connected bars


# simple histogram of on mpg column of mtcars data set
# only a input for x axis is enough for histogram

ggplot(data= mtcars, aes(x= mpg))+
        geom_histogram()+
        theme_classic()+
        ggtitle("Distribution of mpg", subtitle = "from mtcars dataset")+
        labs(x= "mpg", y= "count")


# bins can be adjusted with bins argument
# different bin size leads to different distribution and lead to confusion on data
# 

ggplot(data= mtcars, aes(x= mpg))+
        geom_histogram(fill= "cyan",bins = 15)+
        theme_classic()+
        ggtitle("Distribution of mpg", subtitle = "from mtcars dataset")+
        labs(x= "mpg", y= "count")



ggplot(data= mtcars, aes(x= x))+
        geom_histogram(fill= "blue",bins = 15, aes(x= mpg))+
        theme_classic()+
        ggtitle("Distribution of mpg", subtitle = "from mtcars dataset")+
        labs(x= "mpg", y= "count")


# the histogram can be plotted on opposite directions like mirrors

ggplot(data= iris, aes(x= x))+
        geom_histogram(aes(x= Sepal.Length, y= ..density..),fill= "cyan",bins = 30)+
        geom_label(aes(x= 2, y= 0.4, label= "Sepal length"))+
        geom_histogram(aes(x= Petal.Length, y= -..density..),fill= "blue",bins = 30)+
        geom_label(aes(x= 6, y= -0.45, label= "Petal length"))+
        theme_classic()+
        ggtitle("Sepal length vs Petal length", subtitle = "from iris dataset")+
        labs(x= "length", y= "count")


# A histogram can show multiple variables using color transparency
# multiple variables can be plotted by calling fill with a factor variable
# the histogram will be subdivided into multiple colored histograms 
# based on the factor variable

ggplot(data= mtcars, aes(x= mpg, fill= factor(cyl)))+
        geom_histogram(alpha= 0.6,bins = 15, position= "identity")+
        scale_fill_manual(values= c("tomato", "green", "yellow"))
        theme_classic()+
        ggtitle("Distribution of mpg", subtitle = "based on cyl")+
        labs(x= "mpg", y= "count")


# multiple plots can be called with calling different variables each time

ggplot(data= iris, aes(x= x))+
        geom_histogram(aes(x= Sepal.Length),fill= "red",bins = 30, alpha= 0.5)+
        geom_histogram(aes(x= Petal.Length),fill= "green",bins = 30, alpha= 0.5)+
        theme_classic()+
        ggtitle("Sepal length vs Petal length", subtitle = "from iris dataset")+
        labs(x= "length", y= "count")


# marginal distribution as histogram can be shown for any other plots
# like box, violin, scatter plot, etc.
        
g<- ggplot(data= mtcars, aes(x= mpg, y= disp))+geom_point(alpha= 0.4, size= 5)

ggMarginal(g, data= mtcars, type= "histogram", size= 3)







