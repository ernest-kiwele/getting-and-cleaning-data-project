## This will be used later
library(plyr)

## Download the file and extract the archive:
dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(dataurl, destfile = "dataset.zip")

# extract into given folder:
unzip(zipfile = "dataset.zip", overwrite = TRUE, exdir = "data")

datapath <- "data/UCI HAR Dataset"

## Read the various included data sets:
## And work out the names of required variables
trainfeatures <- read.table(paste(datapath, "train/X_train.txt", sep = "/"), header = F)
testfeatures <- read.table(paste(datapath, "test/X_test.txt", sep="/"), header = F)
trainsubjects <- read.table(paste(datapath, "train/subject_train.txt", sep="/"))
testsubjects <- read.table(paste(datapath, "test/subject_test.txt", sep="/"), header = F)
trainactivity <- read.table(paste(datapath, "train/y_train.txt", sep = "/"), header = F)
testactivity <- read.table(paste(datapath, "test/y_test.txt", sep="/"), header = F)
featurenametable <- read.table(paste(datapath, "features.txt", sep="/"), header = F)
labels <- read.table(paste(datapath, "activity_labels.txt", sep="/"), header = F)

#Extract feature names from this table
featurenames <- featurenametable$V2

#Create a vector of only the names required to be used:
featuresofinterest <- featurenames[grep("(mean|std)\\(\\)", featurenames)]

#A vector with all names to be used in the final dataset.
allnames <- c(as.character(featuresofinterest), c("subject", "activity"))

## Merge train and test data sets:
features <- rbind(trainfeatures, testfeatures)
names(features) <- featurenames

activity <- rbind(trainactivity, testactivity)
names(activity) <- "activity"
#set the label of each activity:
activity$activity <- factor(activity$activity, levels=labels$V1, labels = labels$V2)

subject <- rbind(trainsubjects, testsubjects)
names(subject) <- "subject"


#Merge all datasets into one:
alldata <- cbind(cbind(subject, activity), features)
selectdata <- subset(alldata, select = allnames)

#clean up the names:
allnames <- gsub("\\-", "", gsub("\\-std\\(\\)(\\-)*?", "Std", gsub("\\-mean\\(\\)(\\-)*?", "Mean", gsub("BodyBody", "Body", gsub("Mag", "Magnitude", gsub("Gyro", "Gyroscope", gsub("Acc", "Accelerometer", gsub("^f", "Frequency", gsub("^t", "Time", allnames)))))))))

#Apply thus cleaned up names to the selected dataset
names(selectdata) <- allnames

#Write the file 'finaldataset.txt' after aggregating:
write.table(aggregate(. ~subject + activity, selectdata, mean), row.name = F, file = "finaldataset.txt")
