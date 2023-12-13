# libraries ----
suppressPackageStartupMessages({
    library(shiny)
    library(shinyjs)
    library(shinydashboard)
    library(shinyWidgets)
})

# setup ----

## functions ----
source("scripts/func.R") # helper functions

## tabs ----
source("tabs/intro_tab.R")
source("tabs/prep_tab.R")
source("tabs/run_tab.R")
source("tabs/res_tab.R")
source("tabs/fb_tab.R")

## UI ----
ui <- dashboardPage(
    skin = "black",
    dashboardHeader(title = "CompRepRev", 
        titleWidth = "calc(100% - 44px)" # puts sidebar toggle on right
    ),
    dashboardSidebar(
        # https://fontawesome.com/icons?d=gallery&m=free
        sidebarMenu(
            id = "tabs",
            menuItem("Intro", tabName = "intro_tab", icon = icon("star")),
            menuItem("Prep", tabName = "prep_tab", icon = icon("cog")),
            menuItem("Run", tabName = "run_tab", icon = icon("person-running")),
            menuItem("Results", tabName = "res_tab", icon = icon("chart-simple")),
            menuItem("Feedback", tabName = "fb_tab", icon = icon("comments"))
        )
    ),
    dashboardBody(
        shinyjs::useShinyjs(),
        tags$head(
            # links to files in www/
            tags$link(rel = "stylesheet", type = "text/css", href = "basic_template.css"), 
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"), 
            tags$script(src = "custom.js")
        ),
        tabItems(
            intro_tab,
            prep_tab,
            run_tab,
            res_tab,
            fb_tab
        )
    )
)


# server ----
server <- function(input, output, session) {
  ## load_json ----
  observeEvent(input$load_json, {
    debug_msg("load_json")
    
    tryCatch({
      j <- jsonlite::read_json(input$load_json$datapath)
    }, error = function(e) {
      shinyjs::alert(e$message)
    })
  }, ignoreNULL = TRUE)
  
  ## json_text  ----
  output$json_text <- renderText({
    debug_msg("json_text")
    
    v <- list(
      title = input$intro_title,
      reviewer = input$intro_reviewer,
      issues = list(
        prep = list(
          red = input$prep_red,
          yellow = input$prep_yellow,
          green = input$prep_green),
        run = list(
          red = input$run_red,
          yellow = input$run_yellow,
          green = input$run_green),
        res = list(
          red = input$res_red,
          yellow = input$res_yellow,
          green = input$res_green)
      ),
      comments = list(
        prep = input$prep_comments,
        run = input$run_comments,
        res = input$res_comments
      ),
      suggestions = list(
        prep = input$prep_suggestions,
        run = input$run_suggestions,
        res = input$res_suggestions
      ),
      res = list(
        major = input$res_major,
        minor = input$res_minor,
        missing = input$res_missing
      )
    )
    
    j <- jsonlite::toJSON(v, auto_unbox = TRUE)
    jsonlite::prettify(j)
  })
  
  ## download_json ----
  output$download_json <- downloadHandler(
    filename = function() {
      debug_msg("download_json")
      paste0("file", ".json")
    },
    content = function(file) {
      j <- "json goes here"
      write(j, file)
    }
  )
  
  ## fb_text  ----
  output$fb_text <- renderUI({
    debug_msg("fb_text")
    HTML("fb goes here")
  })
  
  ## download_fb ----
  output$download_fb <- downloadHandler(
    filename = function() {
      debug_msg("download_fb")
      paste0("file", ".html")
    },
    content = function(file) {
      j <- "feedback goes here"
      write(j, file)
    }
  )
} 

shinyApp(ui, server)