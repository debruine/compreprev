item_ui <- function(id, title, desc, issues = c()) {
  ns <- NS(id)
  
  box(id = ns("box"),
      title = title,
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
      checkboxGroupInput(ns("issues"), "Common Issues", choices = issues)
  )
}

itemServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$tl, {
      shinyjs::addClass(paste0(id, "-tl"), "danger")
    })
    
    return(list(tl = input$tl,
                comment = input$comment,
                issues = input$issues))
  })
}