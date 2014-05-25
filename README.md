run_analysis.R
==============

Getting and Cleaning Data Course Project

How the script works:

It:

1. Downloads the training and test data sets.
2. Imports the data sets.
3. Merges the training and the test sets to create one data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Uses descriptive activity names to name the activities in the data set.
6. Appropriately labels the data set with descriptive activity names.
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
8. Open the tidyDataSet <- read.table("./tidyData.txt")

