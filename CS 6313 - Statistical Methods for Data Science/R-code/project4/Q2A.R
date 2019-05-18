#########################
# R Code for Question 2(A)
#########################

# import sql library
library(sqldf)

# Reading the vapor.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/voltage.csv")

# Getting the theoretical and experimental values
voltage.remote<-sqldf("select * from data where location=0")[,2]
voltage.local<-sqldf("select * from data where location=1")[,2]

#Boxplot
par(mfrow=c(1,1))
boxplot(voltage.remote,voltage.local,
        range=1.5,main="Voltages at Remote  and local locations", 
        ylab="Voltage", xlim=c(8,11),ylim=c(0,20),names = c("Remote", "Local"))

# Histograms
par(mfrow=c(1,2))
hist(voltage.remote,main="remote locations", 
            ylab="Number of locations",xlab="Voltage",breaks=seq(8,11,by=0.5))

hist(voltage.local,main="local locations", 
     xlab="Voltage",ylab="number of locations", breaks=seq(8,11,by=0.5))