# 1 which league is the best in terms of wage (eur_wage) and overall?

getwd()
setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/Week5/DataSets")
dir()
sc <- read.csv("complete.csv", stringsAsFactors = FALSE, na.strings = "")
# na.strings = "" means that any empty strings become "NA", we can change that from "" to " " or "." or whatever
sc <- sc[, c("name", "club", "age", "league", "eur_value", "eur_wage", "overall")]
head(sc)

str(sc)
# str tells us about what each of these columns are in the data.frame
summary(sc)

lWage <- aggregate(sc[, "eur_wage"], list(sc$league), mean)
# this gives us the mean of the eur_wage by each league (the list)
names(lWage) <- c("league", "avgWage")
head(lWage)
tail(lWage)

rankWage <- order(lWage[, "avgWage"], decreasing = TRUE)
lWage <- lWage[rankWage, ]

lOverall <- aggregate(sc[,"overall"], list(sc$league), mean)
names(lOverall) <- c("league", "avgOverall")

rankOverall <- order(lOverall[, "avgOverall"], decreasing = TRUE)
lOverall <- lOverall[rankOverall, ]

# 2

rank_value <- order(sc[,"eur_value"], decreasing = TRUE)
lValue <- sc[rank_value, ]
lValue100 <- lValue[1:100,]
lValue100$rank_value <- 1:100

str(lValue100)
teamStat <- summary(factor(lValue100$club))
teamStat <- sort(teamStat, decreasing = TRUE)
teamStat

# 3 Present the distribution of avg wage based on age
ageWage <- aggregate(sc[, "eur_wage"], list(sc$age), mean)
names(ageWage) <- c("age", "avgWage")
plot(ageWage$age, ageWage$avgWage, xlab = "age", ylab = "average wage", type = "b")
boxplot(eur_wage~age, data = sc, xlab = "age", ylab = "wage", range = 0)

# 4 Which team has the most players under 23?

team23 <- factor(sc[sc$age<23, "club"])
teamAge <- table(team23)
teamAgeRank <- sort(teamAge, decreasing = TRUE)
teamAgeRank[1:10]
