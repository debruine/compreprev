res_tab <- tabItem(
  tabName = "res_tab",
  h2("Do all the results match?"),
  box(width = 12, collapsible = TRUE, collapsed = FALSE, title = "Instructions",
      p("This step in the reproducibility check will vary depending on the nature of the report. For full computational reproducibility, all numbers that were calculated for the report should be able to be reproduced and checked. This includes in-text statistics as well as tables and figures."),
      p("This app is designed primarily to evaluate whether all numbers in a report can be reproduced, and it can be helpful to provide the first example or representative examples of numbers that cannot be reproduced in the comment boxes below. However, those doing the reproducibility check may want to use additional tools (e.g., spreadsheets listing all results; manuscript with highlighted results and comments) to track whether each individual result has been checked and confirmed."),
      p("For any discrepancies, please quote the relevant report text (or Figure/Table number) and code (by line numbers) in the boxes below.")
  ),
  
  h3("Critial Issues", class="critical-issue"),
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