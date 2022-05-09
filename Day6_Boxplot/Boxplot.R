
# load library-----
library(tidyverse)
library(ggplot2)
library(ggExtra)

# load data-----
data(mtcars)

str(mtcars)
# cylinder number is a factor
data1<- mtcars%>%
        mutate(cyl= as.factor(cyl), 
               vs= as.factor(vs), 
               am= as.factor(am), 
               gear= as.factor(gear), 
               carb= as.factor(carb))

# re-assign levels
levels(data1$vs)<- c("v_shaped", "stright")
levels(data1$am)<- c("automatic", "manual")

str(data1)



# Box plot------
# The box plot shows a factor variable on x axis 
# and continious variable on y axis. 
# It demonstrates the spread of the continious variable according to the factor. 
# The box in box plot represents interquartile range (IQR). 
# The lower boundary of the box is 25 th quartile and upper boundary is 75 th quartile.
# The horizontal bar in the box is the median. 
# The line extended from the box in up and down direction 
# represent high and lower limit. which is (+/-) 1.5 * IQR
# The dots out side the line represent each outliers in the sample. 

# visualization---- 

# basic plot
data1 %>%
        ggplot(aes(x= cyl, y= mpg))+
        geom_boxplot(aes(fill= cyl))+
        ggtitle("boxplot of mpg vs cyl", 
                subtitle = "Boxplot of mpg of cars grouped by number of cylenders")+
        xlab("cylenders")+
        ylab("mpg")+
        theme_classic()+
        labs(fill= "cylenders", caption = "wide format data")

# long format data
# data organized as observation and value associated with single variable
# basic plot is fine for the purpose

# However, 
# if the data has saveral values for single observation, it is wide format data.
# the data can be transformed into long format using "gather()" of dplyr
mtcars%>%
        select(cyl, drat, wt, vs, am, gear, carb)%>%
        gather(key= "keys", value = "values")%>%
        ggplot(aes(x= keys, y= values, fill= keys))+
        geom_violin()+ 
        theme_classic()+
        labs(title = "Basic violin plot", 
             subtitle = "using mtcars dataset", 
             caption = "long format data")



# custom arrangement with reordering factors first
levels(data1$cyl)<- c("6", "8", "4")
data1 %>%
        ggplot(aes(x= cyl, y= mpg))+
        geom_boxplot(aes(fill= cyl))+
        ggtitle("boxplot of mpg vs cyl", 
                subtitle = "Boxplot of mpg of cars grouped by number of cylenders")+
        xlab("cylenders")+
        ylab("mpg")+
        theme_classic()+
        labs(fill= "cylenders")

# selective fill
data1%>%
        mutate(sel_cyl= ifelse(cyl== "4", "yes", "no"))%>%
        ggplot(aes(x= cyl, y= mpg, fill= sel_cyl))+
        geom_boxplot()+
        scale_fill_manual(values = c("white", "blue"), 
                          labels= c("others" , "4"))+
        ggtitle("boxplot of mpg vs cyl", 
                subtitle = "Boxplot of mpg of cars grouped by number of cylenders")+
        xlab("cylinders")+
        ylab("mpg")+
        theme_classic()+
        labs(fill= "cylinders")


# jitters to show individual data points and using violin plot provides 
# useful details on shape along with spread.  

# plotting with individual data points
data1 %>%
        ggplot(aes(x= cyl, y= mpg))+
        geom_boxplot(aes(fill= cyl))+
        ggtitle("boxplot of mpg vs cyl", 
                subtitle = "Boxplot of mpg of cars grouped by number of cylenders")+
        xlab("cylenders")+
        ylab("mpg")+
        theme_classic()+
        labs(fill= "cylenders")+
        geom_jitter(size= 1)

# violin plot
data1 %>%
        ggplot(aes(x= cyl, y= mpg))+
        geom_violin(aes(fill= cyl))+
        ggtitle("Violin plot of mpg vs cyl", 
                subtitle = "Violin plot of mpg of cars grouped by number of cylenders")+
        xlab("cylenders")+
        ylab("mpg")+
        theme_classic()+
        labs(fill= "cylenders")
