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

