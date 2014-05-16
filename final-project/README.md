Final Project
==============================

Matt O'Brien  
mobrien4@dons.usfca.edu
------
# THE PROJECT:  
Using data from a popular job search website, I gathered a set of 2036 jobs for positions open for individuals proficient in data science. 

The fields in the data consisted of job description, company name, salary, city, state and zipcode.  


The motivation for this project is to visualize where data science jobs are in the United States as well as how much they pay.  

The libraries needed in order to run this shiny app are  

    library(shiny)
    library(zipcode)
    library(mapproj)
    library(choroplethr)
    library(ggplot2)
    library(sp)
    library(maps)
    library(maptools)
    library(randomForest)
    gpclibPermit()

----

# VISUALIZATION #1: COUNTRY MAP  

The first visualization is of a map of the continental United States.  The idea here was to obtain a broad overview of which areas in which states have the most jobs.

###1)  TYPE OF INTERACTIVITY:  

You can interact with this map in a number of ways:  

*  Select which states you want to see and don't want to see
*  Use a slider to narrow the results down to jobs that pay within a specific salary range
*  You can manage overplotting by adjusting the alpha value
*  You can mange overplotting by introducing jitter to the points

###2)  HOW THE DATA WAS ENCODED:  

The data began as zipcode information.  Using the `library(zipcode)` package, the zipcode data was transformed into longitude and latitude coordinates.  

###3)  WHAT I LEARNED ABOUT THE DATA:  
The data showed me that most of the jobs reside in the Bay Area of California.  There aren't many jobs in the Midwest or South, and there are a good amount of jobs in Washington and Texas.  

###4)  PROTOTYPE FEEDBACK:  

