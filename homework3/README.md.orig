Homework 3: Multivariate Plots in shiny
==============================

Matt O'Brien 
| mobrien4@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

    library(shiny)
    library(ggplot2)
    library(scales)
    require(GGally)
    library(reshape2)   
    library(plyr)       
    library(data.table)



To run this code, please enter the following commands in R:

    library(shiny)  
    shiny::runGitHub("msan622", "mobbSF", subdir = "homework3")

This will start the shiny app. See below for details on how to interact with the visualization.

## Discussion ##  
This assignment involved 3 plots.  The plots all feature filtering.  

The following discussion describes my experience with this process.  Although this experience was had many frustrating moments, I learned a lot.

Note:  Markdown has no syntax for specifying the dimensions of an image, and I'm new to GIMP after having recently made the jump from Windows to Linux.  Please forgive the small size of the images.

* Bubbleplot  

The idea for any bubbleplot is to show 3 variables over a 2-D axis.  I chose to show population and income, with murder rate per 100,000 represented by the size of the bubbles.  The filtering is done on the geographic region of the USA.  
I initially chose brushing as the technique to exhibit; however, after creating the bubbleplot, I couldn't extend the technique to the other two plots, so I started over the assignment from the begging, with filtering instead.  My issue was that I implemented brushing by creating 2 dataframes:  one to be plotted with "normal" colors, and another to be overlaid on the next layer, in grey.  To try to create a scatterplot matrix or a parallel plot from two different dataframes given the way those plots need to be created in ggplot2 was impossible for me.

Thus, I chose filtering as a method because it was the only method I could implement given the time constraints.  Filtering is easier in general -- it all boils down to subsetting, and that's it.
  
I chose these columns from the dataset, because I feel they tell an interesting story.   

Additional customization included some graphics and a slider for the alpha level.

![Alt text](https://github.com/mobbSF/msan622/blob/master/homework3/DV_01.png?raw=true)

----------

*  Scatterplot Matrix  

I chose to create the scatterplot matrix because it seemed like a natural way to view the data in the states data set.  This plot was very difficult to create.  I had many problems; everything from rendering in the browser, UI communication, and especially, difficulties with scaling.  

My experience is that there are so many moving parts when it comes to shiny, browers, and ggplotting, that it can be very difficult to determine which component of this process are responsible for showing (or not showing) what you intended for the plot.  With shiny, there is less 'modularity':  lots of elements interact together, and are hard to tease apart.  This makes debugging incredibly slow.  
Another madding problem was my inability to use different palettes.  I struggled with this for hours before finally giving in and removing the component from the graph.  

![Alt text](https://github.com/mobbSF/msan622/blob/master/homework3/DV_02.png?raw=true)

----------
* Parallel Plot    

I don't have much experience with parallel plots, but I feel like they are useful, and was excited to code one up.  I chose Area, High School Graduation, Illiteracy, Income, Life Expectancy, and Murder as variables.  This plot came out fairly well and is mostly self explanatory.  

![Alt text](https://github.com/mobbSF/msan622/blob/master/homework3/DV_03.png?raw=true)

---

To summarize, I would classify these last 2 assignments as among the Top 10 most difficult assignments in the MSAN program for me, given the volume of output (3 plots), time spent making sure GitHub is cooperating, learning ggplot2, learning Shiny and various other things that go along with the process.  In the ruckus, I forgot to upload screen shots, so this submission is now late as well.

I am a little disappointed that I was unable to spend more time interpreting the plots and considering the data I had at my disposal.  Almost all of my time was spent battling coding problems.  I must say I like ggplot2, I like R, and I like data visualization.  I look forward to connecting these 3 things together with less difficulty in the future.

