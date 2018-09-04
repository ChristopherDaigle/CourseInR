## Christopher Daigle
## Wk3D2 Exercise

# Exercise 1
my.str <-"Reverend Meza, Reverend Reck, I'm grateful for your generous invitation to speak my views. 

While the so-called religious issue is necessarily and properly the chief topic here tonight, I want to emphasize from the outset that we have far more critical issues to face in the 1960 election; the spread of Communist influence, until it now festers 90 miles off the coast of Florida--the humiliating treatment of our President and Vice President by those who no longer respect our power--the hungry children I saw in West Virginia, the old people who cannot pay their doctor bills, the families forced to give up their farms--an America with too many slums, with too few schools, and too late to the moon and outer space. 

These are the real issues which should decide this campaign. And they are not religious issues--for war and hunger and ignorance and despair know no religious barriers."

nchar(my.str)
my.list <- strsplit(my.str, split="")

is.list(my.list)

my.chars <- unlist(my.list)
my.chars_lower <- tolower(my.chars)
my.chars <- my.chars_lower[which(my.chars_lower %in% letters)]

my.chartab <- table(my.chars)
my.chartab
plot(my.chartab, xlab = "Characters", ylab = "Counts")

## Exercise 2
presidents <- c("Bill Clinton", "George Bush", "Ronald Reagan", "Jimmy Carter", "Gerald Ford")

president.list <- strsplit(presidents, split = " ")
president.list
president.vec <- unlist(president.list)
president.vec
president.1st <- president.vec[c(TRUE, FALSE)]
president.1st

## Exercise 3
bill <- "Bill CLinton"
others.first <- c("George", "Ronald", "Jimmy", "Gerald")
others.second <- c("Bush", "Reagan", "Carter", "Ford")

others <- paste(others.first, others.second)
others

substr(others, 1, 1)
substr(others, nchar(others)-5, nchar(others))
president <- c(bill, others)
president

substr(president, 1, 3) <- "abc"
president