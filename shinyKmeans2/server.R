source("extRa/startup.R")

function(input, output, session) {
    
  # RenderUI examples
  output$xmean <- renderText({
      vals <-  df[,input$xcol]
      return(paste0("Mean of ",as.character(input$xcol), " is ", as.character(round(mean(vals),2))))
  })
  
  output$ymean <- renderText({
      vals <-  df[,input$ycol]
      return(paste0("Mean of ",as.character(input$ycol), " is ", as.character(round(mean(vals),2))))
  })
    
  # Plot 1
  output$plot1 <- renderPlotly({
      
    key <- row.names(df)
    dfp <- data.frame(x     = df[,isolate(input$xcol)],  # Note the use of `isolate` here
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

