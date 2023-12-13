### prep_tab ----

prep_tab <- tabItem(
  tabName = "prep_tab",
  h2("Can you access the the open data and code?"),
  box(width = 12, collapsible = TRUE, collapsed = FALSE, title = "Instructions",
      p("Please provide links to the open data and code. Ideally, you should link to a single, well-organized project page that includes code, data, any information needed to reproduce the report. If you include multiple links, separate them with a semicolon (;)."),
      p("The main project page must have a file called \"README.txt\" (in plain-text format) that provides the necessary information to reproduce the report (see template). Authors may wish to provide a very complete readme file that describes many details of the research project, but at a minimum, this file should provide information about the software (and hardware, if necessary) to run the analyses, as well as an overview of the code and data files that exist. If multiple code files are included, instructions on the order in which they need to be run should be included. If the code takes a very long time to run, this should be noted."),
      p("We recommend that the project page include a codebook describing all variables used in the analyses.")
  ),
  
  textInput("prep_link", "What is the link to the data and code"),
  h3("Fatal Issues", class="fatal-issue"),
  awesomeCheckboxGroup(
    inputId = "prep_red",
    label = "", 
    choices = c(
      "Links are broken, inaccesible, or lead to an incorrect page" = "links_broken",
      "Code files are missing" = "no_code",
      "Data files are missing" = "no_data",
      "Files inaccessible/corrupted" = "file_corruption",
      "Hardware/software/time requirements not feasible (e.g., proprietary software; requires supercomputer)" = "not_feasible",
      "Other" = "prep_red_other"
    ),
    status = "danger"
  ),
  h3("Critial Issues", class="critical-issue"),
  awesomeCheckboxGroup(
    inputId = "prep_yellow",
    label = "", 
    choices = c(
      "Links to anonymous version (e.g., 'view-only' version of an OSF page)" = "anon",
      "Location of relevant files not clear" = "file_loc",
      "README is not a plain text format" = "readme_text",
      "No codebook describing variables is available" = "no_codebook",
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