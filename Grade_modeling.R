library(shiny)

Physiology <- c(48, 64, 74, 84)
Physiology2 <- ifelse(Physiology <50, "Fail", "Pass")

Biochemistry <- c(48, 49, 74, 84)
Biochemistry2 <- ifelse(Biochemistry <50, "Fail", "Pass")


Second <- data.frame(Physiology,Physiology2,Biochemistry,Biochemistry2)

Second$Physiology <- as.numeric(as.character(Second$Physiology))
Second$Biochemistry <- as.numeric(as.character(Second$Biochemistry))


ui <- fluidPage(
       titlePanel("See how results change by adding whatever you want"),
       
       sidebarLayout(
       sidebarPanel( 
                selectInput("Subject","Choose Subject",choices=list("Physiology" = "Physiology2","Biochemistry" = "Biochemistry2")),
                numericInput("Addition","If we added","0"),
                submitButton('Submit')
      ),
        mainPanel(
                h2('Results'),
                h4('Original Results'),
                tableOutput("table"),
                h4('New Results after addition'),
                tableOutput("table2"))
     )
    )            


server <- shinyServer(function(input,output){

          Omar <- reactive({
          
          Virtual <- as.numeric(ifelse(Second[[input$Subject]]=="Physiology2",Second$Physiology+input$Addition,Second$Biochemistry+input$Addition))

          data.frame (Virtual, Virtual2 = as.factor(ifelse(Virtual<50,"Fail","Pass")))
         })

          output$table <- renderTable(as.table(summary(Second[[input$Subject]])))

          x <- reactive({input$Addition})

          
          output$table2 <- renderTable({
                           if(x()==0) {"No Change because you entered you haven't entered a positive number"} else {as.table(summary(Omar()$Virtual2))}})
                          
        }
      )
shinyApp(ui,server)
