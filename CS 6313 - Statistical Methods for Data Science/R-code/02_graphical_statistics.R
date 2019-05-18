
# We will continue working with the CPU data that we saw earlier

cpu <- scan(file="/users/psprao/downloads/stats/datasets/cputime.txt")

###########
# boxplot #
###########

?boxplot # see help

par(mfrow=c(1,2)) # 2 plots in 1 row
boxplot(cpu, range=0) # plot of 5-number summary
boxplot(cpu, range=1.5) # uses the 1.5 (IQR) rule (also default), i.e. same as boxplot(cpu)
par(mfrow=c(1,1)) # back to the default, 1 plot per row

#############
# histogram #
#############


?hist # see help

# frequency histogram by default

hist(cpu, xlab="cpu time", ylab="frequency", main="frequency histogram of cpu data") 

# relative frequency (density) histogram

hist(cpu, freq=FALSE, xlab="cpu time", ylab="density", main="probability (density) histogram of cpu data") 

# histograms of simulated data from some distributions

nsim <- 1000

# uniform (0,1) distribution

par(mfrow=c(2,2))
hist(runif(nsim), xlab="x", main="")

# exponential (lambda = 4) distribution

hist(rexp(nsim, rate=4), xlab="x", main="")

# normal (mu=5, sigma^2=16) distribution

hist(rnorm(nsim, mean=5, sd=4), xlab="x", main="")

# binomial (n=50, p=0.25)

hist(rbinom(nsim, size=30, prob=0.25), main="")
par(mfrow=c(1,1))

####################
# Time series plot #
####################

# Data from Exercise 8.5
year <- seq(from=1790, to=2010, by=10)
# > year
 # [1] 1790 1800 1810 1820 1830 1840 1850 1860 1870 1880 1890 1900 1910 1920 1930
# [16] 1940 1950 1960 1970 1980 1990 2000 2010
# > 

uspop <- c(3.9, 5.3, 7.2, 9.6, 12.9, 17.1, 23.2, 31.4, 38.6, 50.2, 63.0, 76.2,
				92.2, 106.0, 123.2, 132.2, 151.3, 179.3, 203.3, 226.5, 248.7, 
				281.4, 308.7)
				

plot(year, uspop, ylab="Population (in millions)", main="US population since 1790")

