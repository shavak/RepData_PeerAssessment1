# Reproducible Research: Peer Assessment 1
Shavak Sinanan  

## Introduction

Contained in this report are the items of data analysis as detailed in the instructions for Peer Assessment 1 of *Reproducible Research*.

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a [Fitbit](http://www.fitbit.com), [Nike Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or [Jawbone Up](https://jawbone.com/up). These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilised both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

## Data

The data for this assignment can be downloaded from the course web
site:

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) [52K]

The variables included in this dataset are:

+ **steps** : Number of steps taking in a 5-minute interval (missing
    values are coded as `NA`)

+ **date**: The date on which the measurement was taken in YYYY-MM-DD
    format

+ **interval**: Identifier for the 5-minute interval in which
    measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.

## Required packages

The following packages are used in the analysis: *dplyr*, *ggplot2*.



## Loading and preprocessing the data

The file *activity.csv* should exist in the working directory.


```r
activity <- read.csv("activity.csv", colClasses = c("integer", "Date", "integer")) # date is in YYYY-MM-DD format
```

## What is mean total number of steps taken per day?

The total number of steps taken per day is computed as follows:


```r
activity_by_day <- summarise(group_by(activity, date), total_steps = sum(steps, na.rm = TRUE)) # I spell the British way
```

Below is a code chunk producing a histogram of the total number of steps per day; the histogram follows.


```r
qplot(date,
      data = activity_by_day,
      geom = "histogram",
      weight = total_steps,
      binwidth = 1,
      main = "Total Number of Steps Per Day",
      xlab = "Date",
      ylab = "Total number of steps",
      fill = I("orange"),
      alpha = I(0.75))
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png) 

The mean and median of the total number of steps per day is computed as follows:


```r
mean_steps <- mean(activity_by_day$total_steps)
median_steps <- median(activity_by_day$total_steps)
```

The mean total number of steps is 9354.23.

The median total number of steps is 10395.


## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
