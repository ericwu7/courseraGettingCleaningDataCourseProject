## Study Design
The source data was downloaded as a zip file from the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The files were extracted into a folder called **UCI HAR Dataset**. Then the following text files were copied into the R working directory:

- \UCI HAR Dataset\activity_labels.txt
- \UCI HAR Dataset\features.txt
- \UCI HAR Dataset\test\subject_test.txt*
- \UCI HAR Dataset\test\X_test.txt
- \UCI HAR Dataset\test\y_test.txt
- \UCI HAR Dataset\train\subject_train.txt
- \UCI HAR Dataset\train\X_train.txt
- \UCI HAR Dataset\train\y_train.txt

All the files are space (" ") delimited, so they were loaded into individual data frames in R using the **read.table** function.

Test data: The *X_test.txt*, *subject_test.txt*, and *y_test.txt* data sets each contain data for the same 2,947 observations.
They were combined into one data frame and the "subject" and "y" column names were updated to be more descriptive:
- subjectID
- activityID

Train data: The *X_train.txt*, *subject_train.txt*, and *y_train.txt* data sets each contain data for the same 7,352 observations.
They were combined into one data frame and the "subject" and "y" column names were updated to be more descriptive:
- subjectID
- activityID

The train and test data frames were then appended to create a new data frame **all.data.df** resulting in 10,299 total rows.

The column names in the *features.txt* file were used to appropriately label the column headers **all.data.df**.

In addition to the subjectID and activityID fields, the mean, and standard deviation variables were extracted from **all.data.df** using the following command:
```     
	 grep("mean\\(\\)|std\\(\\)", colnames(all.data.df))
```

Based on Jim Medlock's post on *Tidy Data set 1 and 2 specs*, the *angle(...,mean)* variables were not included because they do not appear to be actual mean or standard deviation values. 
Here is the URL being referenced: https://class.coursera.org/getdata-006/forum/thread?thread_id=196

Additionally, the column names were cleaned up by removing parenthesis and hyphens, and the strings "mean" and "std" were made to have initial capitalization.

The resulting data frame **mean.std.data.df** was transformed using the *merge* function of the **plyr** package to replace the activityID with activityName.
The following is a mapping of the activityID to activityName:

|activityID|activityName|
|----------|------------|
|1|WALKING|
|2|WALKING_UPSTAIRS|
|3|WALKING_DOWNSTAIRS|
|4|SITTING|
|5|STANDING|
|6|LAYING|

The **melt** and **dcast** functions in the **reshape2** package were used to transform the mean.std.data.df so that the mean would be calculated for each variable per subjectID and activityName combination. The resulting data frame is called **avg.mean.std.df**.

Since the variables at this point represent average values, the column names of **avg.mean.std.df** were renamed to append "Avg" as a suffix to reflect this.

Finally, the now tidy data set **avg.mean.std.df** is written to a file in the working directory using the **write.table** command.

The tidy data set has data for 30 subjects each performing 6 activities = 180 rows. This output is confirmed in Wendel Hope's post in **Tidy Data Set 1 and 2 specs**: https://class.coursera.org/getdata-006/forum/thread?thread_id=196

## Code book
This Code Book describes the variables found in the output of run_analysis.R.
This assumes a basic understanding of the source data of which detailed descriptions can be found in the **features_info.txt** file in the following location:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Each row represents the averages for one subject for one activity. 30 subjects performed 6 activities = 180 rows.

#### subjectID
     Subject ID number as sourced from subject_test.txt and subject_train.txt. 
	 Possible values range from 1 - 30.

#### activityName
     Name of the activity performed by the subject. 
	 Possible values include:
     - WALKING
     - WALKING_UPSTAIRS
     - WALKING_DOWNSTAIRS
     - SITTING
     - STANDING
     - LAYING

#### tBodyAccMeanXAvg
     Average of the tBodyAccMeanX signal. (numeric value)

#### tBodyAccMeanYAvg
     Average of the tBodyAccMeanY signal. (numeric value)

#### tBodyAccMeanZAvg
     Average of the tBodyAccMeanZ signal. (numeric value)

#### tBodyAccStdXAvg
     Average of the tBodyAccStdX signal. (numeric value)

#### tBodyAccStdYAvg
     Average of the tBodyAccStdY signal. (numeric value)

#### tBodyAccStdZAvg
     Average of the tBodyAccStdZ signal. (numeric value)

#### tGravityAccMeanXAvg
     Average of the tGravityAccMeanX signal. (numeric value)

#### tGravityAccMeanYAvg
     Average of the tGravityAccMeanY signal. (numeric value)

#### tGravityAccMeanZAvg
     Average of the tGravityAccMeanZ signal. (numeric value)

#### tGravityAccStdXAvg
     Average of the tGravityAccStdX signal. (numeric value)

#### tGravityAccStdYAvg
     Average of the tGravityAccStdY signal. (numeric value)

#### tGravityAccStdZAvg
     Average of the tGravityAccStdZ signal. (numeric value)

#### tBodyAccJerkMeanXAvg
     Average of the tBodyAccJerkMeanX signal. (numeric value)

#### tBodyAccJerkMeanYAvg
     Average of the tBodyAccJerkMeanY signal. (numeric value)

#### tBodyAccJerkMeanZAvg
     Average of the tBodyAccJerkMeanZ signal. (numeric value)

#### tBodyAccJerkStdXAvg
     Average of the tBodyAccJerkStdX signal. (numeric value)

#### tBodyAccJerkStdYAvg
     Average of the tBodyAccJerkStdY signal. (numeric value)

#### tBodyAccJerkStdZAvg
     Average of the tBodyAccJerkStdZ signal. (numeric value)

