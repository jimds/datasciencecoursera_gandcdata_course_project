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


