library(sqldf)

data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/voltage.csv")

voltages.remote<-sqldf("select * from data where location=0")[,2]
voltages.local<-sqldf("select * from data where location=1")[,2]

par(mfrow=c(1,1))
boxplot(voltages.remote,voltages.local,range=1.5,main="Voltage readings", 
        ylab="Voltage", names = c("Remote locations", "Local locations"))