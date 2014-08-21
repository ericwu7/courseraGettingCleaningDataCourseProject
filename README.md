# Course Project ReadMe
#### run_analysis.R 
The R script used to load and create the data set found in the file: **AvgMeanStdBySubjectActivity.txt**.
The script assumes the following files from the **Human Activity Recognition Using Smartphones Dataset** are in the working directory.
- X_test.txt
- X_train.txt
- subject_test.txt
- subject_train.txt
- y_test.txt
- y_train.txt
- activity_labels.txt
- features.txt

The files are space delimited.

#### AvgMeanStdBySubjectActivity.txt
The output of run_analysis.R.

#### CodeBook.md
The code book that contains
- **Study Design:** How the source data was downloaded, manipulated, and transformed into the output.
- **Code Book:** Description of the variables in the tidy data set created by run_analysis.R

##### Source Data
The data for the project was downloaded from this URL and extracted into the working directory: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

That zip file contains a README.txt file that describes the data in detail.