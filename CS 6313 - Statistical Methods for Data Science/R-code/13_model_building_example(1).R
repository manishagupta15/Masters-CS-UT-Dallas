
# Recall the home price data from class. These data come from a sample 
# of homes sold in Maplewood, NJ in 2001.

# Read the home price data

home <- read.table("homeprice_multiple_predictors.txt", sep=",", header=T)

# > str(home)
# 'data.frame':	29 obs. of  7 variables:
 # $ list        : num  80 151 310 295 339 ...
 # $ sale        : num  118 151 300 275 340 ...
 # $ full        : int  1 1 2 2 2 1 3 1 1 1 ...
 # $ half        : int  0 0 1 1 0 1 0 1 2 0 ...
 # $ bedrooms    : int  3 4 4 4 3 4 3 3 3 1 ...
 # $ rooms       : int  6 7 9 8 7 8 7 7 7 3 ...
 # $ neighborhood: int  1 1 3 3 4 3 2 2 3 2 ...
# > 

# Look at distribution of some predictors

boxplot(home$sale)
boxplot(sqrt(home$sale))

# > table(home$full)
 # 1  2  3 
# 13 11  5 
# >
# > table(home$half)
 # 0  1  2 
# 13 13  3 
# >
# > table(home$bedrooms)
 # 1  2  3  4  5 
 # 1  3 16  8  1 
# > 
# > table(home$rooms)
 # 3  4  6  7  8  9 10 11 
 # 1  1  4 12  8  1  1  1 
# > 
# > table(home$neighborhood)
 # 1  2  3  4  5 
 # 2  8 12  5  2 
# > 

plot(home$bedrooms, home$rooms)


# Take sqrt(sale) as response

y <- sqrt(home$sale)

# We exclude list from predictors, and focus on the following
# predictors: full, half, bedrooms, rooms, neighborhood

# First, let's look at the relationship between response and each predictor one by one

plot(home$full, y)
fit1 <- lm(y ~ full, data = home)
abline(fit1)

plot(home$half, y)
fit2 <- lm(y ~ half, data = home)
abline(fit2)

plot(home$bedrooms, y)
fit3 <- lm(y ~ bedrooms, data = home)
abline(fit3)

plot(home$rooms, y)
fit4 <- lm(y ~ rooms, data = home)
abline(fit4)

plot(home$neighborhood, y)
fit5 <- lm(y ~ neighborhood, data = home)
abline(fit5)

# We see a significant positive trend in each case

# Next, we definitely expect bedrooms and neighborhood to be important 
# predictors. So let's start with a model with these two.

fit6 <- lm(y ~ bedrooms + neighborhood, data = home)

# Let's now add the two bathroom variables, full and half.

fit7 <- lm(y ~ bedrooms + neighborhood + full + half, data = home)

# We see that full does seem important. But before removing it from the model
# let's add rooms also. Note that 

# > home$rooms - (home$bedrooms + home$full + home$half)
 # [1] 2 2 2 1 2 2 1 2 1 1 2 1 2 1 0 0 4 1 1 1 3 2 1 2 2 3 1 2
# [29] 3
# > 

# This shows that we cannot have rooms as well as (bedrooms, full, half)
# in the model as the former is essentially determined by the latter. Just
# out of curiousity, let's add rooms also the model to see what happens.


fit8 <- lm(y ~ bedrooms + neighborhood + full + half + rooms, data = home)

# Now, none of bedrooms, full and rooms seems significant.
# Let's drop full and rooms.


fit9 <- lm(y ~ bedrooms + neighborhood + half, data = home)

# Perform a partial F-test to check significance of full and rooms.

# > anova(fit9, fit8)
# Analysis of Variance Table

# Model 1: y ~ bedrooms + neighborhood + half
# Model 2: y ~ bedrooms + neighborhood + full + half + rooms
  # Res.Df    RSS Df Sum of Sq      F Pr(>F)
# 1     25 46.413                           
# 2     23 42.599  2    3.8141 1.0296  0.373
# > 

# We don't need either of two variables. Also, the model in fit9 does not
# have any non-significant predictors. Therefore, we take this as our
# preliminary model for the data. However, we need to perform the diagnostics
# before accepting this model.


