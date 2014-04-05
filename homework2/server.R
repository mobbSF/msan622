# server.R  for HW II
# runApp("DV-app", display.mode = "showcase")
source("code.R")

#install.packages("RColorBrewer")
library(RColorBrewer)
library(ggplot2)
library(reshape2)
data(movies)


# step 1: create the localFrame
loadData <- function() {
  movies <- movies[which(movies$budget>=1),]
  movies$budget <- movies$budget / 1000000
  movies <- movies[order(movies$budget),]
  Genres <- rep(NA, nrow(movies))
  count <- rowSums(movies[, 18:24])
  Genres[which(count > 1)] = "Mixed"
  Genres[which(count < 1)] = "None"
  Genres[which(count == 1 & movies$Action == 1)] = "Action"
  Genres[which(count == 1 & movies$Animation == 1)] = "Animation"
  Genres[which(count == 1 & movies$Comedy == 1)] = "Comedy"
  Genres[which(count == 1 & movies$Drama == 1)] = "Drama"
  Genres[which(count == 1 & movies$Documentary == 1)] = "Documentary"
  Genres[which(count == 1 & movies$Romance == 1)] = "Romance"
  Genres[which(count == 1 & movies$Short == 1)] = "Short"
  movies["Genres"] <- Genres  
  
  return(movies)}


###############
# Create a function that takes a vector of Genres, a MPAA rating (or "All"), color palette name, dot size, and dot alpha that generates a plot. 

getPlot <- function(localFrame, MPAA, genre, colorScheme, dotsize, dotalpha){

  ##### adjust by MPAA ratings
  if (MPAA == "All") {
    localFrame <- localFrame#[localFrame$mpaa %in% c('R'),]
  }
  if (MPAA == "R") {
    localFrame <- localFrame[localFrame$mpaa %in% 'R',]
  }
  else if (MPAA == "PG-13") {
    localFrame <- localFrame[localFrame$mpaa %in% 'PG-13',]
  }
  else if (MPAA == "NC-17") {
    localFrame <- localFrame[localFrame$mpaa %in% 'NC-17',]
  }
  else if (MPAA == "PG") {
    localFrame <- localFrame[localFrame$mpaa %in% 'PG',]
  }
  else if (MPAA == "All") {
    localFrame <- localFrame
  }
  
  ##### adjust by genre
  
  localFrame <- if (localFrame$Genres %in% genre){
  
  subset(localFrame, localFrame$Genres %in% genre)
  }
  else {localFrame <- localFrame}
  #### create the localPlot (aka, ggplot, using the localFrame we just made)
  
  localPlot <- ggplot(localFrame, aes(x=budget, y=rating))
  localPlot <- localPlot + xlim(0, 200)
  localPlot <- localPlot + ylim(0, 10)
  localPlot <- localPlot + geom_point(shape=1, size=dotsize, aes(colour = Genres), alpha = dotalpha)
  
  ##### adjust colors
  if (colorScheme == "Set1") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Set1")
    #scale_fill_brewer(type = "qual", palette = "Blues", name = "Genre")
  }
  else if (colorScheme == "Set2") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Set2")
  }
  else if (colorScheme == "Dark2") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Dark2")
  }

  else if (colorScheme == "Default") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Default")
  }

  else if (colorScheme == "Accent") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Accent")
  }

  else if (colorScheme == "Set3") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Set3")
  }

  else if (colorScheme == "Pastel1") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Pastel1")
  }
  
  else if (colorScheme == "Pastel2") {
    localPlot <- localPlot +
      scale_colour_brewer(palette = "Pastel2")
  }
  
  else {
    localPlot <- localPlot +
      scale_fill_brewer(type = "Default", palette = 1)
  }

  localPlot <- localPlot +   labs(x="Buget (in millions)", y="Rating")
  localPlot <- localPlot + ggtitle("Scatterplot of ratings VS Budget, by Genre")
  localPlot <- localPlot + theme(plot.title = element_text(lineheight=.8, face="bold"))
  localPlot <- localPlot + theme(legend.background = element_rect(fill="gray90", size=.5))
  localPlot
  
  
  return(localPlot)
}

data <- loadData()
dotalpha = .9

##### SHINY SERVER #####

# Create shiny server. Input comes from the UI input
# controls, and the resulting output will be displayed on
# the page.
shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  # Copy the data frame (don't want to change the data
  # frame for other viewers)
  localFrame <- loadData()

getRating <- reactive({
  return(input$rating)
})

getGenre <- reactive({
  return(input$genres)
})

getColor <- reactive({
  return(input$color)
})

getDotSize <- reactive({
  return(input$dotsize)
})

getDotAlpha <- reactive({
  return(input$dotalpha)
})

output$summary <- renderPrint({
  summary(data(localFrame))
})


# Should update every time sort or color criteria changes.
output$mymap <- renderPlot(
{
  
  # Use our function to generate the plot.
  mymap <- getPlot(
    localFrame,
    input$rating,
    input$genres, 
    input$color, 
    input$dotsize, 
    input$dotalpha
  )
  
  # Output the plot
  print((mymap))
}
,width = 1000, height = 800     )
}    )

# Two ways to run this application. Locally, use:
# runApp()

# To run this remotely, use:
# runGitHub("lectures", "msan622", subdir = "ShinyDemo/demo1")