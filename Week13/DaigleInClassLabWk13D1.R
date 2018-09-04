# Chris Daigle
# Econ5495 - R Programming
# Wk13D1 In Class Lab - Time Series

# Importing ####
setwd(
  '/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets'
)
gdp <- read.csv('GDP.csv')

# Structuring ####
head(gdp)
str(gdp)
gdp$DATE <- as.Date(gdp$DATE)
gdp$Time <- format(gdp$DATE, format = '%y/%m')
gdp <- gdp[, c(3, 2)]

# 2017 - 1947
# 1947 + 35
# gdp1 <- mean(gdp[gdp$Time >= 82 / 01, 2])

# Time Setting ####
gdpX <-
  ts(
    gdp$GDP,
    start = c(1947, 1),
    end = c(2017, 4),
    frequency = 4
  ) # Setting this is confusing unless we lose the concept of months and adopt quarters

str(gdpX)
start(gdpX)
head(gdpX)
end(gdpX)
tail(gdpX)
frequency(gdpX)
summary(gdpX)

# Plotting ####
plot(gdpX,
     col = 'blue',
     lwd = 3,
     ylab = 'Gross Domestic Product')
abline(reg = lm(gdpX ~ time(gdpX)), lwd = 3)

plot(
  aggregate(gdpX, FUN = mean),
  col = 'red',
  lty = 2,
  lwd = 3,
  ylab = 'GDP ($)',
  main = 'Yearly Average GDP'
)
lines(gdpX, col = 'blue', lwd = 3)
legend(
  'topleft',
  legend = c('GDP', 'Average GDP'),
  col = c('blue', 'red'),
  lty = c(1, 2),
  lwd = 3
)

boxplot(gdpX ~ cycle(gdpX),
        xlab = 'Quarters',
        ylab = 'GDP ($)',
        main = 'GDP by Quarter (1947 - 2017)')


# Seasonal Decomposition ####
seasDecom <- stl(log(gdpX), s.window = 'period')
plot(seasDecom, lwd = 3)

summary(seasDecom)