# CodeBook

The R script is expected to generate a tidy data set from multiple data sets containing live measurements of activities performed by individuals. The original data sets and the related information can be found at:

https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Files location

To function properly the script expects to find the following files within the directory structure below:

```
+——UCI HAR Dataset
   +——test
      +——subject_test.txt
      +——X_test.txt
      +——Y_test.txt
   +——train
      +——subject_train.txt
      +——X_train.txt
      +——Y_train.txt  
   +——activity_labels.txt
   +——features.txt
   +——run_analysis.R 
```

the R script run_analysis.R needs to be stored within the UCI HAR Dataset folder. 

Below a quick description of the content of each file and the dimensions of the data:

* **activity_labels.txt**: links the class labels with their activity name (dimensions: 6*2)
* **features.txt**:list of all features (dimensions: 561*2)
* **subject_test.txt**: subject doing the activity in the test set (dimensions: 2947*1)
* **X_test.txt**: observations of all the variables measured for each activity done by each subject constituting the test set (dimensions: 2947*561)
* **y_test.txt**: test labels (dimensions: 2947*1)
* **subject_train.txt**: subject doing the activity in the training set (dimensions: 7352*1)
* **X_train.txt**: observations of all the variables measured for each activity done by each subject constituting the training set (dimensions: 7352*561)
* **y_train.txt**: training labels (dimensions: 7352*1)

## R script: run_analysis.R

The R script load the above files and generate two data frames called **test_dataset** and  **train_dataset**. Below a summary of the activities done by the R script, details can be found in the R script itself by looking at the comments.

###Dataframe: test_dataset

The test_dataset dataframe is built by combining by columns - using the cbind() function - the subject_test, the y_test and the X_test data generating a dataframe with 2947 rows and 68 columns. Notes:
* the original X_test contains 561 columns but since we are interested only in the variables (i.e columns) containing only mean and std observations the columns have been filtered appropriately by using the grep() function applied to the features description
* column names (i.e. variables measured) have been named appropriately used the same name convention used by the original dataset to identify the variables (i.e. features)
* the first column of the dataframe contains the subject ID who performed the activity the second column contains the activity ID performed by the subject, the remaining 66 columns contain the observed variables 
* a column has been added to the end, leading effectively to a data frame with 69 columns, to identify that the observations belong to the test dataset

###Dataframe: train_dataset

Following the same approach done before for the test_dataset, the train_dataset dataframe is built by combining by columns - using the cbind() function - the subject_train, the y_train and the X_train data generating a dataframe with 7352 rows and 68 columns. Notes:
* the original X_train contains 561 columns but since we are interested only in the variables (i.e columns) containing only mean and std observations the columns have been filtered appropriately by using the grep() function applied to the features description
* column names (i.e. variables measured) have been named appropriately used the same name convention used by the original dataset to identify the variables (i.e. features)
* the first column of the dataframe contains the subject ID who performed the activity the second column contains the activity ID performed by the subject, the remaining 66 columns contain the observed variables 
* a column has been added to the end, leading effectively to a data frame with 69 columns, to identify that the observations belong to the train dataset

###Combining the test_dataset and the train_dataset

Before computing the average value of all the variables in scope grouped by subject and activity the two dataframes teat_dataset and train_dataset are combined together  - using the rbind() function - to generate a unique dataframe called train_and_test_dataset with 10299 rows and 69 columns. Notes:
* the first column of the dataframe contains the subject ID who performed the activity the second column contains the activity ID performed by the subject, the remaining 66 columns contain the observed variables and the last column identifies if the observation belongs to the test dataset or the train dataset
* since the second column contains the activity ID, in order to describe the activity done by the subject the ID is translated in the activity description by matching the ID number with the appropriate activity - use of the the activity_labels translation dataframe and the factor function - leading to the dataframe containing all the data required to generate the tidy dataset 

###Generation of the tidy dataset 
