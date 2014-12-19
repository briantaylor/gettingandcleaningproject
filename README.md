README notes for Getting and Cleaning Data course project

The R code works in the folowing way:

reads all the data into R variables named to reflect the files they have read

assumes that the UCI HAR Dataset folder is in the working directory with files and structure as downloaded from Coursera

Also assumes that dplyr package has been loaded

step 1 - merge test and train data
I have merged the data placing test data at the top of the combined set and adding trial data below
X_test and X_train have been merged to produce X_merged, still 561 columns wide
y_test and y_train have been merged to produce y_merged, still 1 column wide
subject_test and subject_train have been merged to produce subject_merged, still 1 column wide

I applied column headings at this stage to help my understanding
"subject" for subject_merged, "activity" for y_merged and applied the features vector to name X_merged columns

I then formed a single variable data_merged
with column 1 the subject (from subject_merged),
column 2 the activity code (from y_merged) and
column 3 the numerical data (from X_merged)


step 2 - extract mean and standard deviation
from column headings, I have chosen to select columns 1 to 8 to get subject, activity and the mean and sd data
I have extracted these into a new variable I have called dataset


step 3 - descriptive activity names
I have replaced the factor 1 to 6 entries in the activity column with the relevant description from activity_labels


step 4 - Appropriately labels the data set with descriptive variable names.
subject and activity are already good but I renamed columns 3 to 8 to =simpler names:
"xmean","ymean"and"zmean"for the 3 means and
"xsd", "ysd" and "zsd" for the 3 standard deviations



step 5 - creates a second, independent tidy data set with the average of each variable for each activity and each  subject
I made a new variable, tidydata for this
I used group_by to group by activity and subject
then summarise to collapse the dataset using the mean function to get means of:
3 averages - x, y and z
3 standard deviations - x, y and z


