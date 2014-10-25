#Reading Activity names
activity_names_file_Path<-"./UCI HAR Dataset/activity_labels.txt"
activity_names_data = read.table(activity_names_file_Path)

#Reading features list
test_list_file_Path<-"./UCI HAR Dataset/features.txt"
test_list_data = read.table(test_list_file_Path)
test_list_data[,2]<-as.character(test_list_data[,2])
listAttributes<-test_list_data[grep("mean\\(\\)|std\\(\\)",test_list_data[,2]),2]
listAttributes<-c("Subjects","Activities",listAttributes)

# For Test Files
#Data 
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

# For Training Files
#Data 
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

#Row binding training and testing datasets
MergedDataSet<-rbind(BindedTestData,BindedTrainData)

#Naming columns
colnames(MergedDataSet)<-listAttributes

#Renaming Activity Column
for (i in 1:6)
{
  MergedDataSet[,2]<-sub(i,activity_names_data[i,2],MergedDataSet[,2])
}
#Writting Data
write.table(MergedDataSet,"./UCI HAR Dataset/TidyData.txt",row.name=FALSE)


#Now creating average of above dataset
MergedDataSet <-aggregate(MergedDataSet[, 3:ncol(MergedDataSet)], list(MergedDataSet$Subjects,MergedDataSet$Activities), mean);
#Naming columns
colnames(MergedDataSet)<-listAttributes
#Ordering Data
MergedDataSet <- MergedDataSet[order(MergedDataSet$Subjects),]
#Writing Data
write.table(MergedDataSet,"./UCI HAR Dataset/averagedData.txt",row.name=FALSE)