
# Read the GM Cars data -- retail price of 2005 GM Cars 
# (Source: Kuiper, S. (2008), Journal of Statistics Education, 16,
# www.amstat.org/publications/jse/v16n3/datasets.kuiper.html)


cars <- read.table("kuiper.csv", sep=",", header=T)

> str(cars)
'data.frame':	804 obs. of  12 variables:
 $ Price   : num  17314 17542 16219 16337 16339 ...
 $ Mileage : int  8221 9135 13196 16342 19832 22236 22576 22964 24021 27325 ...
 $ Make    : Factor w/ 6 levels "Buick","Cadillac",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Model   : Factor w/ 32 levels "9_3","9_3 HO",..: 9 9 9 9 9 9 9 9 9 9 ...
 $ Trim    : Factor w/ 47 levels "Aero Conv 2D",..: 40 40 40 40 40 40 40 40 40 40 ...
 $ Type    : Factor w/ 5 levels "Convertible",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ Cylinder: int  6 6 6 6 6 6 6 6 6 6 ...
 $ Liter   : num  3.1 3.1 3.1 3.1 3.1 3.1 3.1 3.1 3.1 3.1 ...
 $ Doors   : int  4 4 4 4 4 4 4 4 4 4 ...
 $ Cruise  : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Sound   : int  1 1 1 0 0 1 1 1 0 1 ...
 $ Leather : int  1 0 0 0 1 0 0 0 1 1 ...
>  

attach(cars)

# Regress Price on Mileage


fit1 <- lm(Price~Mileage)

> summary(fit1)

Call:
lm(formula = Price ~ Mileage)

Residuals:
   Min     1Q Median     3Q    Max 
-13905  -7254  -3520   5188  46091 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  2.476e+04  9.044e+02  27.383  < 2e-16 ***
Mileage     -1.725e-01  4.215e-02  -4.093 4.68e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 9789 on 802 degrees of freedom
Multiple R-squared: 0.02046,	Adjusted R-squared: 0.01924 
F-statistic: 16.75 on 1 and 802 DF,  p-value: 4.685e-05 

> 


# Get the residual plot

plot(fitted(fit1), resid(fit1))
abline(h=0)

# Fit another model

fit2 <- lm (log(Price) ~ Mileage + Make + Liter +  Doors )

> summary(fit2)

Call:
lm(formula = log(Price) ~ Mileage + Make + Liter + Doors)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.27889 -0.07070  0.00479  0.05747  0.34174 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)    9.465e+00  3.276e-02 288.894  < 2e-16 ***
Mileage       -8.066e-06  4.897e-07 -16.473  < 2e-16 ***
MakeCadillac   4.773e-01  1.823e-02  26.174  < 2e-16 ***
MakeChevrolet -1.480e-01  1.511e-02  -9.797  < 2e-16 ***
MakePontiac   -8.148e-02  1.596e-02  -5.105 4.14e-07 ***
MakeSAAB       6.668e-01  1.829e-02  36.447  < 2e-16 ***
MakeSaturn    -1.329e-01  2.075e-02  -6.406 2.56e-10 ***
Liter          2.209e-01  4.506e-03  49.028  < 2e-16 ***
Doors         -4.391e-02  4.966e-03  -8.843  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 0.1134 on 795 degrees of freedom
Multiple R-squared: 0.9243,	Adjusted R-squared: 0.9236 
F-statistic:  1214 on 8 and 795 DF,  p-value: < 2.2e-16 

> 

# Prediction 

> 9.465e+00 + 25000*(-8.066e-06 ) -8.148e-02 + 3.1*(2.209e-01) + 4*(-4.391e-02)
[1] 9.69102
> exp(9.465e+00 + 25000*(-8.066e-06 ) -8.148e-02 + 3.1*(2.209e-01) + 4*(-4.391e-02))
[1] 16171.73
> 


# Fit the third model

fit3 <- update (fit2, . ~ . + Cruise + Leather + Sound)


anova(fit2, fit3)

# Get the residual plot


plot(fitted(fit2), resid(fit2))
abline(h=0)



