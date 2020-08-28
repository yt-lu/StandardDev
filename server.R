library(shiny)
library(shinyalert)
library(DT)

Sys.setenv(TZ = 'US/Eastern')

shinyServer(function(input, output, session) {
  observeEvent(input$submit, {
    
    a <- data.frame(input$temp, input$rate, input$hours)
    if (anyNA(a)) {
    shinyalert(title = "Please fill all cells", 
               type = "error")}
    else {
      write.table(a, 'report.csv', append = T, row.names = FALSE, quote = FALSE, sep = ',', 
                col.names = FALSE)
      shinyalert(title = "Your data has been submitted.", 
                 type = "success")
      
    }
      
  })
  
  userdata <- eventReactive(input$report, {
    x <- read.csv('report.csv' ,strip.white = TRUE, header = TRUE)
    x <- na.omit(x)
    return(x)
  })
  
  output$text <- renderText({
    out <- paste(userdata())
    out
  })
  
  observeEvent(input$reset, {
    msg_new_game <- HTML("This will erase the current class report. Type the admin code to proceed.")
    shinyalert(
      msg_new_game, type = "input", html = TRUE,
      callbackR = function(x) { if(x == 'GoBears') {
          close( file( 'report.csv', open="w" ) )
          write.table("", 'report.csv', row.names = FALSE, col.names = 'Quiz', 
                quote = FALSE, sep = ",")}
        })
    })
  
})
