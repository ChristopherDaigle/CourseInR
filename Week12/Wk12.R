# Week 12
# Day 1 ####

setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets")
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
dim(college)
head(college)
college.1 <- college[,c(-1,-7,-8,-9,-10,-11,-12,-14,-15)]
college.1$Private.1 <- as.numeric(college$Private == "Yes")
college.1$enr.rate <- round(college.1$Enroll/college.1$Accept * 100,1)
college.1 <- college.1[,c(-3,-4)]
dim(college.1)
head(college.1)

# Some questions that we may want to investigage:

# What is the relationship between Private and Expend?
# What is the relationship between Private and perc.alumni?
# Which variable is associated with Grad.Rate?
# Can we predict perc.alumni with other variables?

# Exploratory data analysis(EDA): Before pursuing a specific regression model, 
# it's generally good idea to explore your data to understand the main 
# characteristics of each variable.

dim(college.1)
par(mfrow=c(3,3), mar=c(4,4,2,0.5)) # Setup the dimension for the matrix of 
# multiple graphs and margins

# To see the distribution of each variable: 
for (j in 2:ncol(college.1)) {
  hist(college.1[,j], xlab=colnames(college.1)[j],
       main=paste("Histogram of", colnames(college.1)[j]),
       col="lightblue", breaks=20)
}

# What can we find?
# 1. application, personal, expend, perc.alumni, Top10perc and enrollment 
# ratio are right skewed.
# 2. acceptance rate is left skewed.
# 3. Private is binary
# 4. Grad.rate has fat right tails.
# 5. S.F. ratio looks relatively normal.

# Correlations between variables

cor.college <- cor(college.1[,2:ncol(college.1)])
round(cor.college,2) 

# Some strong correlations! Let's find the biggest (in absolute value):

cor.college[lower.tri(cor.college,diag=TRUE)] = 0 # Why only upper tri part?
cor.college

cor.college.sorted = sort(abs(cor.college),decreasing=T)
cor.college.sorted
cor.college.sorted[cor.college.sorted>0]

a <- which(abs(cor.college)==cor.college.sorted[1])
a
var.big.cor <- arrayInd(a, dim(cor.college)) # convert the index number from  
# which() to the row number and column number
var.big.cor

# Another way to convert                                                                                          
var.big.cor1 <- c(a%%nrow(cor.college), (a%/%nrow(cor.college))+1) 
var.big.cor1

colnames(cor.college)[var.big.cor]

# Let's find the second biggest correlation (in absolute value):
cor.college.sorted[2]
a2 <- which(abs(cor.college)==cor.college.sorted[2])
var.big.cor2 <- arrayInd(a2,dim(cor.college)) 
colnames(cor.college)[var.big.cor2]

cor.college.sorted[3]
a3 <- which(abs(cor.college)==cor.college.sorted[3])
var.big.cor3 <- arrayInd(a3, dim(cor.college)) 

colnames(cor.college)[var.big.cor3]

var1 <- rep(NA,10)
var2 <- rep(NA,10)
high.cor <- rep(NA,10)

high.cor.data <- data.frame(var1,var2, high.cor, row.names=1:10)
for (i in 1:10) {
  which(abs(cor.college)==cor.college.sorted[i])
  a <- which(abs(cor.college)==cor.college.sorted[i])
  var.big.cor <- arrayInd(a, dim(cor.college))
  high.cor.data[i,1:2] <- colnames(cor.college)[var.big.cor]
  high.cor.data[i,3] <- cor.college[var.big.cor]
}
high.cor.data

# Visualizing relationships among variables, with  pairs()
pairs(college.1[,2:ncol(college.1)])

pairs(~S.F.Ratio+Expend+Top10perc+Grad.Rate+perc.alumni, data=college.1)

pc.college <- prcomp(college.1[,2:ncol(college.1)], scale.=TRUE)

summary(pc.college)
par(mfrow=c(1,1))
plot(pc.college, type="l")
biplot(pc.college)


# Linear regression model
# We can use lm() to fit a linear regression model. The first argument is 
# a formula, of the form  Y ~ X1 + X2 + ... + Xp, where Y is the 
# dependent variable and X1, ., Xp are the regressors. These refer to 
# column names of variables in a data frame, that we pass in through the data 
# argument

reg <- lm(perc.alumni ~ enr.rate + Private + S.F.Ratio + Expend + Top10perc, data=college.1)
summary(reg)
round(reg$coefficients,5)

# Day 2 ####

reg <- lm(perc.alumni ~ Private + Top10perc, data = college.1)
reg

plot(perc.alumni ~ Private, data = college.1)
plot(perc.alumni ~ Top10perc, data = college.1)

# Utility functions
# FLinear models in R come with a bunch of utlity functions
# sucah as coef() and ...

# Call esimated coefficients with coef()

reg.coef <- coef(reg)
reg.coef
reg$coefficients

# Call fitted values with firred()
# Using the fitte() function, we can plot the actual values versus the fitted ones
reg.fit <- fitted(reg) # yhat
plot(reg.fit, college.1$perc.alumni, main = 'Actual vs Fitted', xlab = 'fitted values', ylab = '% of Alumni who donate')
abline(a=0, b=1, lty = 2, lwd =3, col= 'red')

# Displating an overview with summary()
# The function summary() gives us a nice summary of the linear model we fit:

summary(reg)

# This 

x <- runif(100, min = 0, max = 2 * pi)
y <- 10 * sin(x) + rnorm(100)

reg1 <- lm(y~x)
plot(x,y)
abline(reg1)
plot(reg1)

