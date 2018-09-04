# Christopher Daigle
# Week10D2 In Class Lab - Histogram

# Exercise

setwd("/Users/daiglechris/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/")
dataSet <- read.csv("histogram.csv", stringsAsFactors = FALSE)
dataSet <- dataSet[dataSet$YRDATA == 2013, ]

# Using plot() and points() functions, highlight the 4 best schools in CT in terms of expenditure per student (TOTALEXP / ENROLL > 30). and put the label of school name on each outlier.
head(dataSet)
onlyPosEnrCT <- dataSet[dataSet$STATE == "Connecticut" & dataSet$ENROLL > 0, ]
expPerStudCT <- onlyPosEnrCT$TOTALEXP / onlyPosEnrCT$ENROLL
greaterThan30 <- which(expPerStudCT > 30)

plot(expPerStudCT)
points(greaterThan30, expPerStudCT[greaterThan30], pch=16, col="red")
text(greaterThan30, expPerStudCT[greaterThan30], labels = onlyPosEnrCT$NAME[greaterThan30], cex = 0.5)

# Make two histograms together for expenditure per student (TOTALEXP / ENROLL) of Connecticut and Alabama and compare them.

onlyPosEnrAB <- dataSet[dataSet$STATE == "Alabama" & dataSet$ENROLL > 0, ]
expPerStudAB <- onlyPosEnrAB$TOTALEXP / onlyPosEnrAB$ENROLL

summary(expPerStudCT)
sd(expPerStudCT)
hist(expPerStudCT, col = rgb(0,0,0.5, 0.2), freq = TRUE, breaks = seq(5, 44, by = 4), xlab = "Expenditure Per Student", main = "ExpPerStudent for CT & AB")

summary(expPerStudAB)
sd(expPerStudAB)
hist(expPerStudAB, col = rgb(1,0,0,.2), freq = TRUE, breaks = seq(0, 44, by = 3), add = TRUE)
legend(x = 32, y = 40, c("Connecticut", "Alabama"), col = c(rgb(0,0,0.5, 0.2), rgb(1,0,0,.2)), pch = 15)

# In comparison, AB spends less per student than CT does, more often (as measured by the frequency of
# occurence), but there is at least one outlier where AB spends more.

# graphics.off()
# 
# hist(expPerStudCT, col = rgb(0,0,0.5, 0.2), freq = FALSE, breaks = seq(5, 44, by = 4), xlab = "Expenditure Per Student", main = "ExpPerStudent for CT & AB")
# hist(expPerStudAB, col = rgb(1,0,0,.2), freq = FALSE, breaks = seq(0, 44, by = 3), add = TRUE)
# legend(x = 32, y = 40, c("Connecticut", "Alabama"), col = c(rgb(0,0,0.5, 0.2), rgb(1,0,0,.2)), pch = 15)