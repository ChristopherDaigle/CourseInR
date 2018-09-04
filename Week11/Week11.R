# Week 11
# Day1 ####
# PLotting a heatmap: Graphical representation of data to visutalize different values
#To plot a heatmal of a numeric matrix, use image()
# heat.colors(), topo.colors(), etc: create a color vector
# contour(): draw conturs, or add an existing plot
# curve(): draw a curve, or add to existing plot

phi <- dchisq(seq(0, 5, length = 50), df = 3)
plot(phi, type = 'l')
normalMat <- phi %*% t(phi)
normalMat
image(normalMat)

image(normalMat, col = heat.colors(20))
image(normalMat, col = heat.colors(3))
?heat.colors

image(normalMat, col = terrain.colors(12))
image(normalMat, col = topo.colors(12))


# Drawing contour lines ####

# To draw contour lines from a numeric matrix, use contour(): to add contours to an 

contour(normalMat, col = 1:3)

image(normalMat, col = terrain.colors(20))
contour(normalMat, add = true)

# Drawing a curve ####
# to draw a curve use curve()

curve(x^3)
curve(x^3, from = -3, to = 3, lwd = 3, col = 'red')

n <- 100
set.seed(0)
x <- sort(runif(n, min = -2, max = 2))
y <- x^3 + rnorm(n)

plot(x, y)
curve(x^3, lwd = 3, col = 'red', add = TRUE)
z<- loess(y~x)
lines(x, fitted(z), lwd = 3, lty = 2, col = "blue")
legend("bottomright", c("true", "loess"), horiz = TRUE, col = c('red', 'blue'), lwd = 3, lty = c(1,2))

# 3D Graph ####
x <- matrix(rep(seq(-10,10, length = 30),30), 30, 30)
y <- t(x)
plot(x,y, pch = 20)

z <- 10 * sin(sqrt(x^2 + y^2)) / sqrt(x^2 + y^2)
persp(x[,1], y[1,], z, theta = 0, phi = 50, expand = 1, col = "lightblue", xlim = c(-10,10), ylim = c(-10,10))

persp(x[,1], y[1,], z, theta = 0, phi = 0, expand = 1, col = "lightblue", xlim = c(-10,10), ylim = c(-10,10))


z <- x^2 + y^2
surface <- persp(x[,1], y[1,], z, theta = 0, phi = 0, expand = 1, col = terrain.colors(10))

n <- 200
x1 = runif(n, -10, 10)
y1 = runif(n, -10, 10)
z1 = x1 ^ 2 + y1 ^2 + 10 * rnorm(n)
xy.list = trans3d(x1, y1, z1, surface)
points(xy.list, pch = 20, col = 1)

# Day 2 ####
# Written notes

# Day 3 ####
# Testing means between groups

dataSet <- read.csv("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/county_data.csv", stringsAsFactors = FALSE)
head(dataSet)

data1 <- dataSet[dataSet$State == "California" | dataSet$State == "Connecticut", ]
data1$State <- factor(data1$State, levels = c("California", "Connecticut"))
boxplot(data1$Unemployment ~ data1$State)

t.test(data1$Unemployment[data1$State == "California"], data1$Unemployment[data1$State == "Connecticut"], var.equal = FALSE)

# In textbooks it is usually assumed that the variances of the two groups are the same

t.test(data1$Unemployment[data1$State == "California"], data1$Unemployment[data1$State == "Connecticut"], var.equal = TRUE)

# 2. Comparison among more than two groups
# Analys of variance (ANOVA)

data2 <- dataSet[dataSet$State %in% c("California", "Connecticut", "Alabama", "Ohio"),]
data2$State <- factor(data2$State, levels = c("California", "Connecticut", "Alabama", "Ohio"))

str(data2)

boxplot(data2$Unemployment ~ data2$State)
anova(lm(data2$Unemployment ~ data2$State))
# in the outcome: residual is within group variation, data2$State is the between group variation

# Pairwise comparison

# You can partly do this from the regression coefficients
reg <- lm(data2$Unemployment ~ data2$State) # Categorical variables (factors) are used as dummies

summary(reg)

# This does not compare California, connecticut, and ohio
# In mulipple testing, use p.adj = "bonferroni" to be conservative

pairwise.t.test(data2$Unemployment, data2$State, p.adj = "bonferroni")
