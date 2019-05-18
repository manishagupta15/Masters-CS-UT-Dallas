###############################
# R Code for Question 1
###############################


# Reading the .csv File 
roadrace <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/roadrace.csv")


# Part (a): Barplot for Runners' Cities 

# Reading tuples of runners from Maine
from.maine <-sqldf("select * from roadrace where Maine='Maine'")

# Reading tuples of runners not from Maine
not.from.maine <- sqldf("select * from roadrace where Maine='Away'")

vect<-c(NROW(from.maine),NROW(not.from.maine))
barplot(vect,main = "Runners' Cities",xlab = "City",
        ylab = "Number of runners",names.arg = c("Maine", "Away"))



# Part (b): Histograms for Runners' Times (minutes)
# Two plots in a row
par(mfrow=c(1,2))

# histogram of running times times of runners from maine
hist(from.maine[,12],xlab="Running time", ylab="Number of Runners", main="Runners from Maine")

# histogram of running times of runners not form maine
hist(not.from.maine[,12],xlab="Running time", ylab="Number of Runners", main="Runners not from Maine")



# Part (c): Boxplot for Runners' Times (minutes)
# boxplot for Runner's Times 
par(mfrow=c(1,1))
boxplot(from.maine[,12],not.from.maine[,12],range=1.5,main="From Maine",ylab="Running Time (minutes)", names=c("Maine","Away"))

par(mfrow=c(1,1))
boxplot(from.maine[,12],not.from.maine[,12],range=0,main="Running Times - Maine and Away",ylab="Running Time (minutes) ", names=c("Maine","Away"))



# PART (d): Boxplot for Runner's Ages (male and female) 
#  Select tuples of runners who are male
male.runners<-sqldf("select * from roadrace where Sex='M'");

#  Select tuples of runners who are female
female.runners<-sqldf("select * from roadrace where Sex='F'")

# boxplot
par(mfrow=c(1,1))
boxplot(male.runners[,5],female.runners[,5],range=1.5,main=" Runners' age", ylab="Age", names = c("Male Runners", "Female Runners"))

