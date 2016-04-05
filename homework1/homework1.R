install.packages("RColorBrewer")
library(RColorBrewer)
library(ggplot2)
library(reshape2)
data(movies)
data(EuStockMarkets)
# If you want to see which palettes you can use, uncomment this next line
#display.brewer.all(5)
#Plot 1: Scatterplot.
#Produce a scatterplot from the movies dataset in the ggplot2 package, where budget is shown on the x-axis and rating is shown on the y-axis.
#Save the plot as hw1-scatter.png.
# step 1: create the movies dataframe
movies <- movies[which(movies$budget>=1),]
movies$budget <- movies$budget / 1000000
movies <- movies[order(movies$budget),]
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies["genre"] <- genre
#################
# Plot #1: Scatterplot
p <- ggplot(movies, aes(x=budget, y=rating))
p <- p + geom_point(shape=1, aes(colour = genre))
p <- p +   labs(x="Buget (in millions)", y="Rating")
p <- p + ggtitle("Scatterplot of ratings VS Budget, by Genre")
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + scale_colour_brewer(palette="Set1", name = "Genre")  #<---this is a 'qualitiative palette'
p <- p + theme(legend.background = element_rect(fill="gray90", size=.5))
p
ggsave(file="hw1-scatter.png")
################
# Plot 2: Bar Chart. Count the number of action, adventure, etc. movies in the genre column of the movies dataset.
# Show the results as a bar chart, and save the chart as hw1-bar.png.
p <- ggplot(movies, aes(x=genre))
p <- p + geom_bar(aes(fill=movies$genre))
p <- p + scale_fill_brewer(palette="PiYG", name="Genre")  #  <-- 'diverging palette' looks best
p <- p + labs(x="Genre", y="Count", name="Genre")
p <- p + ggtitle("Bar Chart of Count vs Genre")
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + theme(legend.background = element_rect(fill="gray90", size=.5))
p
ggsave(file = "hw1-bar.png")
################
# Plot 3: Small Multiples
# Use the genre column in the movies dataset to generate a small-multiples scatterplot using the facet_wrap() function such that budget is shown on the x-axis and rating is shown on the y-axis.
# Save the plot as hw1-multiples.png.
p <- ggplot(movies, aes(x=budget, y=rating))
p <- p + geom_point(shape=1, aes(colour = genre))
p <- p + labs(x="Buget (in millions)", y="Rating")
p <- p + ggtitle("Scatterplot of Ratings VS Budget, by Genre")
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + scale_colour_brewer(palette="Set1", name= "Genre")  #<---this is a 'qualitiative palette', definitely the best
#  scale_colour_brewer(palette="PiYG")  #<---this is a 'diverging palette'
#  scale_colour_brewer(palette="Blues") #<-- this is a 'sequential palette'
p <- p + facet_wrap(~ genre)#(aes(fill=movies$genre))
p
ggsave(file = "hw1-multiples.png")
###############
# Plot 4: Multi-Line Chart.
# Produce a multi-line chart from the eu dataset (created by transforming the EuStockMarkets dataset) with time shown on the x-axis and price on the y-axis.
# Draw one line for each index on the same chart.
# You will need to perform some additional transformations of the dataset before being able to generate this chart. See the multi-line plot code from class for an example.
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))
eu_no_time <- eu[c(1:4)]
eu2 <- melt(eu_no_time)
eu2["Year"] <- rep(eu$time, 4)
names(eu2)[2] <- "Price"
# Multi-Line
p <-  ggplot(eu2, aes(x=Year, y=Price, colour=variable))
p <-  p + geom_line()
p <-  p + ggtitle("Daily Closing Prices of Major European Stock Indices, 1991-1998")
p <-  p + scale_colour_brewer(palette="Set1", name="Major European\nStock Indices")  #<---this is a 'qualitiative palette', definitely the best
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + theme(legend.background = element_rect(fill="gray90", size=.5))
p
ggsave(file = "hw1-multiline.png")
getpath
getpath()
getwd
getwd90
getwd90()
getwd()
#install.packages("RColorBrewer")
library(RColorBrewer)
library(ggplot2)
library(reshape2)
data(movies)
data(EuStockMarkets)
# If you want to see which palettes you can use, uncomment this next line
#display.brewer.all(5)
#Plot 1: Scatterplot.
#Produce a scatterplot from the movies dataset in the ggplot2 package, where budget is shown on the x-axis and rating is shown on the y-axis.
#Save the plot as hw1-scatter.png.
# step 1: create the movies dataframe
movies <- movies[which(movies$budget>=1),]
movies$budget <- movies$budget / 1000000
movies <- movies[order(movies$budget),]
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies["genre"] <- genre
#################
# Plot #1: Scatterplot
p <- ggplot(movies, aes(x=budget, y=rating))
p <- p + geom_point(shape=1, aes(colour = genre))
p <- p +   labs(x="Budget (in millions)", y="Rating")
p <- p + ggtitle("Scatterplot of ratings VS Budget, by Genre")
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + scale_colour_brewer(palette="Set1", name = "Genre")  #<---this is a 'qualitiative palette'
p <- p + theme(legend.background = element_rect(fill="gray90", size=.5))
p
ggsave(file="hw1-scatter.png")
################
# Plot 2: Bar Chart. Count the number of action, adventure, etc. movies in the genre column of the movies dataset.
# Show the results as a bar chart, and save the chart as hw1-bar.png.
p <- ggplot(movies, aes(x=genre))
p <- p + geom_bar(aes(fill=movies$genre))
p <- p + scale_fill_brewer(palette="PiYG", name="Genre")  #  <-- 'diverging palette' looks best
p <- p + labs(x="Genre", y="Count", name="Genre")
p <- p + ggtitle("Bar Chart of Count vs Genre")
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + theme(legend.background = element_rect(fill="gray90", size=.5))
p
ggsave(file = "hw1-bar.png")
################
# Plot 3: Small Multiples
# Use the genre column in the movies dataset to generate a small-multiples scatterplot using the facet_wrap() function such that budget is shown on the x-axis and rating is shown on the y-axis.
# Save the plot as hw1-multiples.png.
p <- ggplot(movies, aes(x=budget, y=rating))
p <- p + geom_point(shape=1, aes(colour = genre))
p <- p + labs(x="Buget (in millions)", y="Rating")
p <- p + ggtitle("Scatterplot of Ratings VS Budget, by Genre")
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + scale_colour_brewer(palette="Set1", name= "Genre")  #<---this is a 'qualitiative palette', definitely the best
#  scale_colour_brewer(palette="PiYG")  #<---this is a 'diverging palette'
#  scale_colour_brewer(palette="Blues") #<-- this is a 'sequential palette'
p <- p + facet_wrap(~ genre)#(aes(fill=movies$genre))
p
ggsave(file = "hw1-multiples.png")
###############
# Plot 4: Multi-Line Chart.
# Produce a multi-line chart from the eu dataset (created by transforming the EuStockMarkets dataset) with time shown on the x-axis and price on the y-axis.
# Draw one line for each index on the same chart.
# You will need to perform some additional transformations of the dataset before being able to generate this chart. See the multi-line plot code from class for an example.
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))
eu_no_time <- eu[c(1:4)]
eu2 <- melt(eu_no_time)
eu2["Year"] <- rep(eu$time, 4)
names(eu2)[2] <- "Price"
# Multi-Line
p <-  ggplot(eu2, aes(x=Year, y=Price, colour=variable))
p <-  p + geom_line()
p <-  p + ggtitle("Daily Closing Prices of Major European Stock Indices, 1991-1998")
p <-  p + scale_colour_brewer(palette="Set1", name="Major European\nStock Indices")  #<---this is a 'qualitiative palette', definitely the best
p <- p + theme(plot.title = element_text(lineheight=.8, face="bold"))
p <- p + theme(legend.background = element_rect(fill="gray90", size=.5))
p
ggsave(file = "hw1-multiline.png")
