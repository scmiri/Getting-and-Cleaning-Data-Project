# This script merges the training and test sets from the Human Activity Recognition database in one data set
# and creates a tidy data set, saved as the file tidydata.txt that contains a summary by subject and activity
# Please refe to the Readme.d file for more overview

require(reshape2)
require(data.table)

# The descLables function is used in step #3 of the exercise. It renames the lables of data set with a more
# descriptive names. The returned lables are longer names in favor of more self explanatory names
# Main transformation:
#       - leading 't' replaced with 'time'
#       - leading 'f' replaced with 'frequency'
#       - replaced abbreviation with full word: Accelerometer(Acc), Gyroscope(Gyro), Magnitude(Mag) 

descLables <- function(lables)
{
        updatedLables <- lables
        updatedLables = gsub("\\(\\)", "", updatedLables)          # strip the '()'
        updatedLables = gsub("-mean", "mean", updatedLables)
        updatedLables = gsub("-std", "std", updatedLables)
        updatedLables = gsub("^t", "time_", updatedLables)
        updatedLables = gsub("^f", "frequency_", updatedLables)
        updatedLables = gsub("Acc", "Accelerometer_", updatedLables)
        updatedLables = gsub("Gyro", "Gyroscope_", updatedLables)
        updatedLables = gsub("Mag", "Magnitude_", updatedLables)
        updatedLables = gsub("Jerk", "Jerk_", updatedLables)         # for consistency use '_' to separate words
        updatedLables = gsub("BodyBody", "Body", updatedLables)      # remove redundant Body in naming
        updatedLables = gsub("Body", "Body_", updatedLables)
        updatedLables = gsub("-", "_", updatedLables)                # for consistency replace any remaining '-' with '_'
        return(updatedLables)
}

#### In preparation for part 1: first, read the data files
# The feature vector  
test_data = read.table("./test/X_test.txt")
train_data = read.table("./train/X_train.txt")

# The activity label for each measurement
test_activity = read.table("./test/y_test.txt")
train_activity = read.table("./train/y_train.txt")

# The identifier of the subject who carried out the experiment.
test_subject = read.table("./test/subject_test.txt")
train_subject = read.table("./train/subject_train.txt")

# Read the feature lables
column_lables = read.table("./features.txt")

#### Part #2: extract only the feature measurements on the mean and standard deviation for each measurement
#### Those columns will contain mean() and std() in their name. The code is deliberately ommiting 
#### columns in which mean/std are not followed by () (tBodyGyroMean,gravityMean,meanFreq)
#### This step is done before merging the data since it impacts the feature vector files only (X_test.txt
#### and X_train.txt)
meanstd_col = subset(column_lables$V2, regexpr("mean()", column_lables$V2, fixed=TRUE) > 0 | regexpr("std()", column_lables$V2, fixed=TRUE) > 0)
names(test_data) <- column_lables$V2
merged_test_data = subset(test_data, select = names(test_data) %in% meanstd_col)
names(train_data) <- column_lables$V2
merged_train_data = subset(train_data, select = names(train_data) %in% meanstd_col)

#### Part #3: call the function that renames the column labels to more descriptive names
updated_lables <- descLables(meanstd_col)

### Part #1 is done here: merge the training and the test sets to create one data set 
# Merge the test data files
merged_test_data = cbind(merged_test_data, test_activity, test_subject)
names(merged_test_data) <- c(updated_lables, "activity", "subject")

# Merge the train data files
merged_train_data = cbind(merged_train_data, train_activity, train_subject)
names(merged_train_data) <- c(updated_lables, "activity", "subject")

# Merge train and test files
merged_data = merge(merged_test_data, merged_train_data, all=TRUE)
datatable = data.table(merged_data)

#### Part #4: label the data set with descriptive activity names 
# Read the activity lables
activity_lables = read.table("./activity_labels.txt")
# Replace the activity identifier with the descriptive activity name
datatable$activity <-  activity_lables[datatable$activity, 2]

#### Part #5: create tidy data set with the average of each variable for each activity and each subject.
#### Sorted by Activity then Subject
results = datatable[ , lapply(.SD, mean), keyby= c("activity", "subject")]

# Write into a file. Remove the row names as it doesnt add to readability
write.table(results, file = "tidydata.txt", sep="\t", row.names=FALSE)
