# Thematic Info Locator (TIL)
A toolkit for using text analysis methods to predict the presence of thematic information across large quantities of text.  The TIL has tools which can help you design a random sample of websites, conduct automated searches to determine the URL for websites of interest, scrape raw HTML text from the sample of websites, and predict the presence of thematic information<sup>1</sup> within the raw scraped text.

*<sup>1</sup>The TIL provides a training dataset for predicting information relating to a specific information theme. If you are attempting to predict other information themes, you will need to find or create a training dataset specific to that theme.*

## Overview
The TIL provides a walkthrough of a text analysis project which includes these tasks:

1. Creating a random sample using R
2. Locating online data sources by programmatically querying a Google Custom Search engine
3. Scraping data from a sample of websites using Python
4. Predictive modeling to find thematic information using Python and R

## Introduction
The TIL is a collection of tools for text analysis that focuses on finding information that matches a specific theme.  The project that inspired the TIL was a research effort in which a team of analysts searched (with their eyeballs) the websites of healthcare providers and searched for the presence of various healthcare provider ratings systems. This manual effort produced the information needed to create a training dataset, which was then used to 6create the TIL toolkit.

## 1.) Creating a random sample using R

