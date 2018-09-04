# # Week 6 Day 1
# # while loop + if else ##################################################################
# 
# j <- 0
# k <- 0
# # Extend/adapt the while loop
# while (j + k < 9) {
#   a <- sample(c("Head","Tail"), size=1)
#   b <- sample(c("Head","Tail"), size=1)
#   print(paste("Tom chooses", a, "and John chooses", b))
#   if (a==b) {
#     print("Tom win!")
#     j <- j + 1
#   } else {
#     print("Jone win!")
#     k <- k + 1
#   }
# }
# print(paste("Tom won", j, "times and John won", k, "times."))
# 
# # for loop ##############################################################################
# 
# # for loop: Loops are used in programming to repeat a specific block of code.
# # syntax
# 
# # for (var in sequence) {
# # statement
# # }
# 
# # Sequence is a vector. In each iteration, var takes on a value of sequence in order,
# # and statement is evaluated.
# 
# Econ5495 <- c("Zaur", "Rob", "Louis", "Tim", "Hanli", "Chris", "Jieun", "Xizi", "Busra", "Jinsoon", "Xuanye",
#               "Chaoyuan", "Yiyan", "Rui", "Tyler", "Kenn", "Alexandra", "Di", "Zhonghui", "Lindsay")
# 
# for (i in Econ5495) {
#   print(paste("Hello",i))
# }
# 
# for (i in 1:length(Econ5495)) {
#   print(paste("Hello", Econ5495[i]))
# }
# 
# # break statement:
# # break is used inside a loop (for, while) to stop the iterations and get outside of the loop
# 
# x <- seq(-6,6, by=0.01)
# y <- x^3 + 2*x
# plot(x,y, type="l")
# 
# x <- c(0, 5)
# i <- 2
# 
# for (i in 2:1000) {
#   x[i+1] <- x[i] - (x[i]^3 + 2*x[i])/(3*x[i]^2 + 2)
#   print(i)
#   i <- i + 1
#   if (abs(x[i] - x[i-1])<0.0001) {
#     break
#   }
# }
# print(paste("The solution to the equation x^3 + 2*x = 0 is x=", x[i]))
# 
# # Next statement
# # A next statement is useful when we want to skip the current iteration of a loop without
# # terminating it. On encountering next, the R skips further evaluation and starts
# # next iteration of the loop.
# 
# Econ5495 <- c("Zaur", "Rob", "Louis", "Tim", "Hanli", "Chris", "Jieun", "Xizi", "Busra", "Jinsoon", "Xuanye",
#               "Chaoyuan", "Yiyan", "Rui", "Tyler", "Kenn", "Alexandra", "Di", "Zhonghui", "Lindsay")
# Econ5495.boy <- c("Zaur", "Rob", "Louis", "Tim", "Chris", "Xizi", "Jinsoon", "Chaoyuan", "Tyler",
#                   "Kenn", "Zhonghui")
# Econ5495.girl <- NULL
# 
# for (i in 1:length(Econ5495)) {
#   if (Econ5495[i] %in% Econ5495.boy) {
#     next
#   }
#   Econ5495.girl <- paste(Econ5495.girl, Econ5495[i])
# }
# 
# print(paste("Girls in Econ 5495 are", Econ5495.girl))
# 
# # for loop in a matrix
# # We can employ a for loop inside a for loop.
# 
# # syntax
# # for (var1 in sequence 1) {
# #   for (var2 in seqence 2) {
# #     statement
# #   }
# # }
# 
# oil.shock <- rnorm(10, 0, 1)
# state.shock <- runif(10, -1, 1)
# random <- matrix(rnorm(100),10,10)
# 
# 
# Economy <- matrix(rep(NA, 100), 10, 10)
# rownames(Economy) <- 2000:2009
# colnames(Economy) <- state.abb[1:10]
# 
# for (i in 1:length(oil.shock)) {
#   for (j in 1:length(country.shock)) {
#     Economy[i,j] <- (oil.shock[i]*state.shock[j] + random[i,j] > 0)*1
#   }
# }
# 
# Economy
# 
# # Alternative way to for loop: matrix operation
# 
# oil.shock.mat <- matrix(rep(oil.shock, 10),10,10)
# state.shock.mat <- matrix(rep(state.shock, 10),10,10, byrow = TRUE)
# 
# Economy1 <- (oil.shock*state.shock.mat+ random > 0)*1
# rownames(Economy1) <- 2000:2009
# colnames(Economy1) <- state.abb[1:10]

