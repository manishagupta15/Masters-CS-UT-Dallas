conf.int<-function(mu,sigma,n,alpha)
{
  x<-rnorm(n,mu,sigma)
  ci<-mean(x) + c(-1,1)*qnorm(1-alpha/2)*sigma/sqrt(n)
  return(ci)
}

# Get one confidence interval
mu<-0.3233885
sigma<-3.077397e-11
n<-20
alpha<-0.05

conf.int(mu,sigma,n,alpha)

# Repeat the simulation for nsim times
nsim<-1000
ci.mat<-replicate(nsim,conf.int(mu,sigma,n,alpha))


# Plot the confidence intervals
plot(1:100, ci.mat[1, 1:100],
     ylim=c(min(ci.mat[,1:100]), max(ci.mat[,1:100])),
     xlab="sample #", ylab="95% CI", type="p")
points(1:100, ci.mat[2, 1:100])
for (i in 1:100) {
  segments(i, ci.mat[1, i], i, ci.mat[2,i], lty=1)
}
abline(h=5, lty=2)