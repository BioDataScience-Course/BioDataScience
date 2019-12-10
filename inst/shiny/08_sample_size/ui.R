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
                        "Nombre d'observations",
                        min = 20,
                        max = 5000,
                        value = 20),
            withMathJax(),
            p("Les hypothèses du test sont :"),
            helpText("L'hypothèse nulle, \\(H_0\\) est l'affirmation de base ou
                de référence que l'on cherchera à réfuter"),
            helpText("$$H_0: \\mathrm{P}(left) = \\frac{1}{2}\\ \\mathrm{et}\\ \\mathrm{P}(right) = \\frac{1}{2}$$"),
            helpText("L'hypothèse alternative, \\(H_1\\) représente une autre affirmation qui
               doit nécessairement être vraie si \\(H_0\\) est fausse"),
            helpText("$$H_1: \\mathrm{P}(left) \\neq \\frac{1}{2}\\ \\mathrm{ou}\\ \\mathrm{P}(right) \\neq \\frac{1}{2}$$"),
            hr(),
            helpText("Valeur du seuil \\(\\alpha\\)"),
            verbatimTextOutput("chi_alpha"),
            helpText("Valeur de p associée au test du \\(chi^2\\)"),
            verbatimTextOutput("chi_pvalue"),
            hr()
            ),

        # Show a plot of the generated distribution
        mainPanel(
            p("Prenons l'exemple des becs croisés des sapins, avec 52% des
                individus ont des becs croisés à gauche et 48 % des individus
                ont des bec croisés à droite qui se rencontrent dans la même
                population."),
            strong("Quelle est la taille minimum de l'échantillon afin de
                    réfuter l'hypothèse nulle au seuil alpha de 5% ? "),
            tableOutput("chi_table"),
            hr(),
            plotOutput("chi_plot"),
            hr()
        )
    )
))
