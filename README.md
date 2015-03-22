Matthew Tanner
mjtanner@uga.edu

                           R Program run_analysis.R
                                  README.md


I Top Down Design.
  
  A. Preserve the current R environment.
  
  B. Step 1: Merges the training and the test sets to create one data set.
     1. Import the train data.
     2. Import the test data.
     3. Merge the data sets.
  
  C. Step 2: Extracts only the measurements on the mean and standard 
     deviation for each measurement using logical subsetting derived
     from to presence of the "mean()" or the "std() in the features 
     table
  
  D. Step 3: Uses descriptive activity names to name the activities in the 
     data set.
     1. Import the activities table.
     2. Use the activities table as a lookup to construct a vector or
        descriptive strings corresponding to the numberic code in the merged 
        data set.
     3. Merge the descriptive vector with the data extracted in C.
 
  E. Step 4: Appropriately labels the data set with descriptive variable names. 
     1. Import the features table to a list.
     2. Prefix the features list with the activities variable name. 
     3. Apply the features list to the dataset.

  F. Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
     1. Melt the dataset by activities.
     2. dcast and new data frame, averaging all variables by activity.

  G. Write the file to disk and restore the R state.