The prototype feedback for this graph was helpful.  Originally I was using red dots (it looked like the map had chicken pox).  I changed to circles and changed the color to green.  I also added state initials, even though it required me to post a question on StackOverflow which you can view [here](http://stackoverflow.com/questions/23447760/include-borders-and-state-abbreviations-when-using-the-map-function-with-the-map).

###5)  DATA VIS METRICS:  

This map has good data density and data-to-ink ratio.  The lie factor is increased when the jitter is used, considerably.  Sometimes, some points in Washington jump into Canada.

###6)  HOW THE INTERACTIVITY ENHANCED THE VISUALIZATION:  

The interactivity enhances the visualization in the sense that it makes the locations visible and simple to view.  

###7)  SUCCESSES:  
Successes here included getting the map to actually work in the first place.  I used the `map` function in the `mapproj` library which is somewhat difficult to work with. 

I also am happy all four methods of interaction.  Here is a screenshot of the visualization with and without jitter:  

![](https://github.com/mobbSF/msan622/blob/master/final-project/001.png?raw=true)


###8)  CHALLENGES:  

One problem is the inability to adjust all states.  I chose a checkbox for the States, and as much as I wanted to, I wasn't able include all 48 states due, simply, to lack of space.  A better control would have allowed me to subset on certain important States.  To me, this is a major, major flaw in my visualization.  The question remains, how can a user intuitively and easily select any combination of 48 states when there is limited space on the graphic?  My solution is to remove control from the user, which is not ideal.
 
----

# VISUALIZATION #2:  CLOROPLETH  

This map is a cloropleth, which is somewhat of a combination of a heatmap and geographic map.  

![](https://github.com/mobbSF/msan622/blob/master/final-project/002.png?raw=true)



###1)  TYPE OF INTERACTIVITY:  

When you think of a cloropleth, or even a heatmap in general, trying to incorporate interactivity can be a difficult task.  After all, a heatmap pretty much shows everything...perhaps the granularity of binning can be adjusted, but what else?  

I chose to approach this in a way that made sense to me.  The way this map works, is the view all of the states together to see how they relate to each other.  Now, we slow remove states, one by one, and each time, watch the choropleth regenerate, and rescale itself to show how the remaining states are distributed.  So, if you didn't want to live in CA, you could remove it, and see a "new" heatmap, based on the remaining parts of the country.  

###2)  HOW THE DATA WAS ENCODED:  

Here, the colors are mapped to the total sum of all salaries.  For example, there is about 5 million dollars worth of salary to be earned in California, which makes the color dark green.

###3)  WHAT I LEARNED ABOUT THE DATA:  

This plot is really another attempt to see how many jobs in each state exist.  The first visualization, naturally suffers from intense overplotting.  The choropleth generalizes the jobs to fit within a state, not just a tiny point surrounded by a hollow circle.  In retrospect, this plot is a little more general in nature than plot 1, and maybe I should have switched the order of these plots to guarantee that the plots are in general --> specific order. 

###4)  PROTOTYPE FEEDBACK:  

During the prototype session, it was advised that I add dollar signs on the legend and pick green colors.  I did both of these things.  


###5)  DATA VIS METRICS:  

This map has good data vis metrics.

###6)  HOW THE INTERACTIVITY ENHANCED THE VISUALIZATION:  

I like the creative way to burrow deep into specific combinations of jobs, depending on which states you choose to exclude.  Once you get used to this idea, it makes a lot of sense.

###7)  SUCCESSES:  

Technically speaking, the fact that this map came into existence is a success.  I had to use the `choroplethr` package, which is so different than the first plot.  Making the two of them match was difficult.  Even matching the colors (which is still imperfect) was a major challenge and required me to get creative and spend hours of my time.  

That being said, I am pretty satisfied with the final outcome.

###8)  CHALLENGES:  

Using breaks, adjusting the legend, and adapting the dataframe were all difficult in this plot.  There actually wasn't anything that wasn't a challenge in this plot.

----

# VISUALIZATION #3: SINGLE STATE BUBBLEPLOT    

Visualization 3 moves us into looking at single states, where we can see more clearly exactly where the jobs reside.  Here is an example of just one of the states you can zoom in on, Washington:  

![](https://github.com/mobbSF/msan622/blob/master/final-project/003.png?raw=true)

###1)  TYPE OF INTERACTIVITY:  

Here, we have:  

* Selecting the particular state in a dropdown menu
* Adjusting salary as in the first map
* Adjusting alpha 
* Adding jitter 

###2)  HOW THE DATA WAS ENCODED:  

The data was encoded in the same way as the first plot, just further subsetted by state, and more importantly, salary was mapped to the size of the circular point.

###3)  WHAT I LEARNED ABOUT THE DATA:  

This visualization is nice, since now we get a better feel for which specific areas these jobs are in.  As the visualizations go, they attempt to get more and granular in nature, and this plot makes a big jump in that direction.  Also, it is really important to realize this is a bubbleplot, and now we can see the salary related to specific jobs, which was prior not easy to see on such an individualized basis.

###4)  PROTOTYPE FEEDBACK:  

The group said that since the states are just simple polygons, they aren't very exciting.  I couldn't agree more.  I added some fill as color (grey90) which helped.  But to be honest, after hours of struggle, I couldn't improve the aesthetics at all on this map.  It came down to a choice -- either start over completely on the whole thing and use 'ggmap' or not. Here, we just have `geom_map` used with a regular ggplot.

###5)  DATA VIS METRICS:  

This plot, due to the lack of color and texture, clearly has a fantastic data to ink ratio. The lie factor is fine and the data density is good too.  In retrospect, I could have removed the jitter option, which would have kept the lie factor down.  I am not convinced that jitter is useful at this level anyways.  It could easily move a job from one city to another.

###6)  HOW THE INTERACTIVITY ENHANCED THE VISUALIZATION:  

The alpha is always necessary, I'm learning, except for sparse states like Kansas where there aren't any overlapping jobs.  The ability to zoom in by selecting a particular state is crucial.  Jitter, as mentioned prior, isn't exceptionally important.  

###7)  SUCCESSES:  

I think the plot is a success in the way that it generates single states, which is a somewhat unorthodox way to create a plot.  I like the dropdown menu and I am glad that finally, after hours of struggle, I was able to make all the plots resize to fill up the space, even though I finally had to post another StackOverflow question [here](http://stackoverflow.com/questions/23449033/how-to-resize-a-state-when-using-the-map-function-in-the-mapproj-library-in-r).

###8)  CHALLENGES:  

Again, technical challenge abounded. I originally wanted to find some way to 'grey out' the controls that aren't being used in this plot, since it's hard to even find the dropdown menu way at the bottom.  But I couldn't figure it out.  Of course, I'm a bit frustrated that there was no way to make the geom_map look better than this.  I had visions of lush geographic terrain and sweet satellite views, but that was a pipe dream.  I would have had to start from scratch, which I had already done numerous times up to that point anyway. 



# VISUALIZATION #4: BAR PLOT


###1)  TYPE OF INTERACTIVITY:  

This chart can be sorted as seen below:  


![](https://github.com/mobbSF/msan622/blob/master/final-project/004.png?raw=true)


###2)  HOW THE DATA WAS ENCODED:  

The data was summed and encoded as scalars with which to plot the number of jobs in each state.


###3)  WHAT I LEARNED ABOUT THE DATA:  

Strangely enough, a simple bar chart might be the most interesting plot of all 4.  Why? Because, finally, we get a numeric representation of the distribution of jobs out there.  Up until now, we've had to rely on color, shape, and space to do so.  Now, we finally hit the nail on the head and with this bar chart, we can see exactly what the job market looked like at this given time, across the country.



###4)  PROTOTYPE FEEDBACK:  

I didn't get any feedback on this one, since it wasn't done when we had prototype review.


###5)  DATA VIS METRICS:  

This plot is clean and doesn't have any excessive values for any of the 3 factors.


###6)  HOW THE INTERACTIVITY ENHANCED THE VISUALIZATION:  

Of course ordering in a bar chart is always a good idea when it comes to interactivity (or at least I suspect this is true).  It only takes a glance to see the relationship between the states and how they come together.



###7)  SUCCESSES:  

I was glad that I was able to remove that annoying area between the x and y axis, remove the tickmarks as I wanted, and otherwise to the customary cleanup on ggplot that we've practiced up to now.


###8)  CHALLENGES:  

This plot was difficult since I had trouble having the interactivity for state selection work with the subsetting.  But eventually, it all came together.  It was unfortunate to miss the graduation dinner, but that's how it goes.

----
##SUMMARY:  

There is no end to how much work you can put into a good visualization -- I never truly had enough appreciation as to how difficult a good vis really is to construct.  For example, was it worth the hours it took to figure out how to give this custom error message?  


![](https://github.com/mobbSF/msan622/blob/master/final-project/005.gif?raw=true)  

Who knows.  But, I also now have more appreciation for why lots of visualizations are hard to read.  This is a large and deep field.
 






















