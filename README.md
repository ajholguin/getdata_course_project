# getdata_course_project

Coursera - Getting and Cleaning Data Course Project

This Github repo contains the code and cleaned dataset produced in the Coursera Getting and Cleaning Data class. There is one R code file called "run_analysis.R", which takes the raw input data files, aggregates them, and performs the necessary transformations to produces a single tidy dataset.

The input data can be found in the "UCI HAR Dataset" directory. For more info about the original dataset, see the original documentation []here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The "run_analysis.R" script reads the various training and testing data files, aggregates the into a single data frame, extracts the meean and standard deviation values for each variable, applies descriptive variable names, calculates a mean value for each of those variables, and the writes the "tidy_data.txt" file. 

For additional documentation on the variables available in the cleaned "tidy_data.txt" file see the code book in this repo.
