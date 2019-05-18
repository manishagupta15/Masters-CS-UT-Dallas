#################################################
# R Code for Question 1
#################################################


compare.est<-function(n,theta,nsim)
{
  # Getting the data
  data <- replicate(nsim,runif(n,0,theta))
  
  # Maximum likelihood estimation
  # Generate a vector of length n from the uniform distribution in the interval (0,theta). Take 
  # the mean. Replicate for rep times
  if(NCOL(data)!=1)
    {
    mle.est <- apply(data,2,max)
  }
  else
  {
    mle.est<-data
  }
  
  # Find the mean squared error
  result1 <- sum((mle.est-theta)^2)/nsim
  
  
  
  # Method of moments
  # Generate a vector from the uniform distribution in the interval (0,theta). Take 
  # the mean times 2. Replicate for rep times
  if(NCOL(data)!=1)
  {
    mom.est <- apply(data,2,mean)
  }
  else
  {
    mom.est<-2*data
  }
  # Find the mean squared error
  result2 <- sum((mom.est-theta)^2)/nsim
  
  
  # Return both the result
  return(c(result1,result2))
}

# Part (b): 
# Simulate for a given combination (n,theta)
# Let n=5, theta=50,rep=1000

# > compare.est(5,50,1000)
# [1] 117.6610 663.7483

# Part(c)
# Repeat the above step for all remaining combinations of (n,theta)

# > compare.est(1,1,1000)
# [1] 0.339195 0.320539

# > compare.est(1,5,1000)
# [1] 7.703114 7.841863

# > compare.est(1,50,1000)
# [1] 811.1820 816.5786

# > compare.est(1,100,1000)
# [1] 3311.070 3265.399

# > compare.est(2,1,1000)
# [1] 0.1621363 0.2893060

# > compare.est(2,5,1000)
# [1] 4.434155 7.506875

# > compare.est(2,50,1000)
# [1] 419.0197 734.2253

# > compare.est(2,100,1000)
# [1] 1784.770 3041.526

# > compare.est(3,1,1000)
# [1] 0.09695403 0.27582063

# > compare.est(3,5,1000)
# [1] 2.431108 6.867733

# > compare.est(3,50,1000)
# [1] 262.1221 689.8118

# > compare.est(3,100,1000)
# [1] 921.4235 2687.4609

# > compare.est(5,1,1000)
# [1] 0.05210957 0.27065755

# > compare.est(5,5,1000)
# [1] 1.160537 6.642441

# > compare.est(5,50,1000)
# [1] 120.4905 674.0310

# > compare.est(5,100,1000)
# [1] 462.295 2630.757

# > compare.est(10,1,1000)
# [1] 0.01460649 0.25359251

# > compare.est(10,5,1000)
# [1] 0.4167772 6.5436014

# > compare.est(10,50,1000)
# [1]  35.15594 641.09682

# > compare.est(10,100,1000)
# [1] 155.2607 2572.9569

# > compare.est(30,1,1000)
# [1] 0.001593959 0.252542160

# > compare.est(30,5,1000)
# [1] 0.04953917 6.23571907

# > compare.est(30,50,1000)
# [1] 4.541694 634.189762

# > compare.est(30,100,1000)
# [1] 20.21065 2516.58880


# Plotting graphs for error of MLE estimator vs sample size
par(mfrow=c(2,2))

n<-c(1,2,3,5,10,30)

t1<-c(0.339195,0.1621363,0.09695403,0.05210957,0.01460649,0.001593959)
t5<-c(7.703114,4.434155,2.431108,1.160537,0.4167772,0.04953917)
t50<-c(811.1820,419.0197,262.1221,120.4905,35.15594,4.5416940)
t100<-c(3311.070,1784.770,921.4235,462.295,155.2607,20.21065)

plot(n,t1,xlab="sample size", ylab="Error", main="MLE Error vs n (theta=1)" )
plot(n,t5 ,xlab="sample size",ylab="Error", main="MLE Error vs n (theta=5)")
plot(n,t50 ,xlab="sample size",ylab="Error", main="MLE Error vs n (theta=50)")
plot(n,t100 ,xlab="sample size",ylab="Error", main="MLE Error vs n (theta=100)")



# Plotting graphs for error of MLE estimator vs theta
par(mfrow=c(2,2))
t<-c(1,5,50,100)

n1<-c(0.339195,7.703114,811.1820,3311.070)
n5<-c(0.05210957,1.160537,120.4905,462.295)
n10<-c(0.01460649,0.4167772,35.15594,155.2607)
n30<-c(0.001593959,0.04953917,4.541694,20.21065)

plot(t,n1 ,xlab="theta",ylab="Error", main="MLE Error vs theta (n=1)")
plot(t,n5 ,xlab="theta",ylab="Error", main="MLE Error vs theta (n=5)")
plot(t,n10 ,xlab="theta",ylab="Error", main="MLE Error vs theta (n=10)")
plot(t,n30 ,xlab="theta",ylab="Error", main="MLE Error vs theta (n=30)")
