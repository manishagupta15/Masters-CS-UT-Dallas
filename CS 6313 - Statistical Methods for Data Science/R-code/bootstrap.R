library(boot)

cpu <- c(70 , 36 , 43,  69 , 82 , 48,  34 , 62,  35,  15 , 59 ,139,
46 , 37 , 42  ,30 , 55  ,56 ,36 , 82,  38,  89,  54,  25,  35,  24,22,9,56,19)
#################
#Non parametric bootstrap
#########################
median.npar <- function(x,indices)
{
  result<-median(x[indices])
  return (result)
}

(median.npar.boot<-boot(cpu,median.npar,R=999,sim="ordinary",stype="i"))

names(median.npar.boot)

# > median(cpu)
# 40

# > median.npar.boot$t0
# 40

# mean(median.npar.boot$t)-median.npar.boot$t0
# 0.961962