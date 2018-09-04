## Week 4

# Data structure: 3. Factor

# Factor one of data structures used to store categorical varaibles. (e.g., gender)

# Gender vector

gender <- c("Male", "Female", "Female", "Male", "Male")
is.vector(gender)
class(gender)

# Convert gender_vector to a factor
factor_gender <- factor(gender)
factor_gender

# There are two different types of categorical variables:
# nominal categorical varaible and ordinal catageorical variable.
# 1. Nominal categorical variable: There is no implied order among categories.
# For example, Male and Female, and Cat, Dog, and Turle
# 2. ORdinal categorical variable: There is a natural oredering.
# For example, "Low", "Medium"m, and "High", and "Primary", "Middle", "High"

#numeric vector()
a <- c(0,0,1,0,1,1,1,0,1,0)
factor_a <- factor(a)

# No ordering
pet <- c("Cat", "Dog", "Turtle", "Dog", "Cat", "Cat")
factor_pet <- factor(pet)
factor_pet
summary(factor_pet)
class(factor_pet)

# Natural ordering
income <- c("High", "High", "Low", "Medium", "Low")
# You can specify the order (or level)
fac_inc <- factor(income, ordered = TRUE, levels <- c("Low", "Medium", "High"))
fac_inc
class(factor_income)

# In survey, abbreviations are often usde because it is convenient to record.
# But this can be confusing when you use surbvey data
# Yoi can recover th efull words using levels function
edu <- c("E", "E", "H", "M", "H", "C")
# If you don't specify the level, it will be alphabetical
fac_edu <- factor(edu, ordered = TRUE, levels <- c("E", "M", "H", "C"))
levels(fac_edu) <- c("Elementary", "Middle", "High", "College")
fac_edu
as.numeric(fac_edu)

# summarize the factor
summary(factor)
summary(edu)

# compare elements of a factor
a <- fac_edu[3]
b <- fac_edu[6]
a>b

## Day 2:

# Data frame is just like a matrix EXCEPT a matrix must be homogenuous

# Data structure : 4. Data frame
# A data frame is a two dimensional format of data structure that is useful to
# store data in tables. In general, each column is for a different item and
# each row is for a different unir.
# Variables in each column is of the same length, but possibly
# different trpe of cariables. (numeric, factor, character)
 # <-> Elemtns ofa matrix should be of the same type

rm(list=ls())
name <- c("Tom", "James", "Mary", "Paker")
score <- c(9, 7, 6, 10)
grade <- factor(c("A", "C", "D", "A"), ordered = TRUE, levels = c("D","C","B","A"))
Econ_dep <- data.frame(name, score, grade)

Econ_dep

str(Econ_dep)
# gives us the number of observations (#number of rows)
# the number of variables (# of coliumns), full list of the variable names,
# Name is not a factor. Two persons with the same name are not in the same category,
# A character vector is converted to a factor in data.frame if we dont't specify as a character

Econ_dep1 <- data.frame(name, score, grade, stringsAsFactors = FALSE)
str(Econ_dep1)
Econ_dep2 <- data.frame(I(name), score, grade)
str(Econ_dep2)


Econ_dep$name
name

rm(name, score, grade)

# subset selection and subset elimination
Econ_dep[c(3,1),]
Econ_dep[c(1,3),]
Econ_dep[-c(2,3),]
Econ_dep[c(TRUE,TRUE,FALSE,FALSE),]
Econ_dep[Econ_dep$name == "James",]
Econ_dep[!(Econ_dep$name == "James"),]
subset(Econ_dep, !(Econ_dep$name == "James"))

Econ_dep[,2]
Econ_dep[,-2]
Econ_dep[,c("name", "grade")]
Econ_dep[,c(TRUE,FALSE,TRUE)]
Econ_dep[,!c(TRUE,FALSE,TRUE)]

Econ_dep$grade <- NULL
Econ_dep

# Add a vector to data.frame
attendance <- c("all", "some", "never", "all")
Econ_dep<- cbind(Econ_dep, attendance)
Econ_dep$gender <- c("Male", "Male", "Female", "Female")
str(Econ_dep)
Econ_dep
# We can see that Econ_dep$gender is a character vector, not a factor

