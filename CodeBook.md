# CodeBook

The R script is expected to generate a tidy data set from multiple data sets containing live measurements of activities performed by individuals. The original data sets and the related information can be found at:

https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script to generate the tidy data set will use the following files

* activity_labels.txt: links the class labels with their activity name (dimensions: 6*2)
* features.txt:list of all features (dimensions: 561*2)
* subject_test.txt: subject doing the activity in the test set (dimensions: 2947*1)
* X_test.txt: observations of all the variables measured for each activity done by each subject constituting the test set (dimensions: 2947*561)
* y_test.txt:test labels (dimensions: 2947*1)
* subject_train.txt: subject doing the activity in the training set (dimensions: 7352*1)
* X_train.txt: observations of all the variables measured for each activity done by each subject constituting the training set (dimensions: 7352*561)
* y_train.txt: training labels (dimensions: 7352*1)