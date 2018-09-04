# #Week 5 Day 1 #####
# getwd()
# setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/Week5/DataSets")
# dir()
# rev_exp0 <- read.csv("district_rev_exp.csv")
# 
# rev_exp <- read.csv(file.choose(), stringsAsFactors = FALSE)
# 
# rev_exp$STATE <- as.factor(revexp$STATE)
# 
# class(rev_exp)
# head(rev_exp0)
# tail(rev_exp)
# 
# str(rev_exp)
# summary(rev_exp)
# 
# rev_exp$TOTALREV[rev_exp$TOTALREV == "-"] <- NA
# rev_exp$TOTALREV <- as.numeric(rev_exp$TOTALREV)
# 
# # Calculate the averages of enrollment, total revenue and total expecnditure for each state.
# colMeans(rev_exp[rev_exp$STATE == "California", c("ENROLL", "TOTALREV", "TOTALEXP")], na.rm = TRUE)
# colMeans(rev_exp[rev_exp$STATE == "Connecticut", c("ENROLL", "TOTALREV", "TOTALEXP")], na.rm = TRUE)
# colMeans(rev_exp[rev_exp$STATE == "Massachusettes", c("ENROLL", "TOTALREV", "TOTALEXP")], na.rm = TRUE)
# colMeans(rev_exp[rev_exp$STATE == "Missouri", c("ENROLL", "TOTALREV", "TOTALEXP")], na.rm = TRUE)
# 
# aggregate(rev_exp[ , c("ENROLL", "TOTALREV", "TOTALEXP")], list(rev_exp$STATE), mean, na.rm=TRUE)
# # list() specifies the criterion to make groups
# aggregate(rev_exp[ , c("ENROLL", "TOTALREV", "TOTALEXP")], by = list(ST = rev_exp$STATE, EnR = rev_exp$ENROLL > 1000), mean, na.rm=TRUE)
# 
# a <- na.omit(rev_exp) # eliminate the rows that contain NA
# 
# # 2. text file: tab-delimited file
# # district_rev_exp.txt
# rev_exp1 <- read.delim(file.choose(), stringsAsFactors = FALSE)
# 
# head(rev_exp1)
# tail(rev_exp1)
# 
# #3. read.table: read any tabulat file as a data.frame
# rev_exp2 <- read.table(file.choose(), sep = "/", stringsAsFactors = FALSE)
# head(rev_exp2)
# str(rev_exp2)
# names(rev_exp2)
# 
# # table doesnt know that the first line is headers, so you must identify it as such if it is
# rev_exp2 <- read.table(file.choose(), sep = "/", header = TRUE, stringsAsFactors = FALSE)
# head(rev_exp2)
# str(rev_exp2)
# names(rev_exp2)
# 
# # we can also read a csv file and tab delimited txt file using read.table
# rev_exp3 <- read.table(file.choose(), sep = ",", header = TRUE, stringsAsFactors = FALSE) # district_rev_exp.csv
# rev_exp3 <- read.table(file.choose(), sep = "\t", header = TRUE, stringsAsFactors = FALSE) # district_rev_exp.csv
# 
# # You can save excel file with csv or tab delimited txt file. Then, you can use to read the file.
# # You can read excel file directly
# # First install the package "readxl"
# install.packages("readxl")
# library(readxl)
# excel_sheets(file.choose())
# rev_exp4 <- read_excel(file.choose(), sheet = 1)
# 
# # iYou can also import data from Stata
# install.packages("foreign")
# library(foreign)

# ## D2 ####
# ## Review of exercise 5d1
# rm(list=ls())
# 
# # 1 which league is the best in terms of wage (eur_wage) and overall?
# 
# getwd()
# setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/Week5/DataSets")
# dir()
# sc <- read.csv("complete.csv", stringsAsFactors = FALSE, na.strings = "")
# # na.strings = "" means that any empty strings become "NA", we can change that from "" to " " or "." or whatever
# sc <- sc[, c("name", "club", "age", "league", "eur_value", "eur_wage", "overall")]
# head(sc)
# 
# str(sc)
# # str tells us about what each of these columns are in the data.frame
# summary(sc)
# # this tells 
# 
# lWage <- aggregate(sc[, "eur_wage"], list(sc$league), mean)
# # this gives us the mean of the eur_wage by each league (the list)
# names(lWage) <- c("league", "avgWage")
# head(lWage)
# tail(lWage)
# 
# rankWage <- order(lWage[, "avgWage"], decreasing = TRUE)
# lWage <- lWage[rankWage, ]
# 
# lOverall <- aggregate(sc[,"overall"], list(sc$league), mean)
# names(lOverall) <- c("league", "avgOverall")
# 
# rankOverall <- order(lOverall[, "avgOverall"], decreasing = TRUE)
# lOverall <- lOverall[rankOverall, ]
# 
# # 2
# 
# rank_value <- order(sc[,"eur_value"], decreasing = TRUE)
# lValue <- sc[rank_value, ]
# lValue100 <- lValue[1:100,]
# lValue100$rank_value <- 1:100
# 
# lValue100
# str(lValue100)
# teamStat <- summary(factor(lValue100$club))
# teamStat
# teamStat <- sort(teamStat, decreasing = TRUE)
# teamStat
# 
# # 3 Present the distribution of avg wage based on age
# ageWage <- aggregate(sc[, "eur_wage"], list(sc$age), mean)
# names(ageWage) <- c("age", "avgWage")
# ageWage
# plot(ageWage$age, ageWage$avgWage, xlab = "age", ylab = "average wage", type = "b")
# boxplot(eur_wage~age, data = sc, xlab = "age", ylab = "wage", range = 0)
# 
# # 4 Which team has the most players under 23?
# 
# team23 <- factor(sc[sc$age<23, "club"])
# teamAge <- table(team23)
# teamAgeRank <- sort(teamAge, decreasing = TRUE)
# teamAgeRank[1:10]

