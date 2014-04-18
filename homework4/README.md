Homework #4: Text Visualization
==============================




Matt O'Brien   
mobrien4@dons.usfca.edu
---------------------------------------
## DATASET

I used a subset of the data collected from the Epinions.com Web site, which can be found here: [http://www.trustlet.org/wiki/Downloaded_Epinions_dataset](http://www.trustlet.org/wiki/Downloaded_Epinions_dataset) .

The data consists of text ratings for a categories of products, including books, cars, cookware, hotels, phones, movies, and music.  For this project, I used only the music reviews.

The music reviews came labeled, as having positive or negative sentiment.

---------------------------------------

###PLOT 1

The plot for this homework was produced with R using `ggplot2`, using the `geom_text` in ggplot2.  I hadn’t used this layer previously and found a few things I liked and disliked about it.

First, some background:

I read the music reviews into R, and  using the `TM` package, did some cursory cleaning, then created a TFIDF matrix.  

After removing sparse terms, I sorted to find the most important terms.  Next I applied the classes (Positive Reviews or Negative Reviews) as axes and plotted the location of the words by the sum of TFIDF scores.  The visualization is below.

![image one](https://github.com/mobbSF/msan622/blob/master/homework4/P1.png?raw=true)


####EVALUATION:

Here you can see that if a word lies pretty close to the diagonal, then that word is fairly common in both classes.  However, some words like “lyric” appear more relevant to the Negative Reviews since they scored higher with this class as compared to this score in the Positive Reviews.  More generally, if a word is above the diagonal, it is more important in the negative reviews as opposed to the positive reviews.  The converse is true for the more positive terms.

Maybe people who dislike certain music are more put-off by the lyrics, whereas people who like certain music are more fond of the beats.  


* The Lie Factor of this plot is pretty close to 1 -- the graphic is flat, in 2D, and the sizes of the words are all comproble.   
* The Data-Ink Ratio in this plot is got closer to 1 once I removed excess ink by including `opts(panel.background = theme_blank())`.  This removed the ink used for the background.  I also removed minor panel grids.  
*The data density of this plot is acceptable.

#####Issues:
I used `position_jitter` which was absolutely essential for making the plot readable by removing overlap, but it did move the words a bit, thus introducing bias into the plot.

It appears unanimous across the entire MSAN cohort -- the stopwords in the `tm` package are terrible!  I eventually had to append a list manually, just to help cut down on the most egregious of the banal terms.  It helped a little but would take a lot more effort to truly clean up the corpus.

---------------------------------------

###PLOT 2

To create the next plot, I proceeded with the same data, and converted my TFIDF matrix into a dissimilarity matrix and calculated the cosine similarity of all documents to the corpus.  From this matrix I created a dendrogram which describe a hierarchical clustering of these distances.  The goal was to see if the documents create any major groups or clusters, and see if the clusters organically represent the classes we already have.  The holy grail in text mining and clustering is to see if the Pos documents form a cluster and the Neg documents form a cluster.

To view, this image really needs to be expanded into it’s full size, since it shows 50 reviews (the entirety of the corpus).


![Image 2](https://github.com/mobbSF/msan622/blob/master/homework4/P2.png?raw=true)

####EVALUATION:

* The Lie Factor of this plot does not indicate problems due to the nature of hierarchical clustering, which uses euclidian distance which is represented in the y-axis -- everything is linear and no impacts are exaggerated due to perspective or resizing.
* The Data-Ink Ratio appears to be favorable, due to the way in which the Height measurement uses distance, represented by the ink it takes to create the vertical lines.
* The data density of this plot is not as ideal, due to the number of observations plotted.  There requires a lot of ink to plot.

#####Issues:

There were quite a few issues with this plot.  To be honest, the more I work with it and examine it, the less I like it.  

First of all, it is hard to determine the correct number of clusters.  It’s nearly impossible to confidently draw a horizontal line across the base of the graph (look around the 0.9 mark) to see how many cuts to make.  There could be anywhere from 2 to 7 clusters -- it’s just not visible.

Second, the text of the documents is overlapping.  I would love to change the font sizes, but I can’t seem to access that parameter.  Reading online, there is some issue with the `cex` parameter for this plot which makes it either prohibitively difficult or impossible.

The dendrogram is a nice plot in general, but for this use, I have to admit that it is not very appropriate.

---------------------------------------


##PLOT 3

<overview>

![Plot 3](https://github.com/mobbSF/msan622/blob/master/homework4/P3.png?raw=true)

####EVALUATION:

*  The Lie Factor is acceptable due to the fact that the words are plotted by frequency -- so the size of the graphic is in direct correspondence to the frequency of the word.
*  The Data-Ink Ratio is fine.  There is no “wasted” ink.
*  The data density is fine as well.

#####Issues:

I attempted to follow closely to the sample code given in class that corresponded with the State Of The Union speeches, but creating the TD matrix failed:

` sotu_tdm <- TermDocumentMatrix(sotu_corpus)`

giving me the error:  

    Error in simple_triplet_matrix(i = i, j = j, v = as.numeric(v), nrow =     
    length(allTerms),  :
    'i, j, v' different lengths

According to what I discovered online, this is due most like to some problem with the data in my corpus that is causing some problem with the construction of the matrix -- as to what exactly, I cannot determine.

Thus, in order to gain access to my data, I have to perform a somewhat hackneyed process, outlined in this StackOverflow post I wrote:

http://goo.gl/OG4XKn

(I didn’t get any insight into the problem, but a few people commented to me that they experienced similar problems.)

My solution was to:
Creat a tfidf matrix, and then exported all the words in my corpus to a csv file:  

`write.csv(inspect(tfidf), file="tdmfile.csv")`

Next I read it back in (I know, I know, this is not elegant):  

`tdmfile <- read.csv("/home/matt/tdmfile.csv")`  

Then I grab the words but using the `names` function:  

`mynames <- names(tdmfile)`  

Finally I produced a wordcloud:  

`wordcloud(mynames, min.freq=5,max.words=50)`

However, this didn’t work, since I had no frequency counts!  Thus I tried to get frequency counts as follows:  

    tablenames <- sort(table(mynames), decreasing = FALSE)
    names(tablenames) <- c("word", "freq")
    tablenames <- as.matrix(tablenames)  

...but then I realized...the counts will always be 1, since each column in the TFIDF is unique!

Finally, I chose a solution whereas I combined all my text documents into 1 document, and the code then worked.  This was a decent solution -- however I lost the structure I had with respect to the labels.  So this plot is basically a one-off.

As far as modifications go, I decided to go with black and white, since I felt that the color was distracting.  

I also decided to plot by frequency which I feel is more informative, using  
 
`random.order = TRUE`  

Since I chose to plot by frequency, I was curious to see the distribution, so I put together a super quick plot:

![quickplot](https://github.com/mobbSF/msan622/blob/master/homework4/quickplot.png?raw=true)

...which told me that the first 100 or so terms looked very frequent.  With this in mind, I realized that it might be a good idea to plot a sizeable number of words, since most of them will be small.  Thus I chose to plot 100 words.  I feel this was a good choice.

