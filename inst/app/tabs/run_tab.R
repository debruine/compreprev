### run_tab ----

run_tab <- tabItem(
  tabName = "run_tab",
  h2("Does the code run?"),
  box(width = 12, collapsible = TRUE, collapsed = FALSE, title = "Instructions",
      p("This page describes issues that may arise when attempting to run the code provided in the project repository.")
  ),
  h3("Fatal Issues", class="fatal-issue"),
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
  h3("Critical Issues", class="critical-issue"),
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