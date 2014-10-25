##Getting and Cleaning Data Assessment 2

In this assessment, I perform following questions:  

1. Merges the training and the test sets to create one data set.   
2. Extracts only the measurements on the mean and standard deviation for each measurement.     
3. Uses descriptive activity names to name the activities in the data set    
4. Appropriately labels the data set with descriptive variable names.      
5. From the data set in step 4, creates a second, independent tidy data set with the average of            each variable for each activity and each subject.      

For this purpose, I first read the activity labels, for using descriptive activity names to name the activities in the data set,

```r
activity_names_file_Path<-"./UCI HAR Dataset/activity_labels.txt"
activity_names_data = read.table(activity_names_file_Path)
```

Then, I read features list and stored them in variable for using that in later analysis, and taking out only the measurements on the mean and standard deviation for each measurement. And then I add Subjects and Activities column names for their respective columns. 


```r
test_list_file_Path<-"./UCI HAR Dataset/features.txt"
test_list_data = read.table(test_list_file_Path)
test_list_data[,2]<-as.character(test_list_data[,2])
listAttributes<-test_list_data[grep("mean\\(\\)|std\\(\\)",test_list_data[,2]),2]
listAttributes<-c("Subjects","Activities",listAttributes)
```

And then I read the test data for only those measurements on the mean and standard deviation for each column, and then I read subject and y test data corresponding to each entry, and then I bind them with row wise,

```r
test_file_Path<-"./UCI HAR Dataset/test/X_test.txt"
test_data = read.table(test_file_Path)
test_data<-test_data[,grep("mean\\(\\)|std\\(\\)",test_list_data[,2])]

#Subjects data 
test_subjects_file_Path<-"./UCI HAR Dataset/test/subject_test.txt"
test_subjects_data = read.table(test_subjects_file_Path)

#Tests files load
test_tests_file_Path<-"./UCI HAR Dataset/test/y_test.txt"
test_tests_data = read.table(test_tests_file_Path)

#cbinding
BindedTestData<-cbind(test_subjects_data,test_tests_data,test_data)
```

and doing the same for training data,

```r
train_file_Path<-"./UCI HAR Dataset/train/X_train.txt"
train_data = read.table(train_file_Path)
train_data<-train_data[,grep("mean\\(\\)|std\\(\\)",test_list_data[,2])]

#Subjects data 
train_subjects_file_Path<-"./UCI HAR Dataset/train/subject_train.txt"
train_subjects_data = read.table(train_subjects_file_Path)

#Tests files load
train_tests_file_Path<-"./UCI HAR Dataset/train/y_train.txt"
train_tests_data = read.table(train_tests_file_Path)

#cbinding
BindedTrainData<-cbind(train_subjects_data,train_tests_data,train_data)
```

and then I merged the two training and test datasets

```r
MergedDataSet<-rbind(BindedTestData,BindedTrainData)
```

and then I named the columns


```r
colnames(MergedDataSet)<-listAttributes
```

and then I renamed activity labels

```r
#Renaming Activity Column
for (i in 1:6)
{
  MergedDataSet[,2]<-sub(i,activity_names_data[i,2],MergedDataSet[,2])
}
```

and then I write them to TidyData.txt file, with row.name=F.

```r
write.table(MergedDataSet,"./UCI HAR Dataset/TidyData.txt",row.name=FALSE)
```

###Now creating average of above dataset

Firstly I take mean that data set exluding first two columns with respect to MergedDataSet$Subjects and MergedDataSet$Activities. Then I renamed them and ordered them. Finally, I write them to averagedData.txt with row.name=FALSE.
    

```r
MergedDataSet <-aggregate(MergedDataSet[, 3:ncol(MergedDataSet)], list(MergedDataSet$Subjects,MergedDataSet$Activities), mean);
#Naming columns
colnames(MergedDataSet)<-listAttributes
#Ordering Data
MergedDataSet <- MergedDataSet[order(MergedDataSet$Subjects),]
#Writing Data
write.table(MergedDataSet,"./UCI HAR Dataset/averagedData.txt",row.name=FALSE)
```