Econ_dep$year <- NA
Econ_dep$year[Econ_dep$ name %in% c("Tom", "Mary")] <- 4
Econ_dep
# Sort Econ_dep using order() function
rank <- order(Econ_dep$score, decreasing = TRUE)
Econ_dep[rank,]

attach(Econ_dep)
#data.frame "Econ_dep" is attached to the R search path
# So, we dont need to put Econ_dep$ to call a variable in Econ_dep
detach(Econ_dep)
name

as.matrix(Econ_dep)
# Easy to convert data.frame to matrix

# Grouped data
ID <- 1:20
rand.number <- rnorm(20)
participant <- data.frame(ID, rand.number)

# Generate tww data frames "group 1" and "group 2" from "participant"

group1 <- participant[participant$rand.number > 0,]
group2 <- subset(participant, subset = rand.number <= 0)

# Create a new variable "level" in "participant" to group data

participant$level[participant$rand.number > 0.5] <- "first"
participant$level[participant$rand.number >0 & participant$rand.number <= 0.5] <- "second"
participant$level[participant$rand.number > -0.5 & participant$rand.number <= 0] <- "third"
participant$level[participant$rand.number <= -0.5] <- "fourth"

## Day 3:
rm(list=ls())
name <- c("Tom", "James", "Mary", "Paker")
score <- c(9, 7, 6, 10)
grade <- factor(c("A", "C", "D", "A"), ordered = TRUE, levels = c("D","C","B","A"))
Econ_dep <- data.frame(name, score, grade)

name <- c("Tom", "James", "Mary")
attendance <- c("all", "some", "never")
attitude <- c("good", "good", "bad")
Econ_dep1 <- data.frame(name, attendance, attitude)

Econ_dep_f <- merge(Econ_dep,Econ_dep1, by = "name", all = TRUE, sort = FALSE)
Econ_dep_f

# Adding more units tto a data.frame

name <- c("Jane", "Kim", "John")
score <- c(8,9,5)
grade <- factor(c("A","A","D"), ordered = TRUE, levels = c("D","C","B","A"))
Econ_dep2 <- data.frame(score, name, grade)

Econ_dep_all <- rbind(Econ_dep, Econ_dep2)

## DAta structure5. list

# list is a collection of varius types of dtata structures under on name. Lists can be any size.
# See line 36 in the handout

age1 <- c(3,5,6)
age2 <- c(4,3)
emp <- list(employee = c("Anna", "Tom"), children = c(2,3), children_age = list(age1,age2))
length(emp)
str(emp)
class(emp)

gdp <- c(1549.13, 1371.15, 1613.46, 1788.65, 1824.29, 1792.88, 1552.81, 1529.76)
year <- 2008:2015
names(gdp) <- year

provinces <- c("AB", "BC", "MB", "NB", "NS", "ON", "PE", "QC", "SK")

cities <- data.frame(name = c("Toronto", "Montreal", "Vancouver", "Calgary"), pop = c(5930, 4100, 2463, 1393))

Canada <- list(gdp, provinces, cities)
Canada
str(Canada)

names(Canada) <- c("GDP", "Prov", "City")
rm(gdp, year, provinces, cities)
Canada
str(Canada)
Canada$GDP

# Select a subset of a list

# 1. list slicing: we get a list slice with the single square bracket [].
Canada[3]
Canada[-3]
Canada[c(1,3)]
Canada[c(T,F,T)]
Canada[names(Canada) == "City"]

is.list(Canada[3])

# 2. Select components from the inside of a list, not slicing
Canada[[3]]
class(Canada[[3]])
Canada[[3]][2,]
Canada[[2]][3]
Canada[["GDP"]][3]
Canada[["GDP"]][names(Canada[["GDP"]])==2010]

Canada$GDP[names(Canada$GDP)==2010]

# Adding a component to a list

Lan = c("English", "French")
Canada$Language <- Lan
str(Canada)
Canada