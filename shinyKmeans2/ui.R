source("extRa/startup.R")

shinyUI(
    navbarPage(
        HTML("<img src='harvard-logo.png'/>"),
        tabPanel("Visualize",
                 fluidPage(
                     pageWithSidebar(
                         headerPanel('ADVANCED'),
                         sidebarPanel(
                             selectInput('xcol', 'X Variable', names(df)[c(-1,-2,-3,-5)],
                                         selected=names(df)[[13]], selectize = TRUE),
                             selectInput('ycol', 'Y Variable', names(df)[c(-1,-2,-3,-5)],
                                         selected=names(df)[[19]], selectize = TRUE),
                             numericInput('clusters', 'Cluster count', 4, min = 1, max = 9),
                             uiOutput('xmean'), 
                             conditionalPanel( condition = "input.clusters  == 3",   # This is Javascript
                                 uiOutput('ymean')
                             )
                         ),
                         mainPanel(
                             plotlyOutput('plot1'),
                             plotlyOutput('brush')
                         )
                     )
                 )
        ),
                     
        tabPanel("Guide",
            includeMarkdown("www/guide.Rmd")
        ),
        
        ##########
        # FOOTER
        ##########
        
        theme = shinytheme("cerulean"),
        footer = HTML(paste0('<P ALIGN=Center>Kmeans2 &copy; <A HREF="mailto:caleblareau@g.harvard.edu">Caleb Lareau</A>')),
        collapsible = TRUE, 
        fluid = TRUE,
        windowTitle = "Kmeans2"
    )
)
        