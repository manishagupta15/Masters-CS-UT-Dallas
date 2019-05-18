#########################
# R Code for Question 1(A)
#########################

# import sql library
library(sqldf)

# Reading the vapor.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/bodytemp-heartrate.csv")

# Getting the male and female body temperatures
male.temp<-sqldf("select * from data where gender=1")[,1]
female.temp<-sqldf("select * from data where gender=2")[,1]

#Boxplot
par(mfrow=c(1,1))
boxplot(male.temp,female.temp,
        range=1.5,main="Body Temperatures - Male and Female", 
        ylab="Temperature",names = c("Male", "Female"))



# Getting sample statistics
n=NROW(male.temp)
x.mean=mean(male.temp)
x.var=var(male.temp)
x.sd=sd(male.temp)

y.sd=sd(female.temp)
y.mean=mean(female.temp)
y.var=var(female.temp)
y=NROW(female.temp)

# Estimator for the difference in means
mean.diff.estimator<-x.mean - y.mean


# Getting a 95% CI for difference in means (assuming equal variances)
pooled.var<-((n-1)*x.var+(m-1)*y.var)/(n+m-2)
mean.diff.ci<- mean.diff.estimator+c(-1,1)*qt(1-(1-0.95)/2,n+m-2)*sqrt(pooled.var/m+pooled.var/n)
print(mean.diff.ci)
# [1] -0.53963938 -0.03882216


# Getting a 95% CI for difference in means (assuming unequal variances)
# getting degrees of freedom using Satherwaite's approximation
a<-(x.sd^2/n + y.sd^2/m)^2
b<-(x.sd^4)/((n^2)*(n-1))
c<-(y.sd^4)/((m^2)*(m-1))
df<-a/(b+c)
mean.diff.ci<- mean.diff.estimator+c(-1,1)*qt(1-(1-0.95)/2,df)*sqrt(x.sd^2/n+y.sd^2/m)

print(mean.diff.ci)
# [1] -0.53964856 -0.03881298


# T-test for a 2 sided hypothesis
# Null hypothesis: body temperatures of male and females do not differ.
# Alternate hypothesis: body temperatures of males and females differ
# tobs value
t_obs<-(x.mean-y.mean)/sqrt((x.sd^2/n) + (y.sd^2/m))

# p-value for a 2-sided test
p_value<-2*(1 - pt(abs(t_obs),df))
# > p_value
# 0.02393826