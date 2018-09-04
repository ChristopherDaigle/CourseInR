## Chris Daigle
## In class lab

## Exercise 1

my_apples <- 5
print(my_apples)
B <- rchisq(1, 5)

my_oranges <- round(my_apples * B)

Comp <- my_apples > my_oranges

my_fruit = my_oranges + my_apples
print(my_fruit)

## Exercise 2

my_character <- "Father"
my_character2 <- "Mother"
print(my_character)

# Which is true?
my_character2 > my_character

#
char.logi <- (is.character(my_character) + is.logical(my_character) - (1/2)) * 2
# 1 0, subtract 1/2, multiply by 2
char.logi <- as.numeric(char.logi)

## Exercise 3

reject <- 0
for (i in 1 : 1000) {
  x <- rbinom(100, 1000, 0.5)
  
  x_bar <- mean(x)
  se_x <- sd(x)
  
  t_x <- (x_bar - 0.5) / (se_x / sqrt(100))
  reject <- (t_x <= -1.96 | t_x >= 1.96)
}
print(reject/1000)

## Exercise 4

First.name <- "Christopher"
Last.name <- "Daigle"

My.name <- paste(First.name, Last.name)

print(My.name)

## Exercise 5
states <- state.name
Tom <- "Conecticut" %in% states
print(Tom)