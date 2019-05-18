
#
# sample size computation for mean
# 

alpha <- 0.01
w <- 2*0.5
sigma <- 1.5

n <- ceiling((2*qnorm(1-(alpha/2))*sigma/w)^2)

# # > n
# [1] 60
# > 

#
# N(0, 1) vs t_k distributions
#

curve(dnorm(x), from = -4, to = 4, col = "black", ylab = " ")
curve(dt(x, df = 2), from = -4, to = 4, col = "pink", add = T)
curve(dt(x, df = 10), from = -4, to = 4, col = "purple", add = T)
curve(dt(x, df = 30), from = -4, to = 4, col = "red", add = T)
legend("topright", legend = c("N(0, 1)", "t_2", "t_10", "t_30"), 
	col = c("black", "pink", "purple", "red"), lty = 1)
title("N(0, 1) vs t_k densities")


#
# unauthorized access example
#

x <- c(0.46, 0.38, 0.31, 0.24, 0.20, 0.31, 0.34, 0.42, 0.09, 0.18, 0.46, 0.21)

alpha <- 1-0.95
n <- length(x)

round(mean(x) + c(-1,1)*qt(1-(alpha/2), df = (n-1)) * sd(x)/sqrt(n), 2)



# > round(mean(x) + c(-1,1)*qt(1-(alpha/2), df = (n-1))*sd(x)/sqrt(n), 2)
# [1] 0.22 0.38
# > 


#
# execution time example
#

n <- 35
xmean <- 230
xsd <- 14
alpha <- 0.05

xmean + c(-1, 1)*qnorm(1-(alpha/2)) * (xsd/sqrt(n))

# > xmean + c(-1, 1)*qnorm(1-(alpha/2))*xsd/sqrt(n)
# [1] 225.3619 234.6381
# > 


#
# RAM chips example
#

n <- 50
phat <- 20/50
alpha <- 0.05
se.phat <- sqrt(phat * (1-phat)/n)

phat + c(-1, 1)*qnorm(1-(alpha/2))*se.phat

# > phat + c(-1, 1)*qnorm(1-(alpha/2))*se.phat
# [1] 0.2642097 0.5357903
# > 

#
# sample size computation for proportion
#

alpha <- 0.05
w <- 2*0.03 

ceiling((qnorm(1-(alpha/2))/w)^2)

# > ceiling((qnorm(1-(alpha/2))/w)^2)
# [1] 1068
# > 

