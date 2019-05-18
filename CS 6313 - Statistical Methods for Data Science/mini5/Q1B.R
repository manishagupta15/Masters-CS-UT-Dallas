#########################
# R Code for Question 1(B)
#########################

# import sql library
library(sqldf)

# Reading the vapor.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/bodytemp-heartrate.csv")

# Getting the male and female heart rate values
male.hrate<-sqldf("select * from data where gender=1")[,3]
female.hrate<-sqldf("select * from data where gender=2")[,3]

# Boxplot
par(mfrow=c(1,1))
boxplot(male.hrate,female.hrate,
        range=1.5,main="Heart Rates - Male and Female", 
        ylab="Heart rate",names = c("Male", "Female"))


# Getting sample statistics
n<-NROW(male.hrate)
x.mean<-mean(male.hrate)
x.var<-var(male.hrate)
x.sd<-sd(male.hrate)

y.mean<-mean(female.hrate)
y.var<-var(female.hrate)
m<-NROW(female.hrate)
y.sd<-sd(female.hrate)


# Estimator for the difference in means
mean.diff.estimator<-x.mean - y.mean


# Getting a 95% CI for difference in means (assuming equal variances)
pooled.var<-((n-1)*x.var+(m-1)*y.var)/(n+m-2)
mean.diff.ci<- mean.diff.estimator+c(-1,1)*qt(1-(1-0.95)/2,n+m-2)*sqrt(pooled.var/m+pooled.var/n)
# > mean.diff.ci
# [1] -3.241461  1.672230


# Getting a 95% CI for difference in means (assuming unequal variances)
# getting degrees of freedom using Satherwaite's approximation
a<-(x.sd^2/n + y.sd^2/m)^2
b<-(x.sd^4)/((n^2)*(n-1))
c<-(y.sd^4)/((m^2)*(m-1))
df<-a/(b+c)

mean.diff.ci<- mean.diff.estimator+c(-1,1)*qt(1-(1-0.95)/2,df)*sqrt(x.sd^2/n+y.sd^2/m)

# > mean.diff.ci
# [1] -3.243732  1.674501


# T-test for a 2 sided hypothesis
# Null hypothesis: heart rates of male and females do not differ.
# Alternate hypothesis: heart rates  of males and females differ
# t_obs value
t_obs<-(x.mean-y.mean)/sqrt((x.sd^2/n) + (y.sd^2/m))

# p-value for a 2-sided test
p_value<-2*(1 - pt(abs(t_obs),df))
# > p_value
# 0.5286842