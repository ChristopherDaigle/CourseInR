## Chris Daigle #####
# Exam 1, 1 Mar ###

# Question 1 ####
countyData <- read.csv("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/Exam/county_data.csv", stringsAsFactors = FALSE)
summary(countyData)

# Question 1, Part 1 ####
# Find the county that has the largest population in each state
maxStateCounty <- aggregate(countyData[ , c("County", "TotalPop")], list(countyData$State), max, na.rm=TRUE)
maxCounty <- maxStateCounty[, c(2,3)]
maxCounty

# Question 1, Part 2 ####
# Select a subset of counties whose popualtion belong to the top 10% and compute the mean and median of those counties
sub <- countyData[,c(1,2,3)]
quant <- quantile(sub$TotalPop, probs = c(0.25, 0.5, 0.75, 0.9), na.rm = TRUE)

interestVector <- rep(NA, length(sub$TotalPop))
interestVector[sub$TotalPop >= quant[4]] <- TRUE
topTen <- sub$County[which(sub$TotalPop >= quant[4])]
avgTopTenCounty <- mean(sub$TotalPop[which(sub$County == topTen)])
medTopTenCounty <- median(sub$TotalPop[which(sub$County == topTen)])
avgTopTenCounty
medTopTenCounty

# Question 2 ####
oneHundred <- rnorm(100, 0, 1)
tenByTen <- matrix(sample(oneHundred), nrow=10, ncol = 10)
apply(tenByTen, MARGIN = 1, FUN=min)

row.names(tenByTen) <- c(1,2,3,4,5,6,7,8,9,10)
rowMins <- rep(NA, 10)
for (i in 1:10){
  rowMins[i] <- min(tenByTen[i,])
}

# Question 3 ####
regression <- function(X,Y) {
  Z = X ^ 2
  bHatOne <- sum((X - mean(X)) * (Y - mean(Y))) / sum((X - mean(X)) ^ 2)
  bHatTwo <- sum((Z - mean(Z)) * (Y - mean(Y))) / sum((Z - mean(Z)) ^ 2)
  bHatZero <- mean(Y) - bHatOne*mean(X) - bHatTwo*mean(Z)
  cat("intercept:", bHatZero)
  print("")
  cat("betaHatOne:", bHatOne)
  print("")
  cat("betaHatTwo:", bHatTwo)
}

X <- (countyData$Men / countyData$Women)
Z <- X ^ 2
Y <- countyData$Unemployment
regTest <- lm(countyData$Unemployment ~ X + Z)

regression(X, Y)
coefficients(regTest[1])
# The function takes in the values as requested, but testing against the builtin "lm", my function does not make the same values (my formulas are wrong, my parentheses are wrong, im not sure)