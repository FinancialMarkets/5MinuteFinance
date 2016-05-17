library(quantmod)
env <- new.env()
Symbols <- c("SPY", "XLP", "XLF", "XLE", "XLV", "XLY", "XLK", "XLB", "XLU", "XLI")
getSymbols(Symbols = Symbols, env = env, from = "1990-01-01", src = 'google')

# Get ETF closing prices ----

# get weekly closes
args.w <- eapply(env = env, FUN = function(x) {
		     to.weekly(x)[,4] })[Symbols]
close.w <- na.omit(do.call(what = merge, args = args.w))
colnames(close.w) <- Symbols

# get weekly returns
returns.w <- apply(close.w, 2, FUN = Delt)
returns.w <- returns.w[-1,]
returns.w <- as.xts(returns.w, order.by = index(close.w)[-1])

returns.annualized <- returns.w * 52

## get risk free rate ----

rf <- getSymbols('WTB3MS', src = "FRED", auto.assign = F)
rf <- rf / 100

data <- merge.xts(returns.annualized, rf, join = 'inner')

save(data, file = "data.RData")









# Calculate monthly ETF market betas ----
#{{{
summary(lm(Delt(close.m$XLP, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLP['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLP['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLV, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLV['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLV['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLE, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLE['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLE['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLK, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLK['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLK['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLF, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLF['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLF['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLB, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLB['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLB['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLU, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLU['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLU['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLY, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLY['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLY['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))

summary(lm(Delt(close.m$XLI, type = 'log') ~ Delt(close.m$SPY, type = 'log')))
summary(lm(Delt(close.m$XLI['/2008-07-01'], type = 'log') ~ Delt(close.m$SPY['/2008-07-01'], type = 'log')))
summary(lm(Delt(close.m$XLI['2008-08-01/'], type = 'log') ~ Delt(close.m$SPY['2008-08-01/'], type = 'log')))
#}}}
