## HW 3
## Matt O'Brien

# load up the libraries
library(shiny)
library(ggplot2)
library(scales)
require(GGally)
library(reshape2)   
library(plyr)       
library(data.table)
data(state)
  
states <- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division)  
######################################################################
getBPlot <- function(states ,alpha_var,regions) {
  if(length(regions)<1){states<-states}
  else{states<-states[which(states$Region %in% regions),]}

# within the getBPlot, put together the ggplot  
p <- ggplot(states, aes(x = Population, y = Income, color = Region, size = Murder))
p <- p + geom_point(alpha = alpha_var, position = "jitter")
p <- p + scale_size_area(max_size = 10, guide = "none") + coord_fixed(ratio = 2)
p <- p + labs(size = "Area", x = "Population", y = "Income")  
#p <- p + scale_x_continuous(c(0, 20000))
#p <- p + scale_y_continuous(c(0, 6000))
### NOTE:  THIS NEXT LINE IS FOR KEEPING THE SIZE OF THE PLOT CONSTANT!!
p <- p + guides(colour = guide_legend(override.aes = list(size=12))) + ylim(3000,6500) + xlim(0,23000)
p <- p + annotate("text", x = 20000, y = 6500, hjust = 0.5, color = "black", label = "Size of bubbles corresponds with murders per 100,000 population")
p <- p + ggtitle("Bubbleplot")
##### after hours and hours of work I can't get the palette to work. 
#p <- p + scale_color_brewer(palette = palette_from_ui) 
p <- p + scale_colour_discrete(limits = levels(states$Region))
p <- p + theme(legend.direction = "vertical")
p <- p + theme(legend.title = element_blank())
p <- p + theme(legend.position = c(.9675, .15))
return(p)
}
################################################################################33
## note:  used this as a guide:  http://stackoverflow.com/questions/22945702/how-to-add-an-external-legend-to-ggpairs
getSPMatrix <- function(states ,alpha_var,regions) {
  if(length(regions)<1){ states <-states}
  else{states <-states[which(states$Region %in% regions),]}
  xx <- with(states, data.table(id=1:nrow(states), group=Region, states[,c(2,6,5,8, 4)]))
  yy <- melt(xx,id=1:2, variable.name="H", value.name="xval")
  setkey(yy,id,group)
  ww <- yy[,list(V=H,yval=xval),key="id,group"]
  zz <- yy[ww,allow.cartesian=T]
  
  zz <- zz[,list(id, group, xval, yval, min.x=min(xval),min.y=min(yval),
                 range.x=diff(range(xval)),range.y=diff(range(yval))),by="H,V"]
  setkey(zz,H,V,group)
  d  <- zz[H==V,list(x=density(xval)$x,
                     y=min.y+range.y*density(xval)$y/max(density(xval)$y)),
           by="H,V,group"]
  ggplot(zz)+
    geom_point(alpha = alpha_var,subset= .(xtfrm(H)<xtfrm(V)), 
               aes(x=xval, y=yval, color=factor(group)), 
               size=3)+
    geom_line(subset= .(H==V), data=d, aes(x=x, y=y, color=factor(group)))+
    facet_grid(V~H, scales="free")+
    scale_color_discrete(name="Region")+
    ggtitle("Scatterplot Matrix") +
    labs(x="", y="") + 
    theme(legend.background = element_blank()) +
    theme(legend.title = element_blank()) +
    theme(legend.key = element_blank()) +
    theme(panel.grid.minor.x=element_blank(),
          panel.grid.minor.y=element_blank()) +
    theme(legend.position = c(1, 1)) +
    theme(legend.justification = c(1, 1)) +
    theme(axis.ticks.x=element_blank()) + theme(axis.ticks.y=element_blank()) +
    scale_colour_discrete(limits = levels(states$Region))
}
############################################################################
getPP <- function(states, alpha_var,regions) {
  if(length(regions)<1){
    states<-states
  }
  else{
    states<-states[which(states$Region %in% regions),]
    states$Region<-factor(states$Region)
  }

  p <- ggparcoord(data = states,                   
                  # Which columns to use in the plot
                  columns = c(2,6,5,8),                   
                  # Which column to use for coloring data
                  groupColumn = 11,                   
                  # Allows order of vertical bars to be modified
                  order = "anyClass",                  
                  # Do not show points
                  showPoints = FALSE,                  
                  # Turn on alpha blending for dense plots
                  alphaLines = alpha_var,                  
                  # Turn off box shading range
                  shadeBox = NULL,                  
                  # Will normalize each column's values to [0, 1]
                  scale = "uniminmax")
  p <- p + theme_minimal()  
 # p <- p + coord_fixed(ratio = 0.2)
  p <- p + ggtitle("Parallelplot")
# Decrease amount of margin around x, y values
  p <- p + scale_y_continuous(expand = c(0.02, 0.02))
  p <- p + scale_x_discrete(expand = c(0.02, 0.02))  
  # Remove axis ticks and labels
  p <- p + theme(axis.ticks = element_blank())
  p <- p + theme(axis.title = element_blank())
  p <- p + theme(axis.text.y = element_blank())  
  # Clear axis lines
  p <- p + theme(panel.grid.minor = element_blank())
  p <- p + theme(panel.grid.major.y = element_blank())  
  # Darken vertical lines
  p <- p + theme(panel.grid.major.x = element_line(color = "#bbbbbb"))  
  # Move label to bottom
  p <- p + theme(legend.position = "bottom") 
  # Figure out y-axis range after GGally scales the data
  min_y <- min(p$data$value)
  max_y <- max(p$data$value)
  pad_y <- (max_y - min_y) * 0.1  
  # Calculate label positions for each veritcal bar
  lab_x <- rep(colnames(states)[2:5], times = 2) # 2 times, 1 for min 1 for max
  lab_y <- rep(c(min_y - pad_y, max_y + pad_y), each = 4)  
  # Get min and max values from original dataset
  lab_z <- c(sapply(states[, 2:5], min), sapply(states[, 2:5], max))  
  # Convert to character for use as labels
  lab_z <- as.character(lab_z)  
  # Add labels to plot
  p <- p + annotate("text", x = lab_x, y = lab_y, label = lab_z, size = 3)
  p <- p + scale_colour_discrete(limits = levels(states$Region))
}

# shiny server goes here:
shinyServer(function(input, output) {
 
  output$bubbleplot <- renderPlot({
    p<-getBPlot(states,input$alpha_var,input$regions)
    print(p)    
  })
  output$scatterplotmatrix <- renderPlot({
    p<-getSPMatrix(states,input$alpha_var,input$regions)
    print(p)    
  })
  output$parallelplot <- renderPlot({
    p<-getPP(states,input$alpha_var,input$regions)
    print(p)    
  })
})