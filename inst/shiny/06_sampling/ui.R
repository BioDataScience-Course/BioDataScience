#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Population & Echantillon"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            p("Si nous pouvions mesurer tous les individus d’une population
               à chaque fois, il serait inutile de faire un échantillonage.
               Mais ce n’est pratiquement jamais possible car le nombre
               d’individus est potentiellement très grand. Afin de limiter
               les mesures à un nombre raisonnable de cas, nous effectuons un
               échantillonnage de n individus dans la population."),
            hr(),
            sliderInput("numb",
                        "Nombre d'observations",
                        min = 10,
                        max = 1000,
                        value = 10),
            hr(),
            h4("Moyenne de l'échantillon"),
            verbatimTextOutput("numb_val"),
            h4("Ecart-type de l'échantillon"),
            verbatimTextOutput("numb_val2")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4("Prenons l'exemple d'une population fictive de moyenne est de 150
                et l'écart-type est de 35. De combien d'observations dans votre
                échantillon avez vous besoin afin vous approcher de ces valeurs ?"),
            plotOutput("densi_plot"),
            p("Le graphique de densité représente la distribution de
              notre population. La ligne rouge montre la moyenne de la population
              et la ligne verte la moyenne de l'échantillon" ),
            hr(),
            verbatimTextOutput("numb_val3")
        )
    )
))
