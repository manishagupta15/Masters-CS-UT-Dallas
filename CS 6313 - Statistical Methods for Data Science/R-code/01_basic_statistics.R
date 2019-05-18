
# Read the CPU time data. Make sure you have changed directory to the folder 
# that contains these data

?read.table
?scan

cpu <- scan(file="/users/psprao/downloads/stats/datasets/cputime.txt")

# look at the first 6 elements

# > head(cpu)
# [1] 70 36 43 69 82 48
# > 

# look at the last 6 elements

# > tail(cpu)
# [1] 35 24 22  9 56 19
# > 

# look at the entire data

# > cpu
 # [1]  70  36  43  69  82  48  34  62  35  15  59 139  46  37  42  30  55  56
# [19]  36  82  38  89  54  25  35  24  22   9  56  19
# > 

# find mean

# > mean(cpu)
# [1] 48.23333
# > 

# find median

# > median(cpu)
# [1] 42.5
# >

# median using our definition

# > sort(cpu)
 # [1]   9  15  19  22  24  25  30  34  35  35  36  36  37  38  42  43  46  48
# [19]  54  55  56  56  59  62  69  70  82  82  89 139
# >

# > mean(sort(cpu)[15:16])
# [1] 42.5
# > 

# quantiles

# the quartiles 

# > quantile(cpu, type=1)
  # 0%  25%  50%  75% 100% 
   # 9   34   42   59  139 
# > quantile(cpu)
    # 0%    25%    50%    75%   100% 
  # 9.00  34.25  42.50  58.25 139.00 
# > 

# notice the discrepancy -- why?

# > quantile(cpu, prob=0.25)
  # 25% 
# 34.25 
# > quantile(cpu, prob=0.25, type=1)
# 25% 
 # 34 
# > 

# interquartile range (IQR) --- uses the default def of quantile

# > IQR(cpu)
# [1] 24
# >


quantile(cpu, prob = c(0.88, 0.99))

# checking for outlier

iqr <- IQR(cpu)
lower <- quantile(cpu, prob=0.25) - 1.5*iqr
upper <- quantile(cpu, prob=0.75) + 1.5*iqr

# > c(lower, upper)
  # 25%   75% 
# -1.75 94.25 
# > 

# differs a bit from what is given on page 223 of the text because
# of a different default definition of quantile

# variance and sd 

# > var(cpu)
# [1] 703.1506
# > sd(cpu)
# [1] 26.51699
# > 

# a set of summary statistics

# > summary(cpu)
   # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   # 9.00   34.25   42.50   48.23   58.25  139.00 
# > 


# apply a function to each column of a matrix

x <- matrix(rnorm(100), nrow = 50, ncol = 2, byrow = T)

# column means
colMeans(x)

# column means
apply(x, MAR = 2, mean)

# column summaries
apply(x, MAR = 2, summary)

# default quantiles for each column
apply(x, MAR = 2, quantile)

