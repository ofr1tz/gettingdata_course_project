## Course project "Getting & Cleaning Data"
## The script assumes the unzipped Samsung data folder to be located in the current working directory

## 1. Merge the training and the test sets to create one data set.
untidy <- cbind(
      rbind(read.table("./UCI HAR Dataset/train/subject_train.txt"),
            read.table("./UCI HAR Dataset/test/subject_test.txt")
            ),
      rbind(read.table("./UCI HAR Dataset/train/y_train.txt"),
            read.table("./UCI HAR Dataset/test/y_test.txt")
            ),
      rbind(read.table("./UCI HAR Dataset/train/X_train.txt"),
            read.table("./UCI HAR Dataset/test/X_test.txt")
            )
      )

## 2. Extract only the measurements on the mean and standard deviation for each measurement
feat <- read.table("./UCI HAR Dataset/features.txt")[,-1]
columns <- sort(c(grep("mean()", feat, fixed=T), grep("std()", feat, fixed=T)))
untidy <- untidy[,c(1:2, columns+2)]

## 3. Use descriptive activity names to name the activities in the data set
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
untidy[,2] <- cut(untidy[,2], breaks=0:6, labels=actlabels[,2])

## 4. Appropriately label the data set with descriptive variable names
feat <- gsub("()", "", feat, fixed=T)
feat <- gsub("-", "_", feat, fixed=T)
colnames(untidy) <- c("Subject", "Activity", feat[columns])

## 5. Create an independent tidy data set with the average of each variable for each activity and each subject
## Requires: dplyr package
library(dplyr)
g <- group_by(untidy, Subject, Activity)
tidy <- as.data.frame(summarise_each(g, funs(mean)))

## Write tidy dataset
write.table(tidy, file="tidy_dataset.txt", row.names=F)

## Use the following command to correctly read the table produced by this script:
## read.table("tidy_dataset.txt", header=T)
