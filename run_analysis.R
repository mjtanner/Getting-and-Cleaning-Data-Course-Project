# Matthew Tanner
# mjtanner@uga.edu

# Set-up
#   Preserve current state.
wd <- getwd()


# 1. Merges the training and the test sets to create one data set.
# Get the train data.
trainFileList = list.files(path = "~/Data/UCI HAR Dataset/train", pattern = NULL, all.files = FALSE, full.names = FALSE, recursive = TRUE, ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
setwd("~/Data/UCI HAR Dataset/train")
trainLists = lapply(trainFileList, read.table)

# Get the test data.
testFileList = list.files(path = "~/Data/UCI HAR Dataset/test", pattern = NULL, all.files = FALSE, full.names = FALSE, recursive = TRUE, ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
setwd("~/Data/UCI HAR Dataset/test")
testLists = lapply(testFileList, read.table)

# Merge the two data sets.
mergedFileList <- gsub("_test","",testFileList)
mergedListsNames <- lapply(sapply(gsub(".txt","",mergedFileList), function(x) strsplit(x, "/")),function(x) tail(x,1))

mergedLists <- mapply(function(x,y) mapply(c, x, y, SIMPLIFY=FALSE), x = trainLists, y = testLists)
names(mergedLists) <- paste0(mergedListsNames, seq_along(mergedListsNames))


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
setwd("~/Data/UCI HAR Dataset")
featuresList = read.table("features.txt")

extract <- mergedLists$X11[(grepl("mean()",featuresList[,2], fixed = TRUE) | grepl("std()",featuresList[,2], fixed = TRUE))]


# 3. Uses descriptive activity names to name the activities in the data set
# Read the activities table.
setwd("~/Data/UCI HAR Dataset")
activitiesLookupList = read.table("activity_labels.txt")
activitiesLookupList[2] <- lapply(activitiesLookupList[2], function(x) gsub("_"," ",x))

activity <- lapply(mergedLists$y12, function(x) as.factor(activitiesLookupList[x,2]))

extract <- c(descriptiveActivityNames, extract)


# 4.Appropriately labels the data set with descriptive variable names. 
# Read the features table.
setwd("~/Data/UCI HAR Dataset")
fullList = read.table("features.txt", as.is = TRUE)

featuresList <- fullList[(grepl("mean()",fullList[,2], fixed = TRUE) | grepl("std()",fullList[,2], fixed = TRUE)),2]
featuresList2 <- c("activity",featuresList)

tidyFrame <- do.call(cbind.data.frame, extract)
names(tidyFrame) <- featuresList2


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
tidyMelt <- melt(tidyFrame, id = c("activity"), measure.vars = featuresList)
tidyFrame2 <- dcast(tidyMelt, activity ~ variable, mean)

setwd("~/Data")
write.table(tidyFrame2, file = "tidyFrame2.txt",sep="\t", row.names = FALSE )


#Housekeeping
#  Restore previous state
setwd(wd)