Getting and Cleaning Data Course Project
========================================

Overview
=========
This script is processing the data from the Human Activity Recognition database and preparing a tidy data set to be used for later analysis. 
The data for the script was collected from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted Samsung smartphone with embedded inertial sensors.

The description of the variables in tidydata.txt can be found in the file CodeBook.md in this repository
A full description of the data processed by the script is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Running the script
-------------------
To run the code you will first download the Human Activity Recognition data to local directory computer from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
A folder names 'UCI HAR Dataset' is downloaded. Place the run_analysis.R script in the same folder.
In your R studio set the working directory to this folder's path. 
source("run_analysis.r")

Viewing the tidydata file
-------------------------
To view the data file in R use
data <- read.table("tidydata.txt", header = TRUE)
View(data)

Dependencies
-------------
run_analysis.R script requires the data.table package installed beforehead.

The run_analysis.R script performs the following steps:

Script steps
-------------
**1. Merging the training and tests data sets (total of 6 files) into one big data frame.**
The code reads the following files under the downloaded folder "UCI HAR Dataset", each files is read into a table
```
-	test/subject_test.txt  
-	train/subject_train.txt
-	test/X_test.txt
-	train/X_train.txt
-	test/y_test.txt
-	train/y_train.txt
```
The approach I selected performs steps 2 and 3 that are described below before continuing with merging the test and train data. That was a more intuitive order of actions to me: first tidy up the feature measurement data then continue with the merge. Note that the current implementation was not optimized for best performance.
  
After extracting measurements for the mean and std in each of the features data sets(X_test.txt ,X_train.txt), the features labels were updated with more descriptive names. 

Using cbind(), the respective test/train subject and activity tables were joined to the test/train features measurement tables. The merge() was used then to merge the test and train data sets. The result is converted into data table.

**2. Extracting only the measurements on the mean and standard deviation for each measurement**
The names to the 561 features are read from the the features.txt file.
Using regular expression, the code subsets the list of feature names to include only the column names that have "mean()" or "std()" string in them.

**3. Use descriptive activity names to name the activities in the data set**
Activity names are read from “activity_labels.txt”
Factorizing the column activity in the datatable using the descriptive activity names

**4. Label the data set with descriptive variable names**
This part is done in a dedicated function named descLables().
There are quite a few manipulations done to the names and to improve the readability of the code in the main flow, the code was placed in a separate function.

The function is using ‘gsub()’ to match patterns and replacing words.
The main transformation done:
```
-	leading 't 'replaced with 'time'
-	leading 'f' replaced with 'frequency'
-	replaced abbreviation with full word: Accelerometer(Acc), Gyroscope(Gyro), Magnitude(Mag)
-	removed redundant extra ‘Body’ word
-	Using ‘_’ to separate words inside a name 
```
**5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject**
I used datatable () from the data.table library to aggregate the data by the mean per subject and activity.
A new tidydata.txt file using the write.table() function

