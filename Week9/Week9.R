# Week9 D1 ####
# On board notes of linear algebra

# Day 2: Page Rank - Snow Day ####
# Matrix algebra

A <- matrix(rnorm(25), 5, 5)
A
t(A)
diag(A)

diag(c(1,1,1,1))

Ainv <- solve(A)  
round(A %*% Ainv, digit=3) 

# inverse matrix
b <- 1:5
b
x <- solve(A,b) # solve b = Ax
x

solve(A)%*%b

B <- t(A)%*%A

eigen.B <- eigen(B)
eigen.B

# Exercise 1. Calculate the PageRank using the following matrix.
# As we learned in class, you can do this in two different ways. 
# 1. Iteration using the while-loop. 1. Calculating the eigenvector associated with eigenvalue 1.

m1 <- c(0,1/3,1/3,1/3)
m2 <- c(0,0,1/2,1/2)
m3 <- c(1,0,0,0)
m4 <- c(1/2,0,1/2,0)

M <- cbind(m1,m2,m3,m4)

eigenM <- eigen(M)
round(eigenM$vectors[,1], digits = 3)

# Exercise 2. Write functions to implement PageRank algorithm.
# Using these functions, calculate the PageRank using a much bigger matrix
# Which one is more efficient between the iteration method and eigenvalue approach?

ind <- 1:1000
M <- matrix(rep(0,1000^2), nrow=1000,ncol=1000)
for (i in 1:1000) {
  a <- sample(x=1:10, size=1)
  b <- sample(x=1:1000, size=a)
  M[b,i] = 1/a
}


# 1. Using the power iteration method

p_1 <- c(0,0,0,0)
p <- cbind(p_1, c(0,0,1,0))
T <- 2
while (sum(abs(p[,T]-p[,T-1]))>0.001) {
  p <- cbind(p, c(0,0,0,0))
  p[,T+1] <- M%*%p[,T]
  T <- T+1
}
p[,T]

pr1 <- function(M) {
  p_1 <- rep(0,nrow(M))
  p <- cbind(p_1, c(1,rep(0,nrow(M)-1)))
  T <- 2
  while (sum(abs(p[,T]-p[,T-1]))>0.001) {
    p <- cbind(p, rep(0,nrow(M)))
    p[,T+1] <- M%*%p[,T]
    T <- T+1
  }
  plot(p[,T], type="h")
  return(p[,T])
}

# 2. Using the eigenvector approach
eigen.M <- eigen(M)

vec.temp <- eigen.M$vectors[,1]
vec.temp

vec.temp <- Re(vec.temp)
vec.temp

eig.vec <- vec.temp/sum(vec.temp)
eig.vec

pr2 <- function(M) {
  eigen.M <- eigen(M)
  
  vec.temp <- eigen.M$vectors[,1]
  vec.temp
  
  vec.temp <- Re(vec.temp)
  
  eig.vec <- vec.temp/sum(vec.temp)
  plot(eig.vec, type="h")
  return(eig.vec)
}


pr.1 <- pr1(M)
pr.2 <- pr2(M)
# Day3 ##############
# Principal Component Analysis

head(mtcars)

data.car1 <- mtcars[,c("mpg","wt")]
data.normalize1 <- scale(data.car1)
apply(data.normalize1, MARGIN=2, sd)
colMeans(data.normalize1)

plot(data.normalize1)


cov.mat1 <- t(data.normalize1) %*% data.normalize1/nrow(data.normalize1)
eig.data1 <- eigen(cov.mat1)

pc <- eig.data1$vectors

# In practice, we can use prcomp or princomp function.

pc1 <- prcomp(data.normalize1)
pc1$rotation

# Let's introduce more variables.
data.car <- mtcars[,1:7]
pairs(data.car)

pc.car <- prcomp(data.car, scale.=TRUE)
pc.car$rotation

summary(pc.car)
plot(pc.car, type="l")
biplot(pc.car)


# Exercise
setwd("/Users/daiglechris/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets")
data.soccer <- read.csv("PCA.csv")
head(data.soccer)
data.psa <- data.soccer[,2:10]
pairs(data.psa)
rownames(data.psa) <- data.soccer[,1]
head(data.psa)

pc.soccer <- prcomp(data.psa, scale.=TRUE)
pc.soccer$rotation
plot(pc.soccer, type="l")
biplot(pc.soccer)
