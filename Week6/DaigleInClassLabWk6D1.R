## Chris Daigle
## In class Lab: Wk6D1

ChrisLose <- 0
JungbinLose <- 0
MinLose <- 0
for (i in 1:2000) {
  Chris <- 6
  Jungbin <- 6
  Min <- 8
  while (Chris > 0 & Jungbin >0 & Min > 0) {
    a <- sample(1:6, 1)
    if (a == 1) {
      Chris = Chris + 1
      Min = Min - 1
    } else if (a == 2) {
      Chris = Chris + 1
      Jungbin = Jungbin - 1
    } else if (a == 3) {
      Jungbin = Jungbin + 1
      Min = Min - 1
    } else if (a == 4) {
      Chris = Chris - 1
      Jungbin = Jungbin + 1
    } else if (a == 5) {
      Jungbin = Jungbin - 1
      Min = Min + 1
    }else if (a == 6) {
      Chris = Chris - 1
      Min = Min + 1
    }
  }
  if (Chris == 0) {
    ChrisLose = ChrisLose +1
  } else if (Jungbin == 0) {
    JungbinLose = JungbinLose + 1
  } else if (Min == 0) {
    MinLose = MinLose + 1
  }
}
print(paste("Chris lost", ChrisLose*100/2000, "% of the time."))
print(paste("Jungbin lost", JungbinLose*100/2000, "% of the time."))
print(paste("Min lost", MinLose*100/2000, "% of the time."))