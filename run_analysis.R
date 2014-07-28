## 3. Uses descriptive activity names to name the activities in the data set
activities<-read.table("UCIHARDataset/activity_labels.txt")[,2] 

## 1. Merge training and test sets
## Read in test data
x_test<- read.table("UCIHARDataset/test/x_test.txt")
y_test<- read.table("UCIHARDataset/test/y_test.txt")
##convert activities to descriptive names
activity_test<-lapply(y_test[1], function(x){activities[x]})
subject_test <- read.table("UCIHARDataset/test/subject_test.txt")
##combine test data
combined_test <- cbind(subject_test,activity_test,x_test)

## Read in train data
x_train<- read.table("UCIHARDataset/train/x_train.txt")
y_train<- read.table("UCIHARDataset/train/y_train.txt")
##convert activities to descriptive names
activity_train<-lapply(y_train[1], function(x){activities[x]})
subject_train <- read.table("UCIHARDataset/train/subject_train.txt")
##combine train data
combined_train <- cbind(subject_train,activity_train,x_train)

##combine train and test data
combined_all <- rbind(combined_test,combined_train)

##2. Extracts only the measurements on the mean and standard deviation for each measurement
##remove unneeded colums ( Keeping only subject, activity, tBodyAcc-mean()-X,tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z)
combined_trimmed <-combined_all[1:(6+2)]


##4. Appropriately labels the data set with descriptive variable names
##Rename columns to descriptive names
names(combined_trimmed)<- c("Subject","Activity","Time_Body_Acceleration_Mean_X","Time_Body_Acceleration_Mean_Y","Time_Body_Acceleration_Mean_Z","Time_Body_Acceleration_Standard_Deviation_X","Time_Body_Standard_Deviation_Y","Time_Body_Standard_Deviation_Z")

## Write tidy data file
write.table(combined_trimmed, file = "tidydata.txt",row.names = FALSE)

##5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. (This has been taken as generating the averages for each actvity FOR each subject)
##create data frame for the new tody data
avg_data<-data.frame(Subject=integer(),Activity=character(),Time_Body_Acceleration_Average_Mean_X=numeric(),Time_Body_Acceleration_Average_Mean_Y=numeric(),Time_Body_Acceleration_Average_Mean_Z=numeric(),Time_Body_Acceleration_Average_Standard_Deviation_X=numeric(),Time_Body_Acceleration_Average_Standard_Deviation_Y=numeric(),Time_Body_Acceleration_Average_Standard_Deviation_Z=numeric())
##get a list of all unique subjects
subjects<-unique(combined_trimmed[,1])
for(s in subjects){
    ##get subject's data
    subject_data <- subset(combined_trimmed,Subject==s)
    ##get uniqe activities for that subject
    sub_activities<- unique(subject_data[,2])
    for(act in sub_activities){
        ##work out the average for the individual activity
        new_row<- data.frame(Subject=s,Activity=act, Time_Body_Acceleration_Average_Mean_X=mean(subset(subject_data,Activity==act)[,3]),Time_Body_Acceleration_Average_Mean_Y=mean(subset(subject_data,Activity==act)[,4]),Time_Body_Acceleration_Average_Mean_Z=mean(subset(subject_data,Activity==act)[,5]),Time_Body_Acceleration_Average_Standard_Deviation_X=mean(subset(subject_data,Activity==act)[,6]),Time_Body_Acceleration_Average_Standard_Deviation_Y=mean(subset(subject_data,Activity==act)[,7]),Time_Body_Acceleration_Average_Standard_Deviation_Z=mean(subset(subject_data,Activity==act)[,8]))
        ##Add new row to the data frame
        avg_data <- rbind(avg_data, new_row)
    }
}

## Write second tidy data file
write.table(avg_data, file = "tidydata_averages.txt",row.names = FALSE)