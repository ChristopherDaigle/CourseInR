# Chris Daigle
# Econ5495 - R Programming
# Wk13D2 In Class Lab - Prediction

# Importing & Setup####
setwd(
  "/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets"
)
gdp <- read.csv('GDP.csv', stringsAsFactors = FALSE)
library(tseries)

head(gdp)
str(gdp)
gdp$DATE <- as.Date(gdp$DATE)
gdp$Time <- format(gdp$DATE, format = '%y/%m')
gdp <- gdp[, c(3, 2)]

# Time Setting ####
gdp <-
  ts(
    gdp$GDP,
    start = c(1947, 1),
    end = c(2017, 4),
    frequency = 4
  ) # Quarterly data

# Summary Statistics ####
str(gdp)
start(gdp)
head(gdp)
end(gdp)
tail(gdp)
frequency(gdp)
summary(gdp)

# Plotting ####
laggedGDP <- lag(gdp, 1)
difGDP <- diff(gdp, 1) # Y(t) - Y(t-1)
difLogGDP <- diff(log(gdp))
plot(difGDP)
plot(laggedGDP)
plot(difLogGDP)

par(mfrow = c(3,1))
plot(difGDP)
plot(laggedGDP)
plot(difLogGDP)
par(mfrow = c(1,1))

plot(difGDP, col = 'blue', ylim = c(-300, 1000), lty = 3, lwd = 3)
lines(laggedGDP, col = 'red', lty = 2, lwd = 3)
lines(difLogGDP, col = 'green', lty = 4, lwd = 3)
legend('topright', legend = c('Dif in GDP', 'Lagged GDP', 'Log of Dif in GDP'), col = c('blue', 'red', 'green'), lty = c(3, 2, 4), lwd = 3)
title(main = 'Transformations of GDP Data')

acf(gdp) # high serial correlation
acf(difLogGDP) # explanatory value of the first, second, and third term is very small (not useful)
pacf(difLogGDP) # explanatory power of first isn't great, but the following are better

par(mfrow = c(3,1))
acf(gdp)
acf(difLogGDP)
pacf(difLogGDP)

seasDecom <- stl(log(gdp), s.window = 'period')
plot(seasDecom, lwd = 1, main = 'log GDP')
# Because there is a trend line, we can immediately see the data is
# non-stationary (dynamic?). Further, we can perform a hypothesis test such that
# the H0: data is non-stationary (ß = 1)

seasDecom1 <- stl(laggedGDP, s.window = 'period')
plot(seasDecom1, lwd = 1, main = 'laggedGDP')

seasDecom2 <- stl(difLogGDP, s.window = 'period')
plot(seasDecom2, lwd = 1, main = 'difLogGDP')

adf.test(gdp, alternative = 'stationary')
# Fail to reject the null (p > 0.05), so it's likely non-stationary The value is
# so large, it's essentially 1 for p, so it is, with near certainty,
# non-stationary
adf.test(difLogGDP, alternative = 'stationary')
# Reject the null (p <0.05), so the data is stationary. In this case, the value
# is so small, it is with near certainty, stationary.

par(mfrow = c(1,1))
fit <- arima(log(gdp), c(0,1,1), seasonal = list(order = c(0,1,1), period = 4)) # first argument is the order of the Autoregressive part c=(0,...), second is the difference part (p) c = (..., 1,...), last  is the moving average (q) c(...,..,1)
pred <- predict(fit, n.ahead = 18*4) # two years by 12 months
ts.plot(gdp, exp(pred$pred), log = 'y', lty = c(1,3), col = c('black', 'blue'), lwd = 1)
legend('topleft', legend = c('GDP', 'LogGDP'), col = c('black', 'blue'), lty = c(1, 2), lwd = 3)
title(main = 'Prediction on GDP Data')

fit <- arima(difLogGDP, c(0,1,1), seasonal = list(order = c(0,1,1), period = 4)) # first argument is the order of the Autoregressive part c=(0,...), second is the difference part (p) c = (..., 1,...), last  is the moving average (q) c(...,..,1)
pred <- predict(fit, n.ahead = 18*4) # two years by 12 months
ts.plot(difLogGDP, pred$pred, log = 'y', lty = c(1,1), col = c('black', 'blue'), lwd = 1)
legend('topright', legend = c('difLogGDP', 'LogGDP'), col = c('black', 'blue'), lty = c(1, 1), lwd = 3)
title(main = 'Prediction on GDP Data')