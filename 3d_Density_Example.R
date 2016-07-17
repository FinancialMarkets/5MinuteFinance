## 3D density plots

## example and data from here: http://rpubs.com/julyanarbel/192923
library(plotly)
mydata <- read.csv("./density.txt")
df = as.data.frame(mydata)
plot_ly(df, x = Y, y = X, z = Z, group = X, type = "scatter3d", mode = "lines") 


## Maybe use this in a blog post about time varying beta (via Kalman filter) -- show how beta (market risk) estimate *and* uncertainty (variance) changes over time.