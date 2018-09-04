# comments with pound

# quotes designate a string
"hello world"

# numbers/ints dont need quotation marks
10

# quotes are necessary for string
# hello world

# defining n as a variable equal to 10, semicolon lets us make two commands in one line
n <- 1000 ; m = 5

# generate 1000 pairs of normal variables
x <- rnorm(n, mean = 3, sd = 2)
y <- rnorm(n, mean = 2, sd = 1)

# c() is a function that combines its arguments
# create a histogram of a mixture of normal distribution with the number of bins 25
hist(c(x, y+3), breaks = 25)

# see variable names that are stored in the workspace
ls()

# remove variables
rm(n,x,y)

x <- seq(1, 20, 0.5)

# Find built in data with R: data()
# Example load, "data(mtcars)"

n <- 1000

# generate 1000 binamial random numbers with size 10
x <- rbinom(n, 10, 0.5)
# create a histogram of x
hist(x)
# view names of variables stored in workspace
ls()
# remove the variable x
rm(x)
x

#make a vector of numbers  x = (1, 1.5, ... , 20) , "seq(start, end, increment)
x <- seq(1, 20, 0.5)
x
hist(x)

a <- 2
b <- 2
# length(x) returns the number of elements in the vector x
# generate e random number with uniform distribution, mean 0 and sd of 4 (var=16)
e <- rnorm(length(x),0,4)

y <- a + b*x + e
reg <- lm(y~x)
summary(reg)

plot(x,y)
plot(reg)

reg$coefficients
reg$residuals

attach(mtcars)
lm(mpg ~ cyl + wt)
detach(mtcars)
lm(mtcars$mpg ~ mtcars$cyl + mtcars$wt)
attach(mtcars)

plot(x,y)
# abline generates a line based on the lm, lty is the line type, like dotted or solid, and col is the color of the line
abline(a,b, lty=3, col=3) # add in the true regression line
abline(reg, lty = 1, col=4) # add in the estimated regression line
?abline

x2 <- seq(1, 8, 0.05)
e2 <- rnorm(length(x2), 0, 0.5)
y2 <- a + b*sin(x2) + e2
plot(x2,y2)

# run a local polynomial regression
lpr <- loess(y2~x2)
#add the local regression curve
lines(x2, fitted(lpr), col = 2)

rm(list=ls())