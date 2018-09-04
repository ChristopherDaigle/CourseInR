## Wk3D1

# Logical Vectors

# Logical vectors can take the values, "TRIE" or "FALSE"
b <- c(TRUE, TRUE, FALSE, TRUE)
is.logical(b)
class(b)

b1 <- c(3>0, 4>3, "Father" > "Mother", "Father" == "Mother")
is.logical(b1)
b1 <- as.numeric(b1) # as.numeric() is the function to transfer to the numeric
class(b1)

c <- b*1
class(c)
c1 <- as.logical(c)

# You can also try this. : variable type is homogenous
vec <- c(3, FALSE, 5, 6, 2, NA, pi);
class(vec);
vec[is.na(vec)] <- 0
vec2 <- c("character", TRUE)
class(vec2)


#  Evaluate how one object is related with another object

c(3>0,-3<0) & c(3%in%1:5, -3%in%1:5)
c(3>0,-3<0) && c(3%in%1:5, -3%in%1:5) # Compate the first elements of two, ignores the second
c(-3>0,3<0) && c(-3%in%1:5, 3%in%1:5)

c(3>0,-3<0) | c(3%in%1:5, -3%in%1:5)
c(3>0,-3<0) || c(3%in%1:5, -3%in%1:5) # Compate the first elements of two, ignores the second
c(-3>0,3<0) || c(-3%in%1:5, 3%in%1:5)

c(!(3>0), !(-3>0))
!c(-3>0, 3>0)

1:10 %in% 3:7

1:10 > 5

# We can use this logical vector to select subsets of a vector.
# Elements are selected if they are corresponding to TRUE.
# Alternatively, you can use "which()" function.
z <- runif(10, min = -1, max  = 1)
z_sub <- z[c(1,3,5)] # picks the first, third, and fifth componenet of z
z_plus <- z[z>0] # picks up components corresponding to TRUE, similar to the which command
z_minus <- z[!(z>=0)]
z[z<0] <- -z[z<0]

z_ind <- 1:20
z_ind[z>0.5] # recycling rule applies

## Wk3D2

# Character Vector

# Chraracter is a symbol in a written like letters, numerals, punctutation, space, etc/
# String is a sequence of characters bound together. Al of interesting data is in character
# Form, e.g. webpages, emails, surveys, etc

# A character vector is a vector of text strings whose elements are specified in quotes.

name1 <- c("Clinton", "Bush", "Obama");
name2 <- c("Reagan", "Carter", "Ford");
name <- c(name1, name2)
is.vector(name)
class(name)
is.character(name)

rev.name <- rev(name);
num <- nchar(name)

num2 <- nchar(c("Bill Clinton", "Spider-Man"))
size <- length(name)

# Substring
phrase <- "Give me a break"
substr(phrase, 1, 4)
substr(phrase, nchar(phrase)-4, nchar(phrase))
substr(name, 1, 2) # gives first and second letter in each element of the vector
substr(name, 1:6, 1:6) # gives "1:1" for first componenet, "2:2" for second component, and so on
substr(name, 1, 1:6) # gives 1:1 for 1, gives 1:2 for 2, and so on

name[substr(name, 1, 1) %in% c("B", "C")]

# Replacement
substr(phrase, 1, 1) <- "L"
phrase
substr(phrase, 1, 4) <- "Show"
phrase
name
first.letters <- substr(name, 1, 1)
first.letters.scrambled <- sample(first.letters)
substr(name, 1, 1) <- first.letters.scrambled
name

# Split
word <- strsplit(phrase, split = " ")
word
word <- unlist(word)
word


lett <- strsplit(name, split = "")
lett
lett <- unlist(lett)
lett
# lett <- unlist(strsplit(name, split = "")) works as well, combine each of these commands into one

# Combine
edu <- c("elementary", "middle", "high", "university")
ord <- c(1,2,3,4)
yrs <- c(5,3,4,4)

paste(ord, edu) # combines this into a vector with a space between each item, elementwise, will recycle if dimensionality problem
paste(ord, edu, sep=".") # combines this into a vector with a period between each item, elementwise
paste(edu, " (", yrs, ")", sep="")

# Converting other data types to strings
num_string <- as.character(num)
logi_string <- as.character(c(T,T,F,F,NA))

# Converting to lower or uppercase
name_upper <- toupper(name1)
namelower <- tolower(name2)

# If we want to remove " " in the output, we can use the cat function.
cat(c("Annie", "John", "Pam", "Sean", "Tom", "Ken"))
cat("What is \"R\"?") # \ : escape character

# Buit-in charaacter vectors in R
LETTERS
letters
month.abb
month.name

"hi" %in% c("hola", "hi", "hello")
"hi" %in% c("hola", "hide", "hello")
