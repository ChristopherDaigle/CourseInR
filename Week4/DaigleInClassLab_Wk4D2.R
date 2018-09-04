## Daigle Wk4D2

# Exercise 1
mtcars
head(mtcars)
tail(mtcars)
str(mtcars)
attach(mtcars)
lm(mpg ~ cyl + hp)

# Exercise 2
name <- c("Apple", "MS", "Google", "Honda", "GM", "Volks", "Hyundai", "Amazon")
type <- c("IT", "IT", "IT", "Auto", "Auto", "Auto", "Auto", "IT")
stock <- c(165.5, 55.48, 1119.20, 36.16, 41, 172.06, 162.5, 1429.95)
US <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)

portfolio <- data.frame(name,type,stock,US)
rm(name,type,stock,US)
attach(portfolio)
portfolio[name == "Google",3]
portfolio[name == "Google",]
portfolio[1:5,3]
portfolio[type == "IT",]

subset(portfolio, subset = stock < stock[name == "Apple"])
portfolio[stock < stock[name == "Apple"],]

rank <- order(stock, decreasing = TRUE)
portfolio[rank,]