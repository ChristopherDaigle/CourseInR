# Operators in R

# (1) Arithmetic

5 + 10 # addition
5 - 10 # subtraction
3 * 5 # multiplication
(5 + 6) / 2 # division
(5 + 6) %/% 2 # Integer quotient, you can also use floor() to have the quotient and modulo
floor ((5 + 6) / 2)
(5 + 6) %% # Modulo (remainder)

2^5 # exponentiation (or 2**5)
sqrt(9) # or 9^(0.5)

# (2) Relational operators: Logical value
# True = 1 and False = 0

17 > 10
17 < 10
7 <= 7 # Inequality should occur first
17 <= 10
17 == 10
17 != 10
(17 > 10) + (17 == 10)
(7 >= 7) < (10 < 7)
3 %in% c(1,3,5,7,9)

# (3) Logical operators: "and" and "or"

(17 > 17) & (TRUE + FALSE == 1)
(17 > 17) | (TRUE + FALSE == 1)
(17 > 17) | (TRUE + FALSE == 1) & (5 + 5 < 11)

#________________#
# Variable Assignment

r <- 3 # Assign the value 3 to r, (r = 3 or 3 -> r also works)

r # prints the value of variable r (print(r) also works)
R # case sensitive

area <- pi * r^2 # pi is a built in constant

# Types of variables

my_numeric <- 2 # numbers are called numeric
my_character <- "Father" # text or string values are called character

my_logical <- FALSE
my_logical2 <- 3 > 2

my_numeric + my_logical + my_logical2

# check the type of 
class(my_numeric)
class(my_character)
class(my_logical)

# check the type of variable
is.numeric(my_character)
is.character(my_character)
is.logical(my_character)

# change the tpye of a variable
my_numeric <- as.character(my_numeric)
class(my_numeric)

my_numeric + my_logical

# Variable assignement for characters
str.1 <- "R"
str.2 <- 'programming'
str.3 <-"isn't too difficult"

str <- paste(str.1, str.2, str.3)