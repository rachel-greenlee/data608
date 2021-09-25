

# Use a fluid Bootstrap layout
fluidPage(    
  
  # Give the page a title
  titlePanel("Crude Mortality Rates by Cause in 2010, by State"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("cause", "Cause:", 
                  choices=mort_2010$ICD.Chapter),
      hr(),
      helpText("Taken from the CDC.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("crude_plot")  
    )
    
  )
)