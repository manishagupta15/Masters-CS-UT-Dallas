
# These data come from a sample of homes sold in Maplewood, NJ in 2001.


# Read the home price data

home <- read.table("homeprice_multiple_predictors.txt", sep=",", header=T)

> str(home)
'data.frame':	29 obs. of  7 variables:
 $ list        : num  80 151 310 295 339 ...
 $ sale        : num  118 151 300 275 340 ...
 $ full        : int  1 1 2 2 2 1 3 1 1 1 ...
 $ half        : int  0 0 1 1 0 1 0 1 2 0 ...
 $ bedrooms    : int  3 4 4 4 3 4 3 3 3 1 ...
 $ rooms       : int  6 7 9 8 7 8 7 7 7 3 ...
 $ neighborhood: int  1 1 3 3 4 3 2 2 3 2 ...
> 

# Attach the dataset in R's memory so that we can
# directly use the names of the variables

attach(home)

# Look at distribution of some predictors

> table(bedrooms)
bedrooms
 1  2  3  4  5 
 1  3 16  8  1 
> 
> table(full)
full
 1  2  3 
13 11  5 
> table(half)
half
 0  1  2 
13 13  3 
> table(neighborhood)
neighborhood
 1  2  3  4  5 
 2  8 12  5  2 
> 


# Regress sale price on # bedrooms and neighborhood

fit1 <- lm(sale ~ bedrooms + neighborhood)

> summary(fit1)

Call:
lm(formula = sale ~ bedrooms + neighborhood)

Residuals:
    Min      1Q  Median      3Q     Max 
-90.871 -39.861   0.636  28.815 107.660 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -132.057     40.341  -3.273 0.003001 ** 
bedrooms       42.483     11.446   3.712 0.000987 ***
neighborhood   93.493      9.101  10.273 1.21e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 47.3 on 26 degrees of freedom
Multiple R-squared: 0.8491,	Adjusted R-squared: 0.8375 
F-statistic: 73.16 on 2 and 26 DF,  p-value: 2.1e-11 

> 

# Add # full and half baths


fit2 <- update(fit1, . ~ . + full + half)


> summary(fit2)

Call:
lm(formula = sale ~ bedrooms + neighborhood + full + half)

Residuals:
    Min      1Q  Median      3Q     Max 
-56.554 -38.067   6.027  26.998  53.311 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -125.121     33.136  -3.776 0.000926 ***
bedrooms       29.513     10.091   2.925 0.007419 ** 
neighborhood   78.724      9.669   8.142 2.31e-08 ***
full           27.345     13.604   2.010 0.055785 .  
half           45.553     12.129   3.756 0.000974 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 38.79 on 24 degrees of freedom
Multiple R-squared: 0.9063,	Adjusted R-squared: 0.8907 
F-statistic: 58.05 on 4 and 24 DF,  p-value: 5.425e-12 

> 

# Drop # full baths

fit3 <- update(fit2, . ~ . - full)


> summary(fit3)

Call:
lm(formula = sale ~ bedrooms + neighborhood + half)

Residuals:
   Min     1Q Median     3Q    Max 
-67.55 -42.27   7.17  26.93  68.83 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -127.348     35.073  -3.631  0.00127 ** 
bedrooms       35.649     10.187   3.500  0.00177 ** 
neighborhood   90.982      7.947  11.449 1.95e-11 ***
half           37.004     12.030   3.076  0.00503 ** 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 41.08 on 25 degrees of freedom
Multiple R-squared: 0.8905,	Adjusted R-squared: 0.8774 
F-statistic:  67.8 on 3 and 25 DF,  p-value: 3.808e-12 

> 


# Compare the nested models

anova(fit1, fit3, fit2)

> anova(fit1, fit3, fit2)
Analysis of Variance Table

Model 1: sale ~ bedrooms + neighborhood
Model 2: sale ~ bedrooms + neighborhood + half
Model 3: sale ~ bedrooms + neighborhood + full + half
  Res.Df   RSS Df Sum of Sq       F   Pr(>F)   
1     26 58164                                 
2     25 42194  1   15970.1 10.6132 0.003338 **
3     24 36114  1    6080.1  4.0406 0.055785 . 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
> 

# 

# Residual plot

plot(fitted(fit3), resid(fit3))
abline(h=0)

# QQ plot

qqnorm(resid(fit3))
qqline(resid(fit3))
   
# Take sqrt(sale) rather than sale as response

fit4 <- update(fit3, sqrt(sale) ~ .)

                                  
# New QQ plot

qqnorm(resid(fit4))
qqline(resid(fit4))
   



	
