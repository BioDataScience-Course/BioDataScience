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
    set.seed(50)
    popu <- rnorm(n = 1000000, mean = 150, sd = 35)

    value <- reactive({
        echant <- sample(popu, size = input$numb)
    })


    output$numb_val <- renderPrint({mean(value())})

    output$numb_val2 <- renderPrint({sd(value())})

    output$numb_val3 <- renderPrint({
        print(value())
        })


    output$densi_plot <- renderPlot({

        chart::chart(tibble::enframe(popu), ~ value) +
            ggplot2::geom_density() +
            ggplot2::geom_hline(yintercept = 0) +
            ggplot2::geom_vline(xintercept = mean(popu), color = "red") +
            ggplot2::geom_vline(xintercept = mean(popu) - sd(popu), color = "red",
                                alpha = 0.5, linetype = "twodash") +
            ggplot2::geom_vline(xintercept = mean(popu) + sd(popu), color = "red",
                                alpha = 0.5, linetype = "twodash") +
            ggplot2::geom_vline(xintercept = mean(value()), color = "green") +
            ggplot2::geom_vline(xintercept = mean(value()) - sd(value()),
                                color = "green", alpha = 0.5, linetype = "twodash") +
            ggplot2::geom_vline(xintercept = mean(value()) + sd(value()),
                                color = "green", alpha = 0.5, linetype = "twodash")

    })

})
