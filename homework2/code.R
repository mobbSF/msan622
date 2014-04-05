#install.packages("RColorBrewer")
library(RColorBrewer)
library(ggplot2)
library(reshape2)
data(movies)

# If you want to see which palettes you can use, uncomment this next line
#display.brewer.all(5)

# step 1: create the localFrame
loadData <- function() {
  #data(movies)
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
# Get this function working before you start experimenting with shiny.




getPlot <- function(localFrame, MPAA, genre, colorScheme, dotsize, dotalpha){
#   # Figure out sort order.
#   localFrame$Genres <- factor(
#     localFrame$Genres,
#     levels = localFrame$Genres[sortOrder])
#   
  
  
  # Create base plot.
  
  ##### adjust by MPAA ratings
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

##### adjust by genre rating

localFrame <- subset(localFrame, localFrame$Genres %in% genrelist)
  
#### create the localPlot (aka, ggplot, using the localFrame we just made)

localPlot <- ggplot(localFrame, aes(x=budget, y=rating))
localPlot <- localPlot + geom_point(shape=1, size=dotsize, aes(colour = Genres), alpha = dotalpha)

##### adjust colors
  if (colorScheme == "Set1") {
    print("yo")
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
  else {
    localPlot <- localPlot +
      scale_fill_brewer(type = "qual", palette = 1)
      #scale_fill_grey(start = 0.4, end = 0.4)
  }


localPlot <- localPlot +   labs(x="Buget (in millions)", y="Rating")
localPlot <- localPlot + ggtitle("Scatterplot of ratings VS Budget, by Genre")
localPlot <- localPlot + theme(plot.title = element_text(lineheight=.8, face="bold"))

#localPlot <- localPlot + scale_colour_brewer(palette="Set1", name = "Genre")  #<---this is a 'qualitiative palette'
localPlot <- localPlot + theme(legend.background = element_rect(fill="gray90", size=.5))
localPlot


  return(localPlot)
}


MPAA <- "All" 
genrelist <- c("Action", "Drama")
data <- loadData()
colorScheme <- "Set1"
dotsize = 9
dotalpha = .1
#colorScheme <- "Color-Blind Friendly"
getPlot(localFrame = data, MPAA, genre, colorScheme, dotsize, dotalpha)
