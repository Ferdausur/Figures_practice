# load libraries----
library(ggplot2)
library(tidyverse)
library(lubridate)

# load data----

data1<- read.csv("Gold_12_24_21-01_02_15.csv", header= TRUE)

# data processing-----
data2 <- data1%>%
        select(Date, Open, Close, High, Low)%>%
        mutate(open_2_close= Open - Close, high_2_low= High - Low)

# date as date
data2$Date<- mdy(data2$Date)

# haven't used them (might use later )
data2$open_2_close_status<- ifelse(data2$open_2_close>=0, "Pos", "Neg")
data2$high_2_low_status<- ifelse(data2$high_2_low>=0, "Pos", "Neg")


# Visualization
data2 %>%
        ggplot(aes(x= Date))+
        geom_line(aes(y= Open), color= "red")+
        geom_line(aes(y= Close), color= "green")

