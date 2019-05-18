#################################################
# R Code for Question 2
#################################################

# Getting the data
data <- c(21.72,14.65,50.42,28.78,11.23)

# Negative of log-likelihood function 
neg.loglik.fun <- function(par,dat)
{ c
  result <- NROW(dat)*log(par) - (par+1)*sum(log(dat))
  return(-1 * result)
}


# Minimize -log (L), i.e., maximize log (L)
ml.est <- optim(par = c(0.1), fn = neg.loglik.fun, method = "L-BFGS-B",lower = rep(0.005), 
               hessian = TRUE, dat = data)

# Estimating the mean squared error
calc = 0.323394
(ml.est$par-0.323394)^2

# Estimating the standard error
(0.3233885-0.323394)^2
# [1] 3.025e-11
 
sqrt(3.025e-11)
# [1] 5.5e-06


# Finding the confidence interval
conf.int<-function(mu,sigma,n,alpha)
{
  x <- rnorm(n,mu,sigma)
  ci <- mean(x) + c(-1,1) * qnorm(1-alpha/2) * sigma/sqrt(n)
  return(ci)
}


# Get one confidence interval 
conf.int(0.3233885,5.5e-06,20,0.05)


# Repeat the simulation for nsim times
nsim <- 1000
ci.mat <- replicate(1000,
                  conf.int(0.3233885,5.5e-06,20,0.05))


# Plot the confidence intervals
plot(1:100, ci.mat[1, 1:100],
    ylim=c(min(ci.mat[,1:100]), max(ci.mat[,1:100])),
     xlab="sample #", ylab="95% CI", type="p")
points(1:100, ci.mat[2, 1:100])
for (i in 1:100) {
  segments(i, ci.mat[1, i], i, ci.mat[2,i], lty=1)
}
abline(h=5, lty=2)
