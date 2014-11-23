CodeBook for the tidy dataset
==============================

Raw Data
-----------------
For a description of the raw data used by the script, please refer to the README and features*.txt files available to download from the Data Folder on the Human Activity Recognition database web page
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

Processed Data
-----------------
The tidy data contains
```
- Activity: The activity label for each measurement. This can be one of: 
WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS, SITTING,STANDING,LAYING
- Subject: the identifier of the subject who carried out the experiment. This ranges between 1 and 30.
- A set of features for which the description is brought belwo
```
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals time_Accelerometer_XYZ and time_Gyroscope_XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (time_Body_Accelerometer_XYZ and time_Gravity_ Accelerometer_XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (time_Body_ Accelerometer_Jerk_XYZ and time_Body_Gyroscope_Jerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (time_Body_Accelerometer_Magnitude, time_Gravity_Accelerometer_Magnitude, time_Body_ Accelerometer_Jerk_Magnitude, time_Body_ Gyroscope_Magnitude, time_Body_Gyroscope_Jerk_Magnitude). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency_Body_Accelerometer_XYZ, frequency_Body_Accelerometer_Jerk_XYZ, frequency_Body_Gyroscope _XYZ, frequency_Body_Accelerometer_Jerk_Magnitude, frequency_Body_Gyroscope_Magnitude, frequency_Body_Gyroscope_Jerk_Magnitude. 
These signals were used to estimate variables of the feature vector for each pattern:  
'_XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
```
time_Body_Accelerometer_XYZ
time_Gravity_Accelerometer_XYZ
time_Body_Accelerometer_Jerk_XYZ
time_Body_Gyroscope_XYZ
time_Body_Jerk_XYZ
time_Body_Accelerometer_Magnitude_XYZ
time_Gravity _Accelerometer_Magnitude_XYZ
time_Body_Accelerometer_Jerk_Magnitude_XYZ
time_Body_ Gyroscope_Magnitude_XYZ
time_Body_ Gyroscope_Jerk_Magnitude_XYZ
frequency_Body_Accelerometer_XYZ
frequency_Body_Accelerometer_Jerk_XYZ
frequency_Body_Gyroscope_XYZ
frequency_Body_Accelerometer_Magnitude_XYZ
frequency_Body_Accelerometer_Jerk_Magnitude_XYZ
frequency_Body_ Gyroscope_Magnitude_XYZ
frequency_Body_ Gyroscope_Jerk_Magnitude_XYZ
```
The set of variables that were estimated from these signals are: 
```
mean(): Mean value
std(): Standard deviation
```
Transformation to the raw data labels:
--------------------------------------
To improve readability of the feature labels, the following are the main transformation performed to the raw data labels:
- leading 't' replaced with 'time'
- leading 'f' replaced with 'frequency'
- replaced abbreviation with full word: Accelerometer(Acc), Gyroscope(Gyro), Magnitude(Mag)
- removed redundant Body in naming

