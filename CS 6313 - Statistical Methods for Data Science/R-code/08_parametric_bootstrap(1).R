
##########################################
# Illustration of Parametric Bootstrap #
########################################

# Suppose X ~ N(mu, sigma^2) and SD(X) = sigma is the 
# parameter of interest. It is estimated by S, the sample SD.
# We will get the bootstrap distribution of S. This distribution 
# approximates the sampling distribution of S.

set.seed(1234)

# (Simulate) original data

n <- 20
x <-  rnorm(n, 10, 5)

# Get estimates based on original data

xbar <- mean(x)
s <- sd(x)

# > xbar
# [1] 8.74668
# > s
# [1] 5.069038
# > 

# Simulate one parametric resample of original sample

xstar <- rnorm(n, xbar, s)

# > xstar
 # [1]  9.426378  6.259374  6.513526 11.076356  5.230185  1.405674
 # [7] 11.660138  3.557730  8.669943  4.002321 14.334268  6.335880
# [13]  5.150501  6.205784  0.488743  2.827973 -2.304024  1.949134
# [19]  7.254893  6.385027
# > 

# Estimate sd based on resample

# > sd(xstar)
# [1] 4.012393
# > 

# Write a function to simulate one resample and compute sd

sd.star <- function(x){
	n <- length(x)
	xbar <- mean(x)
	s <- sd(x)
	xstar <- rnorm(n, xbar, s)
	sstar <- sd(xstar)
	return(sstar)
}

# Simulate bootstrap distribution of S 

nboot <- 1000
sd.boot.dist <- replicate(nboot, sd.star(x))

boxplot(sd.boot.dist)

# Bias of estimate

# > mean(sd.boot.dist) - s
# [1] -0.07288805
# > 


# SE of estimate

# > sd(sd.boot.dist)
# [1] 0.7967314
# > 

# Percentile bootstrap CI for population sd (sigma)

# > sort(sd.boot.dist)[c(25, 975)]
# [1] 3.507753 6.580463
# >

 

