#
# Getting and cleananing Data Course project
#
# The program ie expected to generate a tidy data set from multiple data sets containing
# live measurements of activities performed by individuals. The original data sets 
# and the related information can be found at:
#
#      https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#

#
# To function properly the program expects to find the following files within the directory structure below
#
#  UCI HAR Dataset---------------test---------subject_test.txt
#     |-activity_labels.txt  |            |---X_test.txt
#      -features.txt         |             ---y_test.txt
#                            |
#                             ---train--------subject_train.txt
#                                         |---X_train.txt
#                                          ---y_train.txt
#
# the program itself needs to be stored within the UCI HAR Dataset folder
#
#

#
# set path variables to load/save data
#

path_to_test_data <- "test/"
path_to_train_data <- "train/"
current_dir <- getwd()

#
# read activity_labels and features.text files
#

activity_labels <- read.table(
  file = "activity_labels.txt",
  header = FALSE,
  colClasses = c("integer" , "character"),
  col.names = c("activity_id","activity"))

features <- read.table(
  file = "features.txt",
  header = FALSE,
  colClasses = c("integer" , "character"),
  col.names = c("feature_id","feature")
  )

#
# The features dataframe contains the description of the columns' content of the
# test and train datasets. 
#

#
# identify the rows containing a reference to mean or std: as mentioned above each row
# correspond to a column in the train test dataset
#

mean_std_cols <- features[grep("std\\(|mean\\(",features$feature),]$feature_id

#
# read the X_test.txt file containing the test data set and
# assign as column names the feature description
#

X_test <- read.table(
  file = paste(path_to_test_data , "X_test.txt", sep=''),
  colClasses = "numeric",
  header = FALSE)
colnames(X_test) = features$feature
X_test <- X_test[,mean_std_cols]

#
# read the subject_test.txt file contaning the indication of the subject who performed the test
#

subject_test <- read.table(
  file = paste(path_to_test_data , "subject_test.txt", sep=''),
  colClasses = "integer",
  header = FALSE)
colnames(subject_test) <- "subject_id"

#
# read the y_test.txt file contaning the indication of the activity done by the subject
#

y_test <- read.table(
  file = paste(path_to_test_data , "y_test.txt", sep=''),
  colClasses = "integer",
  header = FALSE)
colnames(y_test) <- "activity"

#
# create the test dataset by merging subject_test + y_test + X_test
# but before check the number of rows is the same
#

if((nrow(X_test) != nrow(y_test)) | (nrow(X_test) != nrow(subject_test))){
  stop("Different row numbers when merging test datasets")
}
test_dataset <- cbind(subject_test , y_test , X_test)
# add a column data_type to the end to identify that the data refer to the test dataset
test_dataset$data_type <- rep("test",nrow(test_dataset)) 

#
# read the X_train.txt file containing the test data set and
# assign as column names the feature description
#

X_train <- read.table(
  file = paste(path_to_train_data , "X_train.txt", sep=''),
  colClasses = "numeric",
  header = FALSE)
colnames(X_train) = features$feature
X_train <- X_train[,mean_std_cols]

#
# read the subject_train.txt file contaning the indication of the subject who performed the test
#

subject_train <- read.table(
  file = paste(path_to_train_data , "subject_train.txt", sep=''),
  colClasses = "integer",
  header = FALSE)
colnames(subject_train) <- "subject_id"

#
# read the y_train.txt file contaning the indication of the activity done by the subject
#

y_train <- read.table(
  file = paste(path_to_train_data , "y_train.txt", sep=''),
  colClasses = "integer",
  header = FALSE)
colnames(y_train) <- "activity"

#
# create the train dataset by merging subject_train + y_train + X_train
# but before check the number of rows is the same
#

if((nrow(X_train) != nrow(y_train)) | (nrow(X_train) != nrow(subject_train))){
  stop("Different row numbers when merging train datasets")
}
train_dataset <- cbind(subject_train , y_train , X_train)
# add a column data_type to the end to identify that the data refer to the train dataset
train_dataset$data_type <- rep("train" , nrow(train_dataset)) 

#
# create a dataset containing both test and train data but
# before check that the number of columns is the same
#

if(ncol(train_dataset) != ncol(test_dataset)){
  stop("Different col numbers when merging train and test datasets")
}
train_and_test_dataset <- rbind(train_dataset , test_dataset)

#
# translate the activity number with the appropriate description
#

train_and_test_dataset$activity <- factor(train_and_test_dataset$activity,
                                          levels = activity_labels$activity_id,
                                          labels = activity_labels$activity)
#
# create the tidy_dataset containing the average of each variable
# for each activity and each subject
#
# note that the last column of the train_and_test_dataset allows to identify
# if the observation is sourced from the test dataset or the train dataset:
# the aggregation function is done in a way to exclude the last
# column so that the average of all observations (i.e. both of the train
# and the test dataset) is computed 
#

tidy_dataset <- aggregate(train_and_test_dataset[,3:(ncol(train_and_test_dataset)-1)]
                          , by = list(subject_id = train_and_test_dataset$subject_id
                                      , activity = train_and_test_dataset$activity)
                          , mean
                          )
# order the tidy dataset by subject_id and activity
tidy_dataset <- tidy_dataset[order(tidy_dataset$subject_id,tidy_dataset$activity),]

#
# write the tidy_dataset in the current directory
# called tidy_dataset.csv using a comma separator and with column names
#
write.table(tidy_dataset
          , file = "tidy_dataset.csv"
          , row.names = FALSE
          , sep = ","
  )

#
# clean variables from memory leaving only the tidy_dataset
#

rm(X_test , y_test , subject_test, X_train , y_train , subject_train
   , test_dataset , train_dataset , activity_labels , features
   , mean_std_cols)

