library(shiny)
library(dplyr)

ID1 <- c(1:10)
Name1 <- rep(c("A","B"),5)
Biology <- c(1:10)
First <- data.frame(cbind(ID1,Name1,Biology))

ID2 <- c(11:20)
Name2 <- rep(c("C","D"),5)
Physiology <- c(11:20)
Second <- data.frame(cbind(ID2,Name2,Physiology))

ui = shinyUI(
 fluidPage(
 titlePanel("VetSMS"),
 sidebarPanel(
 selectInput("Level","Choose your level",choices = c("First","Second")),
 numericInput("ID","Enter your ID",""),
 tableOutput("tbl")
 )
 ))

server <- function(input, output) {
 output$tbl <- renderTable({
 if(input$Level=="First")
 First %>% filter(ID1 %in% input$ID)
else
 if(input$Level=="Second")
 Second %>% filter(ID2 %in% input$ID)
else
 "Please enter a correct ID, make sure you chose the correct level"
}
 )}

shinyApp(ui,server)
