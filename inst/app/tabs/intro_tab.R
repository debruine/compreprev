### intro_tab ----

intro_tab <- tabItem(
  tabName = "intro_tab",
  h2("Introduction"),
  box(width = 12, collapsible = TRUE, collapsed = FALSE, title = "Instructions",
    p("This app is designed to facilitate review of the computational reproducibility of a report. It can be used by authors to evaluate the reproducibility of their own report, and it can be used by external reviewers to evaluate whether someone else's report is reproducible."),
    p("To use the app, click through each tab, noting whether each element is present and whether any problems arise during the review. The items in each tab are organized by importance for establishing the computational reproducibility of the report."),
    p("Items highlighted in red reflect fatal issues. If there is a fatal problem with an element, then either the review cannot continue (e.g., for missing files) or the reproducibility check failed (e.g., when results from statistical output do not match those in the report)."),
    HTML("<p>Items highlighted in yellow are critical issues. If an informational issue exists, review can continue, but authors may wish to update some feature of their project to improve computational reproducibility or to increase clarity. To receive the Computational Reproducibility badge at <i>Psychological Science</i>, issues with informational items need to be resolved.</p>"),
    p("For authors: Before beginning this reproducibility check, make sure that your code is carefully commented to indicate how the code maps on to the results in the report. For example, comments might indicate that \"This code creates the results reported in Table 1\" or \"This code runs a t-test reported in the first paragraph of the Results section.\"")
  ),
  fileInput("load_json", "Load from JSON", width = "100%"),
  textInput("intro_title", "Title or reference to the paper/project"),
  textInput("intro_reviewer", "Name of the reviewer")
)