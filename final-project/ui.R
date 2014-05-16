#setwd("/home/matt/Dropbox/Data_Vis/finalproj")
#setwd("C:/Users/mobb/Dropbox/Data_Vis/finalproj")

#setwd("/users/matto/Dropbox/Data_Vis/finalproj")

shinyUI(pageWithSidebar(
  
  
  headerPanel("MSAN 622: Data Visualization"),
  
  sidebarPanel( width=2,
    list(HTML('<img src="http://www.gadsden.info/i/clipart/American-flag-icon.gif"/>')),
    br(),
    print("Data Science Jobs in the US"),
    br(),
    tags$hr(),
    checkboxInput("jitter", label = "Jitter?", value = FALSE),
    checkboxInput("sort", label = "Sort?", value = FALSE),
    tags$hr(),    
    
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

#    sliderInput("salary", "Salary:",
#                min = 60000, max = 200000, value = 60000, step = 2500,
#                format="$#,##0", locale="us", animate=TRUE),
    
    sliderInput("salary",  format="$#,##0",  "Salary:", 60000, 200000 ,c(60000, 200000) , step=5000),

    sliderInput("alpha", "Alpha:", min = 0.0, max = 1.0, value = 1.0),
    
    
    selectInput("onestate", "Pick a state: ",
                c("Arizona"  = "Arizona",
                  "California" = "CA",
                  "Colorado" = "Colorado",
                  "Florida" = "FL",
                  "Georgia" = "Georgia",
                  "Illinois" = "IL",
                  "Kansas" = "Kansas",
                  "Maryland" = "Maryland",
                  "South Carolina" = "South Carolina",
                  "Texas" = "Texas",
                  "Utah" = "UT",
                  "Virginia" = "Virginia",
                  "Washington" = "WA",
                  "Wisconsin" = "WI"
                ))
    

    #     selectInput("palette_from_ui","Palette:",
#                 c( "Default", "Accent", "Set1", "Set2", "Set3", "Dark2"),
#                 selected='Set1')
),
  
  mainPanel( 
    tabsetPanel(
    tabPanel("Map",plotOutput("map", height="700px")),
    tabPanel("Choropleth", plotOutput("cloropleth", height="700px")),
    tabPanel("Single State",plotOutput("california", height="700px")),
    tabPanel("Bar Plot",plotOutput("barplot", height="700px"))
    )
    ,width=10)
))