Homework 3: Multivariate Plots in shiny
==============================

Matt O'Brien |
|----------:|
:-------------|
| mobrien4@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

    ggplot2
    shiny

To run this code, please enter the following commands in R:

library(shiny)
shiny::runGitHub("msan622", "mobbSF", subdir = "homework3")

This will start the shiny app. See below for details on how to interact with the visualization.

## Discussion ##  
This assignment involved 3 plots.  The plots all feature filtering.  
The following discussion describes my experience with this process.  Although this experience was incredibly frustrating and heartbreaking, I learned a lot.  Most of the discussion that follows will center around what I spent most of the time doing -- desperately attempting to debug my code, and confronting an onslaught of errors.

* Bubbleplot  

The idea for the bubbleplot is to show 3 variables in a 2-D axis.  I chose to show population and income, with murder rate per 100,000 represented by the size of the bubbles.  The filtering is done on the geographic region of the USA.  
I initally chose brushing as the technique to exhibit; however, after creating the bubbleplot, I couldn't make the technique work for the other two plots, so I started over the assignment from the begging, with filtering instead.  Thus I chose filtering because it was the only method I could implement given the time constraints.  
I chose the columns because I feel they tell an interesting story.  
Unfortunately, additional custiomization is at a minimum.  A slider for the alpha level was the only other feature I had time to implement.

*  Scatterplot Matrix  

I implemented the scatterplot matrix because it seemed like a natural way to view the data in the states data set.  This plot was very difficult to create.  I had many problems; everything from rendering in the browser, UI communication, and especially, difficulties with scaling.  There are so many moving parts when it comes to shiny, browers, and ggplotting, that it was difficult to determine which component of this process was responsible for showing (or not showing) what I intended for the plot.  I feel like this process is difficult, because there is less 'modularity':  lots of elements interact together, and are hard to tease apart.  This makes debugging incredibly slow.  
Another maddinging problem was my inability to use different palettes.  I struggled with this for hours before finally giving in and removing the component from the graph.  

* Parallel Plot    

I don't have much experience with parallel plots, but I feel like they are useful, and was excited to code one up.  I chose Area, High School Graduation, Illiteracy, Income, Life Expectancy, and Murder as varaibles.  This plot came out fairly well.  

To summarize, I am a little disappointed that I was unable to spend more time interpreting the plots and considering the data I had at my disposal.  Almost all of my time was spent coding.  I must say I like ggplot2, I like R, and I like data visualization.  I look forward to connenting these 3 things together with less difficulty in the future.
