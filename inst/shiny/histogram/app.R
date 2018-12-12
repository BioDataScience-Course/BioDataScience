# Histogram with variable classes

ui <- fluidPage(
  titlePanel(""), #"Choix des classes pour un histogramme"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins", label = "Nombre de classes:",
        min = 1, max = 50, value = 30)
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    chart::chart(data = geyser, ~waiting) +
      ggplot2::geom_histogram(bins = input$bins,
        col = "white", fill = "#75AADB") +
      ggplot2::ylab("Fréquence")
  })
}

geyser <- data.io::read("geyser", package = "MASS", lang = "fr")
shinyApp(ui, server)
