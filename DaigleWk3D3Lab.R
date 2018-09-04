## Christopher Daigle
## Homework 5

# Exercise 1
# Construct the matrices
a <- 1:9
A <- matrix(a**2,3,3, byrow = TRUE)
A
At <- matrix(a**2,3,3)
At

# Exercise 2
Storrs <- c(365, 489)
Hartford <-  c(426, 387)
Stamford <- c(571, 486)
HP_vector <- c(Storrs, Hartford, Stamford)
HP_vector
HP_matrix <- matrix(HP_vector, 3, 2, TRUE)
type <- c("House", "Condo")
colnames(HP_matrix) <- type
Area <- c("Storrs", "Hartford", "Stamford")
rownames(HP_matrix) <- Area
HP_matrix
CT_average <- colMeans(HP_matrix)
# CT_av <- c(mean(HP_matrix[,1]),mean(HP_matrix[,2])) Creating a vector of column means by column selection
HP_matrix.2 <- rbind(HP_matrix,CT_average)
HP_matrix.2

HC_av <- rowMeans(HP_matrix.2)
HP_matrix.f <- cbind(HP_matrix.2,HC_av)
HP_matrix.f

## Exercise 3
#1
set.seed(1)
Income <- rchisq(100,5)
#2
yrsOfEdu <- sample(7:16,100,TRUE)
#3
CT <- cbind(Income,yrsOfEdu)
#4
gender <- sample(c("Male","Female"),100,TRUE)
#5
Female <- c(gender=="Female")
CT1 <- CT*Female
#6
high_Ed <- yrsOfEdu>12
CT2 <- CT*high_Ed
#7
av_Female_Inc <- mean(CT1[,1])
av_HighEd_Inc <- mean(CT2[,1])
exp_Inc <- c(av_Female_Inc, av_HighEd_Inc)
names(exp_Inc) <- c("av_Female_Inc", "av_HighEd_Inc")
exp_Inc