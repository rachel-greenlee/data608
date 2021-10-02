

# Use a fluid Bootstrap layout
fluidPage(
  tags$head(
    tags$style(HTML("
        body {
        background-color: #faf7f2;
        color: black;
      }"))
  ),
  # Give the page a title
  titlePanel("Crude Mortality Rates by Cause in 2010, by State"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("cause", "Cause of death:", 
                  choices=mort_2010$ICD.Chapter,
                  selected = TRUE),
      hr(),
      helpText("Data from the CDC WONDER system. Please note not all states have data for every cause.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("crude_plot")  
    )
    
  )
)

