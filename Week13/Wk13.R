# Week 13
# Day 1 ####

setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets")

# Time seeries and forecasting
excaus <- read.csv('EXCAUS.csv', stringsAsFactors = FALSE)

head(excaus)
str(excaus)
excaus$DATE <- as.Date(excaus$DATE)
excaus$Time <- format(excaus$DATE, format = '%y/%m')
excaus <- excaus[, c(3,2)]

excaus1 <- mean(excaus[excaus$Time >= 16/01, 2])

# Use ts() function
excaus <- ts(excaus$EXCAUS, start = c(2008, 1), end = c(2018,4), frequency = 12)
str(excaus)
start(excaus)
end(excaus)
frequency(excaus)
summary(excaus)
excaus

plot(excaus, col = 'blue', lwd = 3, ylab = 'Exchange Rate')
abline(reg = lm(excaus~time(excaus)), lwd = 3)

# display yearly averages
plot(aggregate(excaus, FUN = mean))

# Box plot across months will give us a sense on seasonal effect
boxplot(excaus ~ cycle(excaus))

exuseu <- read.csv('EXUSEU.csv', stringsAsFactors = FALSE)
exuseu
exeuus <- (exuseu$DEXUSEU) ^ (-1)
exeuus <- ts(exeuus, start = c(2008, 4), end = c(2018, 3), frequency = 12)
plot(excaus, col = 'blue', lwd = 3, ylim = c(0.6, 1.5), ylab = 'Exchange Rate')
lines(exeuus, col = 'red', lty = 2, lwd = 3) # Adds the line of another plot, note in the first plot that the ylim is set, the ylim is imperative for the second line to be visible on the graph in this case

legend('topleft', legend = c('CAD/USD', 'EUR/USD'), col = c('blue', 'red'), lty = c(1,2), lwd = 3)

title(main = 'Exchange Rate')

# Seasonal Decomposition

# A time series with additive trend, seasonal, and irregular components can be decomposed 
# using the stl() function. 

# For Additive Time Series,
# Yt=St+Tt+Et
# For Multiplicative Time Series,
# Yt=St?Tt?Et -> note this is not dissimilar if we apply a logarithmic function to the multiplicative

# Note that a series with multiplicative effects can often 
# by transformedinto series with additive effects through a 
# blog transformation (i.e., newts <- log(myts)).
# What is stationary time series ?
#

# Seasonal Decomposition
SeasDecom <- stl(log(excaus), s.window="period")
plot(SeasDecom, lwd=3)

summary(SeasDecom)
SeasDecom

# # NOTE: The mean of our seasDecom is not the same at all points, so there is a trend (the mean is shifting over time), thus it's not stationary, 
# 
# # Forecasting generally requires stationarity of time series
# # The distribution hshould be IID
# # The population of interest MUST be the same OR different population with SAME distributions

# Day 2 ####
# What is stationary time series ?

# A time series is said to be stationary if it holds the follwing conditions true
# The mean value of time series is constrant over time, which implies
# There is no trend
# The variance does not change over time
# Seasonality effect is minimal

# This means there is no trend or seasonal pattern, which makes it look like a random white noise irrespective of the observed time interval

# Standard forecasting requires stationarity of data

laggedex <- lag(excaus, 1)
dif <- diff(excaus,1) # Y(t) - Y(t-1)
plot(dif)

# Converts nonstationary data to stationary data

# First we need to check whether the process is stationary (install package tseries)
library(tseries)

adf.test(excaus, alternative = 'stationary') # augmented dickey-fuller test # SEE NOTES FROM POSTED, DISPLAY WAS CUTOFF
# Fail to reject the null (p > 0.05), so it's likely non-stationary
adf.test(diff(log(excaus)), alternative = 'stationary')
# Reject the null (p <0.05), so the data is stationary

# AR(1) model with strong serial correclation
y <- rep(NA, 5*12)

set.seed(pi)

y[1] <- rnorm(1)

for (j in seq(2, 5*12, 1)) {
  y[i] <- 1+ y[i - 1] + rnorm(1)
}

y_ts <- ts(y, start = c(2008, 1), end = c(2012, 12), frequency = 12)
plot(y_ts)
acf(y_ts)

# ACF plots: Autocorrelation function corr(Yt, Yt-1)
acf(excaus) # high serial correlation
acf(diff(log(excaus))) # explanatory value of the first term is very small (not useful)
pacf(diff(log(excaus))) # explanatory power of each isn't too bad

fit <- arima(log(excaus), c(0,1,1), seasonal = list(order = c(0,1,1), period = 12)) # first argument is the order of the Autoregressive part c=(0,...), second is the difference part (p) c = (..., 1,...), last  is the moving average (q) c(...,..,1)
pred <- predict(fit, n.ahead = 2*12) # two years by 12 months
ts.plot(excaus, exp(pred$pred), log = 'y', lty = c(1,3), col = c('black', 'blue'), lwd = 3)

# For exercise, predict on the GDP

# Day 3 ####
rm(list = ls())

# Simple DGP
e <- rnorm(100, 0, 0.1) 
x1 <- runif(100, min = 2, max = 5) # Normally distributed
x2 <- runif(100, min = -1, max = 4) # Normally distributed
x3 <- rnorm(100, 3, 2) # Normally distributed
y1 <- 5 * x1 - 3 * x2 + 9 * x3 + e # linear function
data1 <- as.data.frame(cbind(y1, x1, x2, x3))
data1 

# OlS
lm(y1 ~ x1 + x2 + x3, data = data1)

# Optimization

obj1 <- function(beta, dataset) {
  y <- dataset[,1]
  x1 <- dataset[,2]
  x2 <- dataset[,3]
  x3 <- dataset[,4]
  
  res <- t(y - beta[1] * x1 - beta[2] * x2 - beta[3] * x3) %*% (y - beta[1] * x1 - beta[2] * x2 - beta[3] * x3)
  
  return(res)
}

# Optimization (more than one dimensions)
optim(c(0,0,0),obj1, dataset = data1)
optim(c(0,0,0),obj1, dataset = data1, method = 'BFGS', control = list(trace = TRUE)) # Newton-(rapson) based
optim(c(0,0,0),obj1, dataset = data1, method = 'BFGS', control = list(trace = FALSE)) # Newton-(rapson) based
optim(c(0,0,0),obj1, dataset = data1, method = 'Nelder-Mead', control = list(trace = TRUE, maxit = 3000, abstol = 1e-5)) # direct search

# Optimization (one dimension)
optimize(function(x) (x - pi) ^2, c(0, 10))

# Non-linear minimization
# SimpleDGP
y2 <- 1 / (1 + exp(-(3 + 7 * x1))) + e
data2 <- as.data.frame(cbind(y2, x1))

obj2 <- function(beta, dataset) {
  
  y <- dataset[,1]
  x1 <- dataset[,2]
  
  yhat <- 1 / (1 + exp(-(beta[1] + beta[2] * x1)))
  
  res <- t(y - yhat) %*% (y - yhat)
  
  return(res)
}

optim(c(1,1),obj2, dataset = data2, method = 'BFGS')
optim(c(1,1),obj2, dataset = data2, method = 'Nelder-Mead')

# Non_Linear optimization function
nlm(obj2, c(1,1), dataset = data2)
nlminb(c(1,1), obj2, dataset = data2, lower = c(1,1), upper = c(5,9))

# Something need to know
y3 <- 5 * x1 / (1 + 3 * x2 + 9 * x3) + e
data3 <- as.data.frame(cbind(y3, x1, x2, x3))

library('ggplot2')
library('gridExtra')

x <- seq(-3,3, length.out = 100)
