# GMM practice
# install.packages("gmm")
# ---------------------------------
library(gmm)

# Generate data
set.seed(123)
y <- rnorm(300, 5,2)

# Define the moment conditions
g1 <- function(theta, y) {
  m1 <- y - theta[1]
  m2 <- (y - theta[1])^2 - theta[2]^2
  f <- cbind(m1, m2)
  return(f)
}
# Define the gradient of the moment conditions
Dg <- function(theta, y) {
  G <- matrix(c(-1, -2*(mean(y) - theta[1]), 0, -2*theta[2] ), 
              nrow=2, ncol=2)
  return(G)
}
# Estimate the model
print(res <- gmm(g1, y, c(mu=0,sigma=0), grad = Dg))