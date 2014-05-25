## Download the training and test data sets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
unzip("Dataset.zip")

## Import the data sets
xTrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
xTest<-read.table("./UCI HAR Dataset/test/X_test.txt")
yTrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
yTest<-read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
activityLabels<-read.table("./UCI HAR Dataset/activity_labels.txt")
featuresData<-read.table("./UCI HAR Dataset/features.txt")

## Merges the training and the test sets to create one data set.
xDataSet<-rbind(xTrain,xTest)

## Extracts only the measurements on the mean and standard deviation for each measurement
colnames(xDataSet) <- c(as.character(featuresData[,2]))

Mean<-grep("mean()",colnames(xDataSet),fixed=TRUE)

SD<-grep("std()",colnames(xDataSet),fixed=TRUE)

MeanSD<-xDataSet[,c(Mean,SD)]

## Uses descriptive activity names to name the activities in the data set.

yDataSet<-rbind(yTrain,yTest)

activityData<-cbind(yDataSet,MeanSD)

colnames(activityData)[1] <- "Activity"

## Appropriately labels the data set with descriptive activity names.
activityLabels[,2]<-as.character(activityLabels[,2])

for(i in 1:length(activityData[,1])){
        activityData[i,1]<-activityLabels[activityData[i,1],2]
}

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subjectData<-rbind(subjectTrain,subjectTest)

allData<-cbind(subjectData,activityData)

colnames(allData)[1] <- "Subject"

tidyData <- aggregate( all[,3] ~ Subject+Activity, data = allData, FUN = "mean" )

for(i in 4:ncol(all)){
        tidyData[,i] <- aggregate( all[,i] ~ Subject+Activity, data = allData, FUN = "mean" )[,3]
}

colnames(tidyData)[3:ncol(tidyData)] <- colnames(MeanSD)

write.table(tidyData, file = "tidyData.txt")

## tidyDataSet <- read.table("./tidyData.txt")