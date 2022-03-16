# RStudio addins

sdd_info_addin <- function()
  sdd_info()

sign_out_addin <- function()
  sign_out()

check_project_addin <- function() {

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Check my project"),
    miniUI::miniContentPanel(
      shiny::h4("Project path"),
      shiny::textOutput("proj_dir"),
      shiny::h4("Convert to HTML documents all Rmarkdown documents in the project"),
      shiny::tableOutput("render"),
      shiny::hr()
    )
    )

  server <- function(input, output, session) {

    res_proj <- rprojroot::find_root(rprojroot::is_rstudio_project, path = ".")
    res <- BioDataScience::render_all_rmd_project(".")

    output$proj_dir <- shiny::renderText({
      print(res_proj)
    })

    output$render <- shiny::renderTable({
        res
      })

    shiny::observeEvent(input$done, {
      res1 <- res[res$check == "ERROR", ]

      if(nrow(res1)>0)
        rstudioapi::navigateToFile(res1$file) ## open files that do not knit

      shiny::stopApp()
    })

    shiny::observeEvent(input$cancel, {
      shiny::stopApp()
    })

  }

  viewer <- shiny::paneViewer(300)
  shiny::runGadget(ui, server, viewer = viewer)

}
