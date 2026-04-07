## This is the run_analysis script. 
## It will work through different steps to merge the data and create a tidy dataset.


## PREPARING FOR CLEANING THE DATA
        ## Download the dataset (if not present) and unzipping it.
        if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
                DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(
                        url = DataURL, 
                        destfile ="getdata_projectfiles_UCI HAR Dataset.zip",
                        method="libcurl")}
        if (!file.exists("UCI HAR Dataset")) { 
                unzip("getdata_projectfiles_UCI HAR Dataset.zip") 
        }
        ## Load the dplyr package
        library(dplyr)
        ## Read all the dataframes into R
        features <- read.table(file = "UCI HAR Dataset/features.txt", col.names = c("n","feature"))
        activities <- read.table(file = "UCI HAR Dataset/activity_labels.txt", col.names = c("class","activity"))
        subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", col.names = "subjects")
                x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
                y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "class")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjects")
                x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
                y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "class")

## FOLLOWING THE ASSIGNMENT PARTS        
        ## 1. Merge training set and test set 
        x <- rbind(x_train, x_test)
        y <- rbind(y_train, y_test)
        subjects <- rbind(subject_train, subject_test)
        merged_UCI_HAR_dataset <- cbind(subjects, y, x)
        ## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
        TidySet <- merged_UCI_HAR_dataset %>% select(subjects,class,contains("mean"), contains("std"))
        ## 3. Uses descriptive activity names to name the activities in the data set
        TidySet$class <- activities[TidySet$class, "activity"]
        ## 4. Appropriately labels the data set with descriptive variable names. 
        TidySet <- rename(TidySet, activity = class)
        names(TidySet) <- gsub(pattern = "Acc", replacement = "Accelerometer", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "Gyro", replacement = "Gyroscope", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "BodyBody", replacement = "Body", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "Mag", replacement = "Magnitude", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "angle", replacement = "Angle", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "gravity", replacement = "Gravity", x = names(TidySet)) 
        names(TidySet) < -gsub(pattern = "^t", replacement = "Time", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "^f", replacement = "Frequency", x = names(TidySet))
        names(TidySet) <- gsub(pattern = "tBody", replacement = "TimeBody", x = names (TidySet))
        ## 5. From the data set in step 4, creates a second, independent tidy data 
        ## set with the average of each variable for each activity and each subject.
        Final_subset <- 
                TidySet %>% group_by(subjects, activity) %>% summarise_all(funs(mean))
        write.table(Final_subset, file = "FinalSubset.txt", row.names = FALSE)
        
        
        