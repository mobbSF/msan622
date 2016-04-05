##Matt O'Brien
## HW 3

#setwd("/home/matt/Dropbox/my_git_repo/MSAN622/homework3")

shinyUI(pageWithSidebar(
  
  
  headerPanel("Project 3: Data Visualization"),
  
  sidebarPanel( width=3,
    list(HTML('<img src="http://www.gadsden.info/i/clipart/American-flag-icon.gif"/>'), "Data related to the 50 states of the United States of America."),
    checkboxGroupInput("regions", "Region:",
                       c("Northeast" = "Northeast",
                         "South" = "South",
                         "North Central" = "North Central",
                         "West" = "West")),

    sliderInput("alpha_var", "Alpha:", 0.1, 1.0 ,1.0 ,step=0.1)
    
#     selectInput("palette_from_ui","Palette:",
#                 c( "Default", "Accent", "Set1", "Set2", "Set3", "Dark2"),
#                 selected='Set1')
),
  
  mainPanel( 
    tabsetPanel(
    tabPanel("Bubbleplot",plotOutput("bubbleplot", height="400px")),
    tabPanel("Scatterplot Matrix",plotOutput("scatterplotmatrix")),
    tabPanel("Parallelplot",plotOutput("parallelplot"))
    )
    ,width=9)
))