# Chris Daigle
# Week12 Day 3 - 13 April

# Exercise

setwd(
  "/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets"
)
# Regression model: examine the relation between X and Y
# Y|X ~ P(\beta)
# E(Y|X) = beta0 + beta1 * X
# Y = beta0 + beta1 X + u,  E(u|X)=0,
# In this mean regression, we may assess model validity: Estimation and
# Inference on beta
# We may predict Y using X: prediction

# College data: Demographic characteristics, tuition, and more for USA colleges.

# Private: Public/private indicator
# Apps: Number of applications received
# Accept: Number of applicants accepted
# Enroll: Number of new students enrolled
# Top10perc: New students from top 10 % of high school class
# Top25perc: New students from top 25 % of high school class
# F.Undergrad: Number of full-time undergraduates
# P.Undergrad: Number of part-time undergraduates
# Outstate: Out-of-state tuition
# Room.Board: Room and board costs
# Books: Estimated book costs
# Personal: Estimated personal spending
# PhD: Percent of faculty with Ph.D.'s
# Terminal: Percent of faculty with terminal degree
# S.F.Ratio: Student/faculty ratio
# perc.alumni: Percent of alumni who donate
# Expend: Instructional expenditure per student
# Grad.Rate: Graduation rate

college <- read.csv("College.csv")
college1 <- college[, c(-1, -7, -8, -9, -10, -11, -12, -14, -15)]

# You can create a dummy variable from a continuous variable. For example,
college1$dummyPC <-
  as.numeric(college1$perc.alumni > mean(college1$perc.alumni))

# Find the variables that provide good prediction for this dummy varaible.

naiveReg <- lm(dummyPC ~ ., data = college1)
summary(naiveReg)
# This makes sense that the variable that contructed the new variable, dummyPC
# and perc.alumni, would have a statistically significant relationshop So, let's
# be a little more sophisticated, but nott too much - stick with a linear model
# and first remove the variable that, without a doubt, constructs the variable
# of interest (per.alumni)
college2 <- college1[, -8]
head(college2)
reg1 <- lm(dummyPC ~ ., data = college2)
summary(reg1)
# Signigicant: PrivateYes, Apps, Top10Perc, Personal, Grad.Rate Let's increase
# the degree of freedom by removing variables that are deemed insignificant
head(college2)
reg2 <-
  lm(dummyPC ~ Private + Apps + Top10perc + Personal + Grad.Rate, data = college2)
summary(reg2)
# All but Personal and the intercept exude statistical significance of 99.99%
# level
#
# Let's step it up a notch and use the logistic model as the variable of
# interest is not continuous. A non-linear model is more appropiate.
logistic1 <- glm((dummyPC == 1) ~ ., data=college2, family="binomial")
summary(logistic1)
# Significant: PrivateYes, Apps, Enroll, Top10perc, Personal, Expend, Grad.Rate
head(college2)
college3 <- college2[, c(-3, -7)]
logistic2 <- glm((dummyPC == 1) ~ ., data=college3, family="binomial")
summary(logistic2)
# Variables that are likely to influence investment above the average percent of
# alumni who donate: Private, Enroll, Top10perc, Expend, and Grad.Rate Variables
# that are likely to influence investment below the average percent of alumni
# who donate: Apps and Personal
pHat <- fitted(logistic2)
yHat <- round(pHat)
table(college2$dummyPC)
table(yHat, y.true=college2$dummyPC)
100/414
272/363
# This model seems prerry bad at predicting if there will not be a greater than
# average proportion of alumni investing, but not too bad at predicting if a
# proportion above average of alumni will invest. The model correctly predicts
# about above average percent of alumni investing at about 75%. OR! Incorrectly
# does so about 1/4 of the time. The model correctly predicts below average
# percent of alumni investing at about 25%. OR! Incorrectly does so about 3/4 of
# the time.

# # Let's see if we can get it better by applying some weights. There are 8
# # variables if we account for the intercept, so let's make a vector of 7 values
# # for probability weights with some intuition - base them on the P-values.
# # summary(logistic2)
lambda <- c(2, 3, 2, 3, 2, 3, 3)
x <- 2 + 3 + 2 + 3 + 2 + 3 + 3
lambda <- 1 / x * lambda
lambda
logistic3 <-
  glm((dummyPC == 1) ~ .,
      data = college3,
      weights = c(3 / x, 2 / x, 3 / x, 2 / x, 3 / x, 3 / x),
      family = "binomial"
  )
# This is not the right way to use weights, I think I need a vector as long as
# the number of observations, not as long as the variables (which seems weird to
# me), to apply the weight command in the glm regression.
# summary(logistic3)
# 
# pHat1 <- fitted(logistic3)
# yHat1 <- round(pHat1)
# table(college2$dummyPC)
# table(yHat1, y.true = college2$dummyPC)

