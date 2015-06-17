# gettingdata_course_project
This is the repo for my submission of the course project of "Getting and Cleaning Data" on Coursera. It contains the following elements:

1. This README.md
2. The R script "run_analysis.R"
3. The tidy dataset "tidy_dataset.txt" as the product of the script
4. The "codebook.md" which describes the variables of the tidy dataset.

## How to correctly read the dataset in R
Use the following command to correctly read tidy dataset in R:
read.table("tidy_dataset.txt", header=T)

## How the script works
Before using the script, download the raw data as indicated in the course project instructions and unzip the file. The folder "UCI HAR Dataset" and all its subfolders should be in your current R working directory. The script requires the "dplyr" package.

The script works in five steps:

1. It merges the training and test sets to create one data set:
It reads the training and test measurements, activity index and subject index. The respective test data are added to the training data as rows by rbind. The three resulting tables are than joint as columns by cbind in the following order: subject index, activity index, measurements.
 
2. It extracts only the measurements on the mean and standard deviation for each measurement:
The variable names ("feature.txt") are read into the object "feat". A vector ("columns") is created which identifies the numbers of all columns whose variable names contain the exact strings "mean()" and "std()". The dataset is then reduced to the columns of the subject and activity index plus the identified relevant measurements.  

3. It uses descriptive activity names to name the activities in the dataset:
Descriptive activity names are read from "activity_labels.txt" and are used as factor levels for the activity column in the dataset.

4. It labels the dataset with descriptive variable names:
The descriptive variable names have already been read into the vector "feat" in step 2. They are adapted to R naming standards by removing parentheses and replacing minus signs with "_". The column names of the dataset are defined as "Subject" and "Activity" for the first two columns plus the relevant subset of measurement variable names from the "feat" vector.

5. It creates an independent tidy dataset with the average of each variable for each activity and each subject:
The "dplyr" package is used to group the dataset by Subject and activity and to produce a table indicating the mean of each variable for each activity and each subject using "summarise_each". The resulting table is written as "tidy_dataset.txt.".
