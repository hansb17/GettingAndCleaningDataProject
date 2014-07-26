# Getting and Cleaning Data Project

The purpose of the project is to prepare a tidy dataset that can be used for later analysis starting from a collection of raw datasets. The raw datasets used are created from data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

while the data used for the project can be found at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


To generate the tidy dataset an R script is used. The r script called run_analysis.R does the following:
 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set called with the average of each variable for each activity and each subject.
* Store the independent tidy data set in a csv file called tydy_dataset.csv


## run_analysis.R

To function properly the program expects to find the following files within the directory structure below:

  UCI HAR Dataset---------------test---------subject_test.txt
     |-activity_labels.txt  |            |---X_test.txt
     |-features.txt         |             ---y_test.txt
     |                      |
     |                       ---train--------subject_train.txt
      -run_analysis.R                    |---X_train.txt
                                          ---y_train.txt

the R script run_analysis.R needs to be stored within the UCI HAR Dataset folder. 

To generate the tidy data set the script will:

* read the train and test raw data stored in the respective folders
* merge appropriately the data in an single dataframe
* select the columns of the data frame where the required data for the analysis (mean and standard deviations) are stored
* will aggregate the data in a way to have the AVERAGE of all required variables computed
* will store the tidy dataset as a comma separated values CSV file in the current folder with the name tidy_dataset.csv

The tidy dataset is formed by 180 observations and 68 variables has appropriate labels describing the column variables and the activity done by each subject (observations)