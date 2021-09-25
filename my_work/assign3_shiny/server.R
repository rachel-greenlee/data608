
# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$crude_plot <- renderPlot({
    
  
  # filter data by user input
    if(input$cause != ""){
      mort_2010 <- filter(mort_2010, ICD.Chapter == input$cause)}
    
  # make barplot
    ggplot(mort_2010, aes(x = crude_rate, y = reorder(State, crude_rate))) +
      geom_bar(stat = "identity") + 
      labs(title = "2010 Crude Mortality Rates, by State", 
           x = "Crude Rate (Per 100,000)", 
           y ="State")
    

  }, height = 800, width = 800)
}

