#
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Effet de l'effectif"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("numb",
                        "Nombre d'individus échantillonner observations",
                        min = 3,
                        max = 100,
                        value = 9),
            withMathJax(),
            p("La moyenne d'un échantillon suit l'équation suivante :"),
            helpText("$$\\bar{x}=\\sum_{i=1}^n{\\frac{x_i}{n}}$$"),
            p("L'écart-type d'un échantillon suit l'équation suivante : "),
            helpText("$$s_x = \\sqrt{\\sum_{i=1}^n{\\frac{(x_i - \\bar{x})^2}{n-1}}}$$"),
            hr(),
            helpText("La moyenne de la distribution d’échantillonnage"),
            verbatimTextOutput("mean_value"),
            helpText("L'écart-type de la la distribution d’échantillonnage"),
            verbatimTextOutput("sd_value"),
            hr()
            ),

        # Show a plot of the generated distribution
        mainPanel(
            withMathJax(),
            helpText("Partons d'une distribution théorique de la population
                      qui soit normale, de moyenne \\(\\mu = 8\\) et d'écart
                      type \\(\\sigma = 2\\)."),
            strong("Comment varie la moyenne et l'écart-type de la distribution
                    d'échantillonnage ?"),
            plotOutput("mean_plot"),
            hr()
        )
    )
))
