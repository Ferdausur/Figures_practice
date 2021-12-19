# Hi! I am Ferdausur Rahman

# I tried to plot the map of Bangladesh from .shp file. 
# the file can be found on Google by searching with Bangladesh.shp 
# or Bangladesh shape file. 

# I took the file from 'https://www.diva-gis.org/gdata' as .zip file
# and extracted in my working directory


# load libraries----------------------------------------------------------------

library(sf)
# to read shape file
library(ggplot2)
# for plotting 


#-------------------------------------------------------------------------------

# reading data------------------------------------------------------------------
# the shape file could also be read with 
# st.read() from sf package
# readOGR() from rgdal package

# adm0 contains information on country, name
adm0<- read_sf(paste(getwd(), "BGD_adm/BGD_adm0.shp", sep= "/"))

# adm1 contains information on division
adm1<- read_sf(paste(getwd(), "BGD_adm/BGD_adm1.shp", sep= "/"))

# adm2 in on districts of Bangladesh
adm2<- read_sf(paste(getwd(), "BGD_adm/BGD_adm2.shp", sep= "/"))

# adm3 has  previous information and information on upazila
adm3<- read_sf(paste(getwd(), "BGD_adm/BGD_adm3.shp", sep= "/"))


#-------------------------------------------------------------------------------


# plotting The map--------------------------------------------------------------

# If the shape data was read by readOGR(), 
# map could be also be plotted by getting latitude, longitude from 
# tidy() of broom package 
# and then calling geom_polygon() on the file. 


# a solid map of Bangladesh as adm0 only have country information. 
map0<- ggplot(adm0)+
        geom_sf(aes(fill= NAME_0))+
        labs(title = "A solid map of Bangladesh", 
             x= "Longitude", y= "Latitude")+
        theme_classic()
        
map0


# adm1 has divisional distribution on column NAME_1
map1<- ggplot(adm1)+
        geom_sf(aes(fill= NAME_1))+
        labs(title= "A map of Bangladesh with divisional distribution",
             x= "Longitude", y= "latitude")+
        scale_fill_manual("Divisions",
                          values= c("violet", "blue", "cyan", "green", 
                                    "yellow", "orange", "red"))
map1


# A map of Bangladesh on districts 
map2 <- ggplot(adm2)+
        geom_sf(aes(fill=NAME_1))+
        labs(title="A map of Bangladesh with district distribution",
             x="Longitude",y="Lattitude")+
        theme_classic()+
        scale_fill_manual("Divisions",
                          values= c("violet", "blue", "cyan", "green", 
                                    "yellow", "orange", "red"))
map2

# A map of Bangladesh on Upazila
map3<- ggplot(adm3)+
        geom_sf(aes(fill= NAME_1))+
        labs(title= "A map of Bangladesh with upazila subdivision", 
             x= "Longitude", y= "Latitude")+
        theme_classic()+
        scale_fill_manual("Divisions",
                          values= c("violet", "blue", "cyan", "green", 
                                    "yellow", "orange", "red"))
map3


#-------------------------------------------------------------------------------


# Adding labels on the map------------------------------------------------------
# labels can be added both as text and labels

# labels/ text can be added from ggplot with geom_text() or geom_label()
# however, they need x and y coordinates along with labels
# Approximate x and y is taken from plotting the map without label first
# and then re-plotting with labels and coordinates. 


lats<- c(25.800, 24.800, 24.700, 23.600, 23.100, 22.850, 22.500, 21.000)
longs<- c(89.200, 91.600, 89.000, 90.100, 89.400, 91.900, 90.300, 89.500)

label_name<- c("Rangpur", "Sylhet", "Rajshahi", "Dhaka", 
         "Khulna", "Chittagong", "Barishal", "Bay of Bengal")

lab_df<- data.frame(label_name, longs, lats)


map4 <- ggplot(adm2)+
        geom_sf(aes(fill=NAME_1))+
        labs(title="A map of Bangladesh with divisional distribution",
             x="Longitude",y="Lattitude")+
        theme_classic()+
        geom_label(data = lab_df, 
                   aes(x= longs, y= lats, label= label_name), 
                   alpha= 0.4)+
        scale_fill_manual("Divisions", 
                          values= c("violet", "blue", "cyan", "green", 
                                    "yellow", "orange", "red"))
map4

# labels can be also added with geom_sf_text() or geom_sf_label()

map5 <- ggplot(adm1)+
        geom_sf(aes(fill=NAME_1))+
        labs(title="A map of Bangladesh with divisional distribution",
             x="Longitude",y="Lattitude")+
        theme_classic()+
        geom_sf_label(aes(label= NAME_1, alpha= 0.4))

map5


#-------------------------------------------------------------------------------

# making fill according to a given variable/ column/ information----------------

# Population of Bangladesh by division taken from Wikipedia is added to the data


adm1$population<- c(8325666, 29145000, 36433505, 15687759, 
                      18485858, 15787758, 9807000)


map6 <- ggplot(adm1)+
        geom_sf(aes(fill=population))+
        labs(title="A map of Bangladesh with divisional distribution",
             x="Longitude",y="Lattitude")+
        theme_classic()+
        geom_sf_text(aes(label= NAME_1), color= "white")

map6

#-------------------------------------------------------------------------------


# Thank you for reading
