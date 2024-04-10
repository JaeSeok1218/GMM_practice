# Generalized Method of Moments Practice

I will introduce the **generalized method of moments** briefly and share R codes to enhance the understanding of GMM.

## Momoments Equation
Define the moment equations:

$ E\left[g_{i}\left(\beta \right) \right] = 0 $ or $ E\left[ g\left(\theta_{0}, x_{i} \right)\right] = 0 $
where $ \beta $ and $ \theta_{0} $ is a vector of parameters.

## Method of Moments Estimators
If the number of the equations, $ p $, and the parameters, $ k $, are the same, we can simply set the moment condition as following:

$ E\left[g_{i}\left(\beta\right)\right] = \bar{g}\left(\beta\right) = \displaystyle\frac{1}{N}\sum_{i=1}^{N}g_{i}\left(\beta\right) $