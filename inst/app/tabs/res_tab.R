res_tab <- tabItem(
  tabName = "res_tab",
  h2("Results"),
  box(width = 12, collapsible = TRUE, collapsed = FALSE, title = "Instructions",
      p("This step in the reproducibility check will vary depending on the nature of the report. For full computational reproducibility, all numbers that were calculated for the report should be able to be reproduced and checked. This includes in-text statistics as well as tables and figures."),
      p("This app is designed primarily to evaluate whether all numbers in a report can be reproduced, and it can be helpful to provide the first example or representative examples of numbers that cannot be reproduced in the comment boxes below. However, those doing the reproducibility check may want to use additional tools (e.g., spreadsheets listing all results; manuscript with highlighted results and comments) to track whether each individual result has been checked and confirmed."),
      p("For any discrepancies, please quote the relevant report text (or Figure/Table number) and code (by line numbers) in the boxes below.")
  ),
  
  item_ui("results", "Results", 
          "All results in the report match the correpsonding value in the code",
          c("Major discrepancy" = "results_major",
            "Minor discrepancy" = "results_minor",
            "Missing result" = "results_missing",
            "Figures not created with code" = "results_figure"),
          collapsed = FALSE
  ),
  
  textAreaInput("res_major", "Major Discrepancies", ),
  textAreaInput("res_missing", "Missing Results"),
  textAreaInput("res_minor", "Minor Discrepancies")
)