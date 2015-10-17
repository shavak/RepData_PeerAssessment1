# Shavak Sinanan
# Reproducible Research
# Johns Hopkins University
# Peer Assessment 1

library(dplyr)
library(ggplot2)

activity <- read.csv("activity.csv", colClasses = c("integer", "Date", "integer")) # date is in YYYY-MM-DD format

activity_by_day <- summarise(group_by(activity, date), total_steps = sum(steps, na.rm = TRUE)) # I spell the British way

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

max_j <- which.max(activity_by_interval$avg_steps)
