## Chris Daigle
## In class Lab: Wk5D3 ####

# Exercise 1 ####
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
week <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
names(linkedin) <- week
names(facebook) <- week

if (mean(linkedin) > mean(facebook)) {
  cat("You are more popular on LinkedIn than on Facebook")
} else if (mean(linkedin) < mean(facebook)) {
  cat("You are more popular on Facebook than on LinkedIn")
}

# Exercise 2 ####
li <- 15
fb <-9

if ( (li >= 15) & (fb >= 15)) {
  sns <- (li + fb) * 2
} else if ( (li < 10) & (fb < 10)) {
  sns <- (li + fb) / 2
} else {
  sns <- (li + fb)
}
cat(sns)

# Exercise 3 ####
x <- c(0, 5)
i <- 2

while (abs(x[i] - x[i-1])>0.0001) {
  x[i+1] <- x[i] - ((x[i]-1) ** 3 + (0.5) * x[i] ** 2 - x[i] - 2)/(3 * (x[i] - 1) ** 2 + x[i] - 1)
  i <- i + 1
}
cat("The solution to the equation (x-1)^3 + 0.5*x^(1/2) - x - 2 = 0 is x=", x[i])