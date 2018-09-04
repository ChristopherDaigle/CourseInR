## Chris Daigle
## Homework 1

## Exercise 1
# Using the vector operation in R, obtain the slope coefficient
set.seed(2)
x <- rchisq(20, 5)

e <- rnorm(length(x), 0, 5)

y <- 3 + 2*x + e

b_hat <- (sum((x-mean(x))*(y-mean(y))))/(sum((x-mean(x))^2))
print(b_hat)

## Exercise 2
vector1 <- rbinom(100, 1, 0.5)
x2.3 <- seq(-1,1)
x2.2 <- 0
x2.1 <- rep(x2.2,100)
vector2 <- x2.1 + x2.3
vector2

same <- which(vector1 == vector2)
print(same)

## Exercise 3
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, 350, 10)

days_vector <- c("Mon", "Tue", "Wed", "Thu", "Fri")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

poker_midweek <- poker_vector[c("Tue", "Thu")]

ave_poker_midweek <- mean(poker_midweek)

max_poker_vector <- max(poker_vector)
print(max_poker_vector)

loc_max_poker_vector <- which.max(poker_vector)
print(loc_max_poker_vector)

poker_rev_larger <- which(poker_vector > roulette_vector)
print(poker_rev_larger)

total <- poker_vector + roulette_vector
total_poker <- sum(poker_vector)
print(total_poker)
total_roulette <- sum(roulette_vector)
print(total_roulette)
total_poker > total_roulette

## Exercise 4
set.seed(pi)
num <- sample(1:10, 1000, TRUE)
a <- sample(1:20, 20, TRUE)
num[num == a] <- NA
num
which(is.na(num))