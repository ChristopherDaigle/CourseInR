# Chris Daigle
# Week11 Day 3 - 6 April

# college <- read.csv("/Users/daiglechris/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/College.csv")
college <-
  read.csv(
    "/Users/2011home/Library/Mobile Documents/com~apple~CloudDocs/Education/UConn/Spring 2018/R/DataSets/College.csv"
  )

# College data: Demographic characteristics, tuition, and more of USA colleges
# Private: Public/Private indicator
# Apps: Number of applications recieved
# Enroll: Number of new students enrolled
# Top10perc: New students from top 10% of high school class
# Top25perc: New students from top 25% of high school class
# F.Undergrad: Number of ful-time undergraduates
# P.Undergrad: Number of part-time undergraduates
# Outstate: Out-of-state tuition
# Room.Board: Room and board costs
# Books: Estimated book costs
# Personal: Estimated personal spending
# PhD: Percent of faculty with Ph.D.'s
# Terminal: Percent of faculty with terminal degree
# S.F.Ratio: Student/faculty ratio
# perc.alumni: Percent of alumni who donate
# Expend: Instructional expenditure per student
# Grad.Rate: Graduation rate

# 1. Compare the distributions of "personal" between private school and public school.
# For this, you can first draw box plots and do 2 sample t test.
head(college)
boxplot(
  college$Personal ~ college$Private,
  xlab = "Private College",
  ylab = "Estimated Personal Spending",
  main = 'Spending by Private and Public Colleges'
)
t.test(college$Personal[college$Private == 'No'], college$Personal[college$Private == "Yes"], var.equal = TRUE)

# 2. Divide the colleges into three groups based on Top10perc. Make the group sizes to be
#the same with each other. (I interpret this as "evenly split the Top10perc group into
# thirds and have those be subgroups")
head(college)

# private <- college[college$Private == 'Yes',]
# public <- college[college$Private == 'No',]
#
# private1 <- subset(private, Personal <= quantile(private$Personal, probs = seq(0,1, 1/3), na.rm = TRUE)[2])
# private2 <- subset(private, Personal > quantile(private$Personal, probs =
# seq(0,1, 1/3), na.rm = TRUE)[2] & Personal <= quantile(private$Personal, probs
# = seq(0,1, 1/3), na.rm = TRUE)[3])
# private3 <- subset(private, Personal > quantile(private$Personal, probs = seq(0,1, 1/3), na.rm = TRUE)[3])
#
# quantile(public$Personal, probs = seq(0, 1, 1/3), na.rm = TRUE)
# public1 <- subset(public, Personal <= 1368)
# public2 <- subset(public, Personal > 1368 & Personal <=1951)
# public3 <- subset(public, Personal > 1951)
#
# college1 <- subset(college, Personal <= quantile(college$Personal, probs =
# seq(0,1, 1/3), na.rm = TRUE)[2]) college2 <- subset(college, Personal >
# quantile(college$Personal, probs = seq(0,1, 1/3), na.rm = TRUE)[2] & Personal
# <= quantile(college$Personal, probs = seq(0,1, 1/3), na.rm = TRUE)[3])
# college3 <- subset(college, Personal > quantile(college$Personal, probs =
# seq(0,1, 1/3), na.rm = TRUE)[3])

# I realize now this was not the desired result, here is the answer:

college <- college[order(college$Top10perc), ]
head(college)
college1 <- college[1:259,]
college2 <- college[260:518,]
college3 <- college[519:777,]

# Compare the mean of "Grad.Rate" among these three groups. If you conclude there is any difference, identify which pair of groups have different means

mean1 <- summary(college1$Grad.Rate)[4]
mean1
mean2 <- summary(college2$Grad.Rate)[4]
mean2
mean3 <- summary(college3$Grad.Rate)[4]
mean3

# Put simply, each of these are unequal. No t-test is needed.