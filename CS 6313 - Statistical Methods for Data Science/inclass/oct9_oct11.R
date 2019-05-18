##############
# Example 1 #
##############

# the data 
# x = sugar content of a children's cereal
x <- c(40.3, 55, 45.7, 43.3, 50.3, 45.9, 53.5, 43, 44.2, 44, 47.4, 44, 33.6, 55.1,
48.8, 50.4, 37.8, 60.3, 46.5)

# y = sugar content of an adult's cereal
y <- c(20, 30.2, 2.2, 7.5, 4.4, 22.2, 16.6, 14.5, 21.4, 3.3, 6.6, 7.8, 10.6, 16.2,
14.5, 4.1, 15.8, 4.1, 2.4, 3.5, 8.5, 10, 1, 4.4, 1.3, 8.1, 4.7, 18.4)

# get boxplots

boxplot(x, y)

# get QQ plots
qqnorm(x, main="Q-Q plot for data on children's cereals")
qqline(x)

qqnorm(y, main="Q-Q plot for data on adults' cereals")
qqline(y)

# compute the CI directly and see if the answers match with t.test()
n1 <- length(x)
n2 <- length(y)
v <- (sd(x)^2*(n1-1)+sd(y)^2*(n2-1))/(n1+n2-2)
se <- sqrt(v*(1/n1+1/n2))

mean(x)-mean(y)+c(-1,1)*(qt(0.975,n1+n2-2)*se)

# confidence interval for mean difference (assumes normality)
# (can use t.test function since we have the raw data)

t.test(x, y, alternative = "two.sided", conf.level = 0.95, 
	var.equal = FALSE)

# > t.test(x, y, alternative = "two.sided", conf.level = 0.95, 
 	# var.equal = FALSE) --- Satterthwaite's approximation

	# Welch Two Sample t-test

# data:  x and y
# t = 17.799, df = 42.778, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
 # 32.48894 40.79339
# sample estimates:
# mean of x mean of y 
 # 46.79474  10.15357 


# Note: we can set the var.equal flag to TRUE to get the interval using 
# equal variance assumption (to use pooled sample variance)
t.test(x,y, alternative = "two.sided", var.equal = T,conf.level = 0.95)


###########
# Example 2 #
###########


p1.hat <- 610/4140
p2.hat <- 740/5010
n1 <- 414000000
n2 <- 501000000
alpha <- 0.05
diff.ci <- p1.hat-p2.hat + c(-1, 1)*qnorm(1-alpha/2)*
	sqrt((p1.hat*(1-p1.hat)/n1)+(p2.hat*(1-p2.hat)/n2))

# > diff.ci
# [1] -0.04652425  0.04580106
# > 

###########
# Example 3 #
###########

bp <- read.table("bp.txt", header = T, sep = "\t")

# > head(bp)
  # armsys fingsys
# 1    140     154
# 2    110     112
# 3    138     156
# 4    124     152
# 5    142     142
# 6    112     104
# > 

# boxplots

boxplot(bp)

# histograms and QQ plots

par(mfrow = c(1, 2))
hist(bp[,1])
qqnorm(bp[,1])
qqline(bp[,1])

hist(bp[,2])
qqnorm(bp[,2])
qqline(bp[,2])

# histogram and QQ plot of differences

diff <- bp[,1] - bp[,2]

boxplot(diff)
hist(diff)
qqnorm(diff)
qqline(diff)

# confidence interval

t.test(diff, alternative = "two.sided")

# > t.test(diff, alternative = "two.sided")

	# One Sample t-test

# data:  diff
# t = -4.1642, df = 199, p-value = 4.652e-05
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
 # -6.328898 -2.261102
# sample estimates:
# mean of x 
   # -4.295 
# >

# directly using formula

n <- length(diff)
mean(diff) + c(-1, 1)* qt(0.975, n-1) * sd(diff)/sqrt(n)

# > mean(diff) + c(-1, 1)* qt(0.975, n-1) * sd(diff)/sqrt(n)
# [1] -6.328898 -2.261102
# > 


#################################


