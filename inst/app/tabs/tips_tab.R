### tips_tab ----

tips_tab <- tabItem(
  tabName = "tips_tab",
  h2("Tips for Authors"),
  h3("Code Comments"),
  p("Before beginning this check, make sure that your code is carefully commented to indicate how the code maps on to the results in the report. For example, comments might indicate that \"This code creates the results reported in Table 1\" or \"This code runs a t-test reported in the first paragraph of the Results section.\"")
)


### credit_tab ----

credit_tab <- tabItem(
  tabName = "credit_tab",
  h2("Credit"),
  HTML("<p>You can install the development version of the R package <a href='https://github.com/debruine/compreprev'>compreprev</a> from GitHub with:</p>
<code>
devtools::install_github(\"debruine/compreprev\")
</code>
       <p>Access the <a href='https://rstudio-connect.psy.gla.ac.uk/compreprev/'>shiny app online</a> or <a href='https://github.com/debruine/compreprev/issues'>file issues on the github repo</a>.</p>"),
  
  h3("Contributors"),
  p("The initial development of this app happened at the Garage Project meeting in Melbourne, Australia in December 2023, in a small group of Lisa DeBuine, Tom Hardwicke, Frederick Aust, and Richard Lucas."),
  p("The app was evaulated by a hackathon group at the Perspectives on Scientific Error meeting in Eindhoven, NL in March 2024.")
)