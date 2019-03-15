#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  urchin <- data.io::read("urchin_bio", package = "data.io", lang = "fr")

  output$transfo_plot <- renderPlot({

    # generate bins based on input$bins from ui.R
    if (input$transfox == "Aucune") {
      x <- urchin$weight
      labx <- "Masse"
    } else if (input$transfox == "Logarithme") {
      x <- log(urchin$weight)
      labx <- paste(input$transfox, "de la masse")
    } else {
      x <- sqrt(urchin$weight)
      labx <- paste(input$transfox, "de la masse")
    }
    if(input$transfoy == "Aucune") {
      y <- urchin$height
      laby <- "Hauteur du test"
    } else if (input$transfoy == "Logarithme") {
      y <- log(urchin$height)
      laby <- paste(input$transfoy, "de la hauteur du test")
    } else {
      y <- sqrt(urchin$height)
      laby <- paste(input$transfoy, "de la hauteur du test")
    }

    # draw the histogram with the specified number of bins
    a <- chart::chart(data = urchin, height ~  weight) +
      ggplot2::geom_point()
    b <- chart::chart(data = urchin, y ~ x) +
      ggplot2::geom_point() +
      ggplot2::labs( x = labx, y = laby)
    chart::combine_charts(list(a,b))
  })
})
