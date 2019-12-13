#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    student_plot <- function(mu = 0, sigma = 1, degrees_of_fredom, quantiles = NULL,
                             seuil_alpha = NULL,
                             alternative = c("two.sided", "less", "greater"),
                             xlab = "Quantile", ylab = "Densité de probabilité", ...) {

        .x <- seq(-4.5*sigma+mu, 4.5*sigma+mu, l = 1000)     # Quantiles
        .d <- function (x) dt((x-mu)/sigma, df = degrees_of_fredom)/sigma   # Distribution function
        .q <- function (p) qt(p, df = degrees_of_fredom) * sigma + mu

        a <- chart::chart(
            data = tibble::tibble(
                quantiles = .x, prob = .d(.x)), prob ~ quantiles) +
            ggplot2::geom_hline(yintercept = 0, col = "Black") +
            ggplot2::geom_ribbon(
                x = .x, ymin = 0, ymax = .d(.x), fill = "gray", alpha = 0.2) +
            ggplot2::geom_line() +
            ggplot2::labs(x = xlab, y = ylab, ...)

        if (!is.null(quantiles)) {
            a <- a +
                ggplot2::geom_vline(xintercept = quantiles, col = "Red")
        }

        if (!is.null(seuil_alpha)) {

            if (isTRUE(alternative == "two.sided")) {
                alpha2 <- seuil_alpha/2
                q_ref_left <- mu + sigma * qt(alpha2, df = degrees_of_fredom, lower.tail = TRUE)
                q_ref_right <- mu + sigma * qt(alpha2, df = degrees_of_fredom, lower.tail = FALSE)

                .x2 <- .x1 <- .x
                .x1[.x1 > q_ref_left] <- NA
                .x2[.x2 < q_ref_right] <- NA

                a <- a +
                    ggplot2::geom_ribbon(x = .x1, ymin = 0, ymax = .d(.x1),
                                         fill = "red", alpha = 0.2) +
                    ggplot2::geom_ribbon(x = .x2, ymin = 0, ymax = .d(.x2),
                                         fill = "red", alpha = 0.2)
            }

            if (isTRUE(alternative == "less")) {
                q_ref_left <- mu + sigma * qt(seuil_alpha, df = degrees_of_fredom, lower.tail = TRUE)
                .x1 <- .x
                .x1[.x1 > q_ref_left] <- NA

                a <- a +
                    ggplot2::geom_ribbon(x = .x1, ymin = 0, ymax = .d(.x1),
                                         fill = "red", alpha = 0.2)
            }

            if (isTRUE(alternative == "greater")) {
                q_ref_right <- mu + sigma * qt(seuil_alpha, df = degrees_of_fredom, lower.tail = FALSE)
                .x2 <- .x
                .x2[.x2 < q_ref_right] <- NA

                a <- a +
                    ggplot2::geom_ribbon(x = .x2, ymin = 0, ymax = .d(.x2),
                                         fill = "red", alpha = 0.2)
            }

        }
        #print(a)
        a
    }

    output$stu <- renderText({
        ic <- (1 - (input$numb))
        ic
    })

    output$stu1 <- renderText({
        alpha2 <- (input$numb)/2

        q_ref_left <- 8 + 2 * qt(alpha2, df = 1000, lower.tail = TRUE)

        q_ref_left
    })

    output$stu2 <- renderText({
        alpha2 <- (input$numb)/2

        q_ref_right <- 8 + 2 * qt(alpha2, df = 1000, lower.tail = FALSE)

        q_ref_right

    })

    output$stu_plot <- renderPlot({

        student_plot(mu = 8, sigma = 2, degrees_of_fredom = 1000,
                     seuil_alpha = input$numb, alternative = "two.sided")

    })

})
