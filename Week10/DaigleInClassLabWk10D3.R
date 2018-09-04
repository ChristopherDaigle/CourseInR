# Christopher Daigle
# Week10D3 In Class Lab - Contour Lines and 3-D Visualization

# Exercise

# Draw contour lines of an upper half of a sphere with a radius of 5 and also make image
# Hemisphere equation: z = (5 - x^2 - y^2)^(1/2)
install.packages("rgl")
curve(sqrt(5^2-x^2), from = -1, to = 1)
curve(sqrt(4^2-x^2), from = -1, to = 1, add = TRUE)

surface <- persp(x, y, z, theta = 80, phi = 30, expand = 1, col = terrain.colors(30))

# Run the following regression model and draw a graph in 3-D.
x <- runif(100, min=-1, max=1)
y <- runif(100, min=-1, max=1)
z <- 1 + x + 2 * y + rnorm(100)
# z <- function(x, y) {
#   return (1 + x + 2 * y + rnorm(100))
#   }
# lm(z~x+y)
# z[is.na(z)] <- 1
# op <- par(bg = "white")
plot(x,y)
persp(sort(x), sort(y), z)
persp(sort(x), sort(y), z, theta = 30, phi = 30, expand = 0.5, col = "lightblue")

# Tyler ####
# Draw contour lines of an upper half of a sphere with a radius of 5
x <- matrix(rep(seq(-5, 5, length = 30),30),30,30)
y <- t(x)
z <- sqrt(25-x^2-y^2)

persp(x[,1], y[1,], z, col = "lightblue", xlab="x",ylab="y", zlab="z")


# Run the following regression model and draw a graph in 3-D
x <- sort(runif(100, min=-1, max=1))
y <- sort(runif(100, min=-1, max=1))
z <- sort(1 + x + 2*y + rnorm(100))
lm(z~x+y)

install.packages("plot3D")
library("plot3D")

b <- scatter3D(x, y, z, type="l", col="blue", xlab="x", ylab="y", zlab="z", lwd=1, size=1)
b

# Present the observations on this graph using points function:
list<- trans3d(x, y, z, b)
points(list)