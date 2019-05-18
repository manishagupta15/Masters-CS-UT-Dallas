
# We will continue working with the CPU data that we saw earlier

cpu <-c(70,36,43,69,82,48,34,62,35,15,59,139,46,37,42,30,5,56,36,82,38,
        89,54,25,35,24,22,9,56,19)
# Negative of log-likelihood function assuming gamma parent distribution

neg.loglik.fun <- function(par, dat)
{
	result <- sum(dgamma(dat, shape=par[1], rate=par[2], log=TRUE))
	return(-result)
	}


# Minimize -log (L), i.e., maximize log (L)

ml.est <- optim(par=c(3, 0.1), fn=neg.loglik.fun, method = "L-BFGS-B", 
lower=rep(0,2), hessian=TRUE, dat=cpu)

# > ml.est
# $par
# [1] 3.63149628 0.07529459

# $value
# [1] 136.561

# $counts
# function gradient 
      # 20       20 

# $convergence
# [1] 0

# $message
# [1] "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"

# $hessian
            # [,1]       [,2]
# [1,]    9.501374  -398.4584
# [2,] -398.458449 19223.5065

# > 

# MLE

  ml.est$par
# [1] 3.63149628 0.07529459
# > 

# their standard errors

  sqrt(diag(solve(ml.est$hessian)))
# [1] 0.89720941 0.01994668
# > 

# How well the fitted model represents the data?

# relative density histogram

hist(cpu, freq=FALSE, xlab="cpu time", ylab="density", 
			main="histogram vs fitted gamma distribution") 

# superimpose the fitted density

gamma.pdf <- function(x, shape=ml.est$par[1], rate=ml.est$par[2]) { 
	dgamma(x, shape=shape, rate=rate)
	}
	
curve(gamma.pdf, from=0, to=140, add=TRUE)