x <- runif(100, min = 0, max = 2)
y <- x + rnorm(100)*x

reg2 <- lm(y~x)
plot(x,y)
abline(reg2)
plot(reg2)


xtemp <- runif(50, min = 0, max = 2)
ytemp <- xtemp + rnorm(50, 0, 0.5)
x <- c(2, xtemp)
y <- c(-10, ytemp)

reg3 <- lm(y~x)
plot(x,y)
abline(reg3)
plot(reg3)

# Day 3 ####
college <- read.csv("College.csv")
dim(college)
head(college)
college2 <- college[,c(-1,-7,-8,-9,-10,-11,-12,-14,-15)]

reg <- lm(perc.alumni ~ Private + Top10perc, data = college2)

# MAking predictions with predict()
# with new observations on Private and Top10perc, we may predict perc.alumni based
# on the estimated model.

newObs <- data.frame(Private = 'Yes', Top10perc = 30)
predReg <- predict(reg, newObs)
predReg

# Some tips
# If you don't want to include an intercept
reg5 <- lm(perc.alumni ~ 0 + Private + Top10perc, data = college2)

# Include all predictors: use '.' on the right side of the formula
reg6 <- lm(perc.alumni ~ ., data = college2)

# Include interaction terms: use ':' between two predictors of interest, to include the interaction between theem as a predictor
reg7 <- lm(perc.alumni ~ Private + Top10perc + Private:Top10perc, data = college2)
summary(reg7)

# include polynomial terms as regressors
college2$z <- college2$Top10perc ^ 2 # ASSINGING A VLUE TO A DATA FRAME AND GIVING IT A NAME
reg8 <- lm(perc.alumni ~ Private + Top10perc + I(Top10perc ^ 2), data = college2)

# Beyond linear models
# Logisitic regression modeling
# We can use glm() to fit a logistic regression model. The arguments are bery similar to lm()
# The first argument is a formula of the form Y ~ X1 + X2 + ... + Xp, where Y is the response and X1, ..., Xp are the predictors
# We must also specify family = 'binomial' to get logisitic regression

table(college2$Private)

head(college2)

# You may want to see which variables are associated with Private
par(mfrow = c(3,3), mar = c(4,4,2,0.5))

for (j in c(2:10)) {
  plot(college2[,1],college2[,j], xlab = 'Private', main = paste('Boxplot of', colnames(college2[j])), col = 'lightblue')
}

logistic <- glm((Private == 'Yes') ~ S.F.Ratio + perc.alumni, data = college2, family = 'binomial')

# Utility functions wokr as before
# To call coefficients, fitted values, residuals, summarizing, plotting, making predictions, the utility functions coef(), fitted(), residuals(), summary(), plot(), predict() work pretty much jas as with lm()

coef(logistic)

summary(logistic)

pHat <- fitted(logistic)
yHat <- round(pHat) # if probability is <0.5, it goes to "public"
table(yHat, y.true = college2$Private)
table(college2$Private)

# Exercise

# You can create a dummy variable fro ma continuous vvariable, for example
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
dim(college)
head(college)
college.1 <- college[,c(-1,-7,-8,-9,-10,-11,-12,-14,-15)]

head(college.1)

reg <- lm(perc.alumni ~ Private + Top10perc, data=college.1)
summary(reg)

# Making predictions with predict()
# With new observations on Private and Top10perc, we may predict perc.alumni based on the estimated model.

new.obs <- data.frame(Private="Yes", Top10perc=30)
pred.reg <- predict(reg, new.obs)
pred.reg

# Some tips
# If you don't want to include an intercept
reg5 <- lm(perc.alumni ~ 0 + Private + Top10perc, data=college.1)

# Include all predictors: use . on the right-hand side of the formula
reg6 <- lm(perc.alumni ~ ., data=college.1)

# Include interaction terms: use : between two predictors of interest, to include the interaction between them as a predictor.
reg7 <- lm(perc.alumni ~ Private + Top10perc + Private:Top10perc, data=college.1)

# include polynomial terms as regressors
reg8 <- lm(perc.alumni ~ Private + Top10perc + I(Top10perc^2), data=college.1)

# Beyond linear models
# Logistic regression modeling
# We can use glm() to fit a logistic regression model. The arguments are very similar to lm()
# The first argument is a formula, of the form Y ~ X1 + X2 + ... + Xp, where Y is the response and X1,..., Xp are the predictors. 
# We must also specify family="binomial" to get logistic regression

table(college.1$Private.2)

head(college.1)

# You may want to see which variables are associated with Private.
par(mfrow=c(3,3), mar=c(4,4,2,0.5))

for (j in c(2:10)) {
  plot(college.1[,1],college.1[,j], xlab="Private",
       main=paste("Boxplot of", colnames(college.1)[j]),
       col="lightblue")
}

logistic <- glm((Private=="Yes") ~ S.F.Ratio + perc.alumni, data=college.1, family="binomial")

# Utility functions work as before
# To call coefficients, fitted values, residuals, summarizing, plotting, making predictions, 
# the utility functions coef(), fitted(),  residuals(), summary(), plot(), predict() work pretty much just as with lm().

coef(logistic)

summary(logistic)

p.hat <- fitted(logistic)
y.hat <- round(p.hat)
table(y.hat, y.true=college.1$Private.1)

# Exercise

# You can creat a dummy variable from a continuous variable. For example, 
college.1$dummy_pc <- as.numeric(college.1$perc.alumni > mean(college.1$perc.alumni))

# Find the variables that provide good prediction for this dummy varaible.