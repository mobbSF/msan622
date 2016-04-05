## FINAL
## Matt O'Brien
# load up the libraries 
library(shiny)
library(zipcode)
library(mapproj)
#library(devtools)
library(choroplethr)
library(ggplot2)
library(sp)
library(maps)
library(maptools)
library(randomForest)
gpclibPermit() 

data(zipcode)

DF <- read.csv("jobs.csv")


### clean up DF
DF$location_zip <- as.character(DF$location_zip)
DF <- DF[nchar(DF$location_zip) ==5 , ]
DF$compensation_pay <- as.numeric(DF$compensation_pay)
DF$compensation_pay <- na.roughfix(DF$compensation_pay)
DF <- DF[complete.cases(DF),]


## a function to use to get lon, lat back from zipcodes
findzip <- function(myzip){
  foundzip <- zipcode[match(myzip, zipcode$zip), ]
  return(foundzip)}



#### used for the first map
modifyDF <- function(DF, states, salary){
  DF$region <- DF$location_state
  DF$value  <- DF$compensation_pay
  
  names(DF[8]) <- c('region')
  names(DF[9]) <- c('value')
  if(length(states)<1){cleanDF<-DF}
  else{cleanDF<-DF[which(DF$location_state %in% states),]}
  salary <- as.integer(salary)
#  print(salary)
  cleanDF$value <- as.numeric(as.character(cleanDF$compensation_pay))
  indices <- which(cleanDF$value > salary[1])
  newDF <- cleanDF[indices, ]
  indices2 <- which(cleanDF$value < salary[2])
  newDF <- newDF[indices2, ]
  myzip <- newDF[,5]
  gotzips <- findzip(myzip)
  lon <- c(gotzips[, 4])
  lat <- c(gotzips[, 5])
  longlatdf <- data.frame(lon, lat)#print(gotzips)
  
  return(longlatdf)
}


### used to create the dataframe for the choropleth map
modifyDF2 <- function(DF, states, salary){
  if(length(states)<1){states <- c("AZ", "CA","CO", "FL", "GA", "IL", "KS", "MD", "SC", "TX", "UT", "VA", "WA", "WI")}
  DF$region <- DF$location_state
  DF$value  <- as.numeric(as.character(DF$compensation_pay))
  
  names(DF)[8] <- c('region')
  names(DF)[9] <- c('value')
  
  if(length(states)<1){cleanDF<-DF}
  else{cleanDF<-DF[which(DF$location_state %in% states),]}
  salary <- as.integer(salary)
#  cleanDF$value <- as.numeric(as.character(cleanDF$compensation_pay))
  indices <- which(cleanDF$value > salary[1])
  newDF <- cleanDF[indices, ]
  indices2 <- which(cleanDF$value < salary[2])
  newDF <- newDF[indices2, ]

  return(newDF)
}


### used for the 3rd technique
modifyDF3 <- function(DF, onestate, salary){
  
  newDF<-DF[which(DF$location_state %in% onestate),]
  
  salary <- as.integer(salary)
  newDF$value <- as.numeric(as.character(newDF$compensation_pay))
  indices <- which(newDF$value > salary[1])
  newDF <- newDF[indices, ]
  indices2 <- which(newDF$value < salary[2])
  newDF <- newDF[indices2, ]
  gotzips <- findzip(newDF[,5])
  DF_lon_lat_sal <- data.frame(gotzips[, 4], gotzips[, 5], newDF$compensation_pay)#print(gotzips)
  names(DF_lon_lat_sal) <- c("lon", "lat","sal")
  return(DF_lon_lat_sal)
}

### used for the 4th technique ###
modifyDF4 <- function(DF, states){
  if(length(states)<1){states <- c("AZ", "CA","CO", "FL", "GA", "IL", "KS", "MD", "SC", "TX", "UT", "VA", "WA", "WI")}
  DF<-DF[which(DF$location_state %in% states),]
  return(DF)}



################################################################################33

