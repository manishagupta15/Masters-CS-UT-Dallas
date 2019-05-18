
# Time between keystrokes data from Example 10.9 

x <- c(0.24, 0.22, 0.26, 0.34, 0.35, 0.32, 0.33, 0.29, 0.19, 0.36, 
       0.30, 0.15, 0.17, 0.28, 0.38, 0.40, 0.37,0.27)


# Histogram and boxplot

par(mfrow=c(1,2)) # 2 plots in 1 row

hist(x)
qqnorm(x)
qqline(x)

library(nortest)

shapiro.test(x)

# Shapiro-Wilk normality test

#data:  x 
#W = 0.9611, p-value = 0.6233

  
# Sign test of H0: M = 0.2 vs M is not equal to 0.2
  
sign.stat <- sum(x > 0.2)

#> sign.stat
#[1] 15


binom.test(sign.stat, n=sum(x != 0.2), p = 0.5, alt="two.sided", conf.level=0.95)

# Exact binomial test

# data:  sign.stat and sum(x != 0.2) 
# number of successes = 15, number of trials =
#  18, p-value = 0.007538
# alternative hypothesis: true probability of success is not equal to 0.5 
# 95 percent confidence interval:
#   0.5858225 0.9642149 
# sample estimates:
#  probability of success 
# 0.8333333 


 wilcox.test(x,alternative = "two.sided",
              mu = 0.2, conf.level = 0.95)

 
   wilcox.test(x,alternative = "two.sided",
               mu = 0.2, conf.level = 0.95)
#	Wilcoxon signed rank test

# data:  x 
# V = 162, p-value = 0.0002518
# alternative hypothesis: true location is not equal to 0.2 

> 


# Example 10.12 on page 319
    
  
# Wilcoxon signed rank test H0: M = 0.2 vs M is not equal to 0.2

x <- c(7, 5.5, 9.5, 6, 3.5, 9)

wilcox.test(x,alternative = "greater",
              mu = 5, conf.level = 0.95)

# Wilcoxon signed rank test
# data:  x 
# V = 18, p-value = 0.07813
# alternative hypothesis: true location is greater than 5 

  
# Exercise 10.22 on page 325

x <- c(0.4, 2.1, 3.6, 0.6, 0.8, 2.4, 4.0)
y <- c(1.2, 0.2, 0.3, 3.3, 2.0, 0.9, 1.1, 1.5)


wilcox.test(x, y, alternative="two.sided")
                


  