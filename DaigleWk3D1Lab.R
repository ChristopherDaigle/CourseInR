## Chris Daigle
## Wk3D1 Lab

# Exercise 1
set.seed(pi)
nor <- rnorm(200,6,9)

nor_mid <- nor[(nor >= 4) & (nor <= 7)]
which((nor >= 4) & (nor <= 7))
nor_end <- nor[(nor < 3) | (nor > 9)]

# Exercise 2
set.seed(1)
income <- rchisq(1000, 8)
mid_inc <- quantile(income, probs = seq(0.4, 0.6, 0.2))
print(mid_inc)
hist(income[income >= mid_inc[1] & income <= mid_inc[2]])

# Exercise 3
linkedin <- c(16,9,13,5,2,17,14)
facebook <- c(17,7,5,16,8,13,14)
week <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
names(linkedin) <- week
names(facebook) <- week

names(which(linkedin >15))
names(which(linkedin <= 5))
names(which(linkedin > facebook))

# Exercise 4
set.seed(1)
x <- rnorm(1000, 0, 1)
extreme <- (x>1.96) | (x< (-1.96))
extreme[extreme == FALSE] <- 0
cnt_true <- sum(extreme)
print(cnt_true)
prop_true <- (cnt_true / 1000)*100
prop_true

# Exercise 5
set.seed(pi)
numbers <- sample(1:1000, 1000, replace = TRUE)
even <- (numbers %% 2 == 0)
cnt_even <- sum(even)
cnt_even

# Exercise 6
salary <- c(54,35,65,34,67,76,100,3,154,44,37,98,254)
name <- c("Tom", "Annie", "John", "Park", "Kim", "Bob", "Julia", "Ben", "Steven", "Nick", "Lee", "Rick", "Don")
names(salary) <- name
salary[which(substr(name,1,1) %in% LETTERS[1:11])]