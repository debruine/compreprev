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
  ## load_crr ----
  observeEvent(input$load_crr, {
    debug_msg("load_crr")
    
    tryCatch({
      j <- jsonlite::read_json(input$load_crr$datapath)
      debug_msg(j)
      
      # update text inputs
      updateTextInput(session, "intro_title", value = j$title)
      updateTextInput(session, "intro_reviewer", value = j$reviewer)
      updateTextInput(session, "prep_link", value = j$links)
      updateTextInput(session, "run_time", value = j$run_time)
      
      # update text areas
      updateTextAreaInput(session, "prep_comments", value = j$comments$prep)
      updateTextAreaInput(session, "run_comments", value = j$comments$run)
      updateTextAreaInput(session, "res_comments", value = j$comments$res)
      updateTextAreaInput(session, "prep_suggestions", value = j$suggestions$prep)
      updateTextAreaInput(session, "run_suggestions", value = j$suggestions$run)
      updateTextAreaInput(session, "res_suggestions", value = j$suggestions$res)
      
      updateTextAreaInput(session, "res_major", value = j$res$major)
      updateTextAreaInput(session, "res_minor", value = j$res$minor)
      updateTextAreaInput(session, "res_missing", value = j$res$missing)
      
      # update checkboxes
      updateAwesomeCheckboxGroup(session, "prep_red", selected = j$issues$prep$red)
      updateAwesomeCheckboxGroup(session, "prep_yellow", selected = j$issues$prep$yellow)
      updateAwesomeCheckboxGroup(session, "prep_green", selected = j$issues$prep$green)
      updateAwesomeCheckboxGroup(session, "res_red", selected = j$issues$res$red)
      updateAwesomeCheckboxGroup(session, "res_yellow", selected = j$issues$res$yellow)
      updateAwesomeCheckboxGroup(session, "res_green", selected = j$issues$res$green)
      updateAwesomeCheckboxGroup(session, "run_red", selected = j$issues$run$red)
      updateAwesomeCheckboxGroup(session, "run_yellow", selected = j$issues$run$yellow)
      updateAwesomeCheckboxGroup(session, "run_green", selected = j$issues$run$green)
      
    }, error = function(e) {
      shinyjs::alert(e$message)
    })
  }, ignoreNULL = TRUE)
  
  ## json_text  ----
  output$json_text <- renderText({
    debug_msg("json_text")
    
    get_info(input) |>
      jsonlite::toJSON(auto_unbox = TRUE) |>
      jsonlite::prettify()
  })
  
  ## download_crr ----
  output$download_crr <- downloadHandler(
    filename = function() {
      debug_msg("download_crr")
      input$intro_title |>
        gsub("[^A-Za-z0-9]", "-", x = _) |>
        gsub("-+", "-", x = _) |>
        paste0("_", Sys.Date(), ".crr")
    },
    content = function(file) {
      get_info(input) |>
       jsonlite::toJSON(auto_unbox = TRUE) |>
       jsonlite::prettify() |>
       write(file)
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