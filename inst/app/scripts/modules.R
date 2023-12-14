item_ui <- function(id, title, desc, cb = c()) {
  ns <- NS(id)
  
  box(title = title,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = TRUE,
      class = "crr-item",
      width = 12,
      p(desc),
      radioButtons(ns("tl"), "", c("R", "Y", "G"), 
                   selected = character(0),
                   width = "15%"),
      textAreaInput(ns("comment"), "Comments", width = "85%"),
      checkboxGroupInput(ns("cb"), "Common Issues", choices = cb)
  )
}