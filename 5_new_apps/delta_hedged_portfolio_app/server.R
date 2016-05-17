## modifying presentation here:  http://shiny.rstudio.com/gallery/reactive-poll-and-file-reader.html


## The idea of this app is to simulate a stock can call option price paths and a
## portfolio that replicates the call option, with user set reblancing frequencies.
## The stock, option, hedging portfolio, and replicating portfolio error are all printed
## and the replicateing portfolio error is charted.  

shinyServer(function(input, output, session) {

  # Create a random name for the log file
  logfilename <- paste0('logfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),
                        '.txt')


  # ============================================================
  # This part of the code writes to the log file every second.
  # Writing to the file could be done by an external process.
  # In this example, we'll write to the file from inside the app.
  logwriter <- observe({
    # Invalidate this observer every second (1000 milliseconds)
    invalidateLater(1000, session)

    # Clear log file if more than 10 entries
    ## if (file.exists(logfilename) &&
    ##     length(readLines(logfilename)) > 10) {
    ##   unlink(logfilename)
    ## }


### Put simulation code here to write it to logfile below ---------
### simulation likely incorrect at this point, did very quickly to just test app

      drift <- 0.007
      vol <- 0.1
      initialStock <- 50 
      strike <- 51
      rf <- 0.005

      time <- 1:100

      ## Bt -- brownian motions
      Bt <- rnorm(100, mean = 0, sd = vol) * sqrt(1:100)
      
      stockPrice <- initialStock * exp((drift - (vol^2)/2) * time + vol * Bt)


      d1 <- (1/sqrt(time)) * (log(stockPrice / strike) + (rf + (vol^2) / 2) * time)
      d2 <- d1 - vol * sqrt(time)

      C <- pnorm(d1) * stockPrice - pnorm(d2) * strike * exp(-rf * time)

      ##
      


      
    # Add an entry to the log file
    cat(as.character(C), '\n', file = logfilename,
        append = TRUE)
  })

  # When the client ends the session, suspend the observer and
  # remove the log file.
  session$onSessionEnded(function() {
    logwriter$suspend()
    unlink(logfilename)
  })

  # ============================================================
  # This part of the code monitors the file for changes once per
  # 0.5 second (500 milliseconds).
  fileReaderData <- reactiveFileReader(500, session,
                                       logfilename, readLines)

  output$portfolioText <- renderText({
    # Read the text, and make it a consistent number of lines so
    # that the output box doesn't grow in height.
    text <- fileReaderData()
    length(text) <- 25
    text[is.na(text)] <- ""
    paste(text, collapse = '\n')
  })


  # ============================================================
  # This part of the code monitors the file for changes once
  # every four seconds.

  ## pollData <- reactivePoll(4000, session,
  ##   # This function returns the time that the logfile was last
  ##   # modified
  ##   checkFunc = function() {
  ##     if (file.exists(logfilename))
  ##       file.info(logfilename)$mtime[1]
  ##     else
  ##       ""
  ##   },
  ##   # This function returns the content of the logfile
  ##   valueFunc = function() {
  ##     readLines(logfilename)
  ##   }
  ## )

  ## output$pollText <- renderText({
  ##   # Read the text, and make it a consistent number of lines so
  ##   # that the output box doesn't grow in height.
  ##   text <- pollData()
  ##   length(text) <- 14
  ##   text[is.na(text)] <- ""
  ##   paste(text, collapse = '\n')
  ## })
})
