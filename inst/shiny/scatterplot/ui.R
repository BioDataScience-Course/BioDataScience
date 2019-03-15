#
library(shiny)

titlePanel_h4 <- function(title, windowTitle = title) {
  tagList(tags$head(tags$title(windowTitle)), h4(title))
}

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel_h4("Variation de l'axe X et de l'axe Y"),

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

