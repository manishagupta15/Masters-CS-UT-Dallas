

# Read the house price data

house <- read.csv(file="/users/psprao/Downloads/stats/R-code/house_price.csv", sep=",", header=T)

# > head(house)
#    size price
# 1 0.951 30.00
# 2 1.036 39.90
# 3 0.676 46.50
# 4 1.456 48.60
# 5 1.186 51.50
# 6 1.456 56.99


str(house)
# 'data.frame':	58 obs. of  2 variables:
#  $ size : num  0.951 1.036 0.676 1.456 1.186 ...
# $ price: num  30 39.9 46.5 48.6 51.5 ...
 

# Make a scatterplot

x <- house$size
y <- house$price

plot(x, y, xlab="square footage (1000 sq feet)", ylab="price ($1000)")

# Correlation

> cor(x,y)
[1] 0.8759374
> 


# Get the fitted regression line 


> (house.reg <- lm (y ~ x))

Call:
lm(formula = y ~ x)

Coefficients:
(Intercept)            x  
      5.432       56.083  

> 

# Does R do what we expect it to do?

> c(mean(x), sd(x), mean(y), sd(y), cor(x,y))
[1]   1.8829655   0.6316624 111.0344483  40.4431900   0.8759374
>
> cor(x,y)*sd(y)/sd(x)
[1] 56.08328
>
> mean(y)-(cor(x,y)*sd(y)/sd(x))*mean(x)
[1] 5.431568
> 

# Add the line to the plot

plot(x, y, xlab="square footage (1000 sq feet)", ylab="price ($1000)")
abline(house.reg)



x <- house$size
y <- house$price

house.reg <- lm (y ~ x)

# ANOVA table


> (anova(house.reg))
Analysis of Variance Table

Response: y
          Df Sum Sq Mean Sq F value    Pr(>F)    
x          1  71534   71534  184.62 < 2.2e-16 ***
Residuals 56  21698     387                      
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
> 

# Testing for zero slope

> summary(house.reg)

Call:
lm(formula = y ~ x)

Residuals:
    Min      1Q  Median      3Q     Max 
-38.489 -14.512  -1.422  14.919  54.389 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)    5.432      8.191   0.663     0.51    
x             56.083      4.128  13.587   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 19.68 on 56 degrees of freedom
Multiple R-squared: 0.7673,	Adjusted R-squared: 0.7631 
F-statistic: 184.6 on 1 and 56 DF,  p-value: < 2.2e-16 

> 

# Confidence interval for slope

> confint(house.reg)
                2.5 %   97.5 %
(Intercept) -10.97619 21.83933
x            47.81473 64.35183
> 

# Prediction at a new x 

x.new <- data.frame(x=3) 

> (predict(house.reg, newdata=x.new))
       1 
173.6814 
> 


# Use fitted(house.reg) to get the fitted values 
# Use resid(house.reg) to get the residuals


# Residual plot

plot(fitted(house.reg), resid(house.reg))
abline(h=0)

# QQ plot

qqnorm(resid(house.reg))
qqline(resid(house.reg))
   
                                  
# Time series plot of residuals

plot(resid(house.reg), type="l")
abline(h=0)

