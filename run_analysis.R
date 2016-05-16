##The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
##The goal is to prepare tidy data that can be used for later analysis.

library(dplyr)

##Download the data set and unzip it
if(!file.exists(".\\data")){dir.create(".\\data")}
my_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile=".\\data/Dataset.zip",exdir=".\\data")


##Read in data for test and train sets
test_data <- read.table(".\\data\\HAR\\test\\X_test.txt")
train_data <- read.table(".\\data\\HAR\\train\\X_train.txt")

##Read in subject data for test and train sets
subject_test_data <- read.table(".\\data\\HAR\\test\\subject_test.txt")
subject_train_data <- read.table(".\\data\\HAR\\train\\subject_train.txt")

##Read in labels data for test and train sets
label_test_data <- read.table(".\\data\\HAR\\test\\y_test.txt")
label_train_data <- read.table(".\\data\\HAR\\train\\y_train.txt") 

##Read in features file & prepare it for column names
features <- read.table(".\\data\\HAR\\features.txt", col.names = c("number", "feature"), stringsAsFactors=FALSE )[,2]


##Merge training data
training_data_set <- cbind(cbind(train_data, subject_train_data), label_train_data)

##Merge test data
test_data_set <- cbind(cbind(test_data, subject_test_data), label_test_data)

##Merge test and training data
all_data <- rbind(training_data_set, test_data_set)


##Name Columns in the merged data set
column_names <- c(features, "SubjectID", "ActivityId")
colnames(all_data) <- column_names

##Read in the activities file and assign column names
activity_labels <- read.table(".\\data\\HAR\\activity_labels.txt", sep = "", col.names = c("ActivityId", "Activity"))

##Replace Activity ID number with the Activity name by machting Activity ID in the all_data set against activity_labels information
all_data$ActivityId <- activity_labels$Activity[match(all_data$ActivityId, activity_labels$ActivityId)]

##Move the SubjectID and ActivityId columns to the first and second columns in the data set
all_data <- all_data[c(562:563, 1:561)]  

##Select only columns with mean and standard deviation data
mean_std_data <- all_data[,grep("mean|std|SubjectID|ActivityId", names(all_data), ignore.case = TRUE)]

##Label the data set with descriptive variable names
names(mean_std_data) <- gsub("^t", "time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "frequency", names(mean_std_data))
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data) <- gsub("ActivityId", "Activity", names(mean_std_data))

##Create tidy data set with the average of each variable for each activity and each subject
tidy_mean_data <- aggregate(.~SubjectID + Activity, mean_std_data, mean)

##Create tidydata.txt file
write.table(tidy_mean_data, file = "tidydata.txt", row.names = FALSE)
    
