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
source("scripts/modules.R")

## tabs ----
source("tabs/intro_tab.R")
source("tabs/prep_tab.R")
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
      
      # update text inputs
      updateTextInput(session, "title", value = j$title)
      updateTextInput(session, "reviewer", value = j$reviewer)
      updateTextInput(session, "link", value = j$link)
      updateTextInput(session, "run_time", value = j$run_time)
      
      # update traffic lights and sections
      items <- c("links", "code", "data", "resources", "readme", 
                 "codebook", "errors", "mapping", "results")
      debug_msg(j)
    
      for (i in items) {
        item <- j[[i]]
        updateRadioButtons(session, paste0(i, "-tl"), 
                           selected = item$tl)
        updateTextAreaInput(session, paste0(i, "-comment"), 
                            value = item$comment)
        updateCheckboxGroupInput(session, paste0(i, "-issues"), 
                                 selected = item$issues)
      }
      
      # update res
      updateTextAreaInput(session, "res_major", value = j$res$major)
      updateTextAreaInput(session, "res_minor", value = j$res$minor)
      updateTextAreaInput(session, "res_missing", value = j$res$missing)
      
      
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
      input$title |>
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