#### tBodyGyroMeanXAvg
     Average of the tBodyGyroMeanX signal. (numeric value)

#### tBodyGyroMeanYAvg
     Average of the tBodyGyroMeanY signal. (numeric value)

#### tBodyGyroMeanZAvg
     Average of the tBodyGyroMeanZ signal. (numeric value)

#### tBodyGyroStdXAvg
     Average of the tBodyGyroStdX signal. (numeric value)

#### tBodyGyroStdYAvg
     Average of the tBodyGyroStdY signal. (numeric value)

#### tBodyGyroStdZAvg
     Average of the tBodyGyroStdZ signal. (numeric value)

#### tBodyGyroJerkMeanXAvg
     Average of the tBodyGyroJerkMeanX signal. (numeric value)

#### tBodyGyroJerkMeanYAvg
     Average of the tBodyGyroJerkMeanY signal. (numeric value)

#### tBodyGyroJerkMeanZAvg
     Average of the tBodyGyroJerkMeanZ signal. (numeric value)

#### tBodyGyroJerkStdXAvg
     Average of the tBodyGyroJerkStdX signal. (numeric value)

#### tBodyGyroJerkStdYAvg
     Average of the tBodyGyroJerkStdY signal. (numeric value)

#### tBodyGyroJerkStdZAvg
     Average of the tBodyGyroJerkStdZ signal. (numeric value)

#### tBodyAccMagMeanAvg
     Average of the tBodyAccMagMean signal. (numeric value)

#### tBodyAccMagStdAvg
     Average of the tBodyAccMagStd signal. (numeric value)

#### tGravityAccMagMeanAvg
     Average of the tGravityAccMagMean signal. (numeric value)

#### tGravityAccMagStdAvg
     Average of the tGravityAccMagStd signal. (numeric value)

#### tBodyAccJerkMagMeanAvg
     Average of the tBodyAccJerkMagMean signal. (numeric value)

#### tBodyAccJerkMagStdAvg
     Average of the tBodyAccJerkMagStd signal. (numeric value)

#### tBodyGyroMagMeanAvg
     Average of the tBodyGyroMagMean signal. (numeric value)

#### tBodyGyroMagStdAvg
     Average of the tBodyGyroMagStd signal. (numeric value)

#### tBodyGyroJerkMagMeanAvg
     Average of the tBodyGyroJerkMagMean signal. (numeric value)

#### tBodyGyroJerkMagStdAvg
     Average of the tBodyGyroJerkMagStd signal. (numeric value)

#### fBodyAccMeanXAvg
     Average of the fBodyAccMeanX signal. (numeric value)

#### fBodyAccMeanYAvg
     Average of the fBodyAccMeanY signal. (numeric value)

#### fBodyAccMeanZAvg
     Average of the fBodyAccMeanZ signal. (numeric value)

#### fBodyAccStdXAvg
     Average of the fBodyAccStdX signal. (numeric value)

#### fBodyAccStdYAvg
     Average of the fBodyAccStdY signal. (numeric value)

#### fBodyAccStdZAvg
     Average of the fBodyAccStdZ signal. (numeric value)

#### fBodyAccJerkMeanXAvg
     Average of the fBodyAccJerkMeanX signal. (numeric value)

#### fBodyAccJerkMeanYAvg
     Average of the fBodyAccJerkMeanY signal. (numeric value)

#### fBodyAccJerkMeanZAvg
     Average of the fBodyAccJerkMeanZ signal. (numeric value)

#### fBodyAccJerkStdXAvg
     Average of the fBodyAccJerkStdX signal. (numeric value)

#### fBodyAccJerkStdYAvg
     Average of the fBodyAccJerkStdY signal. (numeric value)

#### fBodyAccJerkStdZAvg
     Average of the fBodyAccJerkStdZ signal. (numeric value)

#### fBodyGyroMeanXAvg
     Average of the fBodyGyroMeanX signal. (numeric value)

#### fBodyGyroMeanYAvg
     Average of the fBodyGyroMeanY signal. (numeric value)

#### fBodyGyroMeanZAvg
     Average of the fBodyGyroMeanZ signal. (numeric value)

#### fBodyGyroStdXAvg
     Average of the fBodyGyroStdX signal. (numeric value)

#### fBodyGyroStdYAvg
     Average of the fBodyGyroStdY signal. (numeric value)

#### fBodyGyroStdZAvg
     Average of the fBodyGyroStdZ signal. (numeric value)

#### fBodyAccMagMeanAvg
     Average of the fBodyAccMagMean signal. (numeric value)

#### fBodyAccMagStdAvg
     Average of the fBodyAccMagStd signal. (numeric value)

#### fBodyBodyAccJerkMagMeanAvg
     Average of the fBodyBodyAccJerkMagMean signal. (numeric value)

#### fBodyBodyAccJerkMagStdAvg
     Average of the fBodyBodyAccJerkMagStd signal. (numeric value)

#### fBodyBodyGyroMagMeanAvg
     Average of the fBodyBodyGyroMagMean signal. (numeric value)

#### fBodyBodyGyroMagStdAvg
     Average of the fBodyBodyGyroMagStd signal. (numeric value)

#### fBodyBodyGyroJerkMagMeanAvg
     Average of the fBodyBodyGyroJerkMagMean signal. (numeric value)

#### fBodyBodyGyroJerkMagStdAvg
     Average of the fBodyBodyGyroJerkMagStd signal. (numeric value)


The home page for the source data used is the *UCI Machine Learning Repository:* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following description of the fields is taken from the features_info.txt file from the source data, which can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	 
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
