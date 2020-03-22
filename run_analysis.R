library(data.table)
library(dplyr)
if(!file.exists("UCI HAR Dataset"))
{
  fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl,"UCI HAR Dataset.zip")
  unzip("UCI HAR Dataset.zip")
}
## Read the training and test dataset
train_data<-fread("./UCI HAR Dataset/train/X_train.txt")
test_data<-fread("./UCI HAR Dataset/test/X_test.txt")
## Read the subject data for training and test set
train_data$subject<-fread("./UCI HAR Dataset/train/subject_train.txt")
test_data$subject<-fread("./UCI HAR Dataset/test/subject_test.txt")
## Read the activity data for training and test set
train_data$activity<-fread("./UCI HAR Dataset/train/y_train.txt")
test_data$activity<-fread("./UCI HAR Dataset/test/y_test.txt")
## Merge the training and test dataset
data<-rbind(train_data,test_data)
## Read the features.txt file
features<-fread("./UCI HAR Dataset/features.txt")$V2
## Select only those features containing mean() or std()
sub_cols<-grep("mean\\(\\)|std\\(\\)",features)
## Extract only mean or std columns of dataset 
data<-select(data,c(sub_cols,562:563))
## Convert the activity column into factor class with appropriate labels for each level
data$activity<-factor(data$activity,labels =c("walking","walkup","walkdown","sitting","standing","laying"))
## Renames the columns of the dataset with feature names 
colnames(data)[1:66]<-features[sub_cols]
colnames(data)<-tolower(colnames(data))
## Removes the "-" or "()" in the column names
colnames(data)<-gsub("-|\\(\\)","",colnames(data))
## Renames the std and acc with stddev and acceleration in column names
colnames(data)<-sub("std","stdev",colnames(data))
colnames(data)<-sub("acc","acceleration",colnames(data))
colnames(data)<-sub("mag","magnitude",colnames(data))
## Creates a new dataset with average of each column for each activity and each subject
new_data<-data %>% group_by(activity,subject) %>% summarise_all(mean)
write.table(new_data,"tidydata.txt",row.names =FALSE)