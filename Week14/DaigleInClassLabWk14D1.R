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

# Prof. Kim Solution
vol <- 0
h <- 0.001
for (i in seq( from = -1 + h, to = 1, by = h)) { # this is the x portion
  for (j in seq(from = -sqrt(1 - (i - h) ^ 2), to = sqrt(1 - i ^ 2), by = h)) { # this is the 'y' portion, h^2 is 'z'
    vol <- vol + h ^ 2 * sqrt(max(1 - i ^ 2 - j ^ 2, 0))
  }
}

# 3. Find maximizer of the following
# Suppose that we allocate our budget between online and TV advertisements to maximize revenue
# (1) The effects on revenue for each advertisement is $200 and $600
# (2) The cost 1 for each advertisement is $150 and $100 and total expense for this cannot be more than $10000.
# (3) The cost 2 for each advertisement is $50 and $300 and total expense for this cannot be more than $10000.
# (4) At least we should have 95 advertisements in total.

# I interpret this as two scenarios: cost 1 and cost 2 scenario

library('lpSolve')
#Scenario 1:
# maxπ = 200X+600Y - 150X - 100Y = 50X+500Y
# s.t.
# 150X + 100Y <= 10,000
# X + Y >= 95

obj.fun <- c(50, 500)
const <- matrix(c(150, 100, 1, 1), ncol = 2, byrow = TRUE)
const.dir <- c('<=', '>=')
rhs <- c(10000, 95)

Scenario1 <- lp('max', obj.fun, const, const.dir, rhs)
Scenario1$solution
#
# Scenario 2:
# maxπ = 200X+600Y - 50X - 300Y = 150X+300Y
# s.t.
# 50X + 300Y <= 10,000
# X + Y >= 95
obj.fun <- c(150, 300)
const <- matrix(c(50, 300, 1, 1), ncol = 2, byrow = TRUE)
const.dir <- c('<=', '>=')
rhs <- c(10000, 95)

Scenario2 <- lp('max', obj.fun, const, const.dir, rhs)
Scenario2$solution

# Prof Kim Solution

obj.fun <- c(200, 600)
const <- matrix(c(150, 100, 50, 300, 1, 0, 0, 1), col = 2, byrow = TRUE)