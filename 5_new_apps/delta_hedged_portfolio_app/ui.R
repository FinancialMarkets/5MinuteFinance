shinyUI(fluidPage(
    titlePanel("Delta Hedged Stock and Option Portfolio Simulatoin"),

## need to put inputs for (1) the number of times to rebalance and (2) a run button.
    
  ## fluidRow(
  ##   column(6, wellPanel(
  ##     plotOutput("portfolioChart")
  ##   )),
    column(12, wellPanel(
        verbatimTextOutput("portfolioText")
    ))
  )
)#)