# How does fit9 compare with automatic stepwise model selection procedures 
# based on AIC? See the steps and make sure to understand how predictors
# are added/dropped in each step, and when the process stops. In the output
# below '+' means 'add variable' and '-' means 'drop variable.'

# Forward selection based on AIC

fit10.forward <- step(lm(y ~ 1, data = home), 
	scope = list(upper = ~full + half + bedrooms + rooms + neighborhood),
	direction = "forward")
	
# > fit10.forward <- step(lm(y ~ 1, data = home), 
# + 	scope = list(upper = ~full + half + bedrooms + rooms + neighborhood),
# + 	direction = "forward")
# Start:  AIC=75.96
# y ~ 1

               # Df Sum of Sq    RSS    AIC
# + neighborhood  1   271.439 100.15 39.943
# + rooms         1   154.501 217.09 62.377
# + full          1   131.804 239.79 65.261
# + bedrooms      1    98.858 272.73 68.995
# + half          1    60.180 311.41 72.841
# <none>                      371.59 75.964

# Step:  AIC=39.94
# y ~ neighborhood

           # Df Sum of Sq     RSS    AIC
# + rooms     1    38.937  61.216 27.666
# + bedrooms  1    37.703  62.450 28.245
# + half      1    27.535  72.618 32.620
# <none>                  100.153 39.943
# + full      1     2.677  97.476 41.157

# Step:  AIC=27.67
# y ~ neighborhood + rooms

           # Df Sum of Sq    RSS    AIC
# + half      1   11.7376 49.478 23.493
# <none>                  61.216 27.666
# + bedrooms  1    2.6817 58.534 28.367
# + full      1    0.1613 61.055 29.590

# Step:  AIC=23.49
# y ~ neighborhood + rooms + half

           # Df Sum of Sq    RSS    AIC
# + bedrooms  1    4.0003 45.478 23.048
# + full      1    3.3355 46.143 23.469
# <none>                  49.478 23.493

# Step:  AIC=23.05
# y ~ neighborhood + rooms + half + bedrooms

       # Df Sum of Sq    RSS    AIC
# <none>              45.478 23.048
# + full  1    2.8788 42.599 23.152
# > 

# Backward elimination based on AIC

fit11.backward <- step(lm(y ~ full + half + bedrooms + rooms + neighborhood, data = home), 
	scope = list(lower = ~1), direction = "backward")

# > fit11.backward <- step(lm(y ~ full + half + bedrooms + rooms + neighborhood, data = home), 
# + 	scope = list(lower = ~1), direction = "backward")
# Start:  AIC=23.15
# y ~ full + half + bedrooms + rooms + neighborhood

               # Df Sum of Sq     RSS    AIC
# - rooms         1     0.548  43.147 21.522
# - full          1     2.879  45.478 23.048
# <none>                       42.599 23.152
# - bedrooms      1     3.544  46.143 23.469
# - half          1    15.878  58.477 30.339
# - neighborhood  1    86.257 128.856 53.251

# Step:  AIC=21.52
# y ~ full + half + bedrooms + neighborhood

               # Df Sum of Sq     RSS    AIC
# <none>                       43.147 21.522
# - full          1     3.266  46.413 21.638
# - bedrooms      1    18.771  61.918 29.997
# - half          1    19.220  62.367 30.206
# - neighborhood  1    94.763 137.910 53.220
# > 

# Both forward/backward


fit12.both <- step(lm(y ~ 1, data = home), 
	scope = list(lower = ~1, upper = ~full + half + bedrooms + rooms + neighborhood),
	direction = "both")

# > fit12.both <- step(lm(y ~ 1, data = home), 
# + 	scope = list(lower = ~1, upper = ~full + half + bedrooms + rooms + neighborhood),
# + 	direction = "both")
# Start:  AIC=75.96
# y ~ 1

               # Df Sum of Sq    RSS    AIC
# + neighborhood  1   271.439 100.15 39.943
# + rooms         1   154.501 217.09 62.377
# + full          1   131.804 239.79 65.261
# + bedrooms      1    98.858 272.73 68.995
# + half          1    60.180 311.41 72.841
# <none>                      371.59 75.964

