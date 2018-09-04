# Chris Daigle
# Week12 Day 1 - 9 April

setwd("/Users/daiglechris/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets")
# Importing ####
compiled <- read.csv('1999-2016 Opioid Mortailty.csv')
head(compiled)
summary(compiled)

# Subsetting
simple <- compiled[, 1:7]
head(simple)
simple <- as.data.frame(simple)


anova(lm(simple$AllOpioids ~ simple$Year))


# x <- pull(simple, State)
x <- simple[["State"]]
x1 <- t(x)
colnames(x1) <- x1[1,]
x1 <- x1[-1, ]
x1 <- x1[,1:51]
statesAsVar <- x1
empty <- rep(NA, 51)

for (i in 1:18) {
  statesAsVar <- rbind(statesAsVar, empty)
}
row.names(statesAsVar) <- c(2016:1999)

states <- unique(simple$State)

for (i in x) {
    statesAsVar[,i] <- simple$AllOpioids[simple$State == i]
}
# Test Case: Alabama <- simple$AllOpioids[simple$State == 'Alabama'], also view(simple) and sort it by State
# Locate states with the highest values
maxes <- rep(NA, length(1999:2016))
for (i in 1:18) {
  maxes[i] <- max(simple$AllOpioids[which(simple$Year == (i+1998))]) 
}

byYrStateMaxes <- rep(NA, length(1999:2016))
for (i in 1999:2016) {
  byYrStateMaxes[i-1998] <- simple$State[which(simple$AllOpioids == maxes[i-1998] & simple$Year == i)]
}
byYrStateMaxes <- simple$State[byYrStateMaxes]

simple2 <- as.data.frame(simple)

# Graphics
library(car)
Boxplot(simple2$AllOpioids, simple2$Year, xlab = 'Year', ylab = 'Total Opiod Deaths', main = 'Total USA Opiod Deaths from 1999 - 2016')
Boxplot(simple2$AllOpioids, simple2$State, xlab = 'Year', ylab = 'Total Opiod Deaths', main = 'Total USA Opiod Deaths from 1999 - 2016')

plot(simple$AllOpioids ~ simple$Year, xlab = 'Year', ylab = 'Total Opiod Deaths', main = 'Total USA Opiod Deaths from 1999 - 2016')

# I don't know how meaningful this is:
pairs(statesAsVar[,1:5])
pairs(statesAsVar[,6:10])
pairs(statesAsVar[,11:15])
pairs(statesAsVar[,16:20])
pairs(statesAsVar[,21:25])
pairs(statesAsVar[,26:30])
pairs(statesAsVar[,31:35])

par(mfrow = c(3,3), mar = c(4,4,2,0.5)) # Setup the dimension for the matrix of multiple graphs and margins
for (i in c(2000, 2001, 2010, 2011, 2012, 2013, 2014, 2015, 2016)) {
  hist(simple$AllOpioids[which(simple$Year == i)], xlab = 'Deaths in the US', main = paste('Opiod Deaths in', i), col = 'lightblue', breaks = 20 )
}
par(mfrow = c(1,1))

pcDeathsByStates <- prcomp(statesAsVar, scale. = TRUE)
#pcDeathsByStates$rotation
plot(pcDeathsByStates, type="l")
biplot(pcDeathsByStates)
