library(shiny)
library(dplyr)

ID <- c(1:1000)
Name <- rep(c("A","B","C","D","E"),200)
English <- c(1:1000)
Computer <- c(1:1000)
Biology <- c(1:1000)
Biophysics <- c(1:1000)

Grades <- data.frame(cbind(ID,Name,English,Computer,Biology,Biophysics))

ui <- fluidPage(
  numericInput("ID","Enter your ID",""),
  tableOutput("tbl")
)

server <- function(input, output, session) {
  output$tbl <- renderTable({filter(Grades,ID==input$ID)
  })
}

shinyApp(ui, server)
