# Plotting a heatmap: Graphical representation of data to visualize different values.
# To plot a heatmap of a numeric matrix, use image()
# heat.colors(), topo.colors(), etc: create a color vector
# contour(): draw contours, or add to existing plot
# curve(): draw a curve, or add to existing plot

mat = 1:5 %*% t(6:10) 
image(mat) # Red means low, white means high

# The orientation of image() is to plot the heatmap according to the following order, in terms of the matrix elements:

# (1,ncol)  (2,ncol) ... (nrow,ncol)
#    
# (1,2)     (2,2)    ...  (nrow,2)
# (1,1)     (2,1)    ...  (nrow,1)

a <- seq(0,1, length=5)
a_mat <- matrix(rep(a,length(a)),length(a),length(a))
text(a_mat,t(a_mat), mat)

#  To have the "usual" order for the matrix, reverse the row order and take the transpose
image(t(mat[nrow(mat):1,]))

# Color scaled
# The default is to use a red-to-white color scale in image(). But the col argument can take any vector of colors. 
# Built-in functions gray.colors(), rainbow(), heat.colors(), topo.colors(), terrain.colors(), cm.colors() all return 
# continguous color vectors of given length

phi = dnorm(seq(-2,6,length=50)) + dnorm(seq(-2,6,length=50), mean=4, sd=1)
plot(phi, type="l")
normal.mat = phi %*% t(phi)
image(normal.mat) # Default is col=heat.colors(12)

image(normal.mat, col=heat.colors(50)) # More colors
?heat.colors
image(normal.mat, col=heat.colors(3)) # More colors

image(normal.mat, col=terrain.colors(12)) # Terrain colors
image(normal.mat, col=topo.colors(12)) # Topological colors

# Drawing contour lines

# To draw contour lines from a numeric matrix, use contour(); to add contours to an existing plot (like, a heatmap), 
# use contour() with add=TRUE

contour(normal.mat, col = 1:3)

image(normal.mat, col=terrain.colors(20))
contour(normal.mat, add=TRUE)

# Draw a map

install.packages("mapproj")
install.packages("ggmap")
install.packages("DeducerSpatial")

library(maps)
library(ggmap)
data()
state.fips 

map("usa")

map("county")

map("state", "GEORGIA")
data(us.cities)
map.cities(us.cities, country = "GA")

# Plot the unemployment rate in each county

data(unemp)
data(county.fips)

# Plot unemployment by country
colors = c("slateblue", "slateblue1", "slateblue2", "slateblue3", "slateblue4") 
head(unemp)
head(county.fips)

unemp$colorBuckets <- as.numeric(cut(unemp$unemp, c(0, 2.5, 5, 7.5, 10, 100))) 
# match returns a vector of the positions of (first) matches of its first argument in its second.
colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)] 
a <- c(2,3,5,1,3)
b <- 0:4
match(a,b)

map("county", col = colors[colorsmatched], fill = TRUE, resolution = 1, 
    lty = 0, projection = "polyconic")    # projection specifies the shape of the map. Also try "lagrange" and "aitoff"

library(mapproj)
# Add border around each State
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1, lwd = 0.2, 
    projection = "polyconic")
title("unemployment rate by county, 2009")

leg.txt <- c("<2.5%", "2.5-5%", "5-7.5%", "7.5-10%", ">10%")
legend("topright", leg.txt, horiz = TRUE, fill = colors)

# Drawing a curve
# To draw a curve of a function, use curve()

curve(x^3) # Default is to plot between 0 and 1. 
curve(x^3, from=-3, to=3, lwd=3, col="red") # More plotting options

n = 100
set.seed(0)
x = sort(runif(n, min=-2, max=2))
y = x^3 + rnorm(n)

plot(x, y)
curve(x^3, lwd=3, col="red", add=TRUE)
z <- loess(y~x)
lines(x,fitted(z), lwd=3, lty=2, col="blue")
legend("bottomright", c("true", "local"), horiz=TRUE, col=c("red", "blue"), lwd=3, lty=c(1,2))

x <- matrix(rep(seq(-10, 10, length= 30),30),30,30)
y <- t(x)
f <- function(x, y) { r <- sqrt(x^2+y^2); return(10 * sin(r)/r) }
f <- function(x, y) { r <- sqrt((100-x^2-y^2)*(100-x^2+-y^2>0)) }
z <- f(x,y)
# z[is.na(z)] <- 1
persp(x[,1], y[1,], z, theta = 10, phi = -10, expand = 0.5, col = "lightblue", xlim=c(-10,10), ylim=c(-10,10), xlab="x",
      ylab="y", zlab="z")

z <- x^3 + y^3
surface <- persp(x[,1], y[1,], z, theta = 80, phi = 30, expand = 1, col = terrain.colors(30))
?terrain.colors

n = 200
x1 = runif(n, -10, 10)
y1 = runif(n, -10, 10)
z1 = x1^3 + y1^3 + 10*rnorm(n)

xy.list = trans3d(x1, y1, z1, surface)
points(xy.list, pch=20, col=heat.colors(10))

# Exercise

# Draw contour lines of an upper half of a sphere with a radius of 5 and also make image



# Run the following regression model and draw a graph in 3-D.
x <- runif(100, min=-1, max=1)
y <- runif(100, min=-1, max=1)
z <- 1 + x + 2 * y + rnorm(100)
lm(z~x+y)





