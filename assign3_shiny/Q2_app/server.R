
# Define a server for the Shiny app
function(input, output) {
  
  # Fill in the spot we created for a plot
  output$comp_linechart <- renderPlot({
    
  
  # filter data by user input
    if(input$cause != ""){
      mort_comp <- filter(mort_comp, ICD.Chapter.x == input$cause)}
    
    if(input$state != ""){
      mort_comp <- filter(mort_comp, State == input$state)}
    
    
  # make linechart
    ggplot(mort_comp, aes( x = Year.x)) + 
      geom_line(aes(y = Crude.Rate, color = "State"), size = 2) + 
      geom_line(aes(y = national_crude_rate, color = "National Average"), size = 1.5, linetype="dashed") +
      scale_color_manual(name = "Rates", values = c("State" = dark_dust, "National Average" = dusty)) +
      xlab("Year") + ylab("Crude Rate (per 100,000)") +
      labs(title= "National average and state crude mortality rates, by year") +
      theme(plot.background = element_rect(fill = backs, color = backs),
            panel.border = element_blank(),
            plot.title = element_text(size = 20),
            axis.text = element_text(size = 14),
            axis.title = element_text(size = 14, face = "bold"),
            legend.position = "bottom",
            legend.key = element_rect(color = backs),
            legend.background = element_rect(fill = backs, color = backs),
            legend.text = element_text(size = 14)) +
      scale_x_continuous(breaks = round(seq(1999, 2010, by = 1),1)) +
      scale_y_continuous(expand = c(0, 10), limits = c(0, NA))
    

  }, height = 400, width = 800)
  
  
  
  # Fill in the spot we created for a plot
  output$comp_divergingchart <- renderPlot({
    
    
    # filter data by user input
    if(input$cause != ""){
      mort_comp <- filter(mort_comp, ICD.Chapter.x == input$cause)}
    
    if(input$state != ""){
      mort_comp <- filter(mort_comp, State == input$state)}
    
    
    # make diverging bar chart
    ggplot(mort_comp, aes(x = Year.x, y = nat_diff, label = nat_diff)) + 
      geom_bar(stat='identity', aes(fill=diff_type), width=.5)  +
      geom_hline(yintercept = 0, color = dusty, size = 1.5) +
      scale_fill_manual(name="Compared to National Crude Rate", 
                        labels = c("Above National Average", "Below National Average"), 
                        values = c("above"= sherbet, "below"= zinnia)) + 
      xlab("Year") + ylab("Difference in Crude Rate (per 100,000)") +
      labs(title= "State's difference from national average, by year") +
      theme(plot.background = element_rect(fill = backs, color = backs),
            panel.border = element_blank(),
            plot.title = element_text(size = 20),
            axis.text = element_text(size = 14),
            axis.title = element_text(size = 14, face = "bold"),
            legend.position = "bottom",
            legend.key = element_rect(color = backs),
            legend.background = element_rect(fill = backs, color = backs),
            legend.text = element_text(size = 14)) +
      scale_x_continuous(breaks = round(seq(1999, 2010, by = 1),1))
    
    
  }, height = 400, width = 800)
  
  
  
  
  
  
  
}

