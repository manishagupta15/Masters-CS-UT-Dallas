
# Input the data

time.attack <- c(0.49, 0.50, 0.11, 0.09, 0.05, 0.75, 0.34, 0.04, 0.26, 0.16)

# Function to numerically compute mean of exponential distribution 

exp.mean <- function(lambda){ 
	fun <- function(x){x*dexp(x, rate=lambda)}
	result <- integrate(fun, lower=0, upper=Inf)
	return(result$value)}
	
# Equation whose solution is MOME

mome.eqn <- function(lambda, dat=time.attack) {exp.mean(lambda)-mean(dat)}

# Solve this equation to get MOME

result <- uniroot(mome.eqn, lower=1, upper=5, dat=time.attack)

# > result
# $root
# [1] 3.584233

# $f.root
# [1] -2.579698e-07

# $iter
# [1] 7

# $estim.prec
# [1] 6.103516e-05
# > 

# Already know that the answer should be:

# > 1/mean(time.attack)
# [1] 3.584229
# > 

# Note: In this example, it is much easier to get MOME directly rather than numerically. 