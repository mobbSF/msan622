Project: Sketch
==============================

Matt O'Brien  
mobrien4@dons.usfca.edu

## Discussion ##

####Planned Tools

I am planning on using `R` and `ggplot2` with `shiny` for this project.

####Planned Techniques

I decided to use a histogram, a ggmap, a scatterplot matrix and a parallel plot.  You can see all the images on the napkin sketch at the bottom of the page.

*Histogram*  
This plot is great for showing the distribution of jobs across occupation.  Instead of region, I will plot across consumer markets, which is a geographic partitioning created by the Neilson Ratings company.  This makes it clear which jobs in higher demand in certain areas.  The user can select by CMR and industry.

*Map*  
As long as the 1000 per day queries to google maps isn't violated, this should work fine.  Although there have been warnings regarding using ggmaps, I want to try it anyway.
This is really be a bubbleplot, layered over a static map. Size of bubbles will correspond with salary.

*Scatterplot Matrix*  
Since my data set is primarily categorical, I will engineer some variables so that I can have the necessary numeric values to create a scatterplot matrix.  "Importance" is the measure of how difficult a job is to get (ie, entry level, CEO, and things inbetween).  "Number of Jobs" I have as well as "Pay" and hopefully I will come up with a few more as I get more comfortable with the fields in the database.

*Parallell Plot*  
I will use the same variables as the scatterplot matrix, but I will use the State information as a subsetting method.  The parallel plot will be manipulable by sorting as well (not shown in my terrible artwork).  This way we can see the same data in different configurations.

Here's the images:

![plots](https://github.com/mobbSF/msan622/blob/master/project-sketch/plots.jpg?raw=true)