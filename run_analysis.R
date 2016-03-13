## run_analysis.R  does the following:
## 1. Merges the training and the test sets in "./UCI HAR Dataset" to create one data set.
## 2. Extracts only the measurements of the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
## STEP 0 - Load required packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

library(data.table)
library(reshape2)

## STEP 1 - Merge the training and the test sets to create one data set.

# Load train set
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") # Subject
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")  # Activity ID
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")  # Samsung Data

# Load test set
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") # Subject
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")  # Activity ID
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")  # Samsung Data

# Merge Train and Test sets
train_data <- cbind(as.data.frame(subject_train), y_train, X_train) # Subject, Activity ID, Features
test_data <- cbind(as.data.frame(subject_test), y_test, X_test) # Subject, Activity ID, Features
data = rbind(test_data, train_data) 

## STEP 2 - Extract only the measurements of the mean and standard deviation for each measurement.
feature_names <- read.table("./UCI HAR Dataset/features.txt")[,2]
extracted_features <- grepl("mean|std", feature_names)  #logical vector
required_columns <- c(TRUE,TRUE, extracted_features) # Add two columns to logical vector for Subject and Activity ID
data <- data[,required_columns]

## STEP 3 - Use descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activityid","activityname") # change column names of activity_labels data.table
data <- merge(data,activity_labels,by.x="V1.1",by.y="activityid") # last column now contains activityname

## STEP 4 - Appropriately label the data set with descriptive variable names.
# Make lable names more descriptive where necessary
feature_names<-tolower(feature_names)
feature_names<-gsub("acc", "accelerometer", feature_names)
feature_names<-gsub("bodybody", "body", feature_names)
feature_names<-gsub("mag", "magnitude", feature_names)
feature_names<-gsub("\\(\\)", "", feature_names)
feature_names<-gsub("\\-", "", feature_names)

varnames <- as.character(feature_names[extracted_features]) # a factor vector containing the names of the mean/std variables
colnames(data) <- factor(c("activityid", "subject", varnames, "activityname")) 

## STEP 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject.
# 1. Each variable forms a column
# 2. Each observation forms a row
# 3. Each table/file stores data about one kind of observation

melt_data <- melt(data,id = c("subject","activityid","activityname"),measure.vars = varnames)
tidy_data <- dcast(melt_data,subject+activityname~variable, mean) 
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE, col.names = TRUE)

