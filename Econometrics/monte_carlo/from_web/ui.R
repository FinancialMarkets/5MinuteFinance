## example is from here:  https://gist.github.com/trestletech/8608815


library(shiny)

shinyUI(pageWithSidebar(

			# Application title
			headerPanel("New Application"),
			sidebarPanel(
  inputPanel(
	   sliderInput(inputId = "reps", label = "Number of Monte Carlo Runs", min = 50, max = 50000, step = 1, value = 1)
  ),
				     "Progress: ",
				     textOutput("counter"),
				     hr(),
				     "Call Value ($):",
				     textOutput("elapsed")
				     ),

			mainPanel(
				  plotOutput("call")
				  )
			))
