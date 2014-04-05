# ui.R

shinyUI(fluidPage(
  
  titlePanel(
    list(HTML('<img src="http://www.usfca.edu/uploadedImages/Destinations/College_of_Arts_and_Sciences/Graduate_Programs/Analytics/images/Student_Photos_2013/Matt%20OBrien.jpg?n=2712"/>'), "BUDGET AND IMDB RATINGS"),
    windowTitle="IMDB RATINGS"
  ),
  helpText("This is a taste of the functionality to be found in the Shiny package in R."),
  #titlePanel("Homework II"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Make some selections:"),
      
      radioButtons("rating", label = h3("MPAA rating"),
                   choices = c("All", "PG", "PG-13", "R", "NC-17")),
#     
     checkboxGroupInput("genres", 
                       label = h3("Movie Genres"), 
                       choices = c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short"), selected = c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short")),
     
# 
     selectInput("color",
                 label = h3("Color Scheme"), 
                 choices = c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2"), selected = 1),
#     
#     
     sliderInput("dotsize", label = h3("Dot Size"),
                 min = 5, max = 20, value = 5),
#     
     sliderInput("dotalpha", label = h3("Dot Alpha"),
                 min = 0, max = 1.0, value = 1.0),
     
wellPanel(
  helpText("ABOUT ME"),
  helpText('Matt O\'Brien'),
  HTML('<br>'),
  HTML('<a href="http://github.com/mobbSF" target="_blank">github/mobbSF</a>')
)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("mymap")),
      
      plotOutput("mymap"),
      tabPanel("README", includeMarkdown("README.md"))

      )
  
      ) 
  )
))