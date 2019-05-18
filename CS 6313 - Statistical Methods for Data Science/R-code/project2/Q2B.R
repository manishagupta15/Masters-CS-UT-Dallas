library(sqldf)

data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/voltage.csv")

voltages.remote<-sqldf("select * from data where location=0")[,2]
voltages.local<-sqldf("select * from data where location=1")[,2]

remote.mean<-mean(voltages.remote)
remote.var=var(voltages.remote)
n=NROW(voltages.remote)

# Getting the statistics for the local voltages
local.mean<-mean(voltages.local)
local.var=var(voltages.local)
m=NROW(voltages.local)

# Estimator for difference in means
theta.hat<- remote.mean-local.mean

# Standard error for mean difference estimator
pooled.var<-((n-1)*remote.var + (m-1)*local.var)/(n+m-2)

# COnfidence interval
mean.diff.ci<-theta.hat + c(-1,1)*qt(1-(1-0.95)/2,n+m-2)*sqrt((pooled.var/n) + (pooled.var/m))

print(mean.diff.ci)