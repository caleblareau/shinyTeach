source("extRa/startup.R")

function(input, output, session) {
    
  # Plot 1
  output$plot1 <- renderPlotly({
      
    key <- row.names(df)
    dfp <- data.frame(x     = df[,isolate(input$xcol)],
                      y     = df[,input$ycol],
                      clust = as.factor(kmeans(df[,c(isolate(input$xcol),input$ycol)], input$clusters)$cluster),
                      team  = df[,5],
                      pos   = df[,3],
                      player= df[,1])
    
    plot_ly(dfp, x = x, y = y, mode = "markers", color = clust, key = key,
        text = paste0("Player:", player, "<br>", "Team: ", team, "<br>", "Position: ", pos)) %>%
        layout(dragmode = "select")
  
  })
  
  # Plot 2  
  output$brush <- renderPlotly({
      eventdata <- event_data("plotly_selected")
      if (is.null(eventdata)){
        return(NULL)
      } else {
        positions <- df[eventdata$key,]$Pos
        ggplot1 <- qplot(positions) + theme_bw()
        ggplotly(ggplot1)
      }
  })
  
}

