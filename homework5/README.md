#Homework #5: Time Series
==============================

####Matt O'Brien  
####mobrien4@dons.usfca.edu |
--------------------

 
##Plot #1: Stacked Area Plot


![](https://github.com/mobbSF/msan622/blob/master/homework5/001.png?raw=true)

The idea behind this plot was to consider only the deaths to passengers in the front seat and death to passengers in the back seat.  

With that choice made, next, the values were normalized between 0 and 1, which is a proportion out of the total deaths in the 2 categories.  

One thing to consider right away was fact that it would be easy to mistake the reddish hue for a background as opposed to a color representing a variable.  These are classic "old school 3D glasses" type colors, designed to give a visual pop.  However, I decided to keep the colors anyway, since I appreciate the extreme contrast.  

An issue with these kinds of normalized plots, is that you lose sight of the global trend.  With this in mind, I decided to use a lowess (locally-weighted polynomial regression fitting) curve to include this information:  
`lowess <- lowess(plotme$time, plotme$trend)`  

I liked this idea because I didn't lose as much information when applying the proportional scaling.  

Other modifications I made included cleaning up the 
legend.
In retrospect, I should have modified the labelling on the x-axis to be integer valued, instead of including those unnecessary decimals. 
--------------------
##Plot #2: Heatmap

![](https://github.com/mobbSF/msan622/blob/master/homework5/002.png?raw=true)


































I found out that I could plot two different plots using  
`library(gridExtra)`  and  
`grid.arrange(p,q, ncol=2)`,  
where `p` and `q` are both heatmaps.  

I chose this technique to give an instant impression on how much safer it is to be sitting in the back seat as opposed to the front seat, when accidents occur. You can see the strong contrast.   

I chose a red color to give that bloody feeling.  I kept both legends to avoid the reader having to look back and forth and save the eyestrain.  I also made sure to make them vertical to better show an increasing scale -- I didn't feel like this was made apparent with a horizontal legend.  

----
















##Plot #3: Circle View


![](https://github.com/mobbSF/msan622/blob/master/homework5/004.png?raw=true)

For this plot, I looked only at the front seat deaths.  Any more than that, I feel I would need to use a different technique.  Further, I decided to look only at the 1970's, since it was the only full decade of data available, and as more data is thrown in, it gets dense.  

Even by reducing the data in this manner, the plot is still busy and hard to read.  I maxed out the capacity of the `color_brewer` palette.  The lines overlap and sometimes the white grid background decides to produce an optical illusion and almost turns yellow (like 1975).  

I can't claim this graph, and by extension, perhaps this technique, is very flexible.  I like the geometric nature of showing abberence from a circle and in theory it's a great idea.  I suppose I'm not quite sold on this plot...




----

##Plot #4: Circle View Heatmap


![](https://github.com/mobbSF/msan622/blob/master/homework5/003.png?raw=true)






















This plot, I created as a bit of an experiment after I had finished the other 3.   I decided to see if I could combine the heatmap and the circular time series plot.  

In this plot we have years represented as concentric circles, away from the center, which is the earliest year (1969).  

The data is over the back-seat deaths.  

Obviously there are still some issues with this plot, most notably whatever object is analogous to the y-axis, which is basically illegible.
Regardless I appreciate the artistic convergence of circle and color...but be aware, the pie-shaped wedges give a false impression of volume, contributing to an increase in the Lie Factor. 
----------
