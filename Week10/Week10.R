# Week 10 ####
# Day 1 ####

# Plotting in R

# plot(): generic plotting function
# points(): add points to an existing plot
# lines(), abline(): add lines to an existing plot
# text(), legend(): add text to an existing plot

# To make a scatter plot of one variable versus another, use plot()
n <- 50
set.seed(0)
x <- sort(runif(n, min = -2, max = 2))
y <- x ^ 3 + rnorm(n)
plot(x,y) # the label is defaulted to the variable name

# The type argument controls the plot type. Default is "p" for points; set it to "l" for lines
plot(x, y, type = "p")
plot(x, y, type = "l")

# Try also "b" or "o", for both points and lines
plot(x, y, type = "b")
plot(x, y, type = "o")

# Labels
# The ain argument controls the title; xlab and ylab are the x and y labels
plot(x, y, main = "A Noisy Cubic")
plot(x, y, type = "o", main = "A Noisy Cubic",  xlab = "My X Variable", ylab = "My Y Variable")

# Point type
# Use the pch argument to control point
plot(x, y, pch= 20) # empty circles by default, "pch" = point characterstic ( the style of the points on the graph)
plot(x, y, pch = "a")
# Try 20 for small filled circles, or "." for single pixels
?pch

# Line type
# USe lty argument to control the line type, and lwd to control the line width
plot(x, y, type = 'l', lty = 1, lwd = 1) # solid line with  default width
?par

# Color
# Use the col arg to control the color
# Can be: an integer between 1 & 8 for vasic colors
# Or: a string for any of the 657 avaialbe named colts

colors()

plot(x,y, pch = 1, col = 1)
plot(x, y, pch = 19, col = 2:4) #recycling rule applies to color

# Multiple Plots
# To compbine multiple plots into one overall graph, use the par() function with the 
par(mfrow = c(2,2)) # filled by row, first arg = # row, second arg = # col
plot(x, y, main = "Red Cubic", pch = 20, col = "red")
plot(x, y, main = "Blue Cubic", pch = 20, col = "blue")
plot(rev(x), y, main = "Flipped Green", pch = 20, col = "green")
plot(rev(x), y, main = "Flipped Purple", pch = 20, col = "purple")


par(mfrow = c(2,2), mar = c(1, 4, 2, 0.5)) # bottom, left, top, right
plot(x, y, main = "Red Cubic", pch = 20, col = "red")
plot(x, y, main = "Blue Cubic", pch = 20, col = "blue")
plot(rev(x), y, main = "Flipped Green", pch = 20, col = "green")
plot(rev(x), y, main = "Flipped Purple", pch = 20, col = "purple")

# Saving
# use the pdf() function to sae a pdf file of your plot in your r working directory
# use getwd() to get the wd and setwd() to set the wd
getwd()
pdf(file = "noisy_cubics.pdf", height = 7, width = 7) # Height width are in inches
par(mfrow = c(2,2), mar = c(1, 4, 2, 0.5))
plot(x, y, main = "Red Cubic", pch = 20, col = "red")
plot(x, y, main = "Blue Cubic", pch = 20, col = "blue")
plot(rev(x), y, main = "Flipped Green", pch = 20, col = "green")
plot(rev(x), y, main = "Flipped Purple", pch = 20, col = "purple")

par(mfrow = c(1,1))
plot(rev(x), y, main = "Flipped Purple", pch = 20, col = "purple")

graphics.off

# Also, use the jpg() and png() functions to save jpg and png files

# adding to plots: You will do this job in exercise

# The main tools for this are
# points(): add points to an existing plot
# lines(), abline(): add lines to an existing plot
# text(), legend(): add text to an existing plot

# Day 2 ####

setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/")

dataSet <- read.csv("county_data.csv", stringsAsFactors = FALSE)

head(dataSet)
str(dataSet)

data1 <- dataSet[1:111,]

dataState <- factor(data1$State, levels = c("Alabama", "Alaska", "Arizona"))
summary(dataState)

table(dataState)

plot(dataState) # If plot() function is used for a single factor
title(main = "Number of County'")

plot(dataState, data1$IncomePerCap, range = 1, las = 1)
boxplot(data1$IncomePerCap ~ dataState, range = 1, las = 2)

