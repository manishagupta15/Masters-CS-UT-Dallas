#########################
# R Code for Question 2(B)
########################
#importing sql library
library(sqldf)

# Reading the vapor.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/voltage.csv")

# Getting the theoretical and experimental values
voltage.remote<-sqldf("select * from data where location=0")[,2]
voltage.local<-sqldf("select * from data where location=1")[,2]

# Getting sample statistics
m=NROW(voltage.local)
y.mean=mean(voltage.local)
y.var=var(voltage.local)

x.mean=mean(voltage.remote)
x.var=var(voltage.remote)
n=NROW(voltage.remote)

# Estimator for the difference in means
mean.diff.estimator<-x.mean - y.mean

# Pooled variance
pooled.var<-((n-1)*x.var+(m-1)*y.var)/(n+m-2)

# Getting a 95% CI for difference in means
mean.diff.ci<- mean.diff.estimator+c(-1,1)*qt(1-(1-0.95)/2,n+m-2)*sqrt(pooled.var/m+pooled.var/n)

print(mean.diff.ci)
# [1] 0.1173110 0.6453556