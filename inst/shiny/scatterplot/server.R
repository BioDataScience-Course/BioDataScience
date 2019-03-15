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

  output$scaleplot <- renderPlot({

    # generate bins based on input$bins from ui.R

    # plot
    chart::chart(data = urchin, height ~  weight) +
      ggplot2::geom_point() +
      ggplot2::scale_x_continuous(limits = input$scalex) +
      ggplot2::scale_y_continuous(limits = input$scaley)

  })

})
