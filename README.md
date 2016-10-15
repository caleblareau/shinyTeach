# shinyTeach
By Caleb Lareau

- Overview of R/Shiny apps through two interactive examples. 
- Introduction to HTML widgets for light weight data sharing.

# Useful links

## R/Shiny
There's a ton of information on Shiny out there, but not all of them are worth your time. Here are my recommendations:
- RStudio [tutorial](http://shiny.rstudio.com/tutorial/lesson1/) is pretty dry but useful if the core concepts are still a bit confusing (Beginner)
- ~1 hour [YouTube video](https://www.youtube.com/watch?v=Ido56dwDTg8) from [Joe Cheng](https://github.com/jcheng5), one of the main developers of Shiny. (Beginner/Intermediate)
- How to [dynamically render UIs](http://shiny.rstudio.com/articles/dynamic-ui.html) in R/Shiny. (Beginner)
- [Advanced Shiny tips](http://deanattali.com/blog/advanced-shiny-tips/) from [Dean Attali](http://deanattali.com/aboutme/), one of the better developers of cool features in Shiny. (Intermediate/Advanced)
- [Shiny gallery](http://shiny.rstudio.com/gallery/) provides all their code along with dozens of sample apps. Sometimes the best way to learn is by example! (Beginner/Intermediate)
- [Plotly gallery](https://plot.ly/r/shiny-gallery/) more examples but rendered through [plotly](https://plot.ly/), which makes the data highly interactive. (Intermediate/Advanced)
- Shameless plugs for two of my mature Shiny apps, an epigenomics browser, [DNAlandscapeR](http://dnalandscaper.aryeelab.org) and [scHemer](https://caleblareau.shinyapps.io/scHemer/)

## R/HTMLwidgets
- Basic [overview/gallery](http://www.htmlwidgets.org/) from their sight
- Making [HTML files from RStudio](https://support.rstudio.com/hc/en-us/articles/200552276-Creating-Notebooks-from-R-Scripts)
- [Rendering HTML files](http://stackoverflow.com/questions/8446218/how-to-see-an-html-page-on-github-as-a-normal-rendered-html-page-to-see-preview) on (personal) github. 
- Sample of Caleb's use [ImmGen ATAC Consortium HTML](https://github.com/buenrostrolab/ImmGen/blob/master/code/ImmGen_chromVar_04Oct.html) and [R script](https://github.com/buenrostrolab/ImmGen/blob/master/code/Immgen_chromVar.R)


# Useful code bits
Chunks of code that I've produced that are generally useful

## Plot all values of a data frame in plotly interactive scatter plot

```
output$plot1 <- renderPlotly({
  
  anno <- apply(sapply(colnames(df), function(name){paste0(name, ": ", df[,name])}), 1, paste, collapse = "<br>")
  plot.df <- data.frame(df[,input$xcol],
						df[,input$ycol],
						df[,input$color],
						Annotation = anno)
  
  # Add column names
  colnames(plot.df) <- c("x", "y","Color" , "Annotation")
  plot_ly(plot.df, x = x, y = y, mode = "markers", color = "Color", source = "subset", text = Annotation,
		  marker = list(size = 15), colors = rev(RColorBrewer::brewer.pal(11, "Spectral"))) %>%
	  layout(title = paste(input$xcol, "vs ", input$ycol),
			 xaxis = list(title = input$xcol),
			 yaxis = list(title = input$ycol),
			 dragmode =  "select")
})
```