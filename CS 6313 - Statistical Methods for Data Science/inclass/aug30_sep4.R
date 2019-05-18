 
 
dnorm(2, sd = 4, mean = 5)
 
dnorm(2, mean = 5, sd = 4)

dnorm(2, 5, 4)

dnorm(2, 4, 5)

dnorm(2)

x <- seq(f=0, t=1, l=100)
dnorm(x)
 
set.seed(1)
 
########################
# Binomial distribution #
########################

# simulate 1 draw of X ~ Binomial (size, prob)

y <- rbinom(1, 10, 0.25)

# simulate 100 draws of X

x <- rbinom(100, 10, 0.25)

# > head(x)
# [1] 2 0 2 4 1 1
# > tail(x)
# [1] 5 3 5 3 3 1
# > 

# P(X = 5) --- PMF

dbinom(5, 10, 0.25)

# P(X <= 5) --- CDF

pbinom(5, 10, 0.25)

qbinom(0.5, 10, 0.25)

########################
# Normal distribution #
########################

# X ~ Normal (0, 1)

# simulate 1000 draws of X

?rnorm
x <- rnorm(1000) # by default, mean = 0, sd = 1

# make a histogram of draws and superimpose Normal (0, 1) density

hist(x)

hist(x, probability = T)
curve(dnorm(x), add = T, xlab = "x", ylab = "density")

# P(|X| > 1) -- exact 

pnorm(-1) + 1 - pnorm(1)

#  P(|X| > 1) -- Monte Carlo estimate

mean(abs(x) > 1)

# E(X) = 0, var(X) = 1 -- exact

# Monte Carlo estimate of E(X)

mean(x)

# Monte Carlo estimate of var(X)

var(x)

# see the effect of N by increasing to, say, 5000, 10000 and 50000

#########################
# computing probabilities #
#########################

?pnorm

pnorm(0, mean = 0, sd = 1) # CDF

punif(0.5, min = 0, max = 1) # CDF

pexp(1, rate = 2) # CDF

#########################
# computing quantiles #
#########################

?qnorm

qnorm(0.975, mean = 0, sd = 1)

qnorm(0.5, mean = 0, sd = 1)


#########################
# normal Q-Q plot #
#########################


x <- rnorm(100, mean = 0, sd = 1)
qqnorm(x)

qqline(x)


########################
# Monte Carlo estimation #
########################

# coin toss experiment 

# X = indicator of heads (1) in one toss. X ~ Bernoulli (p = P(X = 1))

# simulate 10 draws from Bernoulli with p = 0.25

?rbinom
rbinom(n = 10, size = 1, prob = 0.25)

# simulate 1000 draws from Bernoulli with p = 0.8 and take their mean

x <- rbinom(n = 1000, size = 1, prob = 0.8)
mean(x)

# repeat 100 times the process of simulating 1000 draws from Bernoulli with 
# p = 0.8 and taking their average --- this will give 100 averages, all close 
# to p because of Law of Large Numbers

p.1k <- replicate(100, mean(rbinom(1000, 1, 0.8)))

# repeat 100 times the process of simulating 10000 draws from Bernoulli with 
# p = 0.8 and taking their average --- this will give 100 averages, all close 
# to p because of Law of Large Numbers

p.10k <- replicate(100, mean(rbinom(10000, 1, 0.8)))

# compare the distributions of the averages based on 1000 and 10000 draws

boxplot(p.1k, p.10k)
abline(h=0.8)

# check normality of the averages (predicted by Central Limit Theorem)

qqnorm(p.1k)
qqline(p.1k)

qqnorm(p.10k)
qqline(p.10k)

# Will the normal approximation for the average be good if p = 0.01? Check

p.10 <- replicate(100, mean(rbinom(10, 1, 0.01)))

qqnorm(p.10)

p.30 <- replicate(100, mean(rbinom(30, 1, 0.01)))
qqnorm(p.30)

p.1k <- replicate(100, mean(rbinom(1000, 1, 0.01)))
qqnorm(p.1k)


p.1k <- replicate(100, mean(rbinom(1000, 1, 0.10)))
qqnorm(p.1k)


qqline(p.10)

qqnorm(rgamma(100, shape = 50, rate = 1))

qqnorm(rgamma(100, shape = 5, rate = 1))

