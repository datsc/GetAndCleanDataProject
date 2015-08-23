# CodeBook

This code book is prepared to explain the details of the manipulation
of the data set UCI HAR DATA. More information about the initial data
is in Readme.md

## Raw Data

Measurements of the motion parameters (acceleration, gravity etc.)
obtained by several methods by tracking 30 test subjects with smartphones.

## Codebook for tidy data (22/08/2015)

Variable names
-----------------
Every new word in a long variable name starts with a capital letter.

From the complementary keywords "Gravity" and "Body", "Body"" is omitted from all variable names, if a variable name does not have Gravity in it, it measures the body motion. 

Angle is transformed to MeanAngle

t is omitted from the Angle names as they are all in time domain

f is transformed to Freq

t is transformed to Time

angle is transformed to AngleMean

std is transformed to StDev

mean is transformed to Mean

Acc is transformed to Linear

Gyro is transformed to Angular

Mag is transformed to Magnitude

Punctutation marks are omitted in all variable names

Parentheses are omitted in all variable names

Activity Names
---------------

Walking Upstairs and Walking Downstairs have been transformed to Walking up and Walking down, respectively.

Units
-------

All observations are normalized, hence values between -1 and 1.

Transformation from Step4 to Step 5
------------------------------

ShrunkenData has all the variable used in the final data set as well as each individual repeat observation for each test subject performing each activity.

Final data set has the same column number as the ShrunkenData. Howevever, 
the rows are transformed so that, only the mean of all of the observations
for each activity and each test subject is given. 



