## Chris Daigle
## Wk7D1 Inclass Lab

# Exercise 1 ################################################################


setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets")
rev_exp0 <- read.csv("district_rev_exp.csv", na.strings = "-")
head(rev_exp0)

# Calculate the 20% trimmed mean of "TOTALREV" for each state

calMean <- mean(rev_exp0$TOTALREV[rev_exp0$STATE == "California"], trim = 0.2, na.rm = TRUE)
conMean <- mean(rev_exp0$TOTALREV[rev_exp0$STATE == "Connecticut"], trim = 0.2, na.rm = TRUE)
massMean <- mean(rev_exp0$TOTALREV[rev_exp0$STATE == "Massachusetts"], trim = 0.2, na.rm = TRUE)
missMean <- mean(rev_exp0$TOTALREV[rev_exp0$STATE == "Missouri"], trim = 0.2, na.rm = TRUE)
cat("The 20% trimmed mean of California is: $", round(calMean, 2))
cat("The 20% trimmed mean of Connecticut is: $", round(conMean, 2))
cat("The 20% trimmed mean of Massachusetts is: $", round(massMean, 2))
cat("The 20% trimmed mean of Missouri is: $", round(missMean, 2))

meanRevByState <- aggregate(rev_exp0[, "TOTALREV"], list(rev_exp0$STATE), mean, na.rm = TRUE, trim = 0.2)
meanRevByState

# Exercise 2 ################################################################


simpFun <- function(x, y) {
  intOut <- (x + y)
  if (intOut == 0) {
    return(0)
  } else {
    return((x + y) - 1 / (x + y))
  }
}

simpFun(1,7)
simpFun(0,0)

# Exercise 3 ################################################################


fun <- function(x) {
  y <- x ^ 3 + 2 * x + 5
}

fun_der <- function(x) {
  yder <- 3 * x ^ 2 + 2
}

curve(fun, xlim = c(-2,2), col = 'blue', lwd = 2, lty = 2, ylab = 'f(x)')

abline(h = 0)
abline(v = 0)

nr <- function(fun, fun_der, int) {
  x <- c(int - 5, int)
  i <- 2
  while (abs(x[i] - x[i-1])>0.0001) {
    x[i + 1] <- x[i] - (fun(x[i]))/(fun_der(x[i]))
    i <- i + 1
  }
  x[i]
}

nr(fun, fun_der, int = 5)