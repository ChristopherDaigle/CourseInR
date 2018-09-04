# Chris Daigle
# Week 14 D2
# Final Exercise - Simulation

# Exercise 

# Suppose that you have a model for your commuting time. In your model, you
# assume it depends on method and weather. If you drive, your commuting time is
# C = Exp(mean=R)+1, R=2 if it rains, R=0.5 otherwise. If you take a train, your
# commuing time is T = Exp(1)+3. Suppose that the chance to have rain is 0.3.
# Exp denotes the exponential distribution which is often used to characterize
# the time between events. You can generate samples from this distribution using
# "rexp()" with the rate = 1/R

set.seed(0)
n <- 1000
rain <- sample(c(2, 0.5), n, replace = TRUE, prob = c(0.3, 0.7))

drive = rexp(n, rate = 1 / rain) + 1
train = rexp(n, rate = 1) + 3

x.range = range(c(drive, train))
breaks = seq(min(x.range), max(x.range), length = 20)

hist(
  drive,
  breaks = breaks,
  probability = TRUE,
  xlim = x.range,
  col = rgb(0, 0, 0.5, 0.2),
  xlab = 'Time',
  main = 'Expected Drive and Train Commute time',
  ylim = c(0, 1)
)

hist(
  train,
  breaks = breaks,
  probability = TRUE,
  col = rgb(0, 0.3, 0, 0.2),
  add = TRUE
)

lines(density(drive), lwd = 2, col = 'blue')
lines(density(train), lwd = 2, col = 'dark green')
legend(
  'topright',
  legend = c('Drive', 'Train'),
  lty = 1,
  lwd = 2,
  col = 4:3
)

mean((drive - train) > 0)
# The average difference between driving and taking the train is 0.081 (units
# are not specified).