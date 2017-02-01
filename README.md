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
See the example code file named "SampleDraw.R"

This code is intended to take a large dataset and create a simple random sample of the data.  In the provided example we take a dataset of Hospital providers from the publicly available "Hospital Compare" data hosted on [data.medicare.gov](https://data.medicare.gov/data/hospital-compare "Hospital Compare datasets page").  We chose to download the dataset in a .CSV file.  

In the example code we select only 200 records because we later sampled multiple datasets for a total of 850 records.  As a general guideline you should try to select at least 400 records (the more, the better) for each group of interest that you will analyze in order to achieve sufficient statistical power. Due to the methodology required for the project which inspired the TIL, the example code has been written to: 
+ eliminate duplicate records by keeping only one record per provider ID (specifically, the record which contains a provider "star rating")
+ select only providers which have a 4- or 5-star rating
+ select a random sample of 200, with 100 records selected from 4-star providers and 100 selected from 5-star providers
+ save the sample records as a .CSV file





