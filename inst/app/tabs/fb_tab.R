### feedback_tab ----

fb_tab <- tabItem(
  tabName = "fb_tab",
  h2("Feedback Report"),
  downloadButton("download_fb", "Download Feedback"),
  downloadButton("download_json", "Download JSON"),
  htmlOutput("fb_text"),
  verbatimTextOutput("json_text")
)