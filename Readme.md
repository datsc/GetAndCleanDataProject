# Getting and Cleaning Data course project for August 2015: Run Analysis

The developer of the code is Ugur Ural. See also CodeBook.md

## Information about initial data

From the readme file provided with the initial data set:

*italic*"The data used in this project is collected by Smartlab Non Linear Complex Systems Laboratory (www.smartlab.ws).

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."*italic*

## run_analysis.R
The code is written to tidy up the initial data set provided in
"UCI HAR DATASET"" directory to prepare it for further analysis.

It uses the packages plyr,dplyr to manipulate the tabulated data
and stringr to format the variable names used in the table.

The initially provided data sets (7352 observations from 
the training set and 2947 observations from the test set) 
have 561 variables with different measurements for 30 subjects
during whilst performing six activities. 

The code combines these data sets into MergeData together. Then
it chooses a subset of the 86 variables which are the measurements
involving the means and the standard deviations of the observed 
parameters as well as adding the Ids and the activities provided separately. The activities listed as a numerical dictionary are transformed to the actual activity names.

All the variable names are edited in order to omit the punctuation
marks and to make them as descriptive as possible while cutting out
a couple of the redundant keywords in order to save space: When
a variable does not have the keyword "Gravity" in it, it means
it represents the separate "Body" signal measured after separation
from the Gravity: hence the third variable TimeLinearMeanX could be read as BodyTimeLinearMeanX. A dictionary of variable names is provided at the end of this file.

The final data set consistst of 180 rows and 88 columns, where the first two columns are the Id of the subject that participated in the
experiment and the Activity they were involved in while the measurements listed in the next 86 columns were performed. For each Id-Activity pair only one value is displayed which is the mean of all of the measurements made for this variable.

## How to read variable names?
The keyword "Body" from the original data set is omitted as this is the
default mode we calculate unless otherwise determined with the keyword
"Gravity"

Variable name           Read as
----------------------------------------------------------------------------------
TimeLinearMeanX     (Body component of) Time Domain Linear Acceleration in X(meanof)

Time                Time domain
Freq                Frequency domain
Gravity             Gravitational Acceleration
Linear              Linear component of the acceleration
Angular             Angular velocity
Jerk                Jerk movements
Magnitude           Magnitude of the signal from XYZ components
StDev               Standard deviation
Angle               Average signal within a window sample














