---
output: 
  html_document: 
    keep_md: yes
    theme: cerulean
---
## Getting and Cleaning Data Project  
This is the project for the Getting and Cleaning Data course at Coursera.The purpose is to prepare a tidy dataset that can be used for later analysis.The code for preparing data is in the run_analysis.R file.The final tidydata is in the tidydata.txt file.   
The script run_analysis.R does the following:  
1. Downloads the Samsung dataset and unzips it if it does not already exists in the working directory.   
2. Reads the training and test dataset.  
3. Merges the training and test data into a new data set.  
4. Subsets the dataset for only mean and standard deviation columns.  
5. Uses descriptive activity names to name the activities in the data set.  
6. Renames the columns of the dataset with appropriate names.  
7. Creates a new dataset with average of each column for each activity and each subject  
8. Write the ouput in tidydata.txt file  
