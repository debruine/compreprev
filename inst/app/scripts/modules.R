item_ui <- function(id, title, desc, issues = c(), collapsed = TRUE) {
  ns <- NS(id)
  
  box(id = ns("box"),
      title = title,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = collapsed,
      class = "crr-item",
      width = 12,
      p(desc),
      radioButtons(ns("tl"), "", c("red", "yellow", "green"), 
                        selected = character(0),
                        width = "10%"),
      textAreaInput(ns("comment"), "Comments", width = "90%"),
      checkboxGroupInput(ns("issues"), "Common Issues", choices = issues)
  )
}

itemServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$tl, {
      class <- "box-success"
      if (input$tl == "red") class <- "box-danger"
      if (input$tl == "yellow") class <- "box-warning"
      
      shinyjs::removeClass(id = "box", "box-danger")
      shinyjs::removeClass(id = "box", "box-warning")
      shinyjs::removeClass(id = "box", "box-success")
      shinyjs::addClass(id = "box", class)
    })
  })
}