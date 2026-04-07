# CodeBook  
The file "run.analysis.R" retrieves the data collected from the accelerometers 
from the Samsung Galaxy S smartphone for this coursera assignment.  
  
The data is retrieved from here: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.  
  
A full description about the data at the site where the data was obtained from is available here: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>    
   
Below, all the steps in data collection and cleaning are outlined:  

 ## Steps of data retrieval and cleaning  
**Step 1. Retrieving the dataset** 
```
if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){  
                DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(
                        url = DataURL, 
                        destfile ="getdata_projectfiles_UCI HAR Dataset.zip",
                        method="libcurl")}
        if (!file.exists("UCI HAR Dataset")) { 
                unzip("getdata_projectfiles_UCI HAR Dataset.zip") 
        } 
```  
        
**Step 2. Loading the dplyr R package**  
` library(dplyr) `  

**Step 3. Reading all the data frames downloaded into R using read.table**  
``` 
features <- read.table(file = "UCI HAR Dataset/features.txt", col.names = c("n","feature"))
        activities <- read.table(file = "UCI HAR Dataset/activity_labels.txt", col.names = c("class","activity"))
        subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", col.names = "subjects")
                x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
                y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "class")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjects")
                x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
                y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "class") 
                ``` 

**Step 4. Merging the training and the test sets using rbind and cbind**
``` 
x <- rbind(x_train, x_test)
        y <- rbind(y_train, y_test)
        subjects <- rbind(subject_train, subject_test)
        merged_UCI_HAR_dataset <- cbind(subjects, y, x)
``` 

**Step 5. Extracting only the measurements on the mean and standard deviation for each measurement. **
``` 
TidySet <- merged_UCI_HAR_dataset %>% select(subjects,class,contains("mean"), contains("std"))
``` 

**Step 6. Applying descriptive activity names and labels in the data set "TidySet". **
``` 
        TidySet$class <- activities[TidySet$class, "activity"]
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
``` 
  
**Step 7. Created a second independent tidy data set with the average of each variable for each activity and each subject "FinalSubset"**
``` 
        Final_subset <- 
                TidySet %>% group_by(subjects, activity) %>% summarise_all(funs(mean))
        write.table(Final_subset, file = "FinalSubset.txt", row.names = FALSE)
 ```        
        
 ## Variables
 Examples of variables in the data set include:  
 -"Subjects": this corresponds to the number of the volunteer (1-30).  
 -"Activity": this corresponds to the activity being measures (laying, sitting, standing, walking, walking upstairs, walking downstairs).  
 For the other variables, I referr to the original documentation from the dataset. 


