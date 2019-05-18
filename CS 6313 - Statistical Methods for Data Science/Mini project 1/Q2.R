###########################################################
# R Code for problem 2
###########################################################


# Compute the approximate value of pi using Monte Carlo Simulations
# We write a function approxpi(), which uses the 
# concept of a circle of radius 0.5 with centre at (0.5,0.5) 
# circumscribed in a square of unit length with vertices at 
# (0,0), (0,1), (1,0) and (1,1).

approxpi <- function(){
  
  # Generate 10,000 draws for x-coordinate of point inside unit square
  x = runif(10000)
  
  # Generate 10,000 draws for y-coordinate of point inside unit square
  y = runif(10000)
  
  #Computing distance of the point from the centre (0.5, 0.5)
  x = sqrt((x-0.5)^2 + (y-0.5)^2)
  
  # Finding the number of points which fall inside the circle
  sum(x<=0.5)/10000*4
  
}


# > approxpi()

# [1] 3.1404