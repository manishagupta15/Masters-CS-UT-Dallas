###################################
# R code for question 2
###################################
# Reading the .csv File #
motorcycle <- read.csv(file="/users/psprao/downloads/stats/datasets/motorcycle.csv")

# Two plots in a row
par(mfrow=c(1,1))

# boxplot
boxplot(motorcycle[,2],range=1.5,ylab="Number of Accidents",main="Accidents in South Carolina")

