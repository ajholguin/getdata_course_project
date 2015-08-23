
library(dplyr)

setwd("C:/Users/Andrew/OneDrive/Documents/Coursera/3_getdata/proj")

################################################################################
# 1. Merge the training and the test sets to create one data set
################################################################################

# feature names (variables)
features <- read.table("UCI HAR Dataset/features.txt",
                       col.names = c('position','name'),
                       stringsAsFactors = FALSE)

#### read test data ####
test_subjectIDs <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activityIDs <- read.table("UCI HAR Dataset/test/y_test.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")

# add subject and activity IDs to the data table
test_data2 <- cbind(data_source = 'testing',
                    subjectID = test_subjectIDs$V1,
                    activityID = test_activityIDs$V1,
                    test_data)

#### read training data ####
train_subjectIDs <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activityIDs <- read.table("UCI HAR Dataset/train/y_train.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")

# add subject and activity IDs to the data table
train_data2 <- cbind(data_source = 'training',
                     subjectID = train_subjectIDs$V1,
                     activityID = train_activityIDs$V1,
                     train_data)

#### combine training and testing data into one data frame ####
allData <- rbind(train_data2, test_data2)


################################################################################
# Extract only the measurements on the mean and standard deviation for each measurement
################################################################################

mean_sd_ind <- sort(c(grep("mean()", features$name, fixed = TRUE),
                      grep("std()", features$name, fixed = TRUE)))

allData_mean_sd <- allData[,c(1,2,3,mean_sd_ind+3)]


################################################################################
# Use descriptive activity names to name the activities in the data set
################################################################################

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",
                             col.names = c('ID','label'))

activityLabels_all <- activityLabels$label[match(allData_mean_sd$activityID, activityLabels$ID)]

allData_mean_sd$activityLabel <- activityLabels_all


################################################################################
# Label the data set with descriptive variable names
################################################################################

cleanNames <- gsub('-|\\(|\\)', '_', features$name[mean_sd_ind])
cleanNames <- gsub('_+$', '', cleanNames)

names(allData_mean_sd) <- c("data_source","subjectID","activityID",cleanNames,"activityLabel")

################################################################################
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
################################################################################

# calculate mean value for each subject-activity pair
tidy_data <- allData_mean_sd %>% 
  select(-data_source) %>% 
  group_by(subjectID, activityID, activityLabel) %>% 
  summarise_each(funs(mean)) %>% 
  arrange(subjectID, activityID)

write.table(tidy_data, "tidy_data.txt", row.names=FALSE) 

