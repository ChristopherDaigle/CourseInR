## Chris Daigle
## In class Lab: Wk6D1

MinLose <- 0
JungbinLose <- 0
ChrisLose <- 0

players <- c(1, 2, 3)
place <- c(1, 2, 3)
chips <- c(8, 6, 6)
game <- cbind(players, place, chips)
colnames(game) <- c("Players", "Place", "Chips")
rownames(game) <- c("Min", "Chris", "Jungbin")

for (i in 1:2000) {
  while (game[, 3] > 0) {
    game[,2] <- sample(1:3)
  }
  
}