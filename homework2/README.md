Homework 1: Basic Charts
==============================

| **Matt O'Brien**  | | **mobrien4@dons.usfca.edu** |

## Instructions ##

I used the packages `ggplot2` along with 	`RColorBrewer` for visualization, and the  `reshape2` package for melting dataframes.

To run this code, please enter the following commands in R:

    library(devtools)
    source_url("https://github.com/mobbSF/msan622/homework1/homework1.r")


## Discussion ##

The purpose of the first plot is to:
> Produce a scatterplot from the movies dataset in the ggplot2 package, where budget is shown on the x-axis and rating is shown on the y-axis.

Here is the scatterplot I developed:

![scatterplot](https://github.com/mobbSF/msan622/blob/master/homework1/hw1-scatter.png?raw=true)

A few interesting things:

* I experimented with the 3 different possible palettes available to me in the `RColorBrewer` package.  I found that the qualitative palette was the most appropriate, because of the heavy amount of overlapping circles.  The other color schemes, because of the overlapping, seemed to create new colors when combined.  This still, however, leaves a bit to be desired.
* I bolded the title.
* I put a background around the Legend.
* Another change I made was converting the Budget into millions.  Much more readable.

----------
The purpose of the second plot is to:
> Count the number of action, adventure, etc. movies in the genre column of the movies dataset. Show the results as a bar chart.

Here is the bar chart I developed:

![scatterplot](https://github.com/mobbSF/msan622/blob/master/homework1/hw1-bar.png?raw=true)


A few interesting things:

* In retrospect, the diverging palette might not have been the best choice.  It is not the most readable. Since the diverging palette shows extremes at both ends of the data range, I realize now that the 3 bars in the center are all very similar in color, decreasing readability. 
* Again, I bolded the title.
* I was considering removing the legend: not sure if it isn't redundant.  In the end I decided to keep it, since I don't think it causes any real harm.

----------
The purpose of the third plot is to:

>Use the genre column in the movies dataset to generate a small-multiples scatterplot using the facet_wrap() function such that budget is shown on the x-axis and rating is shown on the y-axis.

Here is the bar chart I developed:

![scatterplot](https://github.com/mobbSF/msan622/blob/master/homework1/hw1-multiples.png?raw=true)


A few interesting things:

* A qualitative palette worked best, since we are dealing with categorical variables.
* I kept the bolding of the title, however I skipped the embellishments of the legend.  Not sure if it makes much of a difference either way.
* Again, Budget is in millions

----------
The purpose of the fourth plot is to:

>Produce a multi-line chart from the EU dataset...with time shown on the x-axis and price on the y-axis. Draw one line for each index on the same chart.

Here is the bar chart I developed:

![scatterplot](https://github.com/mobbSF/msan622/blob/master/homework1/hw1-multiline.png?raw=true)

A few interesting things:

* Again, qualitative palette is the best.
* Again, title was bolded; legend was augmented
* I looked at the documentation for the `R` dataset for these timeseries, however, I could not find which denomination (currency) they are in.  It could be one of four different denominations, possibly, maybe all four countries are in the EU by then.  Regardless, I claim the raw data set is missing information.







----------
