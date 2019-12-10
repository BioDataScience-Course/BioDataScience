#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    value <- reactive({
        TABLE <- as.table(
            c(
                left = ceiling(0.52*input$numb),
                right = floor((1 -0.52)*input$numb))
        )
        chisq.test(TABLE, p = c(1/2 , 1/2), rescale.p = FALSE)
    })

    output$chi_table <- renderTable({
        t <- value()
        name_t <-names(t$observed)

        data.frame(
            "fréquence.observée" =  as.numeric(t[["observed"]]),
            "fréquence.théorique" = t[["expected"]],
            row.names = name_t)
    },
    rownames = TRUE, align = "c")

    output$chi_alpha <- renderText({
        as.numeric("0.05")
    })

    output$chi_pvalue <- renderText({
        t <- value()
        t$p.value
    })

    output$chi_plot <- renderPlot({

        t <- value()

        .df <- as.numeric(t$parameter) # Degree of freedom .df
        .x <- seq(0, qchisq(0.999, df = .df), l = 1000)  # Quantiles
        .d <- function(x) dchisq(x, df = .df)           # Distribution function
        #.q <- function(p) qchisq(p, df = .df)           # Quantile for lower-tail prob


        q_ref <- qchisq(0.05, df = as.numeric(t$parameter), lower.tail = FALSE)
        .x2 <- .x
        .x2[.x2 < q_ref] <- NA

        chart::chart(data = tibble::tibble(Quantiles = .x, Prob = .d(.x)), Prob ~ Quantiles) +
            ggplot2::geom_hline(yintercept = 0, col = "gray") +
            ggplot2::geom_ribbon(x = .x, ymin = 0, ymax = .d(.x), fill = "gray", alpha = 0.2) +
            ggplot2::geom_ribbon(x = .x2, ymin = 0, ymax = .d(.x2), fill = "red", alpha = 0.2) +
            ggplot2::geom_line() +
            ggplot2::xlab("Quantile") +
            ggplot2::ylab("Densité de probabilité") +
            ggplot2::ylim(0, 1) +
            ggplot2::geom_vline(xintercept = as.numeric(t[["statistic"]]), col = "green") +
            ggplot2::annotate("text", x = 1.4, y = 0.04,
                             label = "Zone de non rejet", col = "black") +
            ggplot2::annotate(
                "text", x = 5.5, y = 0.1,
                label = "plain(Zone ~ de ~ rejet) == plain(seuil) ~ alpha",
                parse = TRUE, col = "red") +
            ggplot2::annotate(
                "text", x = (as.numeric(t[["statistic"]]) + 1), y = 0.75,
                label = paste("chi[obs]^2 == ", round(as.numeric(t[["statistic"]]), 3)), parse = TRUE,
                     col = "green", fontface = "bold.italic")
    })

})
