library(shiny)
library(DT)
library(shinyalert)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  tags$head(
    tags$style(HTML("
                    * {
                    font-family: Palatino,garamond,serif;
                    font-weight: 500;
                    line-height: 1.2;
                    #color: #000000;
                    }
                    "))
  ), 
  # Application title
  titlePanel("Class Survey"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("temp", "Body temperature:", value = NULL),
      numericInput("rate", "Heart rate:", value = NULL),
      numericInput("hours", "Semester credit hours:", value = NULL),
      
      useShinyalert(),
      actionButton("submit", "Submit"),
      actionButton("report", "Class Report"), hr(),
      actionButton("reset", "Reset")
    ),
  
    
    # Show a plot of the generated distribution
    mainPanel(
      htmlOutput("text")
        )#end of mainPanel
)#end of sidebar layout
)#end of fluidpage
)#end of shinyUI
