# Basic Examples with R codes

## Mean and Variance method of moment

* $ g_{i}\left(\theta, y_{i}\right) = \begin{pmatrix} y_{i} - \mu \\ \left(y_{i} - \mu\right)^{2} - \sigma^{2} \end{pmatrix}, \quad \theta = \begin{pmatrix} \mu \\ \sigma \end{pmatrix}$


where $ \mu $ is the true mean of $ y_{i} $ and $ \sigma $ is the true standard deviation.

1. Generate the variable $ y_{i} $ which has $\mu = 5$ and $\sigma = 2$.
```r
library(gmm)
set.seed(123)
y <- rnorm(1000, 5,2)
```
2. Set the moment equations
```r
g1 <- function(theta, y) {
  m1 <- y - theta[1]
  m2 <- (y - theta[1])^2 - theta[2]^2
  f <- cbind(m1, m2)
  return(f)
}
```
3. Draw the gradient equations
* $ Dg = \begin{bmatrix} -1 & 0 \\ 2\left(\bar{y}_{i} - \mu\right) & -2\sigma  \end{bmatrix} $
```r
Dg <- function(theta, y) {
  G <- matrix(c(-1, -2*(mean(y) - theta[1]), 0, -2*theta[2] ), 
              nrow=2, ncol=2)
  return(G)
}
```
4. 'mm' result
```r
gmm(g1, y, c(mu=0,sigma=0), grad = Dg)

# Result: mu = 5.1484 sigma = 1.8094
```