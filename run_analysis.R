## getting and cleaning data project
## first get data from txt files
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
## now got the data in R

## step 1 merge the training and test data
## I have chosen to place test at the top of the tables and add train below
## set of mreged data is named with a _merged ending
## merge X_test and X_train retain 561 columns but adding more rows
X_merged <- rbind(X_test, X_train)
## merge y_test and y_train retain 1 column but adding more rows
y_merged <- rbind(y_test, y_train)
## subject_test and subject_train retain 1 column but adding more rows
subject_merged <- rbind(subject_test, subject_train)

## add column names
## "subject" for subject_merged, "activity" for y_merged
## apply features vector to name X_merged columns
colnames(subject_merged) <- "subject"
colnames(y_merged) <- "activity"
colnames(X_merged) <- features[,2]

## form a single variable with subject, y and X data together
data_merged <- cbind(y_merged,subject_merged,X_merged)

## step 2 - extract mean and standard deviation
## from column headings, I have chosen to select
## columns 1 to 8 to get the subject, activity and mean and sd data
dataset <- data_merged[,1:8]

## step 3 - descriptive activity names
## replaced factor 1 to 6 entries in the activity column
## with the relevant description from activity_labels
dataset <- mutate(dataset,activity=activity_labels[activity,2])

## step 4 - add meaningful column names
colnames(dataset)[3:8] <- c ("xmean","ymean","zmean","xsd","ysd","zsd")



## step 5 - creates a second, independent tidy data set
## with the average of each variable for each activity and each  subject
## group by activity and subject and summarise to collapse the dataset and apply the mean function
tidydata <- group_by(dataset, activity, subject)
tidydata <- summarise(tidydata,xmean=mean(xmean),ymean=mean(ymean),zmean=mean(zmean),
                      xsd=mean(xsd),ysd=mean(ysd),zsd=mean(zsd))


## Please upload your data set as a txt file created with write.table() using row.name=FALSE
write.table(tidydata, file="getandcleandataproject.txt", row.name=FALSE)
