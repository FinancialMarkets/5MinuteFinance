max.rands <- 1000
S <- 50
K <- 45
r <- 0.01
vol <- 0.2
T <- 0.5
call <- 0

## first approach
set.seed(1)
system.time({
for (i in 1:max.rands) {
  z <- rnorm(1)
  call[i] <- exp(-r*T)*ifelse(S*exp((r - .5 * vol * vol)*T + vol*sqrt(T)*z) > K, S*exp((r - .5*vol * vol)*T + vol*sqrt(T)*z) - K, 0)
}
call.loop <- mean(call)
})

## second approach
set.seed(1)
system.time({
z <- rnorm(max.rands)
stock <- S*exp((r - .5 * vol * vol)*T + vol*sqrt(T)*z)
call.new <- stock - K
call.new[call.new < 0] <- 0
call.vec <- exp(-r*T)*mean(call.new)
}
)

identical(round(call.loop, 6), round(call.vec, 6))
# call values equal!

