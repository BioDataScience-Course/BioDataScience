#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

titlePanel_h4 <- function(title, windowTitle = title) {
  tagList(tags$head(tags$title(windowTitle)), h4(title))
}

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel_h4("Transformations des données"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       selectInput("transfox", "Transformation souhaitée de l'axe X : la masse",
                  choices = c("Aucune", "Logarithme", "Racine carrée")),
       selectInput("transfoy", "Transformation souhaitée de l'axe y : la hauteur",
                   choices = c("Aucune", "Logarithme", "Racine carrée"))
    ),
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("transfo_plot")
    )
  )
))
