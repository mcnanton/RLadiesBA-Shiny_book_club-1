library(shiny)
library(datos)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  title = "Pingüinos Palmer" ,
  selectInput(inputId = "especie", 
              label = "Elegí la especie", 
              choices = unique(pinguinos$especie)), 
  verbatimTextOutput(outputId = "resumen"),
  plotOutput(outputId = "grafico")
)

server <- function(input, output, session) {
 
  dataset_filtrado <- reactive({
    pinguinos |> 
    filter(especie == input$especie)
  })
  
  output$resumen <- renderPrint({
    summary(dataset_filtrado())
  })
  
  output$grafico <- renderPlot({
    
    dataset_filtrado() |> 
      ggplot(aes(x = largo_pico_mm, y = masa_corporal_g)) +
      geom_point()
    
  })
}

shinyApp(ui = ui, server = server)