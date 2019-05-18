#########################
# R Code for Question 1
########################

# importing 'boot' library
library(boot)

#Reading the gpa.csv file
data <- read.csv.sql(file="/users/psprao/downloads/stats/datasets/gpa.csv")

# Getting the GPA and ACT score data
gpa<-data[,1]
act.scores<-data[,2]

# Boxplot
par(mfrow=c(1,1))
boxplot(gpa,act.scores,range=1.5,main="Student scores", 
        ylab="Score", names = c("GPA", "ACT Scores"))


# Scatterplot of gps vs act score
plot(gpa,act.scores,xlab="gpa",ylab="ACT score",main="Scatterplot: GPA vs ACT scores")
abline(lm(act.scores~gpa))

n=NROW(gpa)

# Estimator for pop. correlation
corr.estimator<-cor(gpa,act.scores)

# bootstrap sampling function 
corr.npar<-function(x,i)
{
  x2=x[i,]
  result<-cor(x2$gpa,x2$act)
  return (result)
}



# Bootstrap estimation
corr.npar.boot<-boot(data,corr.npar,sim="ordinary",R=1000)
print(corr.npar.boot)

# ORDINARY NONPARAMETRIC BOOTSTRAP
# Call:
#  boot(data = data, statistic = corr.npar, R = 1000, sim = "ordinary")
# Bootstrap Statistics  :
#  original      bias    std. error
#t1* 0.2694818 0.001159284   0.1071447

# > cor(gpa,act.scores)
# [1] 0.2694818 

# > corr.npar.boot$t0
# [1] 0.2694818

# > mean(corr.npar.boot$t)-corr.npar.boot$t0
# [1] -1.650308e-05

# > sd(corr.npar.boot$t)
# [1] 0.104966

# plotting the bootstrap distribution of the correlation estimator
plot(corr.npar.boot)

# Confidence interval for population correlation
boot.ci(corr.npar.boot,conf=0.95)