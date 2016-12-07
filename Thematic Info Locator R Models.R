### IDEA LAB - Thematic Info Locator ###

#### Info retrieval

## the tm library (and related plugins) is R's ecosystem for text mining.
## for an intro see http://cran.r-project.org/web/packages/tm/vignettes/tm.pdf
library(tm)

# Read in the data file
scrape <- read.csv("all_training.csv",header=TRUE)
y <- scrape$page_MM
notes <- scrape$Visible.Text

#### Create a text mining corpus
## Once you have a bunch of docs in a vector, you 
## create a text mining 'corpus' with: 
docs <- Corpus(VectorSource(notes))
names(docs) <- names(notes) # no idea why this doesn't just happen automatically

## Time to clean up the text.
## tm_map just maps some function to every document in the corpus
docs <- tm_map(docs, content_transformer(tolower)) ## make everything lowercase
docs <- tm_map(docs, content_transformer(removeNumbers)) ## remove numbers
docs <- tm_map(docs, content_transformer(removePunctuation)) ## remove punctuation
## Remove stopwords.  be careful with this: one's stopwords are anothers keywords.
docs <- tm_map(docs, content_transformer(removeWords), stopwords("SMART"))
# You can also do stemming; we don't bother here in the practice code, but it will be included in the full instructions.
docs <- tm_map(docs, content_transformer(stripWhitespace)) ## remove excess white-space


## create a doc-term-matrix
dtm <- DocumentTermMatrix(docs)
dtm # 11 documents, > 4K terms
## These are special sparse matrices.  
class(dtm)
## You can inspect them:
inspect(dtm[1:5,1:8])
## find words with greater than a min count
findFreqTerms(dtm,10)
## or grab words whose count correlates with given words
findAssocs(dtm, "cms", .5)

## Finally, drop those terms that only occur in one or two lectures
## This is a common step: the noise of rare terms tends to overwhelm things,
##					and there is nothing to learn if a term occured once.
## The code below removes those terms that have count 0 in >75% of docs.  
## this is way more harsh than you'd usually do (but we only have 11 docs here)
## .75*11 is 8.25, so this will remove those with zeros in 9+ docs.
## ie, it removes anything that doesn't occur in at least 3 docs
dtm <- removeSparseTerms(dtm, 0.9955)
dtm # now near 700 terms

## Consider Principal Components Analysis (PCA) on term frequencies.
## note that converting to a dense matrix would be infeasible for big corpora
## see the 'irlba' package for PCA on the sparse Matrices we've used with glmnet.
x <- as.matrix(dtm)
xy <- cbind(y,x)
xy <- data.frame(xy)
F <- x/rowSums(x) ## divide by row (doc totals)
# classpca <- prcomp(F, scale=TRUE)
# plot(classpca)

## Try fitting a tree
# install.packages("tree") # use this if you haven't already installed tree
library(tree) # loads the tree package
dtree <- tree(y ~ ., data=xy[,-1], mincut=10) # make a tree of star rating (y) onto all covariates.
# [,-1] drops the intercept
# mincut=1 excludes keywords that appear in only 1 or fewer records
plot(dtree, col=1, lwd=1) # tree plot
text(dtree) # print the predictive probabilities

# The tree is telling us that:
# if the keyword density of "4 star" is above .0125, the website is more likely to have a CMS Star Rating
# among those with 4 star above 0.125, websites that also have excellence above .0164 are even more likely to have a CMS Star Rating
# Now, candidly looking at the data: 
# Around 88% (41 of 45) of records that have a 4 star density above .0125  do in fact use CMS Star Ratings in their advertising
# All 33 of the websites that also had an excellence density above .0164 used CMS Star Ratings in their advertising
# These records represent 24% (33/140) of the 140 websites that used CMS Star Ratings
# Looking at another example to the left of 4 star:
# if 4 star <.0125, and national quality award >.00182, and rated <.556, and five star >.00239, 
# (774 sites, 99 Yes)     (45 websites, 21 Yes)     (39 websites, 21 Yes) (6 websites, all Yes)

# Use cross-validation to prune the tree
cvtree <- cv.tree(dtree, K=90)
cvtree$size  # e.g. 32 30 28 27 25 21 20 18  5  4  3  2  1
cvtree$dev  # shows the deviance for different tree sizes
# plot the out-of-sample deviance for each tree size
# note across the top is 'average number of observations per leaf'; 
plot(cvtree, pch=21, bg=8, type="p", cex=1.5, ylim=c(600,1000))
# Out of sample deviance can be used to choose tree size.  Since a tree of size 4 had the lowest deviance, we will fit to this tree
dcut <- prune.tree(dtree, best=4)
plot(dcut, col=8)
text(dcut)
# We're not learning anything new, our original tree was better