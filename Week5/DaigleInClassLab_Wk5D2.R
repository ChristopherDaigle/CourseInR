## Christopher Daigle
## Wk5D2InClassLab

## Exercise 1
# How many days are between Jan 13 1903 and Feb 14 2018?
dates1 <- c("01/13/1903", "02/14/2018")
dates1 <- as.Date(dates1, format = "%m/%d/%Y")
daysBtwn1 <- dates1[2] - dates1[1]
daysBtwn1

# Create a sequence of dates, by day, from Jan 1 2018 to Feb 14 2018
dates2 <- as.Date(c("01/01/2018", "02/14/2018"), format = "%m/%d/%Y")
daysBtwn2 <- dates2[2] - dates2[1]
dateSeq <- dates2[1] + 0:daysBtwn2

## Exercise 2
# Download "complete.csv" from "International football results from 1872 to 2018" from Kaggle
setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/Week5/DataSets")
dir()
data <- read.csv("results.csv")
head(data)
str(data)

# Convert the variable "date" to variable using as.Date
data$date <- as.Date(data$date, format = "%Y-%m-%d")
str(data)

# Compare the average number of goals in 1930-1939 and in 2005-2014 and see wether is increased or decreased
year <- format(data$date, format = "%Y")
period1 <- data[year >= 1930 & year <= 1939, ]
period2 <- data[year >= 2005 & year <= 2014, ]
goals1 <- period1$home_score + period1$away_score
goals2 <- period2$home_score + period2$away_score
avgGoals1 <- mean(goals1)
avgGoals2 <- mean(goals2)

avgGoals2 > avgGoals1
# The average number of goals decreased

# What is the ratio of home winning games to the total numbr of games in the 1950s?
game50 <- data[year>= 1950 & year <= 1959, ]
homeWin <- data[data$home_score > data$away_score, ]
ratio <- length(homeWin$home_score) / length(data$home_score) # could use nrow(home_win)
ratio
# The ratio is approximately 0.48

# Plot the number of games over each year and see whether there was a decrease in games in WW1 and WW2
data$year <- format(data$date, format = "%Y")
plot(factor(data$year))

# This is extra, an experiment in playing with tables and plots of sort
# WW1 <- data[year >= 1914 & year <= 1918,]
# # Segment
# WW1yr <- format(WW1$date, format = "%Y")
# # Simplify date
# WW1freq <- table(WW1yr)
# # Distinguish each year and the number of times they occur (counting the number of games in the year in the data set)
# WW1freq
# 
# WW2 <- data[year >= 1939 & year <= 1945,]
# WW2yr <- format(WW2$date, format = "%Y")
# WW2freq <- table(WW2yr)
# WW2freq
# 
# plot(c(WW1freq,WW2freq), type = "b")
# WW1freq
# WW2freq