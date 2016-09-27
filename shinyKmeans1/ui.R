source("startup.R")

pageWithSidebar(
  headerPanel('NBA k-means clustering-simple'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(df)[c(-1,-2,-3)], selected=names(df)[[13]]),
    selectInput('ycol', 'Y Variable', names(df)[c(-1,-2,-3)], selected=names(df)[[19]]),
    numericInput('clusters', 'Cluster count', 4, min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

