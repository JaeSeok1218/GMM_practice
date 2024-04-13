# GMM practice 2
library(gmm)
#--------------------------------

# OLS by gmm package
#--------------------------------
# Generate
set.seed(123)
n <- 1000
x <- rnorm(n,0,1)
truebeta <- 2
y <- x*truebeta + rnorm(n,0,1)

# Define moment condition for OLS and Variance
g <- function(theta, x) {
  m1 <- x*(y-x*theta[1])
  m2 <- (y-x*theta[1])^2 - (theta[2])^2
  f <- cbind(m1, m2)
  return(f)
}

# Define gradient of g
Dg <- function(theta, x) {
  G <- matrix(
    c(mean(-t(x)%*%x), 0, -2*mean(t(x)%*%(y-x*theta[1])), -2*theta[2]), nrow=2, ncol=2
  )
  return(G)
}

print(res <- gmm(g, x, c(beta=0, sigma=0), grad = Dg))