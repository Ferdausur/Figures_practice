# Violin pots compares distribution between groups along with their density. 

# load library-----
library(tidyverse)

# load data------
data(iris)
data(mtcars)

data_wide<- iris[,1:4]


# Visualization-------

# basic plot
mtcars%>%
        ggplot(aes(x= as.factor(cyl), 
                   y= mpg, 
                   fill= as.factor(gear)))+
        geom_violin()+ 
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using mtcars dataset", x= "cyl", y= "mpg", fill= "gear")

iris%>%
        ggplot(aes(x= Species, y= Sepal.Length, fill= Species))+
        geom_violin()+ 
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using iris dataset", 
             xlab("Species"), 
             ylab("Sepal length"), caption = "wide format data")


# long format data
# data organized as observation and value associated with single variable
# basic plot is fine for the purpose

# However, 
# if the data has saveral values for single observation, it is wide format data.
# the data can be transformed into long format using "gather()" of dplyr
iris%>%
        select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)%>%
        gather(key= "keys", value = "values")%>%
        ggplot(aes(x= keys, y= values, fill= keys))+
        geom_violin()+ 
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using iris dataset", 
             caption = "long format data")



# reordering between factors (ascending order)
iris%>%
        ggplot(aes(x= fct_reorder(Species, Sepal.Length), 
                   y= Sepal.Length, 
                   fill= Species))+
        geom_violin()+ 
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using iris dataset", 
             caption = "reordered factor")
# descending order
iris%>%
        ggplot(aes(x= fct_reorder(Species, Sepal.Length, .desc = TRUE), 
                   y= Sepal.Length, 
                   fill= Species))+
        geom_violin()+ 
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using iris dataset", 
             caption = "reordered factor")
## we can rename the factors using "fct_recode()"
## "fct_relevel()" can be used to alter formation
## additional ".fun= " argument to order on specific condition

# flipped coordinates
iris%>%
        ggplot(aes(x= fct_reorder(Species, Sepal.Length), 
                   y= Sepal.Length, 
                   fill= Species))+
        geom_violin()+ 
        theme_classic()+
        coord_flip()+
        labs(title = "Basic violin plot", 
             subtitle = "using iris dataset", 
             caption = "flipped coordinates")

# box plot included violin plot
iris%>%
        ggplot(aes(x= fct_reorder(Species, Sepal.Length, .desc = TRUE), 
                   y= Sepal.Length, 
                   fill= Species))+
        geom_violin()+ 
        geom_boxplot(width= 0.1, color= "grey", alpha= 0.2)
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using iris dataset", 
             caption = "reordered factor")


#NB: long data can also be transformed into wide data using "spread()" of dplyr. 