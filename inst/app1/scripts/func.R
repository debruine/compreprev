# display debugging messages in R (if local) 
# and in the console log (if running in shiny)
debug_msg <- function(...) {
  is_local <- Sys.getenv('SHINY_PORT') == ""
  in_shiny <- !is.null(shiny::getDefaultReactiveDomain())
  txt <- toString(list(...))
  if (is_local) message(txt)
  if (in_shiny) shinyjs::runjs(sprintf("console.debug(\"%s\")", txt))
}

debug_sprintf <- function(fmt, ...) {
  debug_msg(sprintf(fmt, ...))
}

get_info <- function(input) {
  list(
    title = input$intro_title,
    reviewer = input$intro_reviewer,
    links = input$prep_link,
    run_time = input$run_time,
    issues = list(
      prep = list(
        red = input$prep_red,
        yellow = input$prep_yellow,
        green = input$prep_green),
      run = list(
        red = input$run_red,
        yellow = input$run_yellow,
        green = input$run_green),
      res = list(
        red = input$res_red,
        yellow = input$res_yellow,
        green = input$res_green)
    ),
    comments = list(
      prep = input$prep_comments,
      run = input$run_comments,
      res = input$res_comments
    ),
    suggestions = list(
      prep = input$prep_suggestions,
      run = input$run_suggestions,
      res = input$res_suggestions
    ),
    res = list(
      major = input$res_major,
      minor = input$res_minor,
      missing = input$res_missing
    )
  )
}
