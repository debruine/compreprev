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

mod_info <- function(input, mod) {
  list(
    tl = input[[paste0(mod, "-tl")]],
    comment = input[[paste0(mod, "-comment")]],
    issues = input[[paste0(mod, "-issues")]]
  )
}

get_info <- function(input) {
  list(
    title = input$title,
    reviewer = input$reviewer,
    link = input$link,
    run_time = input$run_time,
    links = mod_info(input, "links"),
    code = mod_info(input, "code"),
    data = mod_info(input, "data"),
    resources = mod_info(input, "resources"),
    readme = mod_info(input, "readme"),
    codebook = mod_info(input, "codebook"),
    errors = mod_info(input, "errors"),
    mapping = mod_info(input, "mapping"),
    results = mod_info(input, "results"),
    res = list(
      major = input$res_major,
      minor = input$res_minor,
      missing = input$res_missing
    )
  )
}
