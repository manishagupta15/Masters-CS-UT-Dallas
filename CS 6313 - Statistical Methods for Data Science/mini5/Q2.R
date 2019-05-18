##############################
# R code for question 2
#############################

# function to get large -sample CI
ci.norm<-function(n,lambda)
{
  alpha<-0.05
  
  # generate a sample
  x <- rexp(n,lambda)
  
  # get a (1-alpha)% CI
  ci <- mean(x) + c(-1,1) * qnorm(1-alpha/2) * sd(x)/sqrt(n)
  
  return(ci)
}


# function to compute one resample and its mean 
mean.star<-function(x)
{
  n<-length(x)
  
  # getting lambda value
  xbar<-mean(x)
  lambda<-1/xbar
  
  # resample
  xstar<-rexp(n,rate=lambda)
  
  # compute mean of resample
  xstar.mean<-mean(xstar)
  
  return(xstar.mean)
}



# Function to get CI using parametric bootstrap
par.boot.ci<-function(n,lambda)
{
  # generate a sample
  x<-rexp(n,lambda)
  
  # Generate nboot resamples
  nboot<-1000
  mean.boot.dist<-replicate(nboot,mean.star(x))
  
  # get a 95% percentile bootstrap CI
  mean.ci<-sort(mean.boot.dist)[c(25, 975)]
  
  return(mean.ci)
}



# function to get large-sample and boostrap  coverage probabilty for given (n,lambda)
cover.probs<-function(n,lambda,nsim)
{
  # value of mean
  mu<-1/lambda
  
  # Generate nsim large-sample CIs 
  ci.mat<-replicate(nsim,ci.norm(n,lambda))
  
  # get large-sample coverage probability
  cp.norm<-mean((mu>=ci.mat[1,])*(mu<=ci.mat[2,]))
  
  # generate nsim bootstrap CIs
  ci.mat<-replicate(nsim,par.boot.ci(n,lambda))
  
  # get boostrap interval coverage probability
  cp.boot<-mean((mu>=ci.mat[1,])*(mu<=ci.mat[2,]))
  
  return(c(cp.norm,cp.boot))
  
}

# Confidence intervals computed using using large-sample and bootstrap
# first value in result is the large-sample coverage probability
# second value is the percentile bootstrap coverage probability

# > cover.probs(30,0.1,5000)
# [1] 0.9136 0.9360

# > cover.probs(5,0.01,5000)
# [1] 0.8098 0.8968

# > cover.probs(5,0.1,5000)
# [1] 0.8204 0.8970

# > cover.probs(5,1,5000)
# [1] 0.7974 0.8984

# > cover.probs(5,10,5000)
# [1] 0.8124 0.9006

#> cover.probs(10,0.01,5000)
#[1] 0.8652 0.9222

# > cover.probs(10,0.1,5000)
# [1] 0.8696 0.9152

# > cover.probs(10,1,5000)
# [1] 0.8732 0.920

# > cover.probs(10,10,5000)
# [1] 0.8748 0.9156

# > cover.probs(30,0.01,5000)
# [1] 0.9152 0.9366

# > cover.probs(30,1,5000)
# [1] 0.9166 0.9366

# > cover.probs(30,10,5000)
# [1] 0.915 0.9434

# > cover.probs(100,0.01,5000)
# [1] 0.9412 0.9442

# > cover.probs(100,0.1,5000)
# [1] 0.9368 0.9420

# > cover.probs(100,1,5000)
# [1]  0.9434 0.9476

# > cover.probs(100,10,5000)
# [1] 0.9422 0.9430