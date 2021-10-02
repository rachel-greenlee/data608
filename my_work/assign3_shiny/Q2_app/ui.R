

# Use a fluid Bootstrap layout
fluidPage(
  tags$head(
    tags$style(HTML("
        body {
        background-color: #faf7f2;
        color: black;
      }"))
  ),

  titlePanel("Crude Mortality Rates by Cause & State, Compared to National Averages"),
  
  # Generate a row with a sidebar
  sidebarLayout(
    
    
    # Define the sidebar with one input
    sidebarPanel(

      
      selectInput("cause", "Cause of death:", 
                  choices=mort_comp$ICD.Chapter.x,
                  selected = TRUE),
      selectInput("state", "State:",
                  choices = mort_comp$State,
                  selected = TRUE),
      hr(),
      helpText("Data from the CDC WONDER system. Please note not all states have data for every cause.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("comp_linechart"),
      plotOutput("comp_divergingchart")
    )
    
  )
)