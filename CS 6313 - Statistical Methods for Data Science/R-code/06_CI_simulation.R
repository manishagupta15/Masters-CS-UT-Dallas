
#########################################################################
# R code for repeating the process of simulating data and constructing #
# a confidence interval for mean of a normal distribution, and plotting #
# the confidence intervals                                             #
#########################################################################

# A function to simulate data from a N(mu, sigma^2) distribution and computing CI 

conf.int <- function(mu, sigma, n, alpha) {
	x <- rnorm(n, mu, sigma)
	ci <- mean(x) + c(-1, 1) * qnorm(1 - (alpha/2)) * sigma/sqrt(n)
	return(ci)
}

# Se mu, sigma, and alpha

mu <- 5
sigma <- sqrt(10)
n <- 20
alpha <- 0.05


# Get one CI

# > conf.int(mu, sigma, n, alpha)
# [1] 3.520961 6.292768
# > 

# Repeat the process nsim times

nsim <- 10000
ci.mat <- replicate(nsim, conf.int(mu, sigma, n, alpha))

# > dim(ci.mat)
# [1]     2 10000
# > 

# The first 5 intervals

# >  ci.mat[, 1:5]
         # [,1]     [,2]     [,3]     [,4]     [,5]
# [1,] 3.562460 4.122238 4.866313 4.081422 3.668361
# [2,] 6.334267 6.894046 7.638121 6.853229 6.440169
# > 

# Graphing the first 100 intervals

matplot(rbind(1:100, 1:100), ci.mat[, 1:100], type = "l", lty = 1, 
	xlab = "sample number", ylab = "confidence interval")
abline(h = mu)

# Proportion of times the interval is correct

# > mean( (mu >= ci.mat[1,])*(mu <= ci.mat[2,]) )
# [1] 0.9505
# > 

##################################################################################