# Economy1

## Day 2 ####
# Pairwise bootstrap
# 
# plot(mtcars$wt, mtcars$mpg)
# x <- mtcars$wt
# y <- mtcars$mpg
# 
# reg <- lm(y ~ x)
# abline(reg)
# 
# bhat <- reg$coefficients[2]
# n <- nrow(mtcars)
# num <- sum(((x - mean(x)) ^ 2) * (reg$residuals^2))/n
# den <- sum((x-mean(x))^2)/(n-1)
# se <- sqrt(num)/den
# 
# t <- sqrt(n) * bhat / se

## Day 3 ####

plot(mtcars$wt, mtcars$mpg)
x <- mtcars$wt
y <- mtcars$mpg

reg <- lm(y ~ x)
abline(reg)

bHat <- reg$coefficients[2]
uHat <- reg$residuals
aHat <- reg$coefficients[1]
n <- nrow(mtcars)
num <- sum(((x - mean(x)) ^ 2) * (reg$residuals^2))/n
den <- sum((x-mean(x))^2)/(n-1)
se <- sqrt(num)/den

t <- sqrt(n) * bhat / se

summary(reg)

B <- 999
bStar <- rep(NA, B)
tStar <- rep(NA, B)

for (b in 1:B) {
  
  index <- sample(1:nrow(mtcars), size = n, replace = TRUE)
  xStar <- mtcars$wt[index]
  yStar <- mtcars$mpg[index]
  
  regStar <- lm(yStar ~ xStar)
  bStar[b] <- regStar$coefficients[2]
  
  numStar <- sum(((xStar - mean(xStar)) ** 2) * (regStar$residuals ** 2)) / n
  denStar <- sum((xStar - mean(xStar)) ** 2) / (n - 1)
  seStar <- sqrt(n) * (bStar[b] - bHat) / denStar
  
  tStar[b] <- sqrt(n) * (bStar[b] - bHat) / seStar
}

tStar <- sort(tStar)

hist(tStar, breaks = 30, probability = TRUE, col = "grey", main = "Distribution of t*")
lines(density(tStar), col = "red", lwd = 3)
cv <- c(tStar[25], tStar[975])
abline(v = c(cv, bHat), col = c("blue"), lty = c(2, 2, 1), lwd = 3)

# Residual Type ####
B <- 999
bStarRes <- rep(NA, B)
uStarRes <- rep(NA, B)
yStarRes <- rep(NA, B)
tStarRes <- rep(NA, B)

for (b in 1:B) {
  
  index <- sample(1:nrow(mtcars), size = n, replace = TRUE)
  xStarRes <- x
  uStarRes <- reg$residuals[index]
  yStarRes <- aHat + bHat*xStarRes + uStarRes
  
  regStarRes <- lm(yStarRes ~ xStarRes)
  bStarRes[b] <- regStarRes$coefficients[2]
  
  numStarRes <- sum(((xStarRes - mean(xStarRes)) ** 2) * (regStarRes$residuals ** 2)) / n
  denStarRes <- sum((xStarRes - mean(xStarRes)) ** 2) / (n - 1)
  seStarRes <- sqrt(numStarRes) / denStarRes
  
  tStarRes[b] <- sqrt(n) * (bStarRes[b] - bHat) / seStarRes
}

tStarRes <- sort(tStarRes)

hist(tStarRes, breaks = 30, probability = TRUE, col = "grey", main = "Distribution of t*")
lines(density(tStarRes), col = "red", lwd = 3)
cvRes <- c(tStarRes[25], tStarRes[975])
abline(v = c(cvRes, bStarRes), col = c("blue"), lty = c(2, 2, 1), lwd = 3)