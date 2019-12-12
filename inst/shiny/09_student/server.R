#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    value <- reactive({
        means_n <- numeric(10000) # Vecteur de 10000 valeurs

        for (i in 1:10000)
            means_n[i] <- mean(rnorm(input$numb, mean = 8, sd = 2))

        df_test <- tibble::enframe(means_n, name = NULL)
        df_test
    })

    output$mean_value <- renderText({
        t <- value()
        mean(t$value)
    })

    output$sd_value <- renderText({
        t <- value()
        sd(t$value)
    })

    output$mean_plot <- renderPlot({
        t <- value()
        #hist(t$value)

        chart::chart(data = t, ~ value) +
            ggplot2::geom_histogram(bins = 30) +
            ggplot2::labs(x = "Moyenne des échantillons", y = "Dénombrement")
    })

})