# shiny server goes here:
shinyServer(function(input, output) {  
  
#### MAP ####
  output$map <- renderPlot({
    newDF <- modifyDF(DF, input$states, input$salary)
    map(database= "state", col="grey90", fill=FALSE)
    map(database= "usa", col="#AAAAAA22", fill=TRUE,lty=0,add=TRUE)
    text(x=state.center$x, y=state.center$y, state.abb)
    x = newDF$lat
    y = newDF$lon
    if (input$jitter == TRUE){
      x = jitter(newDF$lat, factor = 1, amount = 1)
      y = jitter(newDF$lon, factor = 1, amount = 1)
    }   
    points(x, y, pch="O", cex=1, col = do.call(rgb,c(as.list(col2rgb("springgreen4")/255), input$alpha)))#rgb(0.02,  0.70,	0.43, input$alpha))      #"springgreen4")  #plot converted points
  })               

#### CLOROPLETH ####
  output$cloropleth <- renderPlot({
    cloroDF <- modifyDF2(DF, input$states, input$salary)
    cloroDF <- cloroDF[complete.cases(cloroDF),]
    mycloroDF <- cloroDF[, c(8,9)]
    row.names(mycloroDF)<-NULL
    mycloroDF$value <- as.integer(mycloroDF$value)
    dummystates = data.frame(region=state.abb, value=c(1))
    finalDF <- rbind(mycloroDF, dummystates)
    finalfinalDF <- aggregate(. ~ region, data = finalDF, FUN = sum)
    q <-choroplethr(finalfinalDF, lod="state", num_buckets = 1)
    q <- q + scale_fill_gradient(high = "springgreen4", low= "grey90", name="Sum of all \n salary in a state", 
                                 labels = paste0("$",c("5,000,000", "4,000,000", "3,000,000", "2,000,000", "1,000,000")),
                                 breaks = c(50000000, 40000000, 30000000, 20000000, 10000000))
    q <- q +  theme(legend.justification=c(0.9, 0.1), legend.position=c(0.9, 0.1))
    q <- q + theme(panel.background = element_blank())
    plot(q)
  })
  
### SINGLE STATE MAP ###

  output$california <- renderPlot({
    
    which_state <- input$onestate
    if(which_state == "Arizona"){dfstate <- "AZ"}
    else if(which_state == "Colorado"){dfstate <- "CO"}
    else if(which_state == "Georgia"){dfstate <- "GA"}
    else if(which_state == "Kansas"){dfstate <- "KS"}
    else if(which_state == "Maryland"){dfstate <- "MD"}
    else if(which_state == "South Carolina"){dfstate <- "SC"}
    else if(which_state == "Texas"){dfstate <- "TX"}
    else if(which_state == "Virginia"){dfstate <- "VA"}
    else {dfstate <- which_state}
    latlongDFfor3 <- modifyDF3(DF, dfstate, input$salary)
 
    if (length(latlongDFfor3$lat) == 0) {stop('No salaries in this state within selected range')}

    calif <- map_data('state', region=which_state)
    calif.df <- fortify(calif)
    gg <- ggplot()
    gg <- gg + geom_map(data=calif.df, map = calif.df, 
                        aes(map_id=region, x=long, y=lat), 
                        fill="grey90", color="black")
    gg <- gg + coord_map()
    gg <- gg + labs(x="", y="")
    gg <- gg + theme(plot.background = element_rect(fill = "transparent", color = NA),
                     panel.border = element_blank(),
                     panel.background = element_rect(fill = "transparent", color = NA),
                     panel.grid = element_blank(),
                     axis.text = element_blank(),
                     axis.ticks = element_blank(),
                     legend.position = "none")
    if (input$jitter == TRUE){
      latlongDFfor3$lat = jitter(latlongDFfor3$lat, factor = 1, amount = 0.1)
      latlongDFfor3$lon = jitter(latlongDFfor3$lon, factor = 1, amount = 0.1)
    }
    gg <- gg + geom_point(data=latlongDFfor3, aes(x=lat, y=lon, size=sal), shape='O',  col="springgreen4", alpha=input$alpha)
    plot(gg)
  },  height = 750, width = 1200)


### BARPLOT ####
  output$barplot <- renderPlot({
    
    DF <- modifyDF4(DF, input$states)
  #  print("HI")
  #  str(DF$location_state)
    if(input$sort == TRUE){
            p <- ggplot(DF,
                  aes(x=reorder(location_state,location_state,
                  function(x)-length(x))))}
    else{
    p <- ggplot(DF, aes(x = location_state))}
    p <- p + labs(title = "Job Openings by State", x = "State", y = "Number of job openings")
    p <- p + geom_bar() + coord_flip()
    p <- p + scale_y_continuous(expand = c(0.00, 0.00))
    p <- p + scale_x_discrete(expand = c(0.00, 0.00), limit = input$states)#c("CA", "NY", "DC"))  
    p <- p + theme(axis.ticks = element_blank())
    p <- p + theme_bw()
    plot(p)
  })


  
})



