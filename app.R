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

### prep_tab ----

intro_tab <- tabItem(
  tabName = "intro_tab",
  h2("Introduction"),
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
      "Links broken",
      "Files inaccessible/corrupted",
      "Hardware/software/time requirements not feasible",
      "Other critical issue"
    ),
    status = "danger"
  ),
  h3("Other Issues", class="other-issue"),
  awesomeCheckboxGroup(
    inputId = "prep_yellow",
    label = "", 
    choices = c(
      "Links to anonymous version",
      "Location of relevant files not clear",
      "README is not a plain text format",
      "No data codebook",
      "Other non-critical issue"
    ),
    status = "warning"
  ),
  h3("Required", class="required"),
  awesomeCheckboxGroup(
    inputId = "prep_green",
    label = "", 
    choices = c(
      "Links in paper",
      "README present",
      "README contains software/hardware requirements",
      # "README contains an indication of run time",
      "README describes project structure",
      "README explains how to run code (e.g., order)"
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
      "Can't access critical software component",
      "Critical file missing",
      "Code errors too major to continue",
      "Other critical issue"
    ),
    status = "danger"
  ),
  h3("Other Issues", class="other-issue"),
  awesomeCheckboxGroup(
    inputId = "run_yellow",
    label = "", 
    choices = c(
      "Path names in code need manually changed",
      "Code errors that allow continuation",
      "Other non-critical issue"
    ),
    status = "warning"
  ),
  h3("Required", class="required"),
  awesomeCheckboxGroup(
    inputId = "run_green",
    label = "", 
    choices = c(
      "All code runs with no errors"
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
      "Mapping between output and report too unclear to compare",
      "At least one major discrepancy between output and report",
      "At least one missing result in the output",
      "Other critical issue"
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
      "Mapping between output and report needs improvement",
      "At least one minor discrepancy between output and report (e.g., rounding error)",
      "Figures not created with code*",
      "Other non-critical issue"
    ),
    status = "warning"
  ),
  textAreaInput("res_minor", "Minor Discrepancies"),
  h3("Required", class="required"),
  awesomeCheckboxGroup(
    inputId = "res_green",
    label = "", 
    choices = c(
      "All results in the report can be mapped to output",
      "All results match values in the output"
    ),
    status = "success"
  ),
  textAreaInput("res_comments", "Comments"),
  textAreaInput("prep_suggestions", "Optional Suggestions")
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
            menuItem("Results", tabName = "res_tab", icon = icon("chart-simple"))
            
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
            res_tab
        )
    )
)


# server ----
server <- function(input, output, session) {

} 

shinyApp(ui, server)