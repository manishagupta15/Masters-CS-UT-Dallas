# Read data from file.
prostate.cancer <- read.csv(file="/users/psprao/downloads/stats/mini6/prostate_cancer.csv", 
                              sep=",", header=T)

# attach the data to memory
attach(prostate.cancer)

psa<-prostate.cancer[,2]
psalog <- log(psa)

# Box plot for psa
boxplot(psa)


# Box plot for square root of psa.
boxplot(sqrt(psa))

# Box plot for logarithm of psa
boxplot(psalog)

# Draw scatterplots of each variables with log(psa).
plot(cancervol, psalog,
    xlab="Cancer Volume(cc)",
    ylab="Log of PSA level(log(mg/ml))")
abline(lm(psalog ~ cancervol))


plot(weight, psalog,
    xlab="Weight(gm)",
    ylab="Log of PSA level(log(mg/ml))")
abline(lm(psalog ~ weight))

plot(age, psalog,
    xlab="Age(years)",
    ylab="Log of PSA level(log(mg/ml))")
abline(lm(psalog ~ age))

plot(benpros, psalog,
    xlab="Benign prostatic hyperplasia(cm^2)",
    ylab="Log of PSA level(log(mg/ml))")
abline(lm(psalog ~ benpros))



plot(capspen, psalog,
    xlab="Capsular penetration(cm)",
    ylab="Log of PSA level(log(mg/ml))")
abline(lm(psalog ~ capspen))


# Calculate the first formula.
fit1 <- lm(psalog ~ cancervol + capspen + weight + age + benpros)
fit1

fit2 <- lm(psalog ~ cancervol + capspen + benpros)
fit2

# Compare first two guess.
anova(fit2, fit1)

# Apply stepwise selection.
# Forward selection based on AIC.
fit3.forward <-
    step(lm(psalog ~ 1),
    scope = list(upper = ~ cancervol + capspen + weight + age + benpros),
    direction = "forward")

fit3.forward

# Backward elimination based on AIC.
fit3.backward <-
    step(lm(psalog ~ cancervol + capspen + weight + age + benpros),
    scope = list(lower = ~1),
    direction = "backward")

fit3.backward

# Both forward/backward.
fit3.both <-
    step(lm(psalog ~ 1),
    scope = list(lower = ~1,
                 upper = ~ cancervol + capspen + weight + age + benpros),
    direction = "both")

fit3.both

# Model selected.
fit3 <- lm(formula = psalog ~ cancervol + benpros)

summary(fit3)

# Compare the model with the guess one.
anova(fit3, fit2)

# Residual plot of fit3.
plot(fitted(fit3), resid(fit3))
abline(h = 0)


# Plot the absolute residual of fit3
plot(fitted(fit3), abs(resid(fit3)))

# Plot the times series plot of residuals
plot(resid(fit3), type="l")
abline(h = 0)


# Normal QQ plot of fit3.
qqnorm(resid(fit3))
qqline(resid(fit3))

# Consider the categorical variables.
fit4 <- update(fit3, . ~ . + factor(vesinv))
fit5 <- update(fit3, . ~ . + factor(gleason))

# Comparing two categorical variables.
summary(fit5)

anova(fit3, fit5)

summary(fit4)

anova(fit3, fit4)

# Finalize the model.
fit6 <- update(fit3, . ~ . + factor(vesinv) + factor(gleason))

summary(fit6)

# Residual plot of fit6.
plot(fitted(fit6), resid(fit6))
abline(h = 0)

# Plot the absolute residual of fit3.
plot(fitted(fit6), abs(resid(fit6)))

# Plot the times series plot of residuals
plot(resid(fit6), type="l")
abline(h = 0)

# Normal QQ plot of fit6
qqnorm(resid(fit6))
qqline(resid(fit6))

# Create the function for getting mode
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Predict the PSA level for predictors having vakues at their sample means and categorical 
# predictors at their most frequent label
pred <- predict(fit6,
    data.frame(cancervol = mean(cancervol),
               benpros   = mean(benpros),
               vesinv    = getmode(vesinv),
               gleason   = getmode(gleason)))

# since our respnse variable is log(psa)
exp(pred)
