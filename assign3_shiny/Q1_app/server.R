 
# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$crude_plot <- renderPlot({
    
  
  # filter data by user input
    if(input$cause != ""){
      mort_2010 <- filter(mort_2010, ICD.Chapter == input$cause)}
    
    
    ggplot(mort_2010, aes(x = crude_rate, y = reorder(State, crude_rate))) +
      geom_bar(stat = "identity") + 
      labs(title = "2010 Crude Mortality Rates, by State", 
           x = "Crude Rate (Per 100,000)", 
           y ="State") +
      theme(plot.background = element_rect(fill = backs, color = backs),
            panel.border = element_blank(),
            axis.text = element_text(size = 14),
            axis.title = element_text(size = 18, face = "bold"),
            plot.title = element_blank()) +
      geom_text(aes(x = crude_rate, y = reorder(State, crude_rate), label = State, hjust = 1.3), color = "white")
        
    

  }, height = 850, width = 700)
}

