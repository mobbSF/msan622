## FINAL
## Matt O'Brien
# load up the libraries 
library(shiny)
library(zipcode)
library(mapproj)
data(zipcode)
#DF <- read.csv("~/Dropbox/Data_Vis/finalproj/SH_DS_test.csv")
DF <- read.csv("~/Dropbox/Data_Vis/finalproj/SH_DS.csv")

findzip <- function(myzip){
  foundzip <- zipcode[ zipcode$zip %in% myzip  , ] 
  return(foundzip)}

#myzip <- DF[,5]
#gotzips <- findzip(myzip)

#map(database= "usa", col="grey80", fill=TRUE)
#lon <- c(gotzips[, 4])
#lat <- c(gotzips[, 5])
#points(lat, lon, pch=20, cex=4.2, col="red")  #plot converted points



modifyDF <- function(DF, states, salary){
  #   if (states == "VA"){
  #     print("HI!")}
  if(length(states)<1){cleanDF<-DF}
  else{cleanDF<-DF[which(DF$location_state %in% states),]}
  salary <- as.integer(salary)
  cleanDF$compensation_pay <- as.numeric(as.character(cleanDF$compensation_pay))
  indices <- which(cleanDF$compensation_pay > salary[1])
  newDF <- cleanDF[indices, ]
  indices2 <- which(cleanDF$compensation_pay < salary[2])
  newDF <- newDF[indices2, ]
  myzip <- newDF[,5]
  gotzips <- findzip(myzip)
  lon <- c(gotzips[, 4])
  lat <- c(gotzips[, 5])
  longlatdf <- data.frame(lon, lat)#print(gotzips)
  return(longlatdf)
}



################################################################################33

# shiny server goes here:
shinyServer(function(input, output) {
  
  output$bubbleplot <- renderPlot({
    newDF <- modifyDF(DF, input$states, input$salary)
    map(database= "usa", col="grey80", fill=TRUE)
    #lon <- c(gotzips[, 4])
    #lat <- c(gotzips[, 5])
    points(newDF$lat, newDF$lon, pch=20, cex=2, col="red")  #plot converted points
  })
})

# library(mapproj)
# library(zipcode)
# data(zipcode)
# 
# 
