### intro_tab ----

intro_tab <- tabItem(
  tabName = "intro_tab",
  h2("Introduction"),
  box(width = 12, collapsible = TRUE, collapsed = FALSE, title = "Instructions",
    p("This app is designed to facilitate review of the computational reproducibility of a report. It can be used by authors to evaluate the reproducibility of their own report, and it can be used by external reviewers to evaluate whether someone else's report is reproducible."),
    p("To use the app, click through each tab, noting whether each element is present and whether any problems arise during the review. The items in each tab are organized by importance for establishing the computational reproducibility of the report."),
    p("Items highlighted in red reflect fatal issues. If there is a fatal problem with an element, then either the review cannot continue (e.g., for missing files) or the reproducibility check failed (e.g., when results from statistical output do not match those in the report)."),
    p("Items highlighted in yellow are critical issues. If a critical issue exists, review can continue, but authors may wish to update some feature of their project to improve computational reproducibility or to increase clarity. To receive the Computational Reproducibility badge at Psychological Science, critical issues need to be resolved."),
    p("For authors: Before beginning this reproducibility check, make sure that your code is carefully commented to indicate how the code maps on to the results in the report. For example, comments might indicate that \"This code creates the results reported in Table 1\" or \"This code runs a t-test reported in the first paragraph of the Results section.\""),
    p("Information entered into this app can be saved either for later editing or to submit with your paper for the Computational Reproducibility Badge at Psychological Science. To save your entries, click on “Save CompRepRev File” in the Feedback tab. To load previous responses, upload this CompRepRev (.crr) file on the Intro tab of the app."),
    p("The Feedback tab also provides an option to save a narrative report of the results of the reproducibility check.")
  ),
  fileInput("load_crr", "Load from CompRepRev file", width = "100%"),
  textInput("intro_title", "Title or reference to the paper/project"),
  textInput("intro_reviewer", "Name of the reviewer"),
  
  hr(),
  h4("Links"),
  p("explain stuff..."),
  radioButtons("links", "", c("R" = "red",
                                   "Y" = "yellow",
                                   "G" = "green")),
  textAreaInput("links_comment", "")
  
)