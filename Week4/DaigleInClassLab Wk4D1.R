## Chris Daigle
## In class Lab: Wk4D1

# Exercise 1
set.seed(pi)
r <- rnorm(2754, 0, 1)
income <- exp(r)

# find 1/10, 7/20, 15/20, 98/100 quantiles of income, you can use "quantile()"
quant <- quantile(income, c(0.10, 0.35, 0.75, 0.98))

# construct a vector, income.level, as follows:
income.level <- rep(NA, 2754)
income.level[income <= quant[1]] <- "VL"
income.level[income > quant[1] & income <= quant[2]] <- "L"
income.level[income > quant[2] & income <= quant[3]] <- "M"
income.level[income > quant[3] & income <= quant[4]] <- "H"
income.level[income > quant[4]] <- "VH"

# Make an ordered factor from income.level. Specify the levels.
factor_income.level <- factor(income.level, ordered = TRUE, levels <- c("VL", "L", "M", "H", "VH"))

#rename
levels(factor_income.level) <- c("Very Low", "Low", "Middle", "High", "Very High")

#summary
summary(factor_income.level)

#create a subvector income.high that includes income level is higher than "Middle"
income.high <- income[factor_income.level > "Middle"]
hist(income.high, breaks = 20)

# calculate average income for people with income higher than middle
mean(income.high)

#what's the gap between average income high and very high
gap = mean(income[factor_income.level == "Very High"]) - mean(income[factor_income.level == "High"])
gap

## Exercise 2
industry <- sample(c("Manufacture", "Service", "IT"), 100, replace = TRUE, prob = c(0.3, 0.5, 0.2))
stock <- rep(NA,100)
stock[industry == "Manufacture"] <- rnorm(sum(industry == "Manufacture"), 3, 2)
stock[industry == "Service"] <- rnorm(sum(industry == "Service"), 2, 4)
stock[industry == "IT"] <- rnorm(sum(industry == "IT"), 8, 8)

factor.industry <- factor(industry)
summary(factor.industry)

stockManufacture <- stock[factor.industry == "Manufacture"]
stockService <- stock[factor.industry == "Service"]
stockIT <- stock[factor.industry == "IT"]

mean <- c(mean(stockManufacture), mean(stockService), mean(stockIT))
sd <- c(sd(stockManufacture), sd(stockService), sd(stockIT))

comp <- cbind(mean, sd)
indNames <-c("Manufacture", "Service", "IT")
rownames(comp) <- indNames
comp
str(comp)