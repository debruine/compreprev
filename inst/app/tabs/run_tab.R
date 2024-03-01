### run_tab ----

run_tab <- tabItem(
  tabName = "run_tab",
  h2("Run the Code"),
  textInput("run_time", "Approximately how long did it take to run the code? (e.g., '5 minutes' or '3 hours')"),
  
  h4("Click on each section below"),
  
  item_ui("errors", "Errors/Warnings", 
          "Code runs without errors", 
          c("Critical error prevents code from running" = "error_critical",
            "Non-critical error/warning" = "error_non_critical",
            "Missing code/functions" = "error_missing")
  ),
  
  item_ui("mapping", "Mapping", 
          "Results values, figures and table from the report can be mapped to their origin in the corresponding script", 
          c("Mapping not clear" = "mapping_unclear")
  )
)