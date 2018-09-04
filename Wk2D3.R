## Day 2

# Data structures

# Numeric vectors

# The simplest data type is the numberic vector. Each element of this vector is a number.
# Simple wat ro create a vecor is to use the function c() as follows:

weight <- c(60, 72, 57, 90, 95, 72)
weight
is.vector(weight)
is.numeric(weight)

name <- c("Tom", "John", "Victor", "Ivan", "Brendan", "Andres")
names(weight) <- name

weight

mu <- mean(weight)
sigma2 <- sum((weight - mu)^2)/(length(weight)-1) # Sample variance
sigma <- sd(weight)
# sqrt(sigma2)
total <- sum(weight)
med <- median(weight)

# Operation with vectors is carried our elementwise
height <- c(1.75, 1.80, 1.65, 1.90, 1.74, 1.91)
bmi <- weight/height^2
bmi

1:3
1:3 + 1:3
1:3 * 1:3
1:3*2
1:3^2
(1:3)^2
c(2,8,9)/1:3
abs(-2:2)
sqrt(c(81,100,121))
x <- exp(1:3)
x
log(x)

# Recycling rule: Shorter vectors are recycled as often as needed until they match the length
a <- 1:3
b <- 1:2
c <- a+b
x <- c(10, 5, 3, 4, 9)
y <- c(x, x, 1)
v <- 2*x + y + 1
v

# How to create vectors
x1 <- seq(4,9)
x2 <- seq(4, 10, 2)
x2.1 <- seq(from=4, to=10, by=2)
x3 <- 4:9
x4 <- rep(x1,3)
x5 <- rep(x2, 1:4)
x6 <- c(x3,NA)
is.na(x6)

mean(x6)
mean(x6,na.rm=TRUE)

# Index vextor, selecting subsets of a data set

set.seed(pi) # the seed number you choose is the starting point used to 
z <- runif(20, min = -1, max = 1)
z1 <- z[1:10]
z2 <- z[-(1:10)] # the minus sign signifies "other than" the first 1:10 elements
z[11:20]
z2 == z[11:20]
print(min(z))
mini <- which.min(z) # where is the minimum of z?
print(mini)

x <- rep(NA,6)
x[2*(1:3)] <- (1:3)^2 # distinguishing which elements in the vector will be replaced, must be the same dimmension
x[2*(1:3)-1] <- -(1:3)^2

weight[c("Tom", "Victor")]

# Floor, ceiling and round functions
x <- c(1.3411, 4.603, 3.5)
x_round1 <- round(x)
x_round2 <- round(x,2)
x_floor <- floor(x)
x_ceiling <- ceiling()