AnalyzeExerciseData
===================
## Purpose of this script
 The R script (run\_analysis.R) reads the data from the UCI HAR Dataset directory.
 It combines the datasets in the 'test' and 'training' directories.  It extracts
 the columns of the dataset that contain
 averages and standard deviations for particular measurements during the trial, along with 
 the corresponding Subject\_ID and Activity\_Name. 
 The mean for each subject's measurement is computed by taking all of the trials
 for a given activity for each subject (Ex. take the mean of measurements for
 subject 1 for all RUNNING\_UPSTAIRS trials).  The means of all the standard 
 deviations and means are printed to a file called TidyAverages.txt.  
 There are 180 rows of data (30 subjects * 6 activities).  Each column
 contains an average of the data type listed under Data about motion obtained
 from phone.

##Data Source
The directory UCI HAR Dataset directory must be in the directory from which the run\_analysis.R
script is called.  The data can be obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones    

#Columns in the dataset:
"Subject\_ID"   - the subject's identification number

"Activity\_Name" - the activity being performed while data was collected

###Data about motion obtained from the phone
"tBodyAcc-mean()-X" 

"tBodyAcc-mean()-Y"

"tBodyAcc-mean()-Z"

"tGravityAcc-mean()-X"

"tGravityAcc-mean()-Y"

"tGravityAcc-mean()-Z"

"tBodyAccJerk-mean()-X"

"tBodyAccJerk-mean()-Y"

"tBodyAccJerk-mean()-Z"

"tBodyGyro-mean()-X"

"tBodyGyro-mean()-Y"

"tBodyGyro-mean()-Z"

"tBodyGyroJerk-mean()-X"

"tBodyGyroJerk-mean()-Y"

"tBodyGyroJerk-mean()-Z"

"tBodyAccMag-mean()"

"tGravityAccMag-mean()"

"tBodyAccJerkMag-mean()"

"tBodyGyroMag-mean()"

"tBodyGyroJerkMag-mean()"

"fBodyAcc-mean()-X"

"fBodyAcc-mean()-Y"

"fBodyAcc-mean()-Z"

"fBodyAccJerk-mean()-X"

"fBodyAccJerk-mean()-Y"

"fBodyAccJerk-mean()-Z"

"fBodyGyro-mean()-X"

"fBodyGyro-mean()-Y"

"fBodyGyro-mean()-Z"

"fBodyAccMag-mean()"

"fBodyBodyAccJerkMag-mean()"

"fBodyBodyGyroMag-mean()"

"fBodyBodyGyroJerkMag-mean()"

"tBodyAcc-std()-X"

"tBodyAcc-std()-Y"

"tBodyAcc-std()-Z"

"tGravityAcc-std()-X"

"tGravityAcc-std()-Y"

"tGravityAcc-std()-Z"

"tBodyAccJerk-std()-X"

"tBodyAccJerk-std()-Y"

"tBodyAccJerk-std()-Z"

"tBodyGyro-std()-X"

"tBodyGyro-std()-Y"

"tBodyGyro-std()-Z"

"tBodyGyroJerk-std()-X"

"tBodyGyroJerk-std()-Y"

"tBodyGyroJerk-std()-Z"

"tBodyAccMag-std()"

"tGravityAccMag-std()"

"tBodyAccJerkMag-std()"

"tBodyGyroMag-std()"

"tBodyGyroJerkMag-std()"

"fBodyAcc-std()-X"

"fBodyAcc-std()-Y"

"fBodyAcc-std()-Z"

"fBodyAccJerk-std()-X"

"fBodyAccJerk-std()-Y"

"fBodyAccJerk-std()-Z"

"fBodyGyro-std()-X"

"fBodyGyro-std()-Y"

"fBodyGyro-std()-Z"

"fBodyAccMag-std()"

"fBodyBodyAccJerkMag-std()"

"fBodyBodyGyroMag-std()"

"fBodyBodyGyroJerkMag-std()"

