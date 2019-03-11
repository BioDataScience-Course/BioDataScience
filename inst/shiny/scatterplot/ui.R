#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
SciViews::R

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Variation des l'axe X et de l'axe Y"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       sliderInput("scalex",
                   "Echelle de l'axe X",
                   min = -50,
                   max = 500,
                   value = c(0,100),
                   step = 20),
       sliderInput("scaley",
                   "Echelle de l'axe y",
                   min = -50,
                   max = 150,
                   value = c(0,50),
                   step = 10)
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("scaleplot")
    )
  )
))

