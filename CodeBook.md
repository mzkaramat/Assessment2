##CodeBook   

###About Variables:-

Column                Description
"1*     ---->    *Subjects"
"2*     ---->    *Activities"
"3*     ---->    *tBodyAcc-mean()-X"
"4*     ---->    *tBodyAcc-mean()-Y"
"5*     ---->    *tBodyAcc-mean()-Z"
"6*     ---->    *tBodyAcc-std()-X"
"7*     ---->    *tBodyAcc-std()-Y"
"8*     ---->    *tBodyAcc-std()-Z"
"9*     ---->    *tGravityAcc-mean()-X"
"10*    ---->    *tGravityAcc-mean()-Y"
"11*    ---->    *tGravityAcc-mean()-Z"
"12*    ---->    *tGravityAcc-std()-X"
"13*    ---->    *tGravityAcc-std()-Y"
"14*    ---->    *tGravityAcc-std()-Z"
"15*    ---->    *tBodyAccJerk-mean()-X"
"16*    ---->    *tBodyAccJerk-mean()-Y"
"17*    ---->    *tBodyAccJerk-mean()-Z"
"18*    ---->    *tBodyAccJerk-std()-X"
"19*    ---->    *tBodyAccJerk-std()-Y"
"20*    ---->    *tBodyAccJerk-std()-Z"
"21*    ---->    *tBodyGyro-mean()-X"
"22*    ---->    *tBodyGyro-mean()-Y"
"23*    ---->    *tBodyGyro-mean()-Z"
"24*    ---->    *tBodyGyro-std()-X"
"25*    ---->    *tBodyGyro-std()-Y"
"26*    ---->    *tBodyGyro-std()-Z"
"27*    ---->    *tBodyGyroJerk-mean()-X"
"28*    ---->    *tBodyGyroJerk-mean()-Y"
"29*    ---->    *tBodyGyroJerk-mean()-Z"
"30*    ---->    *tBodyGyroJerk-std()-X"
"31*    ---->    *tBodyGyroJerk-std()-Y"
"32*    ---->    *tBodyGyroJerk-std()-Z"
"33*    ---->    *tBodyAccMag-mean()"
"34*    ---->    *tBodyAccMag-std()"
"35*    ---->    *tGravityAccMag-mean()"
"36*    ---->    *tGravityAccMag-std()"
"37*    ---->    *tBodyAccJerkMag-mean()"
"38*    ---->    *tBodyAccJerkMag-std()"
"39*    ---->    *tBodyGyroMag-mean()"
"40*    ---->    *tBodyGyroMag-std()"
"41*    ---->    *tBodyGyroJerkMag-mean()"
"42*    ---->    *tBodyGyroJerkMag-std()"
"43*    ---->    *fBodyAcc-mean()-X"
"44*    ---->    *fBodyAcc-mean()-Y"
"45*    ---->    *fBodyAcc-mean()-Z"
"46*    ---->    *fBodyAcc-std()-X"
"47*    ---->    *fBodyAcc-std()-Y"
"48*    ---->    *fBodyAcc-std()-Z"
"49*    ---->    *fBodyAccJerk-mean()-X"
"50*    ---->    *fBodyAccJerk-mean()-Y"
"51*    ---->    *fBodyAccJerk-mean()-Z"
"52*    ---->    *fBodyAccJerk-std()-X"
"53*    ---->    *fBodyAccJerk-std()-Y"
"54*    ---->    *fBodyAccJerk-std()-Z"
"55*    ---->    *fBodyGyro-mean()-X"
"56*    ---->    *fBodyGyro-mean()-Y"
"57*    ---->    *fBodyGyro-mean()-Z"
"58*    ---->    *fBodyGyro-std()-X"
"59*    ---->    *fBodyGyro-std()-Y"
"60*    ---->    *fBodyGyro-std()-Z"
"61*    ---->    *fBodyAccMag-mean()"
"62*    ---->    *fBodyAccMag-std()"
"63*    ---->    *fBodyBodyAccJerkMag-mean()"
"64*    ---->    *fBodyBodyAccJerkMag-std()"
"65*    ---->    *fBodyBodyGyroMag-mean()"
"66*    ---->    *fBodyBodyGyroMag-std()"
"67*    ---->    *fBodyBodyGyroJerkMag-mean()"
"68*    ---->    *fBodyBodyGyroJerkMag-std()"

###About Data:-

This data is taken from experiments which have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. This is one of the most exciting areas in all of data science . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###About transformations:-

I read Activity names and transform the values present in original data set with descriptive names with this,

```r
#Reading Activity names
activity_names_file_Path<-"./UCI HAR Dataset/activity_labels.txt"
activity_names_data = read.table(activity_names_file_Path)
for (i in 1:6)
{
  MergedDataSet[,2]<-sub(i,activity_names_data[i,2],MergedDataSet[,2])
}
```

also, I added two columns corresponding to each subjects and activites corresponding to each observation

```r
listAttributes<-test_list_data[grep("mean\\(\\)|std\\(\\)",test_list_data[,2]),2]
listAttributes<-c("Subjects","Activities",listAttributes)
```

and I also only take those columns having mean and std in them

```r
test_data<-test_data[,grep("mean\\(\\)|std\\(\\)",test_list_data[,2])]
train_data<-train_data[,grep("mean\\(\\)|std\\(\\)",test_list_data[,2])]
```

and for averaging, I take mean of all observations with respect to each of the subjects and activities group.

```r
MergedDataSet <-aggregate(MergedDataSet[, 3:ncol(MergedDataSet)], list(MergedDataSet$Subjects,MergedDataSet$Activities), mean);
```