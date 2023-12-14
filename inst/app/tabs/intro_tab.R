### intro_tab ----

intro_tab <- tabItem(
  tabName = "intro_tab",
  h2("Instructions"),
    p("This app is designed to facilitate review of the computational reproducibility of a report. It can be used by authors to evaluate the reproducibility of their own report, and it can be used by external reviewers to evaluate whether someone else's report is reproducible."),
    p("To use the app, click through each tab, noting whether each element is present and whether any problems arise during the review. The items in each tab are organized by importance for establishing the computational reproducibility of the report."),
    p("Choose a red traffic light for fatal issues, where either the review cannot continue (e.g., for missing files) or the reproducibility check failed (e.g., when results from statistical output do not match those in the report).", class="red-light"),
    p("Choose a yellow traffic light for critical issues, where the review can continue, but authors should update some feature of their project to improve computational reproducibility or to increase clarity.", class="yellow-light"),
    p("Choose a green traffic light for items with no problems. You can still add suggestions for further clarification in the comments box, but make sure they are clearly marked as optional.", class="green-light"),
    p("For authors: Before beginning this reproducibility check, make sure that your code is carefully commented to indicate how the code maps on to the results in the report. For example, comments might indicate that \"This code creates the results reported in Table 1\" or \"This code runs a t-test reported in the first paragraph of the Results section.\""),
    p("Information entered into this app can be saved either for later editing or to submit with your paper for the Computational Reproducibility Badge at Psychological Science. To save your entries, click on “Save CompRepRev File” in the sidebar. To load previous responses for editing, upload this CompRepRev file on the Intro tab of the app."),
    p("The sidebar also provides an option to save a narrative report of the results of the reproducibility check. (COMING SOON)")
)