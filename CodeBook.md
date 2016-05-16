Code Book

This code book provides a summary for the variables used for this project.

========================================
Varables:
my_url - URL to the dataset
1)test_data - data set from reading in X_test.txt file 
2)train_data - data set from reading in X_train.txt file
3)subject_test_data - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
4)subject_train_data - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
5)label_test_data - Test labels from y_test.txt
6)label_train_dadta - training labels from y_train.txt
7)features - List of all features read from features.txt file
8)training_data_set - merges all information for the training subjects
9)test_data_set - merges all information for the test subjects
10)all_data - merges all information for the training and test subjects
11)mean_std_data - select data from all_data set with 'mean' and 'std' information
12)tidy_mean_data - stores tidy data set with the average of each of the variables from mean_std_data set for each of the 
activity and each subject