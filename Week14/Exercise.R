# Chris Daigle
# Week 14 D1 In Class Lab

# 1. Take a derivative of the cdf of N(2, 2^2) at x = 0
# pnorm(x, mean, sd, ...) is the cdf of normal
f <- function(x) {
  f <- pnorm(x, mean = 2, sd = 4)
  return(f)
}

f_dev <- function(x, f) {
  h <- 1e-8
  f_dev <- (f(x + h) - f(x)) / h
  return(f_dev)
}

f_dev(x = 0, f = f)

# 2. Calculate the volume of half sphere with a radius of 1.
# General form: int_{a}^{b} pi*sqrt(r^2-x^2)dx = 4*pi((r^3)/3)

x <- c(0,1) # for half and not the whole, if whole, c(-1,1)
h <- 0.0000001
r <- 1

s <- function(r,x) {
  return(pi*((r ^ 2) - (x ^ 2)))
}

sphere <- function(x, s, h) {
  volume <- 0
  for (i in seq(from = x[1], to = x[2] - h, by = h)) {
    volume <- volume + h*s(r,i)
  }
  return(volume)
}
sphere(x, s, h)
# Check
(1/2)*(4*pi*((r^2)/3))

# 3. Find maximizer of the following
# Suppose that we allocate our budget between online and TV advertisements to maximize revenue
# (1) The effects on revenue for each advertisement is $200 and $600
# (2) The cost 1 for each advertisement is $150 and $100 and total expense for this cannot be more than $10000.
# (3) The cost 2 for each advertisement is $50 and $300 and total expense for this cannot be more than $10000.
# (4) At least we should have 95 advertisements in total.