# Step:  AIC=39.94
# y ~ neighborhood

               # Df Sum of Sq    RSS    AIC
# + rooms         1    38.937  61.22 27.666
# + bedrooms      1    37.703  62.45 28.245
# + half          1    27.535  72.62 32.620
# <none>                      100.15 39.943
# + full          1     2.677  97.48 41.157
# - neighborhood  1   271.439 371.59 75.964

# Step:  AIC=27.67
# y ~ neighborhood + rooms

               # Df Sum of Sq     RSS    AIC
# + half          1    11.738  49.478 23.493
# <none>                       61.216 27.666
# + bedrooms      1     2.682  58.534 28.367
# + full          1     0.161  61.055 29.590
# - rooms         1    38.937 100.153 39.943
# - neighborhood  1   155.874 217.090 62.377

# Step:  AIC=23.49
# y ~ neighborhood + rooms + half

               # Df Sum of Sq     RSS    AIC
# + bedrooms      1     4.000  45.478 23.048
# + full          1     3.335  46.143 23.469
# <none>                       49.478 23.493
# - half          1    11.738  61.216 27.666
# - rooms         1    23.140  72.618 32.620
# - neighborhood  1   154.654 204.132 62.593

# Step:  AIC=23.05
# y ~ neighborhood + rooms + half + bedrooms

               # Df Sum of Sq     RSS    AIC
# - rooms         1     0.935  46.413 21.638
# <none>                       45.478 23.048
# + full          1     2.879  42.599 23.152
# - bedrooms      1     4.000  49.478 23.493
# - half          1    13.056  58.534 28.367
# - neighborhood  1   158.186 203.664 64.526

# Step:  AIC=21.64
# y ~ neighborhood + half + bedrooms

               # Df Sum of Sq     RSS    AIC
# + full          1     3.266  43.147 21.522
# <none>                       46.413 21.638
# + rooms         1     0.935  45.478 23.048
# - half          1    16.037  62.450 28.245
# - bedrooms      1    26.205  72.618 32.620
# - neighborhood  1   196.369 242.782 67.621

# Step:  AIC=21.52
# y ~ neighborhood + half + bedrooms + full

               # Df Sum of Sq     RSS    AIC
# <none>                       43.147 21.522
# - full          1     3.266  46.413 21.638
# + rooms         1     0.548  42.599 23.152
# - bedrooms      1    18.771  61.918 29.997
# - half          1    19.220  62.367 30.206
# - neighborhood  1    94.763 137.910 53.220
# > 


# We see that direction = backward and direction = both pick the following model:
# neighborhood + half + bedrooms + full
# Also, direction = forward picks the following model:
# neighborhood + rooms + half + bedrooms
# Whereas, we came up with the following model (fit9):
# bedrooms + neighborhood + half

# Which one seems to be better?

# > anova(fit9, fit12.both)
# Analysis of Variance Table

# Model 1: y ~ bedrooms + neighborhood + half
# Model 2: y ~ neighborhood + half + bedrooms + full
  # Res.Df    RSS Df Sum of Sq      F Pr(>F)
# 1     25 46.413                           
# 2     24 43.147  1    3.2663 1.8168 0.1903
# > 

# > anova(fit9, fit10.forward)
# Analysis of Variance Table

# Model 1: y ~ bedrooms + neighborhood + half
# Model 2: y ~ neighborhood + rooms + half + bedrooms
  # Res.Df    RSS Df Sum of Sq      F Pr(>F)
# 1     25 46.413                           
# 2     24 45.478  1   0.93524 0.4935 0.4891
# > 

# Of course, fit9! So let's go with fit9 and perform model diagnostics
# (already seen in the last class)

# residual plot
plot(fitted(fit9), resid(fit9))
abline(h = 0)

# plot of absolute residuals

plot(fitted(fit9), abs(resid(fit9)))

# normal QQ plot
qqnorm(resid(fit9))
qqline(resid(fit9))

# This preliminary model passes the diagnostics. So we can take this
# as our final model.






