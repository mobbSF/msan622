Homework 2: Interactivity
==============================

| **Name**  | [Matt O'Brien]  |
|----------:|:-------------|
| **Email** | [mobrien4@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `shiny`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub("msan622", "mobbSF", subdir = "homework2")
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Screenshot ##

![screenshot](https://github.com/mobbSF/msan622/blob/master/homework2/myshinyapp.png?raw=true "myshinyapp")

This app was developed as a learning tool for understanding shiny.  The controls are mostly self explanatory.

### Development###

I made some tweaks to the basic template:
 
* I fixed the x and y axis for the ggplot to a static value. I did this so that when the dataframe is subsetted as a result of a user's customization, the dimensions of the plot remain changed.

* I set the dot size differently than was recommended in the assignment.  I think a larger lower threshold is more visible.

* To personalize the pages, I added a photo, a brief "About Me" and some text describing the purpose of the app.

*  I made the README.md file more accessible by creating a tab for it.

Things I would have done differently if I had more time:

* I was determined to create a slider for budget, but I couldn't get it to work in time, so I ended up without it.

## Final Comments##
I spent quite a bit more time battling with the code than I had expected.  Overall, I had a good experience and look forward to using Shiny again soon.
