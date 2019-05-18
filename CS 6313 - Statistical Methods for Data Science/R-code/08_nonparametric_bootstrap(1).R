

# use install.packages("boot") to first install 
# the package and then load it

library(boot)

# read the cpu data (we have seen these before)

cpu <- scan(file="cputime.txt")

# > head(cpu)
# [1] 70 36 43 69 82 48
# > 

# Parameter of interest: Median

###########################
# Nonparametric Bootstrap #
###########################

median.npar <- function(x, indices) {
  result <- median(x[indices])
  return(result)
  }


set.seed(1234)

median.npar.boot <- boot(cpu, median.npar, R=999, sim="ordinary", stype="i")


# > median.npar.boot

# ORDINARY NONPARAMETRIC BOOTSTRAP


# Call:
# boot(data = cpu, statistic = median.npar, R = 999, sim = "ordinary", 
    # stype = "i")


# Bootstrap Statistics :
    # original    bias    std. error
# t1*     42.5 0.5600601    5.828451
# > 

# Let's verify the calculations

# See what's else is stored in median.npar.boot

# > names(median.npar.boot)
 # [1] "t0"        "t"         "R"         "data"      "seed"      "statistic"
 # [7] "sim"       "call"      "stype"     "strata"    "weights"  
# > 

# > median(cpu)
# [1] 42.5
# >


# # > median.npar.boot$t0
# [1] 42.5
# > 


# > mean(median.npar.boot$t)-median.npar.boot$t0
# [1] 0.5600601
# > 

# > sd(median.npar.boot$t)
# [1] 5.828451
# > 

# See the bootstrap distribution of median estimate

plot(median.npar.boot)

# Get the 95% confidence interval for median

# > boot.ci(median.npar.boot)
# BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
# Based on 999 bootstrap replicates

# CALL : 
# boot.ci(boot.out = median.npar.boot)

# Intervals : 
# Level      Normal              Basic         
# 95%   (30.52, 53.36 )   (29.50, 49.50 )  

# Level     Percentile            BCa          
# 95%   (35.5, 55.5 )   (35.5, 55.5 )  
# Calculations and Intervals on Original Scale
# Warning message:
# In boot.ci(median.npar.boot) :
  # bootstrap variances needed for studentized intervals
# > 


# Let's verify 

# Normal approximation method

# > c(42.5 - 0.5600601 - qnorm(0.975) * 5.828451, 
    # 42.5 - 0.5600601 - qnorm(0.025) * 5.828451)
# [1] 30.51639 53.36349
# > 

# Percentile bootstrap method

# > sort(median.npar.boot$t)[c(25, 975)]
# [1] 35.5 55.5
# > 

# Basic bootstrap method

# > c(2*42.5-55.5, 2*42.5-35.5)
# [1] 29.5 49.5
# > 

