# Week 14 #
# Day 1 ####
# Programming a derivative

# 1. f(x) = sqrt(x) at x = 5

1 / (2 * sqrt(5))

h <- 1e-8
x <- 5

f_prime <- (sqrt(x + h) - sqrt(x)) / h

# make a function for general derivative funcation

f <- function(x) {
  f <- sqrt(x)
  return(f)
}

f_dev <- function(x, f) {
  h <- 1e-8
  f_dev <- (f(x + h) - f(x)) / h
  return(f_dev)
}

f_dev(x = 5, f = f)

# 2. Find an integral of f(x) = sqrt(x) in x = (0,5)

x <- c(0,5)
h <- 0.0000001
area <- 0
for (i in seq(from = x[1], to = x[2] - h, by = h)) {
  area <- area + h * sqrt(i)
}
area
2/3 * 5^(3/2)

# make a function for general integration f = sqrt(x)

f_int <- function(x, f) {
  h <- 1e-7
  f_int <- 0
  for (i in seq(from = x[1], to = x[2] - h, by = h)) {
    f_int <- f_int + h * sqrt(i)
  }
  return(f_int)
}

f_int(c(0,5), f = f)

# make a function for general integration f = exp(x)
exp(5)

g <- function(x) {
  g <- exp(x)
  return(g)
}
g_int <- function(x, g) {
  h <- 1e-7
  g_int <- 0
  for (i in seq(from = x[1], to = x[2] - h, by = h)) {
    g_int <- g_int + h * g(i)
  }
  return(g_int)
}

g_int(c(0,2), g = g)


# Linear Programming

# Mathematical technique for maximizinf or minimiatin a linear function of s
# example: maximize proift, minimize cost

# Optimize the value of a linear function with a set of linear constraints
# Max z = c1 *x1+...+cn*xn
# st. a1x1 + ... + anxn <d1
# b1x1 + ... + bnxn <d2
# xi is called decision variables
# solution: LP Problem is generally solved using the simplex method

#Example:
  # f(x,y) = x + y
  # s.t.
  # 2x +y =< 20, x +3y =< 20, x =>0, y =>0


install.packages('lpsolve')
library('lpsolve')

obj.fun <- c(1,1)
const <- matrix(c(2,1,1,3,1,0,0,1), ncol = 2, byrow = TRUE)
constr.dir <- c('<=', '<=', '>=', '>=')
rhs <- c(20, 20, 0, 0)

prod.sol <- lp('max', obj.fun, const, const.dir, rhs)
prod.sol$solution

# Day 2 ####
# Simulation: imitation of the opaeration of a real-world process using some model and computation

# Example: Coin tossing
# Suppose that you play a coin tossing game and want to know what the probsbility of winning is

winYou <- 0
winMin <- 0
trial <- 200

for (i in 1:trial) {
  you <- 4
  Min <- 12
  while (you > 0 & Min >0) {
    a <- sample(1:2, 1)
    if (a == 1) {
      you <- you + 1
      Min <- Min -1
    } else {
      you <- you - 1
      Min <- Min + 1
    }
  }
  if (you == 0) {
    winMin <- winMin +1
  } else {
    winYou <- winYou + 1
  }
}

print(c(winYou, winMin)/trial)

# Online Advertisement Model

# suppose we had a model about how effective online advertisement is for sales compared to TV advertisement
# We believe that if we do online advertisment instead of TV Advertisement salesOnline ~ chisq(3, unif(5, 9))
# The second parameter is noncentrality parameter which is the sum of squared means, sum(muI ^ 2)
# And if we spend that money on TV Advertistment salesTV ~ chisq(5, 1)

# Which one yields better sales?

# Answer used to be: get out your pen and paper, make some approximations
# Answer is now: simulate from the model, no approximations required!

# Simulate, supposing we have 1000 different markets

set.seed(0)
n = 1000
ncp = runif(n, 5, 9)
salesOnline = rchisq(n = n, df = 3, ncp = ncp)
salesTV = rchisq(n = n, df = 5, ncp = 1)

# Find the range of all measurements together, and define breaks
xRange = range(c(salesOnline, salesTV))
breaks = seq(min(xRange), max(xRange), length = 20)

# Produce hist of the non drug measurements then drug measurments...
hist(salesOnline, breaks = breaks, probability = TRUE, xlim = xRange, col = 'lightgray', xlab = 'Sales', main = 'Comparison of Sales', ylim = c(0, 0.15))

# Plot a hist of ..
hist(salesTV, breaks = breaks, probability = TRUE, col = rgb(1, 0, 0, 0.2), add = TRUE)