# ### Time and date data
# today <- Sys.Date()
# today
# class(today)
# 
# now <- date()
# now
# class(now)
# 
# # Use as.Date() to cover charachter to dates
# a <- c("2007-06-22", "2004-02-13")
# class(a)
# myDates <- as.Date(a)
# myDates
# class(myDates)
# 
# a1 <-c("01/13/2013", "Feb-03-2013", "12/11/2014")
# as.Date(a1)
# myDates1 <- as.Date(a1, format= c("%m/%d/%Y", "%b-%d-%Y"))
# myDates1
# 
# format(myDates1, format = "%B %d %Y")
# format(myDates1, format = "%m-%d-%y")
# format(myDates1, format = "%Y")
# 
# # We can compare dates
# myDates[1] > myDates[2]
# days <- myDates[1] - myDates[2]
# days
# class(days)
# 
# myDates[1]
# myDates[1] + 1
# myDates[1] +30
# myDates[1] + 365

# Day 3 ####

# conditional statement: if and if-else

# Sometimes, we want to run one piece of code if some condition is true, but a 
# different piece of code if it is false. We can do this using if-else satement.

# syntex of if statement
# if (condition) {
# statement
# }
# 

if ( 3 != 4) {
  print ("3 is not equal to 4")
}

if (nchar("boy") < nchar("girl")) {
  print("Girl is taller than boy")
}

if ( 3 == 4) {
  print ("3 is equal to 4") # nothing executed because the condition doesn't hold.
}

# syntex of if-else statement
# if (condition) {
# statement 1
# } else {
# statement 2
# }
# 

# The else part is optional and is only evaluated if condition is false. It is important to know that the
# else must be in the same line as the closing brace of the if statement

set.seed(4)
R <- c("Zaur", "Rob", "Louis", "Tim", "Hanli", "Chris", "Jieun", "Xizi", "Busra", "Jinsoon", "Xuanye",
       "Chaoyuan", "Yiyan", "Rui", "Tyler", "Kenn", "Alexandra", "Di", "Zhonghui", "Lindsay")
R.boy <- c("Zaur", "Rob", "Louis", "Tim", "Chris", "Xizi", "Jinsoon", "Chaoyuan", "Tyler", "Kenn", "Zhonghui")
R.girl <- R[!(R %in% R.boy)]

a <- sample(x=R, size=5, replace=FALSE)

if (sum(a %in% R.girl) > sum(a %in% R.boy)) {
  cat("Girls are more than boys in R class")
} else {
  cat("Boys are more than Girls in R class")
}

# We can have as many if-else statements as we want.
# Syntex

# if (condition 1) {
# statement 1
# } else if (condition 2) {
# statement 2
# } else if (condition 3) {
# statement 3 
# } else {
# statement 4
# }

player1 <- "rock"
player2 <- "rock"

if ( (player1 == "rock"& player2 == "scissors") | (player1 == "scissors"& player2 == "paper") 
     | (player1 == "paper"& player2 == "rock") ) {
  cat("Player1 win!")
} else if ((player1 == "scissors" & player2 == "rock") | (player1 == "paper"& player2 == "scissors") 
           | (player1 == "rock"& player2 == "paper")) {
  cat("Player2 win!")
} else {
  cat("Tie!")
}


# While loop: Loops are used in programming to repeat a specific block of code.
# While loop repeat as long as the given condition is true. 
# Draw a flowchart 

# Syntex of while loop
# while (condition) {
# statement
# }

# Example: Initialize the speed variable
speed <- 64
# Code the while loop
while ( speed > 30 ) {
  cat("Slow down!")
  speed <- speed - 7
}

cat("Ok, now. The speed is", speed, "miles/hour")

# Newton-Raphson method for f(x) = x^3 + 2*x
# The Newton-Raphson method is an approach for finding the roots of nonlinear
# equations and is one of the most common root-finding algorithms due to its 
# relative simplicity and speed. 

x <- seq(-6,6, by=0.01)
y <- x^3 + 2*x
plot(x,y, type="l")

x <- c(0, 5)
i <- 2

while (abs(x[i] - x[i-1])>0.0001) {
  x[i+1] <- x[i] - (x[i]^3 + 2*x[i])/(3*x[i]^2 + 2)
  i <- i + 1
}
cat("The solution to the equation x^3 + 2*x = 0 is x=", x[i])

# Law of large numbers

xbar <- c(10)
i = 1
mu = 0
while ( abs(xbar[i] - mu) > 0.000001) {
  x <- runif(i, -3, 3)
  xbar[i+1] <- mean(x)
  i <- i + 1
}

cat ("xbar is", round(xbar[i],3))