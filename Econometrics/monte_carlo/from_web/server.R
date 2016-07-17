
library(shiny)

shinyServer(function(input, output, session) {
	      # The number of iterations to perform
	      # maxIter <- 50

	      # Track the start and elapsed time
	      startTime <- Sys.time()  
	      output$elapsed <- renderText({
		length(vals$call)
	      })

	      # Create a reactiveValues object where we can track some extra elements
	      # reactively.
	      vals <- reactiveValues(call = 0, counter = 0)

	      # Update the percentage complete
	      output$counter <- renderText({
		paste0(round(vals$counter/input$reps * 100, 1), "%")
	      })

	      # Show the value of x
	      output$call <- renderPlot({
		hist(vals$call, breaks = 100)
	      })

	      # Do the actual computation here.
	      observe({
		isolate({
		  # This is where we do the expensive computing
		  
		  ## Change to not run MC many tomes -- but show the output of 1 run with user set number of random variables ----
		  S <- 50
  K <- 45
  r <- 0.01
  vol <- 0.2
  T <- 0.5
  vals$call <- 0
  tmpCall <- 0
      ## numRand <- rnorm(input$reps)      

      z <- rnorm(input$reps)
stock <- S*exp((r - .5 * vol * vol)*T + vol*sqrt(T)*z)
call.new <- stock - K
call.new[call.new < 0] <- 0

  ## for (i in 1:input$reps) {
  ##   z <- rnorm(1)
    ##   tmpCall <- exp(-r*T)*mean(ifelse(S*exp((r - .5 * vol * vol)*T + vol*sqrt(T) * z) > K, S * exp((r - .5 * vol * vol) * T + vol * sqrt(T) * z) - K, 0))
    for(i in 1:input$reps) {
        vals$call <- call.new[1:input$reps]
        ## Sys.Sleep(.1)
        }

        
  ## }
  
  # This is where we do the expensive computing
#   sum <- 0
#   for (i in 1:100000){
#     sum <- sum + rnorm(1)
#   }
#   vals$x <- vals$x + sum
# 		  # Increment the counter
		  vals$counter <- vals$counter + 1
		})

		# If we're not done yet, then schedule this block to execute again ASAP.
		# Note that we can be interrupted by other reactive updates to, for
		# instance, update a text output.
		if (isolate(vals$counter) < input$reps){
		  invalidateLater(1, session)
		}
	      })

})
