# set the working directory
setwd("C:/Users/Victor/Desktop/Project/UCI HAR Dataset")

# load dplyr and reshape2 libraries that will be used further on
library(dplyr)
library(reshape2)

# read all relevant data and store on different objects
features <- read.csv("features.txt",header=FALSE,sep=" ",col.names=c("ID","feature"))
labels <- read.csv("activity_labels.txt",header=FALSE,sep=" ", col.names=c("ID","label"))

subjectsTrain <- read.csv("./train/subject_train.txt",header=FALSE,col.names=c("subject"))
xTrain <- read.table("./train/X_train.txt",header=FALSE,strip.white=TRUE)
yTrain <- read.csv("./train/y_train.txt",header=FALSE)

subjectsTest <- read.csv("./test/subject_test.txt",header=FALSE,col.names=c("subject"))
xTest <- read.table("./test/X_test.txt",header=FALSE,strip.white=TRUE)
yTest <- read.csv("./test/y_test.txt",header=FALSE)

# merge train and test datasets
x <- rbind(xTrain,xTest)
names(x) <- features[,2]

subjects <- rbind(subjectsTrain,subjectsTest)
names(subjects) <- "Subject"

y <- rbind(yTrain,yTest)
names(y) <- "Activity"

# step 1: create a dataset with the subjects, activities and the features measures
merged <- cbind(subjects,y,x)
merged <- tbl_df(merged)

# step 2: extract only the measurements on the mean and standard deviation for each measurement
merged <- tbl_df(merged[,c(1,2,grep("-mean\\()|-std\\()",names(merged)))])

# step 3: use descriptive activity names to name the activities in the data set
labels[,2] <- as.character(labels[,2])
for(i in 1:nrow(merged)){
        merged$Activity[i] <- labels[merged$Activity[i],2]
}

# step 4: label the data set with descriptive variable names
names(merged) <- gsub("(X|Y|Z)$","Axis\\1",names(merged))
names(merged) <- gsub("\\()","",names(merged))
names(merged) <- gsub("-","",names(merged))
names(merged) <- gsub("^t","time",names(merged))
names(merged) <- gsub("^f","freq",names(merged))
names(merged) <- gsub("mean","Mean",names(merged))
names(merged) <- gsub("std","STD",names(merged))
names(merged) <- gsub("BodyBody","Body",names(merged))

# step 5: create a second, independent tidy data set with the average of each variable for each 
# activity and each subject
melted <- melt(merged,id=names(merged)[1:2],measure.vars=names(merged)[3:68])

meansDF <- melted %>%
        group_by(Subject,Activity,variable) %>%
        summarise(average=mean(value))

castDF <- dcast(meansDF,Subject + Activity ~ variable,value.var="average")
castDF <- tbl_df(castDF)
