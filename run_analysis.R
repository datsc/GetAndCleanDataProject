print(paste("if any of the packages are missing, you can re-run the script 
            with the next three lines uncommented"))
#install.packages("plyr")
#install.packages("stringr")
#install.packages("dply")

library(plyr)
library(stringr)
library(dplyr)


##### Reading the data in 
##########################
# doing the first inspection with str and summary gives:
# 561 Variables listed in features (These will be column names)
# 6 activities from activity_labels
# Training set with 7352 observations for the 561 variables *trainsetX
# Test set has 2947 observations for the 561 variables *testsetX
# trainsub and testsub have the subject ids (1:30 in total)
##########################################################

features<-read.table("UCI HAR Dataset/features.txt")
activities<-read.table("UCI HAR Dataset/activity_labels.txt")

trainsetX<-read.table("UCI HAR Dataset/train/X_train.txt")
trainsetlabel<-read.table("UCI HAR Dataset/train/y_train.txt")
trainsub<-read.table("UCI HAR Dataset/train/subject_train.txt")

testsetX<-read.table("UCI HAR Dataset/test/X_test.txt")
testsetlabel<-read.table("UCI HAR Dataset/test/y_test.txt")
testsub<-read.table("UCI HAR Dataset/test/subject_test.txt")

####### MERGING DATA SETS
###################################    
# For now I want to be able to know which data set the data is from, so add
# a variable called "DataSet" to both data frames and merge them after that.
names(trainsub)<-"Id"
names(trainsetlabel)<-"Activity"
trainset<-cbind(trainsetX,trainsub,trainsetlabel)

names(testsub)<-"Id"
names(testsetlabel)<-"Activity"
testset<-cbind(testsetX,testsub,testsetlabel)

MergedData<-rbind(trainset,testset)  

####### Extracting variables with mean or standard deviation
###################################################################### 

AllColumns <- as.character(features[,2])
MeanSelection <- cbind(AllColumns[grep("mean",AllColumns,ignore.case=TRUE)],
                       str_c("V",grep("mean",AllColumns,ignore.case=TRUE)))

StdDevSelection <- cbind(AllColumns[grep("std",AllColumns,ignore.case=TRUE)],
                         str_c("V",grep("std",AllColumns,ignore.case=TRUE)))

MeanCols<-MergedData[,MeanSelection[,2]]
names(MeanCols)<-MeanSelection[,1]
StDevCols<-MergedData[,StdDevSelection[,2]]
names(StDevCols)<-StdDevSelection[,1]
StDevExpanded<-mutate(StDevCols,Id=MergedData$Id,Activity=MergedData$Activity)

ShrunkenData<-cbind(MeanCols,StDevExpanded)

####### Taking the activity names from the activities file.
############################################################### 
activities$V2<-c("Walking","Walking up","Walking down","Sitting","Standing","Laying")
for (i in 1:6)
{
ShrunkenData$Activity[ShrunkenData$Activity==activities[i,1]]<-
    as.character(activities[i,2])    
}

### Tidying up the variable names
#####################################

namesvar<-names(ShrunkenData)
namesvar<-sub("angle","MeanAngle",namesvar) 
namesvar<-sub("BodyBody","Body",namesvar)
namesvar<-sub("fBody","Freq",namesvar)
namesvar<-sub("tBody","Time",namesvar)
namesvar<-sub("gravity","Gravity",namesvar,ignore.case=FALSE)
namesvar<-sub("tGravity","Gravity",namesvar,ignore.case=FALSE)
namesvar<-sub("GravityMean","Gravity",namesvar,ignore.case=FALSE)
namesvar<-sub("Mean,Gravity","AndGravity",namesvar)
namesvar<-sub("Mean),Gravity","AndGravity",namesvar)
namesvar<-sub(",","",namesvar)
namesvar<-sub("Acc","Linear",namesvar)
namesvar<-sub("Gyro","Angular",namesvar)
namesvar<-sub("-","",namesvar)
namesvar<-sub("-","",namesvar)
namesvar<-sub("\\(","",namesvar)
namesvar<-sub("\\)","",namesvar)
namesvar<-sub("std","StDev",namesvar)
namesvar<-sub("mean","Mean",namesvar)
namesvar<-sub("Mag","Magnitude",namesvar)

names(ShrunkenData)<-namesvar

#### Final data set with means of observables for 30 subjects 
### and 6 activities
###############################################################
#From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and 
#each subject.

tidy<-ShrunkenData %>% group_by(Id,Activity) %>%summarise_each(funs(mean))

print(paste("To see a more compact form of the data frame without the longer 
            variable names run type: tidyshort()"))
tidyshort<-function(){
            tidyshort<-tidy
            names(tidyshort)<-c("Id","Activity",c(1:86))
            return(tidyshort)
}


