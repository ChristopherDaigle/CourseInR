# Christopher Daigle
# Week9D3 In Class Lab - Principal Component Analysis

# Exercise ##########################################
# Perform a visualisation similar to that in class from a data set of your choice

# I have chosen to create a dataset from Kaggle related to breweries and two datasets from
# the CDC on impaired/drunk driving

setwd("/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/Project")
# setwd("/Users/daiglechris/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/Project")

# Loading
breweries <- read.csv("breweries.csv", stringsAsFactors = FALSE)
  #breweries2 <- read.csv("breweries2.csv")
duiDeaths <- read.csv("occupantAndAlcohol-ImpairedDrivingDeaths2005_2014.csv", stringsAsFactors = FALSE)
reported <- read.csv("percentAdultsReport2014.csv", stringsAsFactors = FALSE)

head(breweries)
colnames(breweries)[11] <- "State"
table(breweries[,11])

# Cleaning ####
breweries <- breweries[!(breweries$State == 'AB'),] # These observations of Alberta are not in the US
breweries$State[breweries$State == 'AU-WA'] <- 'WA'
breweries$State[breweries$State == 'Denver'] <- 'CO'
breweries$State[breweries$State == 'Los Angeles'] <- 'CA'
breweries <- breweries[!(breweries$State == 'NL'),] # This observation of Ontario is not in the US
breweries <- breweries[!(breweries$State == 'ON'),] # This observation of Ontario is not in the US
breweries$State[breweries$State == 'Pittsburgh'] <- 'PA'
breweries$State[breweries$State == 'Sacramento'] <- 'CA'
breweries$State[breweries$State == 'San Diego'] <- 'CA'
breweries$State[breweries$State == 'St. Louis'] <- 'MO'
breweries$State[breweries$State == 'Tampa'] <- 'FL'

duiDeaths <- duiDeaths[,1:3]

reported <- reported[,1:3]
reported[,1] <- state.abb[match(reported[,1],state.name)]

# Structuring ####
brewByState <- as.data.frame(table(breweries[,11]))
colnames(brewByState) <- c('State', 'numOfBreweries')

colnames(duiDeaths) <- c('State', 'AlcoholImparedDrivingDeaths', 'OccupantDeaths')

colnames(reported) <- c('State', 'PrevalenceIn2012', 'PrevalenceIn2014')

struc1 <- merge(brewByState,reported, all = TRUE)
comData <- merge(struc1, duiDeaths, all = TRUE)
comData[,1] <- as.character(comData[,1])
comData <- comData[-c(8, 52, 53), ]


# Analyzing ####

head(comData)
princomp(c(comData$numOfBreweries, comData$AlcoholImparedDrivingDeaths))

head(comData)
dataInterest <- comData[,2:6]
pairs(dataInterest)
rownames(dataInterest) <- comData[,1]
head(dataInterest)

pc.comData <- prcomp(dataInterest, scale.=TRUE)
pc.comData$rotation
plot(pc.comData, type="l")
biplot(pc.comData)
