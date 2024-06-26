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
source("tabs/run_tab.R")
source("tabs/res_tab.R")
source("tabs/tips_tab.R")

## UI ----
ui <- dashboardPage(
    skin = "blue",
    dashboardHeader(title = "CompRepRev", 
        titleWidth = "calc(100% - 44px)" # puts sidebar toggle on right
    ),
    dashboardSidebar(
        # https://fontawesome.com/icons?d=gallery&m=free
        sidebarMenu(
            id = "tabs",
            menuItem("Intro", tabName = "intro_tab", icon = icon("star")),
            menuItem("Prep", tabName = "prep_tab", 
                     icon = icon("cog")),
            menuItem("Run", tabName = "run_tab", 
                     icon = icon("person-running")),
            menuItem("Results", tabName = "res_tab", 
                     icon = icon("chart-simple")),
           # menuItem("Feedback", tabName = "fb_tab", icon = icon("comments"))
           menuItem("Tips", tabName = "tips_tab", icon = icon("circle-info")),
           menuItem("Credit", tabName = "credit_tab", icon = icon("people-group"))
        ),
        actionButton("reset", "Reset All"),
        fileInput("load_crr", "Load from CompRepRev File", width = "100%"),
        #downloadButton("download_fb", "Download Feedback"),
        div(
          h4("Downloads"),
          downloadButton("download_crr", 
                         "CompRepRev File", 
                         width = "100%"),
          downloadButton("download_readme", 
                         "Template README", 
                         width = "100%"),
          class= "shiny-input-container"
    )),
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
            tips_tab,
            credit_tab
        )
    )
)


# server ----
server <- function(input, output, session) {
  items <- c("links", "code", "data", "resources", "readme", 
             "codebook", "errors", "mapping", "results")
  for (item in items) itemServer(item)
  
  ## reset ----
  observeEvent(input$reset, {
    debug_msg("reset")
    
    reset("shiny-tab-res_tab")
    reset("shiny-tab-prep_tab")
    
    runjs("$('input[type=radio]').prop('checked',false);")
    
    # remove classes from crr-items
    runjs("$('.crr-item')
            .removeClass('box-danger')
          .removeClass('box-warning')
          .removeClass('box-success');")
    
    # TODO: reset crr-item inputs
  })
  
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
  # output$json_text <- renderText({
  #   debug_msg("json_text")
  #   
  #   get_info(input) |>
  #     jsonlite::toJSON(auto_unbox = TRUE) |>
  #     jsonlite::prettify()
  # })
  
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
  
  ## download_readme ----
  output$download_readme <- downloadHandler(
    filename = function() {
      debug_msg("download_readme")
      "README.txt"
    },
    content = function(file) {
      j <- readLines("README.txt")
      write(j, file)
    }
  )
} 

shinyApp(ui, server)