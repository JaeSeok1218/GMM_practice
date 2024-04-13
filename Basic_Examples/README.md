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
3. Derive the gradient matrix
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

## OLS
* $g_{i}(\theta, x_{i}) = \begin{pmatrix} x_{i}\left(y_{i} - x^{T}_{i}\beta \right) \\ (y_{i} - x_{i}^{T}\beta)^{2} - \sigma^{2} \end{pmatrix}, \quad \theta = \begin{pmatrix} \beta \\ \sigma \end{pmatrix} $

where $ x_{i} $ is n by 1 matrix without a constant.

1. Generate variable $ x_{i} $ and $ y_{i} $
```r
# Generate
set.seed(123)
n <- 1000
x <- rnorm(n,0,1)
truebeta <- 2
y <- x*truebeta + rnorm(n,0,1)
```

2. Set the moment equations
```r
g <- function(theta, x) {
  m1 <- x*(y-x*theta[1])
  m2 <- (y-x*theta[1])^2 - (theta[2])^2
  f <- cbind(m1, m2)
  return(f)
}
```

3. Derive the gradient matrix
```r
Dg <- function(theta, x) {
  G <- matrix(
    c(mean(-t(x)%*%x), 0, -2*mean(t(x)%*%(y-x*theta[1])), -2*theta[2]), nrow=2, ncol=2
  )
  return(G)
}
```
4.'mm' result
```r
print(res <- gmm(g, x, c(beta=0, sigma=0), grad = Dg))

# Result: beta = 2.0889 sigma = 1.0060
```