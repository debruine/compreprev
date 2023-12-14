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
                        width = "15%"),
      textAreaInput(ns("comment"), "Comments", width = "85%"),
      checkboxGroupInput(ns("issues"), "Common Issues", choices = issues)
  )
}

itemServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$tl, {
      selector <- paste0("$('#", id, "-box').parent()")
      class <- "box-success"
      if (input$tl == "red") class <- "box-danger"
      if (input$tl == "yellow") class <- "box-warning"
      shinyjs::removeClass(id = NULL, selector = selector, "box-danger", asis = TRUE)
      shinyjs::removeClass(id = NULL, selector = selector, "box-warning", asis = TRUE)
      shinyjs::removeClass(id = NULL, selector = selector, "box-success", asis = TRUE)
      shinyjs::addClass(id = NULL, selector = selector, class, asis = TRUE)
      debug_msg(class)
    })
  })
}