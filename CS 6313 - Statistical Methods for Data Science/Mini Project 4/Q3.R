#########################
# R Code for Question 3
#######################

# importing SQL library
library(sqldf)

# Reading the vapor.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/vapor.csv")

# Getting the theoretical and experimental values
vapor.theoretical<-data[,2]
vapor.experimental<-data[,3]

#Boxplot
par(mfrow=c(1,1))
boxplot(vapor.theoretical,vapor.experimental,
        range=1.5,main="Vapor Pressure of dibenzothiophene", 
        ylab="Pressure", names = c("Theoretical", "Experimental"))


# Histograms
par(mfrow=c(1,2))
hist(vapor.theoretical,main="theoretical", 
     ylab="Number",xlab="Pressure")

hist(vapor.experimental,main="experimental", 
     xlab="Pressure",ylab="Number" )


# Getting sample statistics
x.mean=mean(vapor.theoretical)
x.var=var(vapor.theoretical)
n=NROW(vapor.theoretical)

m=NROW(vapor.experimental)
y.mean=mean(vapor.experimental)
y.var=var(vapor.experimental)

# Estimator for the difference in means
mean.diff.estimator<-x.mean - y.mean

# > mean.diff.estimator
# [1] 0.0006875

# Pooled variance
pooled.var<-((n-1)*x.var+(m-1)*y.var)/(n+m-2)

# Getting a 95% CI for difference in means
mean.diff.ci<- mean.diff.estimator+c(-1,1)*qt(1-(1-0.95)/2,n+m-2)*sqrt(pooled.var/m+pooled.var/n)

# print mean.diff.ci
print(mean.diff.ci)
# [1] -0.2915711  0.2929461