#########################
# R Code for Question 1(C)
#########################

# import sql library
library(sqldf)


# Reading the bodytem-heartrate.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/bodytemp-heartrate.csv")


# Scatterplot for heart rate vs body temp for whole sample
hrate<-data[,3]
temp<-data[,1]
par(mfrow=c(1,1))
plot(hrate,temp,xlab="heart rate",ylab="body temp",main="Scatterplot: body 
     temperature vs heart rate")
abline(lm(temp~hrate))


# correlation coefficient for heart rate and body temperature 
# > cor(hrate,temp)
# [1] 0.2536564



# Scatterplot for body temp vs heart rate for males
male.hrate<-sqldf("select * from data where gender=1")[,3]
male.temp<-sqldf("select * from data where gender=1")[,1]
plot(male.hrate,male.temp,xlab="heart rate",ylab="body temp",main="Scatterplot: body 
     temperature vs heart rate - males")
abline(lm(male.temp~male.hrate))



# correlation coefficient for heart rate and body temperature males
# > cor(male.hrate,male.temp)
# [1]  0.1955894


# Scatterplot for body temp vs heart rate for females in sample 
female.hrate<-sqldf("select * from data where gender=2")[,3]
female.temp<-sqldf("select * from data where gender=2")[,1]
plot(female.hrate,female.temp,xlab="heart rate",ylab="body temp",main="Scatterplot: body 
     temperature vs heart rate - females")
abline(lm(female.temp~female.hrate))


# correlation coefficient for heart rate and body temperature (females)
# > cor(hrate,temp)
# [1]  0.2869312
