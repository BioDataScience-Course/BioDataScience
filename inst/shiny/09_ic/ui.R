#
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Intervalle de confiance"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            withMathJax(),
            p("L'intervalle de confiance suit l'équation suivante :"),
            helpText("$$\\mathrm{IC}(1 - \\alpha) \\simeq \\bar{x} \\pm t_{\\alpha/2}^{n-1} \\cdot \\frac{s_x}{\\sqrt{n}}$$"),
            sliderInput("numb",
                        "Valeur du seuil \\(\\alpha\\)",
                        min = 0,
                        max = 0.999,
                        value = 0.05),
            hr(),
            helpText("Valeur de l'IC à ... \\(%\\)"),
            verbatimTextOutput("stu"),
            helpText("Valeur du quantile à gauche"),
            verbatimTextOutput("stu1"),
            helpText("Valeur du quantile à droite"),
            verbatimTextOutput("stu2"),
            hr()
            ),

        # Show a plot of the generated distribution
        mainPanel(
            withMathJax(),
            helpText("Partons d'une distribution théorique de student la population
                      qui soit normale, de moyenne \\(\\bar{x} = 8\\) et d'écart
                      type \\(s_x = 2\\)."),
            strong("Comment varie l'intervalle de confiance en fonction de la valeur de \\(\\alpha\\) ?"),
            plotOutput("stu_plot"),
            hr()
        )
    )
))
