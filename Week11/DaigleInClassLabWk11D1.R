# Christopher Daigle
# Week11D1 In Class Lab - Contour Lines and 3-D Visualization

# Exercise:

# Draw contour lines of an upper half of a sphere with a radius of 5 and also make image
x <- matrix(rep(seq(-5, 5, length = 100), 100), 100, 100)
y <- t(x)

zsq <- (5^2 - x^2 - y^2)*(5^2 - x^2 - y^2 > 0)
z <- sqrt(zsq)
z[z == 0] <- NA

persp(x[,1], y[1,], z, theta = 0, phi = 0, expand = 1, col = "lightblue")
image(z, col = terrain.colors(10))
contour(z, add = TRUE)

# Run the following regression model and draw a graph in 3-D.
x <- runif(100, min=-1, max=1)
y <- runif(100, min=-1, max=1)
z <- 1 + x + 2 * y + rnorm(100)
reg <- lm(z ~ x + y)
z[z == 0] <- NA

x1 <- matrix(rep(seq(-1, 1, length = 10), 10), 10, 10)
y1 <- t(x1)
zhat <- reg$coefficients[1] + reg$coefficients[2]*x1 + reg$coefficients[3]*y1

surface <- persp(x1[,1], y1[1,], zhat, theta = 0, phi = 0, expand = 1, col = terrain.colors(10))

# Present the observations on this graph showing the points

xy.list <- trans3d(x, y, z, surface)
points(xy.list, pch = 20, col = heat.colors(10))