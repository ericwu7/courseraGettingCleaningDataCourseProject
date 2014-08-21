# Description: This script loads Human Activity Recognition Using Smartphones 
# Data Set and performs the steps described in the Course Project 
# instructions, listed below:

# 1. Merges the training and the test sets to create one data set. 
#    --Done in data frame called all.data.df

# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement. 

# 3. Uses descriptive activity names to name the activities in the data set

# 4. Appropriately labels the data set with descriptive variable names. 

# 5. Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 
#  -- as stated in Wendel Hope's post in Tidy Data Set 1 and 2 specs,
#  my tidy data set has 30 subjects each performing 6 activities = 180 rows
# https://class.coursera.org/getdata-006/forum/thread?thread_id=196
################################################################################
#  setwd("C:\\Users\\ewu3\\Documents\\Courses\\GettingAndCleaningData\\Project")

# Assume the following files are in the working directory. The files are space delimited
# X_test.txt
# X_train.txt
# subject_test.txt
# subject_train.txt
# y_test.txt
# y_train.txt
# activity_labels.txt
# features.txt

# Load the activity labels into a data frame called activity.labels
  activity.labels.df <- read.table(file="activity_labels.txt", sep=" ")

# Load and then combine the the data sets with their respective subject IDs and activity labels
# Load and combine X_test.txt, subject_test.txt, and y_test.txt
  x.test.df <- read.table(file="X_test.txt", stringsAsFactors=FALSE)
  subject.test.df <- read.table(file="subject_test.txt", col.names="subjectID")
  y.test.df <- read.table(file="y_test.txt", col.names="activityID")
  test.combined.df <- cbind(subject.test.df, y.test.df, x.test.df)

# Load and combine X_train.txt, subject_train.txt, and y_train.txt
  x.train.df <- read.table(file="X_train.txt", stringsAsFactors = FALSE)
  subject.train.df <- read.table(file="subject_train.txt", col.names="subjectID")
  y.train.df <- read.table(file="y_train.txt", col.names="activityID")
  train.combined.df <- cbind(subject.train.df, y.train.df, x.train.df)

# Merge train.combined.df with test.combined.df using rbind
  all.data.df <- rbind(train.combined.df, test.combined.df)

# Load the features.txt file into data frame called features.df to get the variable names
  features.df <- read.table(file="features.txt", stringsAsFactors = FALSE, col.names=c("columnID", "columnName"))

# Assign coumnName from features.df to all.data.df column names
  colnames(all.data.df)[3:563] <- features.df[["columnName"]]

# Create a new data frame called mean.std.data.df that keeps 
# only studentID, activityID, and mean and std variables
  mean.std.data.df <- all.data.df[,c(1:2, grep("mean\\(\\)|std\\(\\)", colnames(all.data.df)))]

# Clean up the column names by removing parenthesis and dashes, and 
# capitalize first letter of "mean" and "std" to make headers more readable
  colnames(mean.std.data.df) <- gsub("-","",
                                     gsub("-std","-Std",
                                          gsub("-mean","-Mean",
                                               gsub("\\(\\)", "", 
                                                    colnames(mean.std.data.df)))))

# Match the activityIDs with the activity label names in activity.labels.df
  library(plyr)
  colnames(activity.labels.df)[2] <- "activityName"  # rename variable V2 to activityName
  mean.std.data.df <- merge(mean.std.data.df, activity.labels.df, by.x="activityID", by.y="V1", all=FALSE)

# table(mean.std.data.df[,c(1,69)])  # this is a check to make sure the merge worked properly

# Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 
# class(mean.std.data.df$activityName)  # factor. good.
# class(mean.std.data.df$subjectID)  # integer. need to change to factor

# convert subjectID to a factor for using in split
  mean.std.data.df$subjectID <- as.factor(mean.std.data.df$subjectID)

# table(mean.std.data.df$subjectID)  # this is check to make sure subjectID is populated properly

# use the reshape2 package: melt and dcast functions to do the same thing to create avg.mean.std.df
  library(reshape2)
  datamelt.df <- melt(mean.std.data.df, id=c("subjectID","activityName"), measure.vars=colnames(mean.std.data.df)[3:68])
  avg.mean.std.df <- dcast(datamelt.df, subjectID + activityName ~ variable, mean)

# append "Avg" to each variable name since it's now the average of the mean/std
  colnames(avg.mean.std.df)[3:68] <- paste(colnames(avg.mean.std.df)[3:68], "Avg", sep="") 

# write table out to file called AvgMeanStdBySubjectActivity.txt
  write.table(avg.mean.std.df, file="AvgMeanStdBySubjectActivity.txt", row.name=FALSE)

## option 2. di not use but keeping here to preserve alternative method
#tidy.df <-  as.data.frame(t(sapply(split(mean.std.data.df[, 3:68], list(mean.std.data.df$subjectID, mean.std.data.df$activityName)), colMeans)))  
# nrow(tidy.df)  # 180


# populate subjectID and activityName variables using substring on the rownames
#tidy.df$subjectID <- substring(rownames(tidy.df), 1, regexpr("\\.", rownames(tidy.df)) - 1)
#tidy.df$activityName <- substring(rownames(tidy.df), regexpr("\\.", rownames(tidy.df)) + 1)

# write the tidy data set to tidyoutput.txt in the working directory 
#write.table(tidy.df[, c(67:68,1:66)], file="tidy2output.txt", row.name=FALSE)