# libraries ----
suppressPackageStartupMessages({
    library(shiny)
    library(shinyjs)
    library(shinydashboard)
    library(shinyWidgets)
})

# setup ----


# functions ----
source("scripts/func.R") # helper functions

# user interface ----

## tabs ----

### intro_tab ----

intro_tab <- tabItem(
  tabName = "intro_tab",
  h2("Introduction"),
  fileInput("load_json", "Load from JSON", width = "100%"),
  textInput("intro_title", "Title or reference to the paper/project"),
  textInput("intro_reviewer", "Name of the reviewer")
)

### prep_tab ----

prep_tab <- tabItem(
  tabName = "prep_tab",
  h2("Can you access the the open data and code?"),
  textInput("prep_link", "What is the link to the data and code (ideally, link to a single overview page, use ';' to separate multiple links if necessary"),
  h3("Blocking Issues", class="blocking-issue"),
  awesomeCheckboxGroup(
    inputId = "prep_red",
    label = "", 
    choices = c(
      "Links broken" = "links_broken",
      "Files inaccessible/corrupted" = "no_file",
      "Hardware/software/time requirements not feasible" = "not_feasible",
      "Other" = "prep_red_other"
    ),
    status = "danger"
  ),
  h3("Other Issues", class="other-issue"),
  awesomeCheckboxGroup(
    inputId = "prep_yellow",
    label = "", 
    choices = c(
      "Links to anonymous version" = "anon",
      "Location of relevant files not clear" = "file_loc",
      "README is not a plain text format" = "readme_text",
      "No data codebook" = "no_codebook",
      "Other" = "prep_yellow_other"
    ),
    status = "warning"
  ),
  h3("Required", class="required"),
  awesomeCheckboxGroup(
    inputId = "prep_green",
    label = "", 
    choices = c(
      "Links in paper" = "links",
      "README present" = "readme",
      "README contains software/hardware requirements" = "readme_req",
      # "README contains an indication of run time",
      "README describes project structure" = "readme_structure",
      "README explains how to run code (e.g., order)" = "readme_code"
    ),
    status = "success"
  ),
  textAreaInput("prep_comments", "Comments"),
  textAreaInput("prep_suggestions", "Optional Suggestions")
)

### run_tab ----

run_tab <- tabItem(
  tabName = "run_tab",
  h2("Can you run the code?"),
  h3("Blocking Issues", class="blocking-issue"),
  awesomeCheckboxGroup(
    inputId = "run_red",
    label = "", 
    choices = c(
      "Can't access critical software component" = "software_access",
      "Critical file missing" = "file_missing",
      "Code errors too major to continue" = "major_errors",
      "Other" = "run_red_other"
    ),
    status = "danger"
  ),
  h3("Other Issues", class="other-issue"),
  awesomeCheckboxGroup(
    inputId = "run_yellow",
    label = "", 
    choices = c(
      "Path names in code need manually changed" = "path_problems",
      "Code errors that allow continuation" = "minor_errors",
      "Other" = "run_yellow_other"
    ),
    status = "warning"
  ),
  h3("Required", class="required"),
  awesomeCheckboxGroup(
    inputId = "run_green",
    label = "", 
    choices = c(
      "All code runs with no errors" = "no_errors"
    ),
    status = "success"
  ),
  textInput("run_time", "Approximately how long did this take? (e.g., '5 minutes' or '3 hours')"),
  textAreaInput("run_comments", "Comments"),
  textAreaInput("run_suggestions", "Optional Suggestions")
)

### res_tab ----

res_tab <- tabItem(
  tabName = "res_tab",
  h2("Do all the results match?"),
  p("For any discrepancies, please quote the relevant report text (or Figure/Table number) and code (by line numbers) in the boxes below."),
  h3("Blocking Issues", class="blocking-issue"),
  awesomeCheckboxGroup(
    inputId = "res_red",
    label = "", 
    choices = c(
      "Mapping between output and report too unclear to compare" = "unclear_mapping",
      "At least one major discrepancy between output and report" = "major_discrepancy",
      "At least one missing result in the output" = "missing_result",
      "Other" = "res_red_other"
    ),
    status = "danger"
  ),
  textAreaInput("res_major", "Major Discrepancies"),
  textAreaInput("res_missing", "Missing Results"),
  
  h3("Other Issues", class="other-issue"),
  awesomeCheckboxGroup(
    inputId = "res_yellow",
    label = "", 
    choices = c(
      "Mapping between output and report needs improvement" = "mapping_improve",
      "At least one minor discrepancy between output and report (e.g., rounding error)" = "minor_discrepancy",
      "Data figures not created with code*" = "figure_code",
      "Other" = "res_yellow_other"
    ),
    status = "warning"
  ),
  textAreaInput("res_minor", "Minor Discrepancies"),
  h3("Required", class="required"),
  awesomeCheckboxGroup(
    inputId = "res_green",
    label = "", 
    choices = c(
      "All results in the report can be mapped to output" = "all_results_mapped",
      "All results match values in the output" = "all_results_match"
    ),
    status = "success"
  ),
  textAreaInput("res_comments", "Comments"),
  textAreaInput("prep_suggestions", "Optional Suggestions")
)

### feedback_tab ----

fb_tab <- tabItem(
  tabName = "fb_tab",
  h2("Feedback Report"),
  downloadButton("download_fb", "Download Feedback"),
  downloadButton("download_json", "Download JSON"),
  htmlOutput("fb_text"),
  verbatimTextOutput("json_text")
)

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
    jsonlite::prettify(j, )
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