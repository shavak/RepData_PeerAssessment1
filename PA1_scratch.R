# Shavak Sinanan
# Reproducible Research
# Johns Hopkins University
# Peer Assessment 1

library(dplyr)
library(ggplot2)
library(chron)
library(data.table)

activity <- read.csv("activity.csv", colClasses = c("integer", "Date", "integer")) # date is in YYYY-MM-DD format

activity_by_day <- summarise(group_by(activity, date), total_steps = sum(steps, na.rm = TRUE))

qplot(total_steps,
      data = activity_by_day,
      geom = "histogram",
      main = "Total Number of Steps Per Day",
      xlab = "Total number of steps",
      ylab = "Frequency",
      fill = I("orange"),
      alpha = I(0.75))

mean_steps <- mean(activity_by_day$total_steps)
median_steps <- median(activity_by_day$total_steps)

activity_by_interval <- summarise(group_by(activity, interval), avg_steps = mean(steps, na.rm = TRUE))
qplot(interval,
      avg_steps,
      data = activity_by_interval,
      geom = "line",
      main = "Average Daily Activity",
      xlab = "Interval",
      ylab = "Average number of steps",
      col = I("red"))
# I'd really have liked the x axis to be prettier; will work on this more if I have some time

max_interval <- activity_by_interval[which.max(activity_by_interval$avg_steps), 1]

bad_rows <- !complete.cases(activity)

bad_num <- sum(!complete.cases(activity))

# the following is an impute function designed specifically for "daily" subsets of the master dataset

impute_steps <- function(daily_activity, step_profile = rep(0, 288)) {
    # default is to replace missing values with 0
    baddies <- is.na(daily_activity$steps)
    daily_activity$steps[baddies] <- step_profile[baddies] # replace missing values and keep the rest
    daily_activity
}

# split, apply, combine
# do it all in one line - no farting around
patched_activity <- rbindlist(lapply(split(activity, activity$date), impute_steps, step_profile = activity_by_interval$avg_steps)) # replace missing values with average for the appropriate interval

day_type <- factor(is.weekend(patched_activity$date), levels = c(TRUE, FALSE), labels = c("weekend", "weekday"))

patched_activity <- data.table(cbind(patched_activity, day_type))

patched_activity_by_iw <- patched_activity[, mean(steps), by = c("interval", "day_type")]

qplot(interval,
      V1,
      data = patched_activity_by_iw,
      facets = day_type ~ .,
      geom = "line",
      main = "Average Daily Activity",
      xlab = "Interval",
      ylab = "Average number of steps",
      col = I("purple"))