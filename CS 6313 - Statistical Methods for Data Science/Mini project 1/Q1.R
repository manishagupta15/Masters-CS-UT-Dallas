###########################################################
#R Code for problem 1
###########################################################

# Problem 1 (b)
# part (i) : Simulate a draw of Xa, Xb and T

simulatedraw <- function(){
  
  # Simulate a draw of Xa using the function Xa = -10 ln (1-U)
  #Xa = (-10) * 2.303 * log10(1 - runif(1)) 
  
  # Print the value of the draw
  print(Xa)
  
  # Simulate a draw of Xb using the function Xb = -10ln(1-U)
  Xb = (-10) * 2.303 * log10(1 - runif(1)) 
  
  # Print the value of the draw
  print(Xb)
  
  # Simulate the draw of T using the above values of Xa and Xb
  print(Xa+Xb)
  
}

  
# > simulatedraw()
# [1] 3.821385
# [1] 17.6624
# [1] 21.48379


# Part (ii) Replicate the draw in part (a) for 10,000 times and 
#store the results

getdraw <- function(n){
  
  # Store the values of T in the variable t
  t <- replicate(n, (-10) * (2.303) * log10(1 - runif(1)) +
                   (2.303) * log10(1 - runif(1)) * (-10))
  
  return (t)
  
}


  
# > getdraw(10000)

# [1] 10.0029291 13.0884744 20.1432919  7.9062688 13.7474493
# [6]  3.2303715  3.1979952 14.0537767 36.2692867 14.9240531
# [11] 63.3234714 16.0721903 20.3507367  0.8239364 27.7695047
# [16] 45.9597216 18.7721382  9.4141846 10.4780209 49.1960118
# [21]  2.3129311 14.7745887 12.8468813 25.9557017 14.9179431
...
...
...


# Part (iii) : Draw a histogram and a add curve for the exponential 
# density function
# We call the following commands:

 t = getdraw(10000)
 hist(t, probability = TRUE, col = gray(.9), main = "Satellite Lifetime")
 curve( dexp(x,0.1), add = T )
 
 
# Part (iv) : Estimate the value of E(T)
 
# > m = getdraw(10000)
# > mean(m)
 
# [1] 19.99373
 
# Part (v) : Estimate the probability that the lifetime of the
# satellite exceeds 15 years i.e. P(T>15)
 
# > m = getdraw(10000)
# > sum(m>15)/10000
 
 # [1] 0.5532
 
 
# Part (vi): Simulating 10,000 draws for 4 times
# We add another paramter k to our getdraw(n) function
# and write a new function getdraw (n, k)
 
getdraws <- function(n,k){
   
   # Getting n draws for k times
   t <- replicate(k, (-10) * (2.303) * log10(1 - runif(n)) +
                    (2.303) * log10(1 - runif(n)) * (-10))
   
   # Finding the mean value in each column of the result         
   m <- apply(t,2,mean)
   
   # Finding the probability of T>15 in each column of the result
   p  <- apply(t,2,function(x) sum(x>15)/sum(x>=0))
   
   # Combining the mean and probability results
   result <- cbind(m,p)
   
   # Naming the columns
   colnames(result) <- c("E(T)","P(T>15)")
   
   return (result)
   
 }
 
# We simply call getdraw(10000,4):
 
# > getdraws(10000,4)
 
#       E(T)   P(T>15)
# [1,] 20.18618  0.5636
# [2,] 20.10753  0.5632
# [3,] 20.00512  0.5580
# [4,] 19.95078  0.5566
 
 
# Problem 1, Part (c) : Monte Carlo replications for k=5 times using
# n=1000 and	n=100000, where n is the number of draws taken
 
# > getdraws (1000, 5)
 
#       E(T)  	 P(T>15)
# [1,] 19.29913   0.541
# [2,] 20.48910   0.568
# [3,] 19.83506   0.548
# [4,] 19.79278   0.557
# [5,] 20.22468   0.543 
 
# > getdraw (100000, 5)
 
#       E(T)   	P(T>15)
# [1,] 20.10833 0.56098
# [2,] 19.95363 0.55437
# [3,] 19.97778 0.55673
# [4,] 20.02585 0.55765
# [5,] 19.96851 0.55651