big <- NA
big[data1$TotalPop > 70000] <- "big"
big[data1$TotalPop <= 70000] <- "small"

par(mar = c(6, 4, 2, 1)) # bottom, left, up, right
boxplot(data1$IncomePerCap ~ big*dataState, col = c("blue", "red"), main = "Income per Cap")

plot(data1[,3:ncol(data1)])
pairs(data1[,3:ncol(data1)])

# highlight outliers

data2 <-dataSet[dataSet$State == "California",]
plot(data2$TotalPop)
index1 <- which(data2$TotalPop > 10 ^ 6)
abline(h = 10 ^ 6, lty = 2)
points(index1, data2$TotalPop[index1], pch = 16, col = "red")

index2 <- which(data2$TotalPop > 2 * 10^5 & data2$TotalPop < 10^6)
abline(h = 2 * 10^5, lty = 2)
points(index2, data2$TotalPop[index2], pch = 16, col = "blue")

text(c(index1,index2),data2$TotalPop[c(index1,index2)], labels = data2$County[c(index1,index2)], cex=0.8)

# Adding a straight line on a plot
propotion <- data1$Women / data1$TotalPop
plot(propotion, data1$Unemployment, pch = 20, xlab = "women/totalPop", ylab = "unempRate")
linearFit <- lm(data1$Unemployment ~ propotion)
abline(linearFit, lwd = 3, col = "red")

linearFit
# You can aslo specify the coefficient directly to use abline()
abline(a = -3, b = 30, lwd = 3, col = "blue")

plot(proportion, data1$Unemployment, pch = 20, xlab = "women/totalPop", ylab = "unempRate")
abline(v = 0.5, col = "red", lwd = 3, lty = 2)
abline(h = 15, col = "blue", lwd = 3, lty = 1)

# hist(), image(): histogram and heatmap
# heat.colors(), topo.colors(), etc: create a color vector
# density(): estimate density, which can be plotted

# Plotting a histogram
# To plot a histogram of a numberic vector, use hist()

aveIncome <- dataSet$IncomePerCap
hist(aveIncome)

# Histogram options
# Several options are available as arguments to hist(), such as col, frew
# breaks, xlab, ylab, main

hist(aveIncome, col = "pink", freq = TRUE) # Frequency scale, defualt

hist(aveIncome, col = "pink", freq = FALSE, breaks = seq(0, 70000, by = 10000), xlab = "incomePerCap", main = "County level Avg IncomePerCap")

hist(aveIncome, col = "pink", freq = FALSE, breaks = seq(0, 70000, by = 50), xlab = "incomePerCap", main = "County level Avg IncomePerCap")

hist(aveIncome, col = "pink", freq = FALSE, breaks = seq(0, 90000, by = 2000), xlab = "incomePerCap", main = "County level Avg IncomePerCap")

# ASIDE:
# Add a Normal Curve (Thanks to Peter Dalgaard)
# x <- mtcars$mpg 
# h<-hist(x, breaks=10, col="red", xlab="Miles Per Gallon", 
#         main="Histogram with Normal Curve") 
# xfit<-seq(min(x),max(x),length=40) 
# yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
# yfit <- yfit*diff(h$mids[1:2])*length(x) 
# lines(xfit, yfit, col="blue", lwd=2)

hist(aveIncome + 20000, col = rgb(0.0,0.5,0.5,0.2), freq = FALSE, breaks = seq(0, 90000, by = 2000), add = TRUE)

# Adding a desnity curve to a histogram

# To estimate a desntity fro ma numeric vector, use density()
# This returns a list: it has components x and y, so we can actually call lines() directly on the returned object

densityEst <- density(aveIncome, adjust = 1) # 1.5 times the default bandwidth

hist(aveIncome, col = "pink", freq = FALSE, # probability scale, and more options
     breaks = seq(0, 70000, by = 2000), xlab = "incomePerCap", main = "County level AvgIncomePerCap")

lines(densityEst, lwd = 3)
polygon(densityEst, col = rgb(0.5, 0.8, 0.5, 0.5), border = "blue")

# Day 3 ####

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