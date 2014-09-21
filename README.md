README.md
========================================================

Summary: this is a processed data set from the data "Human Activity Recognition Using Smartphones Dataset Version 1.0"collected by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

The first thing to do was to load the dplyr and reshape2 libraries that will be used further on.

Then, all the relevant data is read and loaded into separte objects (test and train data sets and also labels (for the activities) and features).

Then, the test and train data sets are merged. (Step 1) A new dataset, merged, is created with one column for Subject, one for Activity and all the features as the rest of columns.

(Step 2) Through the grep() function only those measurements referencing mean() and std() are taken into account.

(Step 3) Within the Activity column, the numbers are substituted by more descriptive names such as "Standing" or "Walking" through a for loop.

(Step 4) The names of the measurements left on the data set are changed in order to be more descriptive. A word "Axis" is placed before each of the axis (i.e. X,Y,Z). Parenthesis and symbols are taken from the names. "t" and "f" are converted into time and freq respectively. "mean" and "std" are converted into Mean and STD respectively. And finally the errors like duplication of "BodyBody" are eliminated.
The output is 66 columns starting with lower case and then each word is capitalised to spot more easily the starting of a new word.

(Step 5) In order to calculate the mean of each of the measurements grouped by each of the subjects and each of the activities a melt&cast strategy has been performend. This is to melt the dataframe, perform all the required calculations, and finally cast it in order to have the original form.

Finally the ultimate dataframe contains a tidy data set with all the means for all the measurements by activity and subject.

- 68 columns/variables: Subject, Activity, and 66 measurements
- 180 rows/observations: 30 Subjects by 6 activities