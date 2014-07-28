datasciencecoursera_gandcdata_course_project
============================================

###Usage
The script need to be run where UCIHARDataset (containing the Samsung data) is a folder in the working drectory

###Output
The script will output a tidy data set that is the result of the merging of the Samsung training and test data sets where the *time body acceleration mean* and *standard deviation* has been collected

###Details
The script initially reads in the *activity_labels.txt* file into a vector that will later be used to convert the activity key to descriptive values

It then reads in the *x_test.txt* and *y_test.txt* data

It uses the activities vector to modify the *y_test.txt* data into its descriptive form

It then reads in the *subject_test.txt* data

It then combines these using *cbind()*

The above steps are repeated for the training data and the the two are combined using *rbind*

The data frame columns are then trimmed to remove the unnecessary measurments

The column names are then changed to descriptive column names

The tidy data set is then written to a file, *tidydata.txt*

