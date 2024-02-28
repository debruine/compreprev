### prep_tab ----

prep_tab <- tabItem(
  tabName = "prep_tab",
  h2("Can you access the the open data and code?"),
  
  textInput("title", "Title or reference to the paper/project"),
  textInput("reviewer", "Name of the reviewer"),
  textInput("link", "What is the link to the data and code? (separate multiple links with ;)"),
  
  h4("Click on each section below"),
  
  item_ui("links", "Links", 
          "Links are provided in the paper and work correctly. There should ideally be a single link to a well-organized project page that includes code, data, any information needed to reproduce the report.", 
          c("Links not provided" = "link_not_provided",
            "Links do not work" = "links_not_work",
            "Links go to wrong page" = "links_wrong",
            "Links go to anonymous project" = "links_anon")
  ),

  
  item_ui("readme", "README", 
          "Repository includes a usable README file that explains how to reproduce analyses. At a minimum, this file should provide information about the software (and hardware, if necessary) to run the analyses, as well as an overview of the code and data files that exist. If multiple code files are included, instructions on the order in which they need to be run should be included. If the code takes a very long time to run, this should be noted.", 
          c("No README" = "readme_none",
            "Not a text file" = "readme_format",
            "Does not explain how to reproduce results" = "readme_repro",
            "Does not include software/hardware requirements" = "readme_req",
            "No runtime estimate" = "readme_runtime")
  ),
  
  item_ui("resources", "Resources", 
          "Software/hardware/run-time requirements are feasible", 
          c("Software not available" = "resources_software",
            "Hardware not available" = "resources_hardware",
            "Run-time is too long" = "resources_long_run")
  ),
  
  item_ui("code", "Code Files", 
          "Code files are present and not corrupted", 
          c("One or more code files does not exist" = "code_missing",
            "One or more code files is corrupted" = "code_corrupt")
  ),
  
  item_ui("data", "Data Files", 
          "Data files are present and not corrupted", 
          c("One or more data files does not exist" = "code_missing",
            "One or more data files is corrupted" = "code_corrupt")
  ),
  
  item_ui("codebook", "Codebook", 
          "Codebook is included (if needed). We recommend that the project page include a codebook describing all variables used in the analyses.", 
          c("Codebook is missing" = "codebook_missing",
            "Codebook is incomplete" = "codebook_incomplete")
  ),
  
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