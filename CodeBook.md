# CodeBook  
The file "run.analysis.R" retrieves the data collected from the accelerometers 
from the Samsung Galaxy S smartphone for this coursera assignment.  
  
The data is retrieved from here: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.  
  
 A full description about the data at the site where the data was obtained from is available here: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>  
   
   
**1. Retrieve the dataset** 
``` if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
                DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(
                        url = DataURL, 
                        destfile ="getdata_projectfiles_UCI HAR Dataset.zip",
                        method="libcurl")}
        if (!file.exists("UCI HAR Dataset")) { 
                unzip("getdata_projectfiles_UCI HAR Dataset.zip") 
        } ```  
        
**2. load the dplyr R package**  
` library(dplyr) `  

**3. Read all the data frames downloaded into R**  
```  features <- read.table(file = "UCI HAR Dataset/features.txt", col.names = c("n","feature"))
        activities <- read.table(file = "UCI HAR Dataset/activity_labels.txt", col.names = c("class","activity"))
        subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", col.names = "subjects")
                x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
                y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "class")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjects")
                x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
                y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "class") ``` 

work in progress

