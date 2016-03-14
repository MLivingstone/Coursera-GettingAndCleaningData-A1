# Assignment for Getting and Cleaning Data - Data Science Coursera course

This repo contains the following files:
* run_analysis.R
* codebook.txt
* README.md

Download the dataset from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data set into your working dicrectory and you should see a folder named UCI HAR Dataset

## run_analysis.R
This scripts performs the following:
* Merges the training and the test sets to create one data set (data)
* Extracts only the measurements on the mean and standard deviation for each measurement (required_columns)
* Uses descriptive activity names to name the activities in the data set (activity_labels)
* Appropriately labels the data set with descriptive variable names (varnames and 'activityid','subject','activityname')
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* The tidy dataset gives the mean of each measurement for each subject/activity combination.

The script expects the train dataset to be in: "./UCI HAR Dataset/train", and the test dataset to be in "./UCI HAR Dataset/test". The other metadata files should be in "./UCI HAR Dataset"

Further details about the files can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## codebook.txt
This is the codebook for the tidy data set mentioned above. 

## README.md
The readme file for this repo.
