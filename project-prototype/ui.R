setwd("/home/matt/Dropbox/Data_Vis/finalproj")

shinyUI(pageWithSidebar(
  
  
  headerPanel("MSAN 622: Data Visualization"),
  
  sidebarPanel( width=3,
    list(HTML('<img src="http://www.gadsden.info/i/clipart/American-flag-icon.gif"/>'), "Data Science Jobs in the US"),
    checkboxGroupInput("states", "States:",
                       c("Arizona"  = "AZ",
                         "California" = "CA",
                         "Colorado" = "CO",
                         "Florida" = "FL",
                         "Georgia" = "GA",
                         "Illinois" = "IL",
                         "Kansas" = "KS",
                         "Maryland" = "MD",
                         "South Carolina" = "SC",
                         "Texas" = "TX",
                         "Utah" = "UT",
                         "Virginia" = "VA",
                         "Washington" = "WA",
                         "Wisconsin" = "WI"
                         )),

    sliderInput("salary", "Salary:", 60000, 200000 ,c(60000, 200000) ,step=5000),
    list(HTML('<i>sample data courtesy of <a href = http://www.simplyhired.com/k-data-science-l-san-francisco-ca-jobs.html>simplyhired.com</a></i>'))
#     selectInput("palette_from_ui","Palette:",
#                 c( "Default", "Accent", "Set1", "Set2", "Set3", "Dark2"),
#                 selected='Set1')
),
  
  mainPanel( 
    tabsetPanel(
    tabPanel("Map",plotOutput("bubbleplot", height="700px"))
#    tabPanel("Scatterplot Matrix",plotOutput("scatterplotmatrix")),
#    tabPanel("Parallelplot",plotOutput("parallelplot"))
    )
    ,width=9)
))