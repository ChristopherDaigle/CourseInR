## Chris Daigle
## Wk6D2InClassLab

plot(mtcars$wt, mtcars$mpg)
x <- mtcars$wt
y <- mtcars$mpg

reg <- lm(y ~ x)
abline(reg)

bhat <- reg$coefficients[2]
n <- nrow(mtcars)
num <- sum(((x - mean(x)) ^ 2) * (reg$residuals^2))/n
den <- sum((x-mean(x))^2)/(n-1)
se <- sqrt(num)/den

t <- sqrt(n) * bhat / se

B <- 999
bStar <- rep(NA, B)
tStar <- rep(NA, B)

for (b in 1:B) {
  index <- sample(1:32, size = 32, replace = TRUE)
  xStar <- x[index]
  yStar <- y[index]
  regStar <- lm(yStar~xStar)
  bStar[b] <- regStar$coefficients[2]
  numStar <- sum(((xStar - mean(xStar)) ^ 2) * (regStar$residuals^2))/n
  denStar <- sum((xStar-mean(xStar))^2)/(n-1)
  seStar <- sqrt(numStar)/denStar
  tStar[b] <- sqrt(n) * (bStar[b] - bhat) / seStar
}

hist(tStar)
tStar <- sort(tStar)
tStar25 <- tStar[25]
tStar975 <- tStar[975]

t < tStar25
t > tStar975

critV <- c(tStar25, tStar975)
t %in